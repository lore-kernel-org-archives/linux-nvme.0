From: swise@opengridcomputing.com (Steve Wise)
Date: Sun, 12 Jun 2016 23:53:17 -0700
Subject: [PATCH] nvme-rdma: don't use IB-CM status code in reject path
Message-ID: <20160614175333.853CCE0753@smtp.ogc.us>

Instead, check the private data length to determine if there
is private data in the reject.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7506431..e1205c0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1208,7 +1208,7 @@ out_destroy_queue_ib:
 static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
 		struct rdma_cm_event *ev)
 {
-	if (ev->status == IB_CM_REJ_CONSUMER_DEFINED) {
+	if (ev->param.conn.private_data_len) {
 		struct nvme_rdma_cm_rej *rej =
 			(struct nvme_rdma_cm_rej *)ev->param.conn.private_data;
 
-- 
2.7.0
