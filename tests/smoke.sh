#!/usr/bin/env bash

set -eu

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)
SCRIPT="${PROJECT_ROOT}/bin/gpuq"

bash -n "${SCRIPT}"
bash "${SCRIPT}" --help >/dev/null
bash "${SCRIPT}" 3 --help >/dev/null 2>&1 || true

printf 'smoke checks passed\n'
