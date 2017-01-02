#!/bin/bash
.repo/local_manifests/do.sh oneplus2 
if [ $? -ne 0 ]; then
  exit 1
fi
rm -rf out/target/product/oneplus2
.repo/local_manifests/do.sh oneplus3 no
if [ $? -ne 0 ]; then
  exit 1
fi
rm -rf out/target/product/oneplus3
.repo/local_manifests/do.sh onyx no
if [ $? -ne 0 ]; then
  exit 1
fi
rm -rf out/target/product/onyx
.repo/local_manifests/do.sh bacon no
if [ $? -ne 0 ]; then
  exit 1
fi
rm -rf out/target/product/bacon
