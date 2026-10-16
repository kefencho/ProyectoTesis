#!/usr/bin/env bash
set -Eeuo pipefail

BASE="https://resultadohistorico-eg2026.onpe.gob.pe/presentacion-backend"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"
ROOT="$PROJECT_ROOT/data/raw/ONPE_2026/Peru"
mkdir -p "$ROOT"

# Detecta Python funcional, incluso si Windows tiene alias rotos de Microsoft Store.
PYTHON=""
for candidate in python3 python py; do
  if command -v "$candidate" >/dev/null 2>&1 &&
     "$candidate" -c "import sys" >/dev/null 2>&1; then
    PYTHON="$(command -v "$candidate")"
    break
  fi
done
if [[ -z "$PYTHON" && -d /c/Users ]]; then
  for candidate in /c/Users/*/AppData/Local/Programs/Python/Python*/python.exe /c/Python*/python.exe; do
    if [[ -f "$candidate" ]] && "$candidate" -c "import sys" >/dev/null 2>&1; then
      PYTHON="$candidate"; break
    fi
  done
fi
if [[ -z "$PYTHON" ]]; then
  echo "ERROR: no se encontró Python funcional. Instala Python 3 o corrige PATH." >&2
  exit 1
fi
echo "Python detectado: $PYTHON"
"$PYTHON" --version

curl_json() {
  local url="$1" destination="$2"
  mkdir -p "$(dirname "$destination")"
  echo "  GET $url"
  local code
  code="$(curl --compressed --silent --show-error --fail-with-body \
    "$url" \
    -H "Accept: application/json" \
    -H "Accept-Language: es-ES,es;q=0.9" \
    -H "Referer: https://resultadohistorico-eg2026.onpe.gob.pe/" \
    -H "Sec-Fetch-Dest: document" \
    -H "Sec-Fetch-Mode: navigate" \
    -H "Sec-Fetch-Site: none" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36" \
    -H "Accept-Encoding: gzip,deflate,br,zstd" \
    -o "$destination" -w "%{http_code}")" || {
      echo "ERROR al descargar: $url" >&2
      rm -f "$destination"
      return 1
    }
  echo "  HTTP: $code"
  if ! "$PYTHON" -c 'import json,sys; json.load(open(sys.argv[1],encoding="utf-8"))' "$destination"; then
    echo "ERROR: respuesta no JSON válida en $destination" >&2
    head -c 250 "$destination" >&2 || true
    printf '\n' >&2
    return 1
  fi
}

# Descarga una respuesta y registra fallo sin abortar todo el país.
curl_json_optional() {
  local url="$1" destination="$2"
  if ! curl_json "$url" "$destination"; then
    echo "AVISO: se omite este recurso; revisa el archivo/log y vuelve a ejecutar para reintentar." >&2
    return 1
  fi
  return 0
}

echo "1/4 Descargando catálogo de departamentos..."
curl_json "$BASE/ubigeos/departamentos?idEleccion=10&idAmbitoGeografico=1" "$ROOT/departamentos.json"

echo "2/4 Recorriendo departamentos, provincias y distritos..."
"$PYTHON" - "$ROOT/departamentos.json" "$ROOT" "$BASE" <<'PYCODE'
import json, os, re, subprocess, sys, time
from urllib.parse import urlencode

departamentos_file, root, base = sys.argv[1:4]
def read_json(path):
    with open(path, encoding="utf-8") as f:
        obj = json.load(f)
    if not obj.get("success", False) or "data" not in obj:
        raise ValueError(f"Respuesta inesperada: {path}")
    return obj["data"]

def slug(text):
    text = re.sub(r'[<>:"/\\|?*]', '', text).strip()
    text = re.sub(r'\s+', '_', text)
    return text or "SIN_NOMBRE"

def fetch(url, path):
    if os.path.exists(path):
        try:
            with open(path, encoding="utf-8") as f:
                obj=json.load(f)
            if obj.get("success", False) and "data" in obj:
                return obj["data"]
        except Exception:
            pass
    os.makedirs(os.path.dirname(path), exist_ok=True)
    cmd = [
      "curl", "--compressed", "--silent", "--show-error", "--fail-with-body", url,
      "-H", "Accept: application/json",
      "-H", "Accept-Language: es-ES,es;q=0.9",
      "-H", "Referer: https://resultadohistorico-eg2026.onpe.gob.pe/",
      "-H", "Sec-Fetch-Dest: document",
      "-H", "Sec-Fetch-Mode: navigate",
      "-H", "Sec-Fetch-Site: none",
      "-H", "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36",
      "-o", path, "-w", "%{http_code}"
    ]
    try:
        r=subprocess.run(cmd, capture_output=True, text=True, timeout=90)
        print(f"    HTTP {r.stdout.strip()} | {os.path.relpath(path, root)}")
        if r.returncode != 0:
            raise RuntimeError(r.stderr.strip() or "curl falló")
        data=json.load(open(path, encoding="utf-8"))
        if not data.get("success", False) or "data" not in data:
            raise ValueError("JSON no contiene success=true y data")
        return data["data"]
    except Exception as e:
        print(f"    AVISO: no se pudo descargar {path}: {e}", file=sys.stderr)
        try: os.remove(path)
        except OSError: pass
        return None

