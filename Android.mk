ifeq ($(TARGET_DEVICE),legend)

LOCAL_PATH := $(my-dir)
subdir_makefiles := \
	$(LOCAL_PATH)/liblights/Android.mk \
	$(LOCAL_PATH)/libsensors/Android.mk

include $(subdir_makefiles)

endif
