#
# Copyright (C) 2020 The ConquerOS Project
#				(C) 2021-2022 The xdroidOSS && Prjkt
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

XDROID_HOST_TIME := $(shell date +"%Y%m%d-%H%M")
XDROID_BUILD_DATE := $(shell date -u +%d%m%Y)
XDROID_BUILD_TIME := $(shell date -u +%H%M)
XDROID_BUILD_DATE_TIME := $(XDROID_BUILD_DATE)$(XDROID_BUILD_TIME)

ifndef XDROID_BUILD_TYPE
   XDROID_BUILD_TYPE := REL
endif

XDROID_VERSION := 13
XDROID_ANDROID := 13.0
XDROID_VERSION_PLATFORM := $(XDROID_ANDROID).$(XDROID_VERSION)
XDROID_PLATFORM_RELEASE_OR_CODENAME := 13.0
XDROID_REVISION := INA.XD.$(XDROID_ANDROID).$(XDROID_VERSION)-$(XDROID_BUILD)-$(XDROID_BUILD_DATE)-$(XDROID_BUILD_TIME)-$(XDROID_BUILD_TYPE)
XDROID_BUILD_NUMBER := XD.r$(XDROID_VERSION).$(XDROID_HOST_TIME)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.aosp.revision=$(AOSP_REVISION) \
   ro.xdroid.fullver=$(XDROID_VERSION_PLATFORM) \
   ro.xdroid.platform_release_or_codename=$(XDROID_PLATFORM_RELEASE_OR_CODENAME) \
   ro.xdroid.revision=$(XDROID_REVISION) \
   ro.xdroid.build.security_patch=$(XDROID_SECURITY_PATCH) \
   ro.xdroid.build.number=$(XDROID_BUILD_NUMBER) \
   ro.build.datetime=$(XDROID_BUILD_DATE_TIME)
