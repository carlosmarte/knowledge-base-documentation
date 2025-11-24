# Build-time (secure)
```
docker build \
  --secret id=mytoken,src=./token.txt \
  -t fastapi-app .
```

# Dockerfile
```
RUN --mount=type=secret,id=mytoken \
    MYSECRET=$(cat /run/secrets/mytoken) && \
    python generate_initial_config.py "$MYSECRET"
```

# Run-time (secure & persistent)
```
docker run \
  -v $(pwd)/mysecret.txt:/run/secrets/mytoken:ro \
  fastapi-app
```
