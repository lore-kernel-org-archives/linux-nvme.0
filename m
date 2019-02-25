From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 25 Feb 2019 13:00:04 +0200
Subject: [PATCH 1/1] nvme: avoid double dereference to convert le to cpu
Message-ID: <1551092404-16456-1-git-send-email-maxg@mellanox.com>

Use le16_to_cpu instead of le16_to_cpup and le64_to_cpu instead of
le64_to_cpup. This will also align the code to nvme-core driver
convention.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68..2323375 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1548,7 +1548,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
+	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
 	blk_mq_freeze_queue(disk->queue);
@@ -2501,7 +2501,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
-	ctrl->oncs = le16_to_cpup(&id->oncs);
+	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-- 
1.8.3.1
