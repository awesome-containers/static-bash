# Statically linked Bash

> ℹ️ This container only contains **bash**,
> there are no utilities like `cp` or `ls` here

Statically linked [Bash] container image

> ~ 1,1M

```bash
ghcr.io/awesome-containers/static-bash:latest
ghcr.io/awesome-containers/static-bash:5.2.15

docker.io/awesomecontainers/static-bash:latest
docker.io/awesomecontainers/static-bash:5.2.15
```

Slim statically linked [Bash] container image packaged with [UPX]

> ~ 578K

```bash
ghcr.io/awesome-containers/static-bash:latest-slim
ghcr.io/awesome-containers/static-bash:5.2.15-slim

docker.io/awesomecontainers/static-bash:latest-slim
docker.io/awesomecontainers/static-bash:5.2.15-slim
```

[Bash]: https://www.gnu.org/software/bash/
[UPX]: https://upx.github.io/

<!--

```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_BASH_IMAGE="$image" \
  --build-arg STATIC_BASH_VERSION=latest .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
