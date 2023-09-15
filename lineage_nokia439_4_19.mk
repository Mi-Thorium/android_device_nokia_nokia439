#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Kernel
TARGET_KERNEL_VERSION := 4.19

# Inherit from nokia439 device
$(call inherit-product, device/nokia/nokia439/device.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    nokia_deadpool_overlay_lineage

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := nokia439_4_19
PRODUCT_NAME := lineage_nokia439_4_19
BOARD_VENDOR := Nokia
PRODUCT_BRAND := Nokia
PRODUCT_MODEL := SDM439
PRODUCT_MANUFACTURER := Nokia
TARGET_VENDOR := Nokia

PRODUCT_GMS_CLIENTID_BASE := android-nokia

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="Panther-user 11 RKQ1.200928.002 00WW_3_240 release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := "Nokia/Panther_00WW/PAN_sprout:11/RKQ1.200928.002/00WW_3_240:user/release-keys"
