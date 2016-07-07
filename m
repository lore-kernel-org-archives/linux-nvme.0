From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  7 Jul 2016 11:01:26 +0200
Subject: [PATCH] nvme-loop: add configfs dependency
Message-ID: <20160707090144.3061799-1-arnd@arndb.de>

CONFIG_NVME_TARGET has a correct CONFIG_CONFIGFS_FS dependency, but the
newly added NVME_TARGET_LOOP is missing this, resulting in a link
failure:

drivers/nvme/built-in.o: In function `nvmet_init_configfs':
loop.c:(.init.text+0x2a0): undefined reference to `config_group_init'
loop.c:(.init.text+0x2c0): undefined reference to `config_group_init_type_name'
loop.c:(.init.text+0x318): undefined reference to `configfs_register_subsystem'
drivers/nvme/built-in.o: In function `nvmet_exit_configfs':
loop.c:(.exit.text+0x9c): undefined reference to `configfs_unregister_subsystem'

This adds the same dependency here.

Signed-off-by: Arnd Bergmann <arnd at arndb.de>
Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
---
 drivers/nvme/target/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index b77ce4350695..6bbd7890c3ad 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -16,6 +16,7 @@ config NVME_TARGET
 config NVME_TARGET_LOOP
 	tristate "NVMe loopback device support"
 	depends on BLK_DEV_NVME
+	depends on CONFIGFS_FS
 	select NVME_TARGET
 	select NVME_FABRICS
 	select SG_POOL
-- 
2.9.0
