From: jsmart2021@gmail.com (James Smart)
Date: Wed, 22 Feb 2017 12:16:50 -0800
Subject: [PATCH v2] lpfc: add missing Kconfig NVME dependencies
Message-ID: <58adf1b2.pGf0m6CGsoX83xvw%jsmart2021@gmail.com>


add missing Kconfig NVME dependencies

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index d4023bf..2558434 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1240,6 +1240,7 @@ config SCSI_LPFC
 	tristate "Emulex LightPulse Fibre Channel Support"
 	depends on PCI && SCSI
 	depends on SCSI_FC_ATTRS
+	depends on NVME_FC && NVME_TARGET_FC
 	select CRC_T10DIF
 	help
           This lpfc driver supports the Emulex LightPulse
-- 
2.5.0
