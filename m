From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Oct 2017 18:52:53 +0200
Subject: [PATCH 12/17] nvme: check for a live controller in nvme_dev_open
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
Message-ID: <20171018165258.23212-13-hch@lst.de>

This is a much more sensible check than just the admin queue.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3757f5695de2..d490abd0195c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1891,7 +1891,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	if (!ctrl->admin_q)
+	if (ctrl->state != NVME_CTRL_LIVE)
 		return -EWOULDBLOCK;
 	file->private_data = ctrl;
 	return 0;
-- 
2.14.1
