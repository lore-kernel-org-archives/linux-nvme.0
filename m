From: jsmart2021@gmail.com (James Smart)
Date: Sat, 27 Oct 2018 12:41:54 -0700
Subject: [PATCH] nvme-fc: fix request private initialization
Message-ID: <20181027194154.3965-1-jsmart2021@gmail.com>

The patch made to avoid Coverity reporting of out of bounds access
on aen_op moved the assignment of a pointer, leaving it null when it
was subsequently used to calculate a private pointer. Thus the private
pointer was bad.

Move/correct the private pointer initialization to be in sync with the
patch.

Fixes: 0d2bdf9f4134 ("nvme-fc: rework the request initialization code")
Signed-off-by: James Smart <jsmart2021 at gmail.com>
---

This kills all nvme-fc initiators, so rather critical we merge it
quickly.

The patch that introduced the issue was in the "nvme updates for Linux 4.20"
pulled by Jens on 10/19

 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fd6899e9fa2b..854cc3801bda 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1707,7 +1707,6 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	op->fcp_req.rspaddr = &op->rsp_iu;
 	op->fcp_req.rsplen = sizeof(op->rsp_iu);
 	op->fcp_req.done = nvme_fc_fcpio_done;
-	op->fcp_req.private = &op->fcp_req.first_sgl[SG_CHUNK_SIZE];
 	op->ctrl = ctrl;
 	op->queue = queue;
 	op->rq = rq;
@@ -1755,6 +1754,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	if (res)
 		return res;
 	op->op.fcp_req.first_sgl = &op->sgl[0];
+	op->op.fcp_req.private = &op->priv[0];
 	return res;
 }
 
-- 
2.13.7
