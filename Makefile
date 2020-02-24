ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 192.168.0.172 #I think I can safely leave this here

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Cartella

Cartella_FILES = Cartella.xm
Cartella_CFLAGS = -fobjc-arc
Cartella_EXTRA_FRAMEWORKS += Cephei #I use Cephei because it's convenient

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += cartellaprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
