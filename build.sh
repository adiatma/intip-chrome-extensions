#!/bin/bash

read -p "version: " VERSION

build() {
    echo 'building react'

    rm -rf releases/*

    export INLINE_RUNTIME_CHUNK=false
    export GENERATE_SOURCEMAP=false

    bsb -make-world -clean-world
    react-scripts build

    mkdir -p "releases/${VERSION}"
    cp -r build/* "releases/${VERSION}/"
    mv "releases/${VERSION}/index.html" "releases/${VERSION}/popup.html"
}

build
