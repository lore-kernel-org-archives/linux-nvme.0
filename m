From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Nov 2017 13:36:49 -0700
Subject: [PATCH 1/2] nvme: Fix NULL dereference on reservation request
Message-ID: <20171116203650.19591-1-keith.busch@intel.com>

This fixes using the NULL 'head' before getting the reference. It is
however possible the head will always be NULL, so this patch uses the
struct nvme_ns to get the ns_id field.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25da74d310d1..a2ab4e440bea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1449,19 +1449,19 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	int srcu_idx, ret;
 	u8 data[16] = { 0, };
 
+	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		return -EWOULDBLOCK;
+
 	put_unaligned_le64(key, &data[0]);
 	put_unaligned_le64(sa_key, &data[8]);
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(head->ns_id);
+	c.common.nsid = cpu_to_le32(ns->head->ns_id);
 	c.common.cdw10[0] = cpu_to_le32(cdw10);
 
-	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
-	if (unlikely(!ns))
-		ret = -EWOULDBLOCK;
-	else
-		ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+	ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
 	nvme_put_ns_from_disk(head, srcu_idx);
 	return ret;
 }
-- 
2.13.6
