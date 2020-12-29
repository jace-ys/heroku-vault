FROM jaceys/vault-init:v0.1.0 AS init

FROM vault:1.6.1
COPY --from=init /bin/vault-init /usr/local/bin/vault-init
COPY ./scripts .
CMD ["./start.sh"]
