#!/bin/bash

BRANCH=coq-8.12


git clone -b $BRANCH --depth 1 https://github.com/MetaCoq/metacoq.git metacoq-repo
cp metacoq-repo/*.opam .
rm -rf metacoq-repo



