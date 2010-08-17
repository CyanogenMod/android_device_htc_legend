# common settings for all builds

$(call inherit-product, frameworks/base/data/sounds/AudioPackage4.mk)
$(call inherit-product, build/target/product/generic.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

DEVICE_PACKAGE_OVERLAYS := device/htc/legend/overlay

WITH_WINDOWS_MEDIA := true

PRODUCT_LOCALES += de_AT de_CH mdpi

PRODUCT_PACKAGES += \
    lights.legend \
    sensors.legend

#TODO remove if is this breaks something
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=htc_legend \
	BUILD_VERSION_TAGS=release-keys \
	TARGET_BUILD_TYPE=userdebug \
	BUILD_ID=FRF91 \
	BUILD_DISPLAY_ID=FRF91 \
	BUILD_FINGERPRINT="google/passion/passion/mahimahi:2.2/FRF91/43546:user/release-keys" \
	PRIVATE_BUILD_DESC="legend-user 2.2 FRF91 43546 release-keys"

PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.enable_bypass=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.com.google.clientidbase=android-google \
    keyguard.no_require_sim=true \
    ro.media.enc.file.format       = 3gp,mp4 \
    ro.media.enc.vid.codec         = m4v,h263 \
    ro.media.enc.vid.h263.width    = 176,640 \
    ro.media.enc.vid.h263.height   = 144,480 \
    ro.media.enc.vid.h263.bps      = 64000,1600000 \
    ro.media.enc.vid.h263.fps      = 1,30 \
    ro.media.enc.vid.m4v.width     = 176,640 \
    ro.media.enc.vid.m4v.height    = 144,480 \
    ro.media.enc.vid.m4v.bps       = 64000,1600000 \
    ro.media.enc.vid.m4v.fps       = 1,30 \
    ro.com.google.networklocation=1 \
    ro.com.google.locationfeatures=1 \
    ro.com.google.gmsversion=2.2_r2 \
    dalvik.vm.dexopt-flags=m=y
