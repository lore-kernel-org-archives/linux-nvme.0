From: colin.king@canonical.com (Colin King)
Date: Sun, 25 Sep 2016 14:56:08 -0700
Subject: [PATCH] lightnvm: add missing \n to end of dev_err message
Message-ID: <20160925215608.12976-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err message is missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f5e3011..3dd312d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -431,7 +431,7 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 	if (le32_to_cpu(bb_tbl->tblks) != nr_blks) {
 		ret = -EINVAL;
 		dev_err(ctrl->device,
-				"bbt unsuspected blocks returned (%u!=%u)",
+				"bbt unsuspected blocks returned (%u!=%u)\n",
 				le32_to_cpu(bb_tbl->tblks), nr_blks);
 		goto out;
 	}
-- 
2.9.3
