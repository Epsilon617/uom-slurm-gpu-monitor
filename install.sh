#!/usr/bin/env bash

set -eu

PROJECT_ROOT=$(cd "$(dirname "$0")" && pwd)
SOURCE_SCRIPT="${PROJECT_ROOT}/bin/gpuq"
TARGET_DIR="${HOME}/bin"
TARGET_SCRIPT="${TARGET_DIR}/gpuq"
BASHRC="${HOME}/.bashrc"
WRAPPER='gpuq() { bash "$HOME/bin/gpuq" "$@"; }'

mkdir -p "${TARGET_DIR}"
cp "${SOURCE_SCRIPT}" "${TARGET_SCRIPT}"
chmod +x "${TARGET_SCRIPT}"

if [[ -f "${BASHRC}" ]]; then
  if ! grep -Fqx "${WRAPPER}" "${BASHRC}"; then
    printf '\n%s\n' "${WRAPPER}" >> "${BASHRC}"
  fi
else
  printf '%s\n' "${WRAPPER}" > "${BASHRC}"
fi

cat <<EOF
Installed:
  ${TARGET_SCRIPT}

Shell wrapper ensured in:
  ${BASHRC}

Next step:
  source ~/.bashrc
EOF
