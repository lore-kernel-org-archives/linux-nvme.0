From: axel.lin@ingics.com (Axel Lin)
Date: Sat, 20 Jun 2015 16:29:14 +0800
Subject: [PATCH] block: nvme-scsi: Catch kcalloc failure
Message-ID: <1434788954.21528.3.camel@ingics.com>

res variable was initialized to -ENOMEM, but it's override by
nvme_trans_copy_from_user(). So current code returns 0 if kcalloc fails.
Fix it to return proper error code.

Signed-off-by: Axel Lin <axel.lin at ingics.com>
---
 drivers/block/nvme-scsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index a0fade9..e5a63f0 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2377,7 +2377,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct scsi_unmap_parm_list *plist;
 	struct nvme_dsm_range *range;
 	struct nvme_command c;
-	int i, nvme_sc, res = -ENOMEM;
+	int i, nvme_sc, res;
 	u16 ndesc, list_len;
 
 	list_len = get_unaligned_be16(&cmd[7]);
@@ -2399,8 +2399,10 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 
 	range = kcalloc(ndesc, sizeof(*range), GFP_KERNEL);
-	if (!range)
+	if (!range) {
+		res = -ENOMEM;
 		goto out;
+	}
 
 	for (i = 0; i < ndesc; i++) {
 		range[i].nlb = cpu_to_le32(be32_to_cpu(plist->desc[i].nlb));
-- 
2.1.0
