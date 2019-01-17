From: hare@suse.de (Hannes Reinecke)
Date: Thu, 17 Jan 2019 08:42:41 +0100
Subject: [PATCH] nvme-fc: use pci device as parent for nvme controller
Message-ID: <20190117074241.40672-1-hare@suse.de>

To allow system tools to figure out which pci device provides a
given NVMe controller this patch moves the nvme controller sysfs
entry as a child of the PCI device.

With this tools like dracut can traverse the device hierarchy to figure
out which modules to include.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index feb86b59170e..1ecdec6b8b4a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3117,7 +3117,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	 * Defer this to the connect path.
 	 */
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
+	ret = nvme_init_ctrl(&ctrl->ctrl, ctrl->dev, &nvme_fc_ctrl_ops, 0);
 	if (ret)
 		goto out_cleanup_admin_q;
 
-- 
2.16.4
