From: hch@lst.de (Christoph Hellwig)
Date: Mon, 26 Jun 2017 12:39:03 +0200
Subject: [PATCH 3/4] nvme: simplify nvme_dev_attrs_are_visible
In-Reply-To: <20170626103904.9516-1-hch@lst.de>
References: <20170626103904.9516-1-hch@lst.de>
Message-ID: <20170626103904.9516-4-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 32cdad8afa2b..4342ec9bc528 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2126,23 +2126,16 @@ static struct attribute *nvme_dev_attrs[] = {
 	NULL
 };
 
-#define CHECK_ATTR(ctrl, a, name)		\
-	if ((a) == &dev_attr_##name.attr &&	\
-	    !(ctrl)->ops->get_##name)		\
-		return 0
-
 static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (a == &dev_attr_delete_controller.attr) {
-		if (!ctrl->ops->delete_ctrl)
-			return 0;
-	}
-
-	CHECK_ATTR(ctrl, a, address);
+	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
+		return 0;
+	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
+		return 0;
 
 	return a->mode;
 }
-- 
2.11.0
