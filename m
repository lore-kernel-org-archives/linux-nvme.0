From: sbates@raithlin.com (sbates@raithlin.com)
Date: Mon,  5 Feb 2018 15:32:23 -0700
Subject: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate q_depth
Message-ID: <1517869943-3655-1-git-send-email-sbates@raithlin.com>

From: Stephen Bates <sbates@raithlin.com>

We should not be using the CMB to determine the permissable q_depth
when we don't plan to place any queues in the CMB. In the case of a
small CMB or large numbers of queues this could lead to shallow queues
when they don't need to be.

Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0bc6a9e..0d099e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1913,7 +1913,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (nr_io_queues == 0)
 		return 0;
 
-	if (dev->cmb && (dev->cmbsz & NVME_CMBSZ_SQS)) {
+	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
 		if (result > 0)
-- 
2.7.4
