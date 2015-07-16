From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 16 Jul 2015 16:51:27 -0600
Subject: [PATCHv4 1/2] NVMe: Unify SQ entry writing and doorbell ringing
In-Reply-To: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>
References: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1437087088-1628-2-git-send-email-jonathan.derrick@intel.com>

This patch changes sq_cmd writers to instead create their command on
the stack. __nvme_submit_cmd copies the sq entry to the queue and writes
the doorbell.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/block/nvme-core.c | 80 +++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e511271..ef5ef76 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -720,18 +720,16 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
 		struct nvme_iod *iod)
 {
-	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	struct nvme_command cmnd;
 
-	memcpy(cmnd, req->cmd, sizeof(struct nvme_command));
-	cmnd->rw.command_id = req->tag;
+	memcpy(&cmnd, req->cmd, sizeof(cmnd));
+	cmnd.rw.command_id = req->tag;
 	if (req->nr_phys_segments) {
-		cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
+		cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
 	}
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	__nvme_submit_cmd(nvmeq, &cmnd);
 }
 
 /*
@@ -744,45 +742,41 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 {
 	struct nvme_dsm_range *range =
 				(struct nvme_dsm_range *)iod_list(iod)[0];
-	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	struct nvme_command cmnd;
 
 	range->cattr = cpu_to_le32(0);
 	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
 	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 
-	memset(cmnd, 0, sizeof(*cmnd));
-	cmnd->dsm.opcode = nvme_cmd_dsm;
-	cmnd->dsm.command_id = req->tag;
-	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
-	cmnd->dsm.nr = 0;
-	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+	memset(&cmnd, 0, sizeof(cmnd));
+	cmnd.dsm.opcode = nvme_cmd_dsm;
+	cmnd.dsm.command_id = req->tag;
+	cmnd.dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd.dsm.prp1 = cpu_to_le64(iod->first_dma);
+	cmnd.dsm.nr = 0;
+	cmnd.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	__nvme_submit_cmd(nvmeq, &cmnd);
 }
 
 static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 								int cmdid)
 {
-	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	struct nvme_command cmnd;
 
-	memset(cmnd, 0, sizeof(*cmnd));
-	cmnd->common.opcode = nvme_cmd_flush;
-	cmnd->common.command_id = cmdid;
-	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+	memset(&cmnd, 0, sizeof(cmnd));
+	cmnd.common.opcode = nvme_cmd_flush;
+	cmnd.common.command_id = cmdid;
+	cmnd.common.nsid = cpu_to_le32(ns->ns_id);
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	__nvme_submit_cmd(nvmeq, &cmnd);
 }
 
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
 	struct request *req = iod_get_private(iod);
-	struct nvme_command *cmnd;
+	struct nvme_command cmnd;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -794,19 +788,17 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
-	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
-	memset(cmnd, 0, sizeof(*cmnd));
-
-	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
-	cmnd->rw.command_id = req->tag;
-	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
-	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	memset(&cmnd, 0, sizeof(cmnd));
+	cmnd.rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
+	cmnd.rw.command_id = req->tag;
+	cmnd.rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
+	cmnd.rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd.rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
 	if (blk_integrity_rq(req)) {
-		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
+		cmnd.rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
@@ -815,19 +807,17 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 		case NVME_NS_DPS_PI_TYPE2:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD |
 					NVME_RW_PRINFO_PRCHK_REF;
-			cmnd->rw.reftag = cpu_to_le32(
+			cmnd.rw.reftag = cpu_to_le32(
 					nvme_block_nr(ns, blk_rq_pos(req)));
 			break;
 		}
 	} else if (ns->ms)
 		control |= NVME_RW_PRINFO_PRACT;
 
-	cmnd->rw.control = cpu_to_le16(control);
-	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+	cmnd.rw.control = cpu_to_le16(control);
+	cmnd.rw.dsmgmt = cpu_to_le32(dsmgmt);
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	__nvme_submit_cmd(nvmeq, &cmnd);
 
 	return 0;
 }
-- 
2.1.4
