#!/bin/bash 
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
. build/envsetup.sh
export PATH=/home/daktak/.gentoo/java-config-2/current-user-vm/bin:$PATH
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 20G
export ANDROID_CCACHE_SIZE="20G"
export ANDROID_CCACHE_DIR="/pub/aosp/android/.ccache"
breakfast oneplus2
croot
mka org.cyanogenmod.platform-res -j2
brunch oneplus2
