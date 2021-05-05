#!/bin/sh

set -e

cat > /vault/config/default.hcl << EOF
storage "postgresql" {
  connection_url = "${DATABASE_URL:?}"
}

listener "tcp" {
  address = "0.0.0.0:${PORT:-8200}"
  tls_disable = true
}

disable_mlock = true

api_addr = "http://127.0.0.1:${PORT:-8200}"
ui = ${VAULT_UI:-true}
EOF

if [[ ${VAULT_AUTO_UNSEAL:-true} = true ]]; then
  (sleep 10 &&
  vault-init start \
    --vault-addr "http://127.0.0.1:${PORT:-8200}" \
    --encryption-local-secret-key "${VAULT_INIT_SECRET_KEY:?}" \
    --storage-postgres-connection-url "${DATABASE_URL:?}") &
fi

vault server -config /vault/config
