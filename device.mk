#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# ConsumerIR
TARGET_HAS_NO_CONSUMERIR := true

# Cryptfshw
TARGET_EXCLUDE_CRYPTFSHW := true

# Gatekeeper
TARGET_USES_DEVICE_SPECIFIC_GATEKEEPER := true

# Keymaster
TARGET_USES_DEVICE_SPECIFIC_KEYMASTER := true

# Vibrator
ifneq ($(TARGET_KERNEL_VERSION),4.19)
TARGET_USES_DEVICE_SPECIFIC_VIBRATOR := true
endif

# Inherit from mithorium-common
$(call inherit-product, device/xiaomi/mithorium-common/mithorium.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Overlays
PRODUCT_PACKAGES += \
    nokia_deadpool_overlay \
    nokia_panther_overlay \
    nokia_panther_overlay_Snap

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
ifneq ($(TARGET_KERNEL_VERSION),4.19)
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-haptics
endif

# Boot animation
TARGET_SCREEN_HEIGHT := 1440
TARGET_SCREEN_WIDTH := 720

# Dynamic Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# Permissions
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_olive/android.hardware.fingerprint.xml

# A/B
PRODUCT_PACKAGES += \
    update_engine \
    update_verifier

# A/B - bootctrl
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service

# A/B - Postinstallation - otapreopt
PRODUCT_PACKAGES += \
    otapreopt_script

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# A/B - Postinstallation - Userdata checkpoint
PRODUCT_PACKAGES += \
    checkpoint_gc

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.xml,$(LOCAL_PATH)/audio/,$(TARGET_COPY_OUT_ODM)/etc/)

# Camera
#PRODUCT_PACKAGES += \
#    camera.msm8937

# Filesystem
PRODUCT_PACKAGES += \
    e2fsck_ramdisk \
    tune2fs_ramdisk \
    resize2fs_ramdisk

ifeq ($(TARGET_KERNEL_VERSION),4.19)
# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
endif

# Fingerprint
#PRODUCT_PACKAGES += \
#    android.hardware.biometrics.fingerprint@2.1-service.nokia_nokia439 \
#    android.hardware.biometrics.fingerprint@2.2

# Recovery
PRODUCT_COPY_FILES += \
    vendor/nokia/nokia439/proprietary/vendor/bin/hvdcp_opti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/hvdcp_opti

# Rootdir
PRODUCT_PACKAGES += \
    fstab.qcom_ramdisk \
    init.xiaomi.device.rc \
    init.xiaomi.device.sh

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Vibrator
ifneq ($(TARGET_KERNEL_VERSION),4.19)
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.3-service.nokia_nokia439
endif

# Inherit from vendor blobs
$(call inherit-product, vendor/nokia/nokia439/nokia439-vendor.mk)
