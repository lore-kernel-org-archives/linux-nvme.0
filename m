From: igor.j.konopko@intel.com (Igor Konopko)
Date: Fri, 23 Nov 2018 16:58:10 +0100
Subject: [PATCH] nvme: Fix PCIe surprise removal scenario
Message-ID: <20181123155810.60246-1-igor.j.konopko@intel.com>

This patch fixes kernel OOPS for surprise removal
scenario for PCIe connected NVMe drives.

After latest changes, when PCIe device is not present,
nvme_dev_remove_admin() calls blk_cleanup_queue() on
admin queue, which frees hctx for that queue.
Moment later, on the same path nvme_kill_queues()
calls blk_mq_unquiesce_queue() on admin queue and
tries to access hctx of it, which leads to
following OOPS scenario:

Oops: 0000 [#1] SMP PTI
RIP: 0010:sbitmap_any_bit_set+0xb/0x40
Call Trace:
 blk_mq_run_hw_queue+0xd5/0x150
 blk_mq_run_hw_queues+0x3a/0x50
 nvme_kill_queues+0x26/0x50
 nvme_remove_namespaces+0xb2/0xc0
 nvme_remove+0x60/0x140
 pci_device_remove+0x3b/0xb0

Fixes: cb4bfda62afa2 ("nvme-pci: fix hot removal during error handling")
Signed-off-by: Igor Konopko <igor.j.konopko at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 65c42448e904..5aff95389694 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3601,7 +3601,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q)
+	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-- 
2.14.5
