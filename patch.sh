#!/bin/bash
cd /pub/mmkang
for n in .repo/local_manifests/*.patch; do
    patch -p0 < ${n};
done;
