#
# Copyright (C) 2024 xdroidOSS
#
# SPDX-License-Identifier: Apache-2.0
#

OFFICIAL_MAINTAINER = $(shell cat official-maintainer/maintainers.list | awk '{ print $$1 }')

ifdef XDROID_MAINTAINER
ifeq ($(filter $(XDROID_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(XDROID_MAINTAINER))
$(warning "xdroid: $(XDROID_MAINTAINER) is verified as official maintainer, build as official build.")
    XDROID_OFFICIAL = true
    include official-settings/sign.mk
else
$(warning "xdroid: Unofficial maintainer detected, building as unofficial build.")
endif
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.xdroid.maintainer=$(XDROID_MAINTAINER)
else
$(warning "xdroid: No maintainer name detected, building as unofficial build.")
endif
