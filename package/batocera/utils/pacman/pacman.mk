################################################################################
#
# pacman Package Manager
#
################################################################################

PACMAN_VERSION = 5.2.1
PACMAN_SITE = https://sources.archlinux.org/other/pacman
PACMAN_SOURCES = pacman-$(PACMAN_VERSION).tar.gz
PACMAN_LICENSE = GPLv2
PACMAN_DEPENDENCIES = glibc libarchive libcurl libgpgme openssl

define BATOCERA_PACMAN_INSTALL_CONF
	mkdir -p $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman
	mkdir -p $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman/db
	mkdir -p $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman/hooks
	mkdir -p $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman/pkg
	rm -f $(TARGET_DIR)/usr/bin/makepkg
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/utils/pacman/pacman.conf $(TARGET_DIR)/etc/pacman.conf
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/utils/pacman/batocera-makepkg $(TARGET_DIR)/usr/bin/batocera-makepkg
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/utils/pacman/batocera-pacman-batoexec $(TARGET_DIR)/usr/bin/batocera-pacman-batoexec
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/utils/pacman/batocera-install.hook $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman/hooks/batocera-install.hook
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/utils/pacman/batocera-uninstall.hook $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman/hooks/batocera-uninstall.hook
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/utils/pacman/userdata_pacman.conf $(TARGET_DIR)/usr/share/batocera/datainit/system/pacman/pacman.conf
endef

PACMAN_POST_INSTALL_TARGET_HOOKS = BATOCERA_PACMAN_INSTALL_CONF

$(eval $(autotools-package))