From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  2 Nov 2018 11:22:13 -0700
Subject: [PATCH v4] nvme: make sure ns head inherits underlying device limits
Message-ID: <20181102182213.23911-1-sagi@grimberg.me>

Whenever we update ns_head info, we need to make sure it is still
compatible with all underlying backing devices because although nvme
multipath doesn't have any explicit use of these limits, other devices
can still be stacked on top of it which may rely on the underlying limits.
Start with unlimited stacking limits, and every info update iterate over
siblings and adjust queue limits.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v3:
- move default stacking limits setting to multipath request queue creation
- apply stack limits adjustment only for the head disk (multipath disk
  node)

Changes from v2:
- fixed missing ifdef config (multipathing)

Changes from v1:
- fix change log with better reasoning
 drivers/nvme/host/core.c      | 4 +++-
 drivers/nvme/host/multipath.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 66903bb6d630..864673fe9bf8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1535,8 +1535,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->ndev)
 		nvme_nvm_update_nvm_info(ns);
 #ifdef CONFIG_NVME_MULTIPATH
-	if (ns->head->disk)
+	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
+		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+	}
 #endif
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5e3cc8c59a39..9901afd804ce 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -285,6 +285,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
+	blk_set_stacking_limits(&q->limits);
 
 	/* we need to propagate up the VMC settings */
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
-- 
2.17.1
