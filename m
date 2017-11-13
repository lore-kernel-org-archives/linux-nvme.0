From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 13 Nov 2017 13:36:50 -0600
Subject: [PATCH] nvme: host: core: fix NULL pointer dereference in
 nvme_pr_command
Message-ID: <20171113193650.GA2832@embeddedor.com>

_head_ pointer is being dereferenced when it is NULL.

Fix this by moving the code that dereferences such pointer after it has
been properly initialized in function nvme_get_ns_from_disk.

Addresses-Coverity-ID: 1461344
Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme subsystems")
Signed-off-by: Gustavo A. R. Silva <garsilva at embeddedor.com>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25da74d..9b9c324 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1452,16 +1452,16 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	put_unaligned_le64(key, &data[0]);
 	put_unaligned_le64(sa_key, &data[8]);
 
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(head->ns_id);
-	c.common.cdw10[0] = cpu_to_le32(cdw10);
-
 	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
-	if (unlikely(!ns))
+	if (unlikely(!ns)) {
 		ret = -EWOULDBLOCK;
-	else
+	} else {
+		memset(&c, 0, sizeof(c));
+		c.common.opcode = op;
+		c.common.nsid = cpu_to_le32(head->ns_id);
+		c.common.cdw10[0] = cpu_to_le32(cdw10);
 		ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
+	}
 	nvme_put_ns_from_disk(head, srcu_idx);
 	return ret;
 }
-- 
2.7.4
