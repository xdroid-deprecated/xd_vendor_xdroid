#
# Copyright (C) 2021-2022 The xdroidOSS && Prjkt
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