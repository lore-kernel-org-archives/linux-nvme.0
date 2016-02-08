From: hch@lst.de (Christoph Hellwig)
Date: Mon,  8 Feb 2016 19:07:36 +0100
Subject: [PATCH] nvme: fix drvdata setup for the nvme device
Message-ID: <1454954856-32236-1-git-send-email-hch@lst.de>

See http://www.infradead.org/rpr.html

Pass the right private data to device_create_with_groups from the
beginning, and remove the superflous call to dev_set_drvdata.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5bf001..c326931 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1383,14 +1383,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	ctrl->device = device_create_with_groups(nvme_class, ctrl->dev,
 				MKDEV(nvme_char_major, ctrl->instance),
-				dev, nvme_dev_attr_groups,
+				ctrl, nvme_dev_attr_groups,
 				"nvme%d", ctrl->instance);
 	if (IS_ERR(ctrl->device)) {
 		ret = PTR_ERR(ctrl->device);
 		goto out_release_instance;
 	}
 	get_device(ctrl->device);
-	dev_set_drvdata(ctrl->device, ctrl);
 
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
-- 
2.1.4
