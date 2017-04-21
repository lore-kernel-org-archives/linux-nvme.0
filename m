From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:49:59 +0200
Subject: [PATCH 1/7] nvme/fc: mark two symbols static
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-2-hch@lst.de>

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 596b3a453b54..63819b12c1da 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1183,7 +1183,7 @@ nvme_fc_exit_aen_ops(struct nvme_fc_ctrl *ctrl)
 	}
 }
 
-void
+static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
@@ -1671,7 +1671,7 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 	return 0;
 }
 
-enum blk_eh_timer_return
+static enum blk_eh_timer_return
 nvme_fc_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
-- 
2.11.0
