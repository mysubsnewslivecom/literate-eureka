# Setting vault for kubernetes

### 1. Enable vault path
```sh
vault secrets enable -path=secret kv-v2

vault auth enable kubernetes

vault auth enable userpass

```

### 2. Setup Kubernetes auth config
```sh
vault write auth/kubernetes/config \
   token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
   kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
   kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

### 3. Create vault policy
```sh
vault policy write database-app - <<EOF
path "secret/data/database/config" {
  capabilities = ["read"]
}
EOF

vault policy write app - <<EOF
path "secret*" {
  capabilities = ["read"]
}
EOF
```

### 4. Create kubernetes service account
```sh
export SERVICE_NAME=vault-sa
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${SERVICE_NAME?}
EOF
```

### 5. Create vault role
```sh
export SERVICE_NAME=vault-sa
export NAMESPACE=vault
vault write auth/kubernetes/role/internal-app \
    bound_service_account_names=${SERVICE_NAME?} \
    bound_service_account_namespaces=${NAMESPACE?} \
    policies=app \
    ttl=24h
```

