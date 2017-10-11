wget "https://github.com/LineageOS/android_frameworks_base/compare/cm-14.1...Matssa56:cm-14.1-OMS3.diff" -O .repo/local_manifests/enabled/oms-frameworks_base.patch
wget "https://github.com/LineageOS/android_frameworks_native/compare/cm-14.1...Matssa56:cm-14.1-OMS.diff" -O .repo/local_manifests/enabled/oms-frameworks_native.patch
wget "https://github.com/LineageOS/android_system_sepolicy/compare/cm-14.1...Matssa56:cm-14.1-OMS.diff" -O .repo/local_manifests/enabled/oms-system_sepolicy.patch
sed -i.bak 's/--- a\//--- frameworks\/base\//g' .repo/local_manifests/enabled/oms-frameworks_base.patch
sed -i.bak 's/--- a\//--- frameworks\/native\//g' .repo/local_manifests/enabled/oms-frameworks_native.patch
sed -i.bak 's/--- a\//--- system\/sepolicy\//g' .repo/local_manifests/enabled/oms-system_sepolicy.patch
sed -i.bak 's/+++ b\//+++ frameworks\/base\//g' .repo/local_manifests/enabled/oms-frameworks_base.patch
sed -i.bak 's/+++ b\//+++ frameworks\/native\//g' .repo/local_manifests/enabled/oms-frameworks_native.patch
sed -i.bak 's/+++ b\//+++ system\/sepolicy\//g' .repo/local_manifests/enabled/oms-system_sepolicy.patch
rm .repo/local_manifests/enabled/oms-*.bak
