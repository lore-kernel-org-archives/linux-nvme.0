From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 Aug 2016 11:16:36 -0700
Subject: [PATCH 2/2] nvme: fabrics drivers don't need the nvme-pci driver
In-Reply-To: <1471544196-30525-1-git-send-email-hch@lst.de>
References: <1471544196-30525-1-git-send-email-hch@lst.de>
Message-ID: <1471544196-30525-3-git-send-email-hch@lst.de>

So select the NVME_CORE symbol instead of depending on BLK_DEV_NVME.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/Kconfig   | 2 +-
 drivers/nvme/target/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index db39d53..0c644f7 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -31,7 +31,7 @@ config NVME_FABRICS
 config NVME_RDMA
 	tristate "NVM Express over Fabrics RDMA host driver"
 	depends on INFINIBAND
-	depends on BLK_DEV_NVME
+	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
 	help
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index a5c31cb..3a5b9d0 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -15,8 +15,8 @@ config NVME_TARGET
 
 config NVME_TARGET_LOOP
 	tristate "NVMe loopback device support"
-	depends on BLK_DEV_NVME
 	depends on NVME_TARGET
+	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
 	help
-- 
2.1.4
