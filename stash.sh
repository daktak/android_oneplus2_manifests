#!/bin/bash
for n in .repo/local_manifests/*.patch; do
    patch -r - -p0 -R < ${n};
done;
