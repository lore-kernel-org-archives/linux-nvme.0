From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sun,  4 Jun 2017 12:36:43 +0200
Subject: [PATCH v4 2/8] nvme: rename uuid to nguid in nvme_ns
In-Reply-To: <20170604103649.22130-1-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
Message-ID: <20170604103649.22130-3-jthumshirn@suse.de>

The uuid field in the nvme_ns structure represents the nguid field
from the identify namespace command. And as NVMe 1.3 introduced an
UUID in the NVMe Namespace Identification Descriptor this will
collide.

So rename the uuid to nguid to prevent any further
confusion. Unfortunately we export the nguid to sysfs in the uuid
sysfs attribute, but this can't be changed anymore without possibly
breaking existing userspace.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a60926410438..7b254be16887 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1016,7 +1016,7 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 	if (ns->ctrl->vs >= NVME_VS(1, 1, 0))
 		memcpy(ns->eui, (*id)->eui64, sizeof(ns->eui));
 	if (ns->ctrl->vs >= NVME_VS(1, 2, 0))
-		memcpy(ns->uuid, (*id)->nguid, sizeof(ns->uuid));
+		memcpy(ns->nguid, (*id)->nguid, sizeof(ns->nguid));
 
 	return 0;
 }
@@ -1784,8 +1784,8 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	int serial_len = sizeof(ctrl->serial);
 	int model_len = sizeof(ctrl->model);
 
-	if (memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
-		return sprintf(buf, "eui.%16phN\n", ns->uuid);
+	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
+		return sprintf(buf, "eui.%16phN\n", ns->nguid);
 
 	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
 		return sprintf(buf, "eui.%8phN\n", ns->eui);
@@ -1804,7 +1804,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%pU\n", ns->uuid);
+	return sprintf(buf, "%pU\n", ns->nguid);
 }
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 
@@ -1839,7 +1839,7 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
-		if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
+		if (!memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 			return 0;
 	}
 	if (a == &dev_attr_eui.attr) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..5004f0c41397 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -189,7 +189,7 @@ struct nvme_ns {
 	int instance;
 
 	u8 eui[8];
-	u8 uuid[16];
+	u8 nguid[16];
 
 	unsigned ns_id;
 	int lba_shift;
-- 
2.12.0
