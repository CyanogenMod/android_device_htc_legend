# common settings for all builds

DEVICE_PACKAGE_OVERLAYS := vendor/htc/legend/overlay

NO_DEFAULT_SOUNDS := true
include frameworks/base/data/sounds/AudioPackage4.mk

PRODUCT_LOCALES += mdpi

PRODUCT_COPY_FILES += \
    vendor/htc/legend/files/init.rc:root/init.rc


PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=htc_legend \
	BUILD_ID=ERE27 \
	BUILD_DISPLAY_ID=ERE27 \
	BUILD_FINGERPRINT="htc_wwe/htc_legend/legend/legend:2.1-update1/ERE27/183823:user/release-keys"


PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enterprise_mode=1 \
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
    ro.com.google.gmsversion=2.1_r4 \
    dalvik.vm.dexopt-flags=m=y
