From: colin.king@canonical.com (Colin King)
Date: Sun, 25 Sep 2016 15:04:13 -0700
Subject: [PATCH] nvme: add missing \n to end of dev_warn message
Message-ID: <20160925220413.13487-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_warn message is missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0..62a3644 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -855,7 +855,7 @@ static void abort_endio(struct request *req, int error)
 	struct nvme_queue *nvmeq = iod->nvmeq;
 	u16 status = req->errors;
 
-	dev_warn(nvmeq->dev->ctrl.device, "Abort status: 0x%x", status);
+	dev_warn(nvmeq->dev->ctrl.device, "Abort status: 0x%x\n", status);
 	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
 	blk_mq_free_request(req);
 }
-- 
2.9.3
