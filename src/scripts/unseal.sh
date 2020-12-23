#!/bin/sh

if [ -z "$1" ]; then
  echo "==> Vault address not provided, cannot unseal."
  exit 1
else
  export VAULT_ADDR=$1
fi

for i in $(seq 1 5); do
  echo "==> Fetching Vault status.."

  STATUS=$(vault status)

  if [[ -z "$STATUS" ]]; then
    echo "==> Failed to retrieve Vault status."
  else
    echo "$STATUS"
    INITIALIZED=$(echo "$STATUS" | awk '$1 == "Initialized" { print $2 }')
    SEALED=$(echo "$STATUS" | awk '$1 == "Sealed" { print $2 }')

    if [[ "$INITIALIZED" = false ]]; then
      echo "==> Vault needs to be manually initialized before unsealing."
      exit 0
    fi

    if [[ "$SEALED" = false ]]; then
      echo "==> Vault is already unsealed."
      exit 0
    fi

    if [[ -z "$VAULT_UNSEAL_KEY" ]]; then
      echo "==> Vault unseal key not provided."
      exit 1
    fi

    echo "==> Attempting to unseal Vault.."

    if vault operator unseal "$VAULT_UNSEAL_KEY"; then
      echo "==> Vault unsealed successfully."
      exit 0
    fi
  fi

  sleep 1
done

echo "==> Failed to unseal Vault."
exit 1
