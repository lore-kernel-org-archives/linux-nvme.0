From: mlin@kernel.org (Ming Lin)
Date: Wed, 10 Feb 2016 10:03:29 -0800
Subject: [PATCH v3 1/4] nvme/host: reference the fabric module for each bdev
 open callout
In-Reply-To: <1455127412-23940-1-git-send-email-mlin@kernel.org>
References: <1455127412-23940-1-git-send-email-mlin@kernel.org>
Message-ID: <1455127412-23940-2-git-send-email-mlin@kernel.org>

From: Sagi Grimberg <sagig@mellanox.com>

We don't want to be able to unload the fabric driver when we have
openened referenced to our namespaces. Thus, for each nvme_open we
take a reference on the fabric driver and put it in nvme_release.
This behavior is consistent with the scsi model.

This resolves the panic when unloading a fabric module with
mpath holders.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Ian Bakshan <ianb at mellanox.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5bf001..8adc598 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -71,11 +71,21 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 
 	spin_lock(&dev_list_lock);
 	ns = disk->private_data;
-	if (ns && !kref_get_unless_zero(&ns->kref))
-		ns = NULL;
+	if (ns) {
+		if (!kref_get_unless_zero(&ns->kref))
+			goto fail;
+		if (!try_module_get(ns->ctrl->ops->module))
+			goto fail_put_ns;
+	}
 	spin_unlock(&dev_list_lock);
 
 	return ns;
+
+fail_put_ns:
+	kref_put(&ns->kref, nvme_free_ns);
+fail:
+	spin_unlock(&dev_list_lock);
+	return NULL;
 }
 
 void nvme_requeue_req(struct request *req)
@@ -499,7 +509,10 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 
 static void nvme_release(struct gendisk *disk, fmode_t mode)
 {
-	nvme_put_ns(disk->private_data);
+	struct nvme_ns *ns = disk->private_data;
+
+	module_put(ns->ctrl->ops->module);
+	nvme_put_ns(ns);
 }
 
 static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4fb5bb7..9f77386 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -117,6 +117,7 @@ struct nvme_ns {
 };
 
 struct nvme_ctrl_ops {
+	struct module *module;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..e36ca02 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2029,6 +2029,7 @@ static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
 }
 
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
+	.module			= THIS_MODULE,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-- 
1.9.1
