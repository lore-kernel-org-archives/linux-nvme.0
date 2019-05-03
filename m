From: hare@suse.de (Hannes Reinecke)
Date: Fri,  3 May 2019 16:14:59 +0200
Subject: [PATCH] nvme-fc: trace sq head updates
Message-ID: <20190503141459.111641-1-hare@suse.de>

FC-NVMe has some detailed rules if and when SQ head pointer updates
should be send, but the spec is a tad unclear about the values.
So add tracing to the FC-NVMe driver to track this.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6d8451356eac..755c93a0c664 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -12,6 +12,7 @@
 
 #include "nvme.h"
 #include "fabrics.h"
+#include "trace.h"
 #include <linux/nvme-fc-driver.h>
 #include <linux/nvme-fc.h>
 
@@ -35,7 +36,8 @@ struct nvme_fc_queue {
 	u32			qnum;
 	u32			rqcnt;
 	u32			seqno;
-
+	u16			sq_head;
+	u16			sq_tail;
 	u64			connection_id;
 	atomic_t		csn;
 
@@ -1653,6 +1655,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
 			goto done;
 		}
+		queue->sq_head = cpu_to_le16(cqe->sq_head);
 		result = cqe->result;
 		status = cqe->status;
 		break;
@@ -1675,6 +1678,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+	trace_nvme_sq(rq, queue->sq_head,
+		      queue->sq_tail % ctrl->ctrl.sqsize);
 	nvme_end_request(rq, status, result);
 
 check_error:
@@ -2215,6 +2220,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	op->fcp_req.rcv_rsplen = 0;
 	op->fcp_req.status = NVME_SC_SUCCESS;
 	op->fcp_req.sqid = cpu_to_le16(queue->qnum);
+	queue->sq_tail++;
 
 	/*
 	 * validate per fabric rules, set fields mandated by fabric spec
-- 
2.16.4
