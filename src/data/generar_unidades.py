#!/usr/bin/env python3
"""Convierte cada JSON dentro de data/raw/ONPE_2026 en una unidad textual legible."""
import json
from pathlib import Path

ROOT = Path("data/raw/ONPE_2026")
OUTPUT_ROOT = Path("data/processed/unidades_textuales")
COUNT = 0

def flatten(value, prefix=""):
    lines = []
    if isinstance(value, dict):
        for key, child in value.items():
            new_prefix = f"{prefix}.{key}" if prefix else str(key)
            lines.extend(flatten(child, new_prefix))
    elif isinstance(value, list):
        for i, child in enumerate(value):
            lines.extend(flatten(child, f"{prefix}[{i}]"))
        if not value:
            lines.append(f"{prefix}: []")
    else:
        lines.append(f"{prefix}: {value}")
    return lines

for path in ROOT.rglob("*.json"):
    if path.name.endswith("_unidad_textual.json"):
        continue
    try:
        with path.open("r", encoding="utf-8") as f:
            obj = json.load(f)
        output = OUTPUT_ROOT / path.relative_to(ROOT).parent / f"{path.stem}_unidad_textual.txt"
        output.parent.mkdir(parents=True, exist_ok=True)
        with output.open("w", encoding="utf-8", newline="\n") as f:
            f.write(f"FUENTE: {path.as_posix()}\n")
            f.write("=" * 72 + "\n")
            f.write("\n".join(flatten(obj)))
            f.write("\n")
        print(f"Generado: {output}")
        COUNT += 1
    except Exception as exc:
        print(f"AVISO: se omite {path}: {exc}")
print(f"Finalizado. JSON procesados: {COUNT}")
