From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:06 +0300
Subject: [PATCH 1/7] nvme-rdma: pass tagset to directly nvme_rdma_free_tagset
In-Reply-To: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
Message-ID: <1507724952-13917-2-git-send-email-sagi@grimberg.me>

Instead of flagging admin/io.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf2ac5d893d5..9e040bbc08c9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -670,11 +670,10 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl, bool admin)
+static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl,
+		struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct blk_mq_tag_set *set = admin ?
-			&ctrl->admin_tag_set : &ctrl->tag_set;
 
 	blk_mq_free_tag_set(set);
 	nvme_rdma_dev_put(ctrl->device);
@@ -744,7 +743,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 	}
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
@@ -818,7 +817,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
@@ -830,7 +829,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
 	}
 	nvme_rdma_free_io_queues(ctrl);
 }
@@ -873,7 +872,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
-- 
2.7.4
