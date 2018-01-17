From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 17 Jan 2018 16:43:32 +0200
Subject: [PATCH 1/1] nvme-rdma: remove redundant reference between ib_device
 and tagset
Message-ID: <1516200212-15088-1-git-send-email-maxg@mellanox.com>

In the past, before adding f41725bb ("nvme-rdma: Use mr pool") commit,
we needed a reference on the ib_device as long as the tagset
was alive, as the MRs in the request structures needed a valid ib_device.
Now, we allocate/deallocate MR pool per and QP and consume on demand.

Also remove nvme_rdma_free_tagset function and use blk_mq_free_tag_set
instead, as it unneeded anymore.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a0bba7..5eee1d7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -666,15 +666,6 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl,
-		struct blk_mq_tag_set *set)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	blk_mq_free_tag_set(set);
-	nvme_rdma_dev_put(ctrl->device);
-}
-
 static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		bool admin)
 {
@@ -712,24 +703,9 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 
 	ret = blk_mq_alloc_tag_set(set);
 	if (ret)
-		goto out;
-
-	/*
-	 * We need a reference on the device as long as the tag_set is alive,
-	 * as the MRs in the request structures need a valid ib_device.
-	 */
-	ret = nvme_rdma_dev_get(ctrl->device);
-	if (!ret) {
-		ret = -EINVAL;
-		goto out_free_tagset;
-	}
+		return ERR_PTR(ret);
 
 	return set;
-
-out_free_tagset:
-	blk_mq_free_tag_set(set);
-out:
-	return ERR_PTR(ret);
 }
 
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -738,7 +714,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
+		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 	}
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
@@ -809,7 +785,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
+		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
@@ -821,7 +797,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 	nvme_rdma_stop_io_queues(ctrl);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
+		blk_mq_free_tag_set(ctrl->ctrl.tagset);
 	}
 	nvme_rdma_free_io_queues(ctrl);
 }
@@ -862,7 +838,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
+		blk_mq_free_tag_set(ctrl->ctrl.tagset);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
-- 
1.8.3.1
