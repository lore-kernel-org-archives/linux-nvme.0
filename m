From: yuyufen@huawei.com (Yufen Yu)
Date: Tue, 12 Mar 2019 22:21:05 +0800
Subject: [PATCH] nvme: update comment to make the code easier to read
Message-ID: <20190312142105.44612-1-yuyufen@huawei.com>

After commit a686ed75c0fb ("nvme: introduce a helper function for
controller deletion), nvme_delete_ctrl_sync no longer use flush_work.
Update comment, accordingly.

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 35a497e2959d..7c95122bf14d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -179,8 +179,8 @@ static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	int ret = 0;
 
 	/*
-	 * Keep a reference until the work is flushed since ->delete_ctrl
-	 * can free the controller.
+	 * Keep a reference until nvme_do_delete_ctrl() complete,
+	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-- 
2.16.2.dirty
