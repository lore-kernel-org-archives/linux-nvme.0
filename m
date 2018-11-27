From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Nov 2018 16:06:46 +0100
Subject: [PATCH 3/3 v2] nvme: deprecate the multipath=0 module option
In-Reply-To: <afb3bc49-522a-6587-7a3c-d15416f31195@grimberg.me>
References: <20181120162734.2013-1-hch@lst.de>
 <20181120162734.2013-4-hch@lst.de>
 <afb3bc49-522a-6587-7a3c-d15416f31195@grimberg.me>
Message-ID: <20181127150646.GA25947@lst.de>

This was intended as a bridge for pre-existing setups if there were
any, and is not intended to build long-term solutions on top.
Deprecate it and print a warning for each controller found when it
is set.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/multipath.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9901afd804ce..5f253839f517 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -273,9 +273,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing data could
 	 * change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
+	if (!(ctrl->subsys->cmic & (1 << 1)))
 		return 0;
 
+	if (!multipath) {
+		dev_warn(ctrl->device,
+"multipath=0 module option is deprecated and will be removed in 2020.\n");
+		return 0;
+	}
+
 	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!q)
 		goto out;
-- 
2.19.1