departamentos=read_json(departamentos_file)
total_dept=len(departamentos)
for di, dep in enumerate(departamentos, 1):
    dcode=dep["ubigeo"]; dname=dep["nombre"]
    ddir=os.path.join(root, f'{dcode}_{slug(dname)}')
    os.makedirs(ddir, exist_ok=True)
    print(f"[Departamento {di}/{total_dept}] {dname} ({dcode})")

    # Totales y participantes del departamento
    for endpoint, filename in [
      ("totales", "totales.json"), ("participantes", "participantes.json")
    ]:
        params={"idEleccion":"10", "tipoFiltro":"ubigeo_nivel_01",
                "idAmbitoGeografico":"1", "idUbigeoDepartamento":dcode}
        fetch(f"{base}/resumen-general/{endpoint}?{urlencode(params)}",
              os.path.join(ddir, filename))

    provinces_url=f"{base}/ubigeos/provincias?{urlencode({'idEleccion':'10','idAmbitoGeografico':'1','idUbigeoDepartamento':dcode})}"
    provinces=fetch(provinces_url, os.path.join(ddir, "provincias.json"))
    if provinces is None: continue
    for pi, prov in enumerate(provinces, 1):
        pcode=prov["ubigeo"]; pname=prov["nombre"]
        pdir=os.path.join(ddir, f'{pcode}_{slug(pname)}')
        os.makedirs(pdir, exist_ok=True)
        print(f"  [Provincia {pi}/{len(provinces)}] {pname} ({pcode})")
        for endpoint, filename in [
          ("totales", "totales.json"), ("participantes", "participantes.json")
        ]:
            params={"idEleccion":"10", "tipoFiltro":"ubigeo_nivel_02",
                    "idAmbitoGeografico":"1", "idUbigeoDepartamento":dcode,
                    "idUbigeoProvincia":pcode}
            fetch(f"{base}/resumen-general/{endpoint}?{urlencode(params)}",
                  os.path.join(pdir, filename))

        districts_url=f"{base}/ubigeos/distritos?{urlencode({'idEleccion':'10','idAmbitoGeografico':'1','idUbigeoProvincia':pcode})}"
        districts=fetch(districts_url, os.path.join(pdir, "distritos.json"))
        if districts is None: continue
        for xi, dist in enumerate(districts, 1):
            xcode=dist["ubigeo"]; xname=dist["nombre"]
            xdir=os.path.join(pdir, f'{xcode}_{slug(xname)}')
            os.makedirs(xdir, exist_ok=True)
            print(f"    [Distrito {xi}/{len(districts)}] {xname} ({xcode})")
            for endpoint, filename in [
              ("totales", "totales.json"), ("participantes", "participantes.json")
            ]:
                params={"idEleccion":"10", "tipoFiltro":"ubigeo_nivel_03",
                        "idAmbitoGeografico":"1", "idUbigeoDepartamento":dcode,
                        "idUbigeoProvincia":pcode, "idUbigeoDistrito":xcode}
                fetch(f"{base}/resumen-general/{endpoint}?{urlencode(params)}",
                      os.path.join(xdir, filename))
            time.sleep(0.08)

print("Recorrido geográfico terminado. Los archivos existentes válidos se reutilizan al volver a ejecutar.")
PYCODE

echo "3/4 Descargando totales y participantes nacionales..."
curl_json_optional "$BASE/resumen-general/totales?idEleccion=10&tipoFiltro=ambito_geografico&idAmbitoGeografico=1" "$ROOT/totales_nacional.json" || true
curl_json_optional "$BASE/resumen-general/participantes?idEleccion=10&tipoFiltro=ambito_geografico&idAmbitoGeografico=1" "$ROOT/participantes_nacional.json" || true

echo "4/4 Generando unidades textuales..."
"$PYTHON" "$PROJECT_ROOT/src/data/generar_unidades.py"

echo "Proceso terminado. Revisa data/raw/ONPE_2026/Peru."
