From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 12:34:59 -0700
Subject: [PATCH v4 4/8] nvme-rdma: use rdma connection reject helper functions
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <35db2feb4dcac92924992d5655630aa70972ad00.1477426743.git.swise@opengridcomputing.com>

Also add nvme cm status strings and use them.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index fbdb226..f34edae 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -43,6 +43,28 @@
 
 #define NVME_RDMA_MAX_INLINE_SEGMENTS	1
 
+static const char *const nvme_rdma_cm_status_strs[] = {
+	[NVME_RDMA_CM_INVALID_LEN]	= "invalid length",
+	[NVME_RDMA_CM_INVALID_RECFMT]	= "invalid record format",
+	[NVME_RDMA_CM_INVALID_QID]	= "invalid queue ID",
+	[NVME_RDMA_CM_INVALID_HSQSIZE]	= "invalid host SQ size",
+	[NVME_RDMA_CM_INVALID_HRQSIZE]	= "invalid host RQ size",
+	[NVME_RDMA_CM_NO_RSC]		= "resource not found",
+	[NVME_RDMA_CM_INVALID_IRD]	= "invalid IRD",
+	[NVME_RDMA_CM_INVALID_ORD]	= "Invalid ORD",
+};
+
+static const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
+{
+	size_t index = status;
+
+	if (index < ARRAY_SIZE(nvme_rdma_cm_status_strs) &&
+	    nvme_rdma_cm_status_strs[index])
+		return nvme_rdma_cm_status_strs[index];
+	else
+		return "unrecognized reason";
+};
+
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
@@ -1222,17 +1244,25 @@ out_destroy_queue_ib:
 static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
 		struct rdma_cm_event *ev)
 {
-	if (ev->param.conn.private_data_len) {
-		struct nvme_rdma_cm_rej *rej =
-			(struct nvme_rdma_cm_rej *)ev->param.conn.private_data;
+	struct rdma_cm_id *cm_id = queue->cm_id;
+	int status = ev->status;
+	const char *rej_msg;
+	struct nvme_rdma_cm_rej *rej_data;
+	u8 rej_data_len;
+
+	rej_msg = rdma_reject_msg(cm_id, status);
+	rej_data = (struct nvme_rdma_cm_rej *)
+		   rdma_consumer_reject_data(cm_id, ev, &rej_data_len);
+
+	if (rej_data && rej_data_len >= sizeof(u16)) {
+		u16 sts = le16_to_cpu(rej_data->sts);
 
 		dev_err(queue->ctrl->ctrl.device,
-			"Connect rejected, status %d.", le16_to_cpu(rej->sts));
-		/* XXX: Think of something clever to do here... */
-	} else {
+		      "Connect rejected: status %d (%s) nvme status %d (%s).\n",
+		      status, rej_msg, sts, nvme_rdma_cm_msg(sts));
+	} else
 		dev_err(queue->ctrl->ctrl.device,
-			"Connect rejected, no private data.\n");
-	}
+			"Connect rejected: status %d (%s).\n", status, rej_msg);
 
 	return -ECONNRESET;
 }
-- 
2.7.0
