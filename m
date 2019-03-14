From: marcin.dziegielewski@intel.com (Marcin Dziegielewski)
Date: Thu, 14 Mar 2019 14:41:49 +0100
Subject: [PATCH] nvme: lightnvm: expose OC devices as zero size to OS
Message-ID: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>

Open channel devices are not able to handle traditional
IO requests addressed by LBA, so following current
approach to exposing special nvme devices as zero size
(e.g. with namespace formatted to use metadata) also
open channel devices should be exposed as zero size
to OS.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski at intel.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07bf2bf..52cd5c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1606,7 +1606,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
+	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
+	    ns->ndev)
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-- 
1.8.3.1
