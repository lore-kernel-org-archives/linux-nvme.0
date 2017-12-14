From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Dec 2017 11:20:32 -0700
Subject: [PATCH] nvme: Setup streams after initializing namespace head
Message-ID: <20171214182032.4762-1-keith.busch@intel.com>

Fixes a NULL pointer dereference.

Reported-by: Arnav Dawn <a.dawn at samsung.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9831a592bbb9..15cb0b6bfe4f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2870,7 +2870,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
-	nvme_setup_streams_ns(ctrl, ns);
 
 	id = nvme_identify_ns(ctrl, nsid);
 	if (!id)
@@ -2881,6 +2880,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (nvme_init_ns_head(ns, nsid, id, &new))
 		goto out_free_id;
+	nvme_setup_streams_ns(ctrl, ns);
 	
 #ifdef CONFIG_NVME_MULTIPATH
 	/*
-- 
2.13.6
