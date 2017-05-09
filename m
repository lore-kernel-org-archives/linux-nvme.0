From: rakesh@tuxera.com (Rakesh Pandit)
Date: Tue, 9 May 2017 16:55:08 +0300
Subject: [PATCH] nvme: lightnvm: fix memory leak
Message-ID: <20170509135506.GA22624@dhcp-216.srv.tuxera.com>

Free up kmalloc allocated memory if failure happens while handling L2P
table transfer in nvme_nvm_get_l2p_tbl.

Fixes: 8e79b5cb ("lightnvm: move block provisioning to targets")
Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
---
 drivers/nvme/host/lightnvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 206bfdb..f5df78e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -367,7 +367,8 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 
 		if (unlikely(elba > nvmdev->total_secs)) {
 			pr_err("nvm: L2P data from device is out of bounds!\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
 		/* Transform physical address to target address space */
-- 
2.5.5
