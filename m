From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 14:58:06 +0200
Subject: [PATCH] nvme: add back dependency on CONFIG_BLOCK
Message-ID: <20160906125827.1595094-1-arnd@arndb.de>

A recent change removed the dependency on BLK_DEV_NVME, which implies
the dependency on PCI and BLOCK. We don't need CONFIG_PCI, but without
CONFIG_BLOCK we get tons of build errors, e.g.

In file included from drivers/nvme/host/core.c:16:0:
linux/blk-mq.h:182:33: error: 'struct gendisk' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
drivers/nvme/host/core.c: In function 'nvme_setup_rw':
drivers/nvme/host/core.c:295:21: error: implicit declaration of function 'rq_data_dir' [-Werror=implicit-function-declaration]
drivers/nvme/host/nvme.h: In function 'nvme_map_len':
drivers/nvme/host/nvme.h:217:6: error: implicit declaration of function 'req_op' [-Werror=implicit-function-declaration]
drivers/nvme/host/scsi.c: In function 'nvme_trans_bdev_limits_page':
drivers/nvme/host/scsi.c:768:85: error: implicit declaration of function 'queue_max_hw_sectors' [-Werror=implicit-function-declaration]

This adds back the specific CONFIG_BLOCK dependency to avoid broken
configurations.

Signed-off-by: Arnd Bergmann <arnd at arndb.de>
Fixes: aa71987472a9 ("nvme: fabrics drivers don't need the nvme-pci driver")
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0c644f7bdf80..4b6cfff4b5be 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -31,6 +31,7 @@ config NVME_FABRICS
 config NVME_RDMA
 	tristate "NVM Express over Fabrics RDMA host driver"
 	depends on INFINIBAND
+	depends on BLOCK
 	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
-- 
2.9.0
