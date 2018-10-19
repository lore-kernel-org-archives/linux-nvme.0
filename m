From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Oct 2018 15:24:50 -0700
Subject: [PATCH] nvme: make sure ns head inherits underlying device limits
Message-ID: <20181019222450.25397-1-sagi@grimberg.me>

Whenever we update ns_head info, we need to make sure it is still
compatible with all underlying backing devices. Start with unlimited
stacking limits, and every info update iterate over siblings and
adjust queue limits.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdfbbeb4b2f8..6194b3ee30ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1480,6 +1480,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	struct nvme_ns *n;
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
@@ -1504,6 +1505,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	else
 		set_disk_ro(disk, false);
 
+	list_for_each_entry_rcu(n, &ns->head->list, siblings)
+		blk_queue_stack_limits(disk->queue, n->queue);
+
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
@@ -2958,6 +2962,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	if (ret)
 		goto out_cleanup_srcu;
 
+	blk_set_stacking_limits(&head->disk->queue->limits);
+
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
 
 	kref_get(&ctrl->subsys->ref);
-- 
2.17.1
