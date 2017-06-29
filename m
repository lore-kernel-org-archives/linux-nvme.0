From: vrothberg@suse.com (Valentin Rothberg)
Date: Thu, 29 Jun 2017 08:59:07 +0200
Subject: [PATCH] nvme: Makefile: remove dead build rule
Message-ID: <20170629065907.13132-1-vrothberg@suse.com>

Remove dead build rule for drivers/nvme/host/scsi.c which has been
removed by commit ("nvme: Remove SCSI translations").

Signed-off-by: Valentin Rothberg <vrothberg at suse.com>
---
 drivers/nvme/host/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index f1a7d945fbb6..cc0aacb4c8b4 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 
 nvme-core-y				:= core.o
-nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
 nvme-y					+= pci.o
-- 
2.12.3
