#!/bin/bash 
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
. build/envsetup.sh
#export PATH=/home/daktak/.gentoo/java-config-2/current-user-vm/bin:$PATH
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 25G
export ANDROID_CCACHE_SIZE="25G"
export ANDROID_CCACHE_DIR="/home/user/android/.ccache"
breakfast oneplus2
if [ $? -ne 0 ]; then
  exit 1
fi
croot
#mka org.cyanogenmod.platform-res -j2
#do custom apps first
for n in `grep + .repo/local_manifests/enabled/device.patch | grep -v ++ | grep -v PRODUCT | grep -v @@ | grep -v device.mk | grep -v wpa | awk '{print $2}'`; do mka ${n}; done

brunch oneplus2 > build.log
