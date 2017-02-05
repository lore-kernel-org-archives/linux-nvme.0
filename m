From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun,  5 Feb 2017 15:44:00 +0000
Subject: [PATCH -next] lightnvm: fix possible memory leak in
 nvme_nvm_get_l2p_tbl()
Message-ID: <20170205154400.31336-1-weiyj.lk@gmail.com>

From: Wei Yongjun <weiyongjun1@huawei.com>

'entries' is malloced in nvme_nvm_get_l2p_tbl() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: 8e79b5cb1d3b ("lightnvm: move block provisioning to targets")
Signed-off-by: Wei Yongjun <weiyongjun1 at huawei.com>
---
 drivers/nvme/host/lightnvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 588d4a3..2388716 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -368,7 +368,8 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 
 		if (unlikely(elba > nvmdev->total_secs)) {
 			pr_err("nvm: L2P data from device is out of bounds!\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		/* Transform physical address to target address space */
