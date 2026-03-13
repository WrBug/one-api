#!/bin/sh

# VERSION 在项目根目录，从 web 目录运行时读取上一级
version=$(cat ../VERSION 2>/dev/null || echo "")
pwd

# 单个主题失败不中断，继续构建其余主题
set +e

while IFS= read -r theme; do
    echo "Building theme: $theme"
    rm -rf build/$theme
    cd "$theme" || exit 1
    npm install --legacy-peer-deps
    if DISABLE_ESLINT_PLUGIN='true' REACT_APP_VERSION=$version npm run build; then
        echo "Theme $theme built successfully."
    else
        echo "Warning: Theme $theme build failed, continuing with next theme."
    fi
    cd .. || exit 1
done < THEMES

# 若 build 目录不存在则创建，避免后端找不到目录
mkdir -p build
exit 0
