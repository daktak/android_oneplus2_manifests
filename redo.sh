#!/bin/bash
repo sync --force-sync
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
.repo/local_manifests/patch.sh
rm frameworks/base/core/res/res/values/*.orig
rm device/oneplus/oneplus2/*.orig
.repo/local_manifests/do.sh
