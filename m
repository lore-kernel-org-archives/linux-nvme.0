From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Dec 2015 10:26:45 -0700
Subject: [PATCH] NVMe: Expose namespace unique identifier to sysfs
Message-ID: <1449595605-20735-1-git-send-email-keith.busch@intel.com>

A controller namespace supporting 1.1 or 1.2 capabilities uniquely
identifies itself with either the 64-bit EUI or 128-bit NGUID.

This patch determines which the device supports and reports the unique
identifier in new sysfs binary attribute "uuid". The attribute group is
added to the gendisk's kobject directory.

No fallback is provided for controllers not reporting a unique id.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd2a64f..472a96c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -574,6 +574,21 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		ns->type = NVME_NS_LIGHTNVM;
 	}
 
+	if (ns->ctrl->vs >= NVME_VS(1, 1)) {
+		u8 *identifier = id->eui64;
+		int len = sizeof(id->eui64);
+
+		if (bitmap_empty((void *)identifier, len * 8) &&
+					ns->ctrl->vs >= NVME_VS(1, 2)) {
+			identifier = id->nguid;
+			len = sizeof(id->nguid);
+		}
+		if (!bitmap_empty((void *)identifier, len * 8)) {
+			memcpy(ns->uuid, identifier, len);
+			ns->uuid_len = len;
+		}
+	}
+
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->lba_shift = id->lbaf[lbaf].ds;
@@ -994,6 +1009,34 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL
 };
 
+#define nvme_bin_attr(field)						\
+static ssize_t field##_show(struct file *filp, struct kobject *kobj,	\
+		 struct bin_attribute *bin_attr,			\
+		 char *buf, loff_t off, size_t count)			\
+{									\
+	struct device *dev = container_of(kobj, struct device, kobj);	\
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;		\
+	return memory_read_from_buffer(buf, count, &off,		\
+				       ns->field,			\
+				       ns->field##_len);		\
+}									\
+static struct bin_attribute dev_attr_nvme_##field = {			\
+	.attr =	{.name = #field, .mode = S_IRUGO },			\
+	.size = 0,							\
+	.read = field##_show,						\
+};
+
+nvme_bin_attr(uuid);
+
+static struct bin_attribute *nvme_ns_bin_attrs[] = {
+	&dev_attr_nvme_uuid,
+	NULL,
+};
+
+static struct attribute_group nvme_ns_attrs_group = {
+	.bin_attrs = nvme_ns_bin_attrs,
+};
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -1068,9 +1111,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	kref_get(&ctrl->kref);
-	if (ns->type != NVME_NS_LIGHTNVM)
-		add_disk(ns->disk);
+	if (ns->type == NVME_NS_LIGHTNVM)
+		return;
 
+	add_disk(ns->disk);
+	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
+			&nvme_ns_attrs_group)) {
+		del_gendisk(ns->disk);
+		nvme_put_ctrl(ctrl);
+		goto out_free_queue;
+	}
 	return;
  out_free_disk:
 	kfree(disk);
@@ -1090,6 +1140,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
+		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj, &nvme_ns_attrs_group);
 		del_gendisk(ns->disk);
 	}
 	if (kill || !blk_queue_dying(ns->queue)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b041762..4731205 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,8 @@ struct nvme_ns {
 	struct gendisk *disk;
 	struct kref kref;
 
+	u8 uuid_len;
+	u8 uuid[16]; /* Either EUI64 or NGUID, if provided */
 	unsigned ns_id;
 	int lba_shift;
 	u16 ms;
-- 
2.6.2.307.g37023ba
