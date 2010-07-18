# Build configuration for AOSP on HTC Legend
$(call inherit-product, build/target/product/generic.mk)
include vendor/htc/legend/device_legend.mk

PRODUCT_NAME := htc_legend
PRODUCT_BRAND := htc_wwe
PRODUCT_DEVICE := legend

# The user-visible product name
PRODUCT_MODEL := Legend
PRODUCT_MANUFACTURER := HTC

include frameworks/base/data/sounds/AudioPackage4.mk

PRODUCT_LOCALES += mdpi
