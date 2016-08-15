From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Mon, 15 Aug 2016 09:47:37 -0700
Subject: [PATCH v2 3/5] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1471279659-25951-4-git-send-email-james_p_freyensee@linux.intel.com>

Now that the host will be sending sqsize 0-based values,
the target need to be adjusted as well.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/target/rdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e06d504..68b7b04 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1004,11 +1004,11 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 	queue->host_qid = le16_to_cpu(req->qid);
 
 	/*
-	 * req->hsqsize corresponds to our recv queue size
-	 * req->hrqsize corresponds to our send queue size
+	 * req->hsqsize corresponds to our recv queue size plus 1
+	 * req->hrqsize corresponds to our send queue size plus 1
 	 */
-	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
-	queue->send_queue_size = le16_to_cpu(req->hrqsize);
+	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
+	queue->send_queue_size = le16_to_cpu(req->hrqsize) + 1;
 
 	if (!queue->host_qid && queue->recv_queue_size > NVMF_AQ_DEPTH)
 		return NVME_RDMA_CM_INVALID_HSQSIZE;
-- 
2.7.4
