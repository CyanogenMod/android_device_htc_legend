LOCAL_PATH := $(call my-dir)


# kernel

ifeq ($(TARGET_PREBUILT_KERNEL),)
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/files/kernel
endif

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)





# shared libs

include $(CLEAR_VARS)
LOCAL_MODULE := libcamera.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libgps.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := liboemcamera.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libmm-adspsvc.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libOmxH264Dec.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libOmxMpeg4Dec.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libOmxVidEnc.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_SRC_FILES := proprietary/lib/$(LOCAL_MODULE)
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_PREBUILT)



# misc

file := $(TARGET_OUT_KEYLAYOUT)/legend-keypad.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/files/legend-keypad.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_OUT_KEYLAYOUT)/h2w_headset.kl
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/files/h2w_headset.kl | $(ACP)
	$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.legend.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/files/init.legend.rc | $(ACP)
	$(transform-prebuilt-to-target)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := legend-keypad.kcm
include $(BUILD_KEY_CHAR_MAP)


# other proprietary files
PRODUCT_COPY_FILES += \
	device/htc/inc/media_profiles.xml:system/etc/media_profiles.xml \
	frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	$(LOCAL_PATH)/files/etc/fstab:system/etc/fstab \
	$(LOCAL_PATH)/files/etc/pvasflocal.cfg:system/etc/pvasflocal.cfg \
	$(LOCAL_PATH)/files/etc/vold.fstab:system/etc/vold.fstab \
	$(LOCAL_PATH)/files/etc/media_profiles.xml:system/etc/media_profiles.xml \
	$(LOCAL_PATH)/proprietary/bin/akmd:system/bin/akmd \
	$(LOCAL_PATH)/proprietary/bin/btipsd:system/bin/btipsd \
	$(LOCAL_PATH)/proprietary/bin/wpa_supplicant:system/bin/wpa_supplicant \
	$(LOCAL_PATH)/proprietary/etc/firmware/avpr.bts:system/etc/firmware/avpr.bts \
	$(LOCAL_PATH)/proprietary/etc/firmware/fmc_init_1273.2.bts:system/etc/firmware/fmc_init_1273.2.bts \
	$(LOCAL_PATH)/proprietary/etc/firmware/fm_rx_init_1273.2.bts:system/etc/firmware/fm_rx_init_1273.2.bts \
	$(LOCAL_PATH)/proprietary/etc/firmware/tiinit_7.2.31.bts:system/etc/firmware/tiinit_7.2.31.bts \
	$(LOCAL_PATH)/proprietary/etc/firmware/vac_config.ini:system/etc/firmware/vac_config.ini \
	$(LOCAL_PATH)/proprietary/etc/firmware/wl1271.bin:system/etc/firmware/wl1271.bin \
	$(LOCAL_PATH)/proprietary/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
	$(LOCAL_PATH)/proprietary/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \
	$(LOCAL_PATH)/proprietary/etc/wifi/Fw1273_CHIP.bin:system/etc/wifi/Fw1273_CHIP.bin \
	$(LOCAL_PATH)/proprietary/etc/wifi/tiwlan.ini:system/etc/wifi/tiwlan.ini \
	$(LOCAL_PATH)/proprietary/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	$(LOCAL_PATH)/proprietary/etc/agps_rm:system/etc/agps_rm \
	$(LOCAL_PATH)/proprietary/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
	$(LOCAL_PATH)/proprietary/etc/AudioPara4.csv:system/etc/AudioPara4.csv \
	$(LOCAL_PATH)/proprietary/etc/AudioPara4_WB.csv:system/etc/AudioPara4_WB.csv \
	$(LOCAL_PATH)/proprietary/etc/AudioPara_HTC_FR.csv:system/etc/AudioPara_HTC_FR.csv \
	$(LOCAL_PATH)/proprietary/etc/AudioPara_HTC_WB_FR.csv:system/etc/AudioPara_HTC_WB_FR.csv \
	$(LOCAL_PATH)/proprietary/etc/AudioPreProcess.csv:system/etc/AudioPreProcess.csv \
	$(LOCAL_PATH)/proprietary/etc/WP_0C0AESN.db:system/etc/WP_0C0AESN.db \
	$(LOCAL_PATH)/proprietary/etc/WP_040CFRA.db:system/etc/WP_040CFRA.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0401ARA.db:system/etc/WP_0401ARA.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0404CHT.db:system/etc/WP_0404CHT.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0405CSY.db:system/etc/WP_0405CSY.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0407GER.db:system/etc/WP_0407GER.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0408GRK.db:system/etc/WP_0408GRK.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0409WWE.db:system/etc/WP_0409WWE.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0410ITA.db:system/etc/WP_0410ITA.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0413NLD.db:system/etc/WP_0413NLD.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0414NOR.db:system/etc/WP_0414NOR.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0415PLK.db:system/etc/WP_0415PLK.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0419RUS.db:system/etc/WP_0419RUS.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0804CHS.db:system/etc/WP_0804CHS.db \
	$(LOCAL_PATH)/proprietary/etc/WP_0816PTG.db:system/etc/WP_0816PTG.db \
	$(LOCAL_PATH)/proprietary/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
	$(LOCAL_PATH)/proprietary/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
	$(LOCAL_PATH)/proprietary/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
	$(LOCAL_PATH)/proprietary/lib/hw/gralloc.msm7k.so:system/lib/hw/gralloc.msm7k.so \
	$(LOCAL_PATH)/proprietary/lib/modules/sdio.ko:system/lib/modules/sdio.ko \
	$(LOCAL_PATH)/proprietary/lib/modules/tiwlan_drv.ko:system/lib/modules/tiwlan_drv.ko \
	$(LOCAL_PATH)/files/modules/tun.ko:system/lib/modules/tun.ko \
	$(LOCAL_PATH)/proprietary/lib/libaudioeq.so:system/lib/libaudioeq.so \
	$(LOCAL_PATH)/proprietary/lib/libAudioTrimmer.so:system/lib/libAudioTrimmer.so \
	$(LOCAL_PATH)/proprietary/lib/libgsl.so:system/lib/libgsl.so \
	$(LOCAL_PATH)/proprietary/lib/libhtc_acoustic.so:system/lib/libhtc_acoustic.so \
	$(LOCAL_PATH)/proprietary/lib/libhtc_ril.so:system/lib/libhtc_ril.so \
	$(LOCAL_PATH)/proprietary/lib/libinterstitial.so:system/lib/libinterstitial.so \
	$(LOCAL_PATH)/proprietary/lib/libmmclient.so:system/lib/libmmclient.so \
	$(LOCAL_PATH)/proprietary/lib/libmscompress.so:system/lib/libmscompress.so \
	$(LOCAL_PATH)/proprietary/lib/libObexJniWrapper.so:system/lib/libObexJniWrapper.so \
	$(LOCAL_PATH)/proprietary/lib/libOlaBase.so:system/lib/libOlaBase.so \
	$(LOCAL_PATH)/proprietary/lib/libomx_wmadec_sharedlibrary.so:system/lib/libomx_wmadec_sharedlibrary.so \
	$(LOCAL_PATH)/proprietary/lib/libomx_wmvdec_sharedlibrary.so:system/lib/libomx_wmvdec_sharedlibrary.so \
	$(LOCAL_PATH)/proprietary/lib/libpvasfcommon.so:system/lib/libpvasfcommon.so \
	$(LOCAL_PATH)/proprietary/lib/libpvasflocalpbreg.so:system/lib/libpvasflocalpbreg.so \
	$(LOCAL_PATH)/proprietary/lib/libpvasflocalpb.so:system/lib/libpvasflocalpb.so
