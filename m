From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Oct 2018 00:01:04 -0700
Subject: [PATCH v2] nvme: make sure ns head inherits underlying device limits
Message-ID: <20181031070104.5824-1-sagi@grimberg.me>

Whenever we update ns_head info, we need to make sure it is still
compatible with all underlying backing devices because although nvme
multipath doesn't have any explicit use of these limits, other devices
can still be stacked on top of it which may rely on the underlying limits.
Start with unlimited stacking limits, and every info update iterate over
siblings and adjust queue limits.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- fix change log with better reasoning

 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4325f1aeea1f..335f1e33e212 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1482,6 +1482,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	struct nvme_ns *n;
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
@@ -1506,6 +1507,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	else
 		set_disk_ro(disk, false);
 
+	list_for_each_entry_rcu(n, &ns->head->list, siblings)
+		blk_queue_stack_limits(disk->queue, n->queue);
+
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
@@ -2960,6 +2964,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	if (ret)
 		goto out_cleanup_srcu;
 
+	blk_set_stacking_limits(&head->disk->queue->limits);
+
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 
 	kref_get(&ctrl->subsys->ref);
-- 
2.17.1
