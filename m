From: james.smart@broadcom.com (James Smart)
Date: Mon, 26 Sep 2016 07:35:05 -0700
Subject: [PATCH 2/3] nvme-fabrics: set sqe.command_id in core not
 transports
Message-ID: <57e93219.xbYWGJXKaa4jLjGe%james.smart@broadcom.com>

set sqe.command_id in core not transports

Prior patch updated to correct pci and loop transports

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/core.c   | 3 ++-
 drivers/nvme/host/pci.c    | 1 -
 drivers/nvme/host/rdma.c   | 1 -
 drivers/nvme/target/loop.c | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 329381a..22e98ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -295,7 +295,6 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
-	cmnd->rw.command_id = req->tag;
 	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
@@ -335,6 +334,8 @@ int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	else
 		nvme_setup_rw(ns, req, cmd);
 
+	cmd->common.command_id = req->tag;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 47a44e9..f016926 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -609,7 +609,6 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto out;
 
-	cmnd.common.command_id = req->tag;
 	blk_mq_start_request(req);
 
 	spin_lock_irq(&nvmeq->q_lock);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9bbd886..539fcfc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1453,7 +1453,6 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	c->common.command_id = rq->tag;
 	blk_mq_start_request(rq);
 
 	map_len = nvme_map_len(rq);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d5df77d..1e511ae 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -193,7 +193,6 @@ static int nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		BUG_ON(iod->req.sg_cnt > req->nr_phys_segments);
 	}
 
-	iod->cmd.common.command_id = req->tag;
 	blk_mq_start_request(req);
 
 	schedule_work(&iod->work);
-- 
2.5.0
