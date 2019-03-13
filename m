From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:54:58 +0100
Subject: [PATCH 05/17] nvme: update comment to make the code easier to read
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-6-hch@lst.de>

From: Yufen Yu <yuyufen@huawei.com>

After commit a686ed75c0fb ("nvme: introduce a helper function for
controller deletion), nvme_delete_ctrl_sync no longer use flush_work.
Update comment, accordingly.

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d57a84f45ed0..b92fab434066 100644
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
2.20.1
