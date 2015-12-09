From: keith.busch@intel.com (Keith Busch)
Date: Wed,  9 Dec 2015 11:42:57 -0700
Subject: [PATCHv2 2/2] NVMe: Expose namespace identity attribute to sysfs
In-Reply-To: <1449686577-6319-1-git-send-email-keith.busch@intel.com>
References: <1449686577-6319-1-git-send-email-keith.busch@intel.com>
Message-ID: <1449686577-6319-3-git-send-email-keith.busch@intel.com>

Adds EUI-64 and NGUID attributes to sysfs under the gendisk kobject
path. The files' visibility depends on the namespace capabilities. User
space needs to check the existence of both files to determine how to
identify the namespace.

NGUID format: 00000000-0000-0000-0000-000000000000
EUI64 format: 00-00-00-00-00-00-00-00

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  3 +++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd2a64f..bc85318 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -574,6 +574,11 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		ns->type = NVME_NS_LIGHTNVM;
 	}
 
+	if (ns->ctrl->vs >= NVME_VS(1, 1))
+		memcpy(ns->eui, id->eui64, sizeof(ns->eui));
+	if (ns->ctrl->vs >= NVME_VS(1, 2))
+		memcpy(ns->uuid, id->nguid, sizeof(ns->uuid));
+
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->lba_shift = id->lbaf[lbaf].ds;
@@ -994,6 +999,50 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL
 };
 
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	return sprintf(buf, "%pU\n", ns->uuid);
+}
+static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
+
+static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	return sprintf(buf, "%pMFl\n", ns->eui);
+}
+static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
+
+static struct attribute *nvme_ns_attrs[] = {
+	&dev_attr_uuid.attr,
+	&dev_attr_eui.attr,
+	NULL,
+};
+
+static umode_t nvme_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+
+	if (a == &dev_attr_uuid.attr) {
+		if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
+			return 0;
+	}
+	if (a == &dev_attr_eui.attr) {
+		if (!memchr_inv(ns->eui, 0, sizeof(ns->eui)))
+			return 0;
+	}
+	return a->mode;
+}
+
+static const struct attribute_group nvme_ns_attr_group = {
+	.attrs		= nvme_ns_attrs,
+	.is_visible	= nvme_attrs_are_visible,
+};
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -1068,9 +1117,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
-	if (ns->type != NVME_NS_LIGHTNVM)
-		add_disk(ns->disk);
+	if (ns->type == NVME_NS_LIGHTNVM)
+		return;
 
+	add_disk(ns->disk);
+	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
+					&nvme_ns_attr_group))
+		pr_warn("%s: failed to create sysfs group for identification\n",
+			ns->disk->disk_name);
 	return;
  out_free_disk:
 	kfree(disk);
@@ -1090,6 +1144,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
+		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
+					&nvme_ns_attr_group);
 		del_gendisk(ns->disk);
 	}
 	if (kill || !blk_queue_dying(ns->queue)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b041762..d88cf45 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,9 @@ struct nvme_ns {
 	struct gendisk *disk;
 	struct kref kref;
 
+	u8 eui[8];
+	u8 uuid[16];
+
 	unsigned ns_id;
 	int lba_shift;
 	u16 ms;
-- 
2.6.2.307.g37023ba
