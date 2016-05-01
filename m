From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  1 May 2016 06:25:44 +0300
Subject: [PATCH] nvme/lightnvm: Log using the ctrl named device
Message-ID: <1462073144-30533-1-git-send-email-sagi@grimberg.me>

Align with the rest of the nvme subsystem.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/lightnvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 9461dd639acd..a03a3e8febdf 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -367,7 +367,7 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 		ret = nvme_submit_sync_cmd(ns->ctrl->admin_q,
 				(struct nvme_command *)&c, entries, len);
 		if (ret) {
-			dev_err(ns->ctrl->dev, "L2P table transfer failed (%d)\n",
+			dev_err(ns->ctrl->device, "L2P table transfer failed (%d)\n",
 									ret);
 			ret = -EIO;
 			goto out;
@@ -441,27 +441,27 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 	ret = nvme_submit_sync_cmd(ctrl->admin_q, (struct nvme_command *)&c,
 								bb_tbl, tblsz);
 	if (ret) {
-		dev_err(ctrl->dev, "get bad block table failed (%d)\n", ret);
+		dev_err(ctrl->device, "get bad block table failed (%d)\n", ret);
 		ret = -EIO;
 		goto out;
 	}
 
 	if (bb_tbl->tblid[0] != 'B' || bb_tbl->tblid[1] != 'B' ||
 		bb_tbl->tblid[2] != 'L' || bb_tbl->tblid[3] != 'T') {
-		dev_err(ctrl->dev, "bbt format mismatch\n");
+		dev_err(ctrl->device, "bbt format mismatch\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (le16_to_cpu(bb_tbl->verid) != 1) {
 		ret = -EINVAL;
-		dev_err(ctrl->dev, "bbt version not supported\n");
+		dev_err(ctrl->device, "bbt version not supported\n");
 		goto out;
 	}
 
 	if (le32_to_cpu(bb_tbl->tblks) != nr_src_blks) {
 		ret = -EINVAL;
-		dev_err(ctrl->dev, "bbt unsuspected blocks returned (%u!=%u)",
+		dev_err(ctrl->device, "bbt unsuspected blocks returned (%u!=%u)",
 				le32_to_cpu(bb_tbl->tblks), nr_src_blks);
 		goto out;
 	}
@@ -494,7 +494,7 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct nvm_rq *rqd,
 	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct nvme_command *)&c,
 								NULL, 0);
 	if (ret)
-		dev_err(ns->ctrl->dev, "set bad block table failed (%d)\n", ret);
+		dev_err(ns->ctrl->device, "set bad block table failed (%d)\n", ret);
 	return ret;
 }
 
-- 
1.9.1
