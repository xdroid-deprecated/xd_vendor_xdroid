#
# Copyright (C) 2024 xdroidOSS
#
# SPDX-License-Identifier: Apache-2.0
#

# Bootanimation
ifeq ($(XD_BOOT),1080)
     PRODUCT_COPY_FILES += vendor/xdroid/bootanimation/xd_boot_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(XD_BOOT),1440)
     PRODUCT_COPY_FILES += vendor/xdroid/bootanimation/xd_boot_1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(XD_BOOT),720)
     PRODUCT_COPY_FILES += vendor/xdroid/bootanimation/xd_boot_720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
    ifeq ($(XD_BOOT),)
        $(warning "XD_BOOT is undefined, assuming 1080p")
    else
        $(warning "Current bootanimation res is not supported, forcing 1080p")
    endif
    PRODUCT_COPY_FILES += vendor/xdroid/bootanimation/xd_boot_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif
