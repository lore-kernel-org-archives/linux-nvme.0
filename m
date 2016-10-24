From: james.smart@broadcom.com (James Smart)
Date: Mon, 24 Oct 2016 08:50:52 -0700
Subject: [PATCH] nvme-fabrics: Add HAS_DMA to FC Transport Kconfigs
Message-ID: <580e2ddc.sdo3rtJa9FKNq/z9%james.smart@broadcom.com>


Add HAS_DMA to FC Transport host and target Kconfig

Obviously dependent on prior patches to add FC transport

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/Kconfig   | 1 +
 drivers/nvme/target/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index aacac94..90745a6 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -47,6 +47,7 @@ config NVME_RDMA
 config NVME_FC
 	tristate "NVM Express over Fabrics FC host driver"
 	depends on BLOCK
+	depends on HAS_DMA
 	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 0d88c23..d55576f 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -38,6 +38,7 @@ config NVME_TARGET_RDMA
 config NVME_TARGET_FC
 	tristate "NVMe over Fabrics FC target driver"
 	depends on NVME_TARGET
+	depends on HAS_DMA
 	help
 	  This enables the NVMe FC target support, which allows exporting NVMe
 	  devices over FC.
-- 
2.5.0
