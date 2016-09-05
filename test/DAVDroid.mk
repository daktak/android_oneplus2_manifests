LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := DAVDroid
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := DAVDroid

davdroid_root  := $(LOCAL_PATH)
davdroid_dir   := app
davdroid_out   := $(OUT_DIR)/target/common/obj/APPS/$(LOCAL_MODULE)_intermediates
davdroid_build := $(davdroid_root)/$(davdroid_dir)/build
davdroid_apk   := build/outputs/apk/$(davdroid_dir)-release-unsigned.apk

$(davdroid_root)/$(davdroid_dir)/$(davdroid_apk):
	rm -Rf $(davdroid_build)
	mkdir -p $(davdroid_out)
	ln -sf $(davdroid_out) $(davdroid_build)
	cd $(davdroid_root)/$(davdroid_dir) && JAVA_TOOL_OPTIONS="$(JAVA_TOOL_OPTIONS) -Dfile.encoding=UTF8" ../gradlew assembleRelease

LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := $(davdroid_dir)/$(davdroid_apk)
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)
