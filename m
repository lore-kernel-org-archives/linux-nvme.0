From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:27:34 +0100
Subject: [PATCH 3/3] nvme: deprecate the multipath=0 module option
In-Reply-To: <20181120162734.2013-1-hch@lst.de>
References: <20181120162734.2013-1-hch@lst.de>
Message-ID: <20181120162734.2013-4-hch@lst.de>

This was intended as a bridge for pre-existing setups if there were
any, and is not intended to build long-term solutions on top.
Explicitly it and print a warning for each controller found when it
is set.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/multipath.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index eec44e5ec294..3851c09695b5 100644
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
 	q = blk_alloc_queue_node(GFP_KERNEL, ctrl->numa_node);
 	if (!q)
 		goto out;
-- 
2.19.1
