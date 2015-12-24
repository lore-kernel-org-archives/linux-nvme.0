From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 24 Dec 2015 13:23:59 +0200
Subject: [PATCH RFC 2/4] nvme: Add a controller reference to the admin tagset
In-Reply-To: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
Message-ID: <1450956241-4626-3-git-send-email-sagig@mellanox.com>

We will need it in order to move the IO failure helpers to the core.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/host/nvme.h   |    1 +
 drivers/nvme/host/pci.c    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8bc6660..2e3475e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -49,6 +49,7 @@ struct nvme_ctrl {
 	struct kref kref;
 	int instance;
 	struct blk_mq_tag_set *tagset;
+	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
 	struct device *device;	/* char device */
 	struct list_head node;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a5c2390..0d78b3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1261,6 +1261,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			blk_mq_free_tag_set(&dev->admin_tagset);
 			return -ENOMEM;
 		}
+		dev->ctrl.admin_tagset = &dev->admin_tagset;
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
 			nvme_dev_remove_admin(dev);
 			dev->ctrl.admin_q = NULL;
-- 
1.7.1
