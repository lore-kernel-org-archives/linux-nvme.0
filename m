From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:50:00 +0200
Subject: [PATCH 2/7] nvme/fc: don't byte swap command_id
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-3-hch@lst.de>

The command ID is a field for host only use and thus always is in
native endian.

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 63819b12c1da..68887818801e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1274,7 +1274,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 			     be32_to_cpu(op->rsp_iu.xfrd_len) !=
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
-			     op->rqno != le16_to_cpu(cqe->command_id))) {
+			     op->rqno != cqe->command_id)) {
 			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
 			goto done;
 		}
@@ -1830,7 +1830,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	sqe->rw.dptr.sgl.addr = 0;
 
 	/* odd that we set the command_id - should come from nvme-fabrics */
-	WARN_ON_ONCE(sqe->common.command_id != cpu_to_le16(op->rqno));
+	WARN_ON_ONCE(sqe->common.command_id != op->rqno);
 
 	if (op->rq) {				/* skipped on aens */
 		ret = nvme_fc_map_data(ctrl, op->rq, op);
-- 
2.11.0
