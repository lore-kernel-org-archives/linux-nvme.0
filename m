From: colin.king@canonical.com (Colin King)
Date: Sun, 25 Sep 2016 15:01:48 -0700
Subject: [PATCH] nvme-rdma: add missing \n to end of dev_err message
Message-ID: <20160925220148.13300-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err message is missing a \n, so add it. Also
break line as it was over 80 chars wide.

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 69e1fb7..3f32995 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1227,7 +1227,8 @@ static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
 			(struct nvme_rdma_cm_rej *)ev->param.conn.private_data;
 
 		dev_err(queue->ctrl->ctrl.device,
-			"Connect rejected, status %d.", le16_to_cpu(rej->sts));
+			"Connect rejected, status %d.\n",
+			le16_to_cpu(rej->sts));
 		/* XXX: Think of something clever to do here... */
 	} else {
 		dev_err(queue->ctrl->ctrl.device,
-- 
2.9.3
