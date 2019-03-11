From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:02:25 -0700
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size exceeds
 PAGE_SIZE
In-Reply-To: <20190311220227.23656-1-sagi@grimberg.me>
References: <20190311220227.23656-1-sagi@grimberg.me>
Message-ID: <20190311220227.23656-2-sagi@grimberg.me>

If our target exposed a namespace with a block size that is greater
than PAGE_SIZE, set 0 capacity on the namespace as we do not support it.

This issue encountered when the nvmet namespace was backed by a tempfile.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7321da21f8c9..e08979094eb5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1610,6 +1610,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
+	if (ns->lba_shift > PAGE_SHIFT) {
+		/* unsupported block size, set capacity to 0 later */
+		bs = (1 << 9);
+	}
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
@@ -1621,7 +1625,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
+	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
+	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-- 
2.17.1
