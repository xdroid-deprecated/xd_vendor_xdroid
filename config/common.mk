#
# Copyright (C) 2020 The ConquerOS Project
# Copyright (C) 2021 a xdroid Prjkt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# xd. version
include vendor/xdroid/config/xd_version.mk

# xd. packages
include vendor/xdroid/config/xd_packages.mk

# xd. props
include vendor/xdroid/config/xd_props.mk

# xd. permissions
PRODUCT_COPY_FILES += \
    vendor/xdroid/config/permissions/xd_permissions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/xd_permissions_system.xml \
    vendor/xdroid/config/permissions/xd_permissions.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/xd_permissions_system-ext.xml \
    vendor/xdroid/config/permissions/xd_permissions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/xd_permissions_product.xml

# xd. signed
include vendor/xdroid/config/xd_signed.mk

# xd. xdroidUI
include vendor/xdroidui/config.mk

# xd. GMS
$(call inherit-product, vendor/gms/gms_mini.mk)
TARGET_SUPPORTS_GOOGLE_RECORDER ?= false
TARGET_INCLUDE_STOCK_ARCORE ?= false
TARGET_INCLUDE_LIVE_WALLPAPERS ?= false
TARGET_SUPPORTS_QUICK_TAP ?= true

# ART
# Optimize everything for preopt
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
# Use 64-bit dex2oat for better dexopt time.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/xdroid/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/xdroid/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/xdroid/prebuilt/common/bin/50-xdroid.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-xdroid.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/xdroid/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/xdroid/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/xdroid/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/xdroid/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/xdroid/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/xdroid/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/xdroid/overlay/common

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/xdroid/prebuilt/common/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sensitive_pn.xml

# Use default filter for problematic apps.
PRODUCT_DEXPREOPT_QUICKEN_APPS += \
    Dialer

# Do not preoptimize prebuilts when building GApps
DONT_DEXPREOPT_PREBUILTS := true

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/xdroid/overlay/dictionaries

# Disable EAP Proxy because it depends on proprietary headers
# and breaks WPA Supplicant compilation.
DISABLE_EAP_PROXY := true

# init.rc
$(foreach f,$(wildcard vendor/xdroid/prebuilt/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))
