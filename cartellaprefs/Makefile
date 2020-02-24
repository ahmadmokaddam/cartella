include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CartellaPrefs

CartellaPrefs_FILES = $(wildcard *.m) #makes compiler include the other cells/pages of prefs
CartellaPrefs_INSTALL_PATH = /Library/PreferenceBundles
CartellaPrefs_FRAMEWORKS = UIKit
CartellaPrefs_PRIVATE_FRAMEWORKS = Preferences
CartellaPrefs_CFLAGS = -fobjc-arc
CartellaPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CartellaPrefs.plist$(ECHO_END)
