#!/bin/bash

set -x

#TODO 本地打包时使用镜像
if [[ $CN == "yes" ]]; then
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
  export GOPROXY=https://goproxy.cn
fi

#apk add gcc musl-dev

uname -a

cd /server

#go mod tidy

ldflags="-s -w -extldflags '-static' -X main.appVer=$appVer -X main.commitId=$commitId -X main.buildDate=$(date -Iseconds)"

go build -o anylink -trimpath -ldflags "$ldflags"

ls -l /server/

/server/anylink -v