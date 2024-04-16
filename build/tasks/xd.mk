#
# Copyright (C) 2024 xdroidOSS
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(XDROID_OFFICIAL),true)
XDROID_TARGET_PACKAGE := $(PRODUCT_OUT)/$(XDROID_REVISION)_SIGNED.zip
else
XDROID_TARGET_PACKAGE := $(PRODUCT_OUT)/$(XDROID_REVISION).zip
endif

.PHONY: xd
xd: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(XDROID_TARGET_PACKAGE)
	@echo "Done"
	@echo -e "\t ===============================-Package complete-========================================="
	@echo -e "\t Zip: $(XDROID_TARGET_PACKAGE)"
	@echo -e "\t Size: `du -sh $(XDROID_TARGET_PACKAGE) | awk '{print $$1}' `"
	@echo -e "\t xdroid | #minimalistEra"
	@echo -e "\t =========================================================================================="
