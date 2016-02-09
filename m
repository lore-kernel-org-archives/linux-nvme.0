From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Feb 2016 10:24:45 +0100
Subject: [PATCH 0/4] nvme: split pci module out of core module
In-Reply-To: <1454970284-29543-1-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
Message-ID: <20160209092445.GA21250@lst.de>

On Mon, Feb 08, 2016@02:24:40PM -0800, Ming Lin wrote:
> We'll have nvme over fabric dirver soon.
> This series split nvme pci module out of nvme core module.
> 
> nvme.ko is split into 2 modules:
> nvme-core.ko: the core part
> nvme.ko: the PCI driver

Might be worth explaining why we are doing this:  for the NVMe over
Fabrics drivers that are going to reuse the core, as well as things
like the vhost NVMe driver if we're going to merge it.

We'll also need something to take proper references to the transport
driver on open in this series.  E.g. this patch from Sagi in the Fabrics
tree:

---
>From 1fafa7768fe93bd6a7ec335738bbae9e00f4a634 Mon Sep 17 00:00:00 2001
From: Sagi Grimberg <sagig@mellanox.com>
Date: Tue, 2 Feb 2016 21:52:51 +0100
Subject: nvme/host: reference the fabric module for each bdev open callout

We don't want to be able to unload the fabric driver when we have
openened referenced to our namespaces. Thus, for each nvme_open we
take a reference on the fabric driver and put it in nvme_release.
This behavior is consistent with the scsi model.

This resolves the panic when unloading a fabric module with
mpath holders.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Ian Bakshan <ianb at mellanox.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a152b8c..9fe7471 100644
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
@@ -517,7 +527,10 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 
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
index 62209aa..cce40c9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -119,6 +119,7 @@ struct nvme_ns {
 };
 
 struct nvme_ctrl_ops {
+	struct module *module;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ad24442d..526a30b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2016,6 +2016,7 @@ static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
 }
 
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
+	.module			= THIS_MODULE,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-- 
2.1.4
