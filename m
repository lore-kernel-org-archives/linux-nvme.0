From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 09:57:48 -0700
Subject: [PATCH] NVMe: Expose ns wwid through single sysfs entry
Message-ID: <1455814668-784-1-git-send-email-keith.busch@intel.com>

The method to uniquely identify a namespace depends on the controller's
specification revision level and implemented capabilities. This patch
has the driver figure this out and exports the unique string through a
single 'wwid' attribute so the user doesn't have this burden.

The longest namespace unique identifier is used if available. If not
available, the driver will concat the controller's vendor, serial,
and model with the namespace ID. The specification provides this as a
unique indentifier.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 26 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index face31f..b29fae6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -872,6 +872,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
@@ -1008,6 +1009,30 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int serial_len = sizeof(ctrl->serial);
+	int model_len = sizeof(ctrl->model);
+
+	if (memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
+		return sprintf(buf, "eui.%16phN\n", ns->uuid);
+
+	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
+		return sprintf(buf, "eui.%8phN\n", ns->eui);
+
+	while (ctrl->serial[serial_len - 1] == ' ')
+		serial_len--;
+	while (ctrl->model[model_len - 1] == ' ')
+		model_len--;
+
+	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
+		serial_len, ctrl->serial, model_len, ctrl->model, ns->ns_id);
+}
+static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -1033,6 +1058,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 
 static struct attribute *nvme_ns_attrs[] = {
+	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dcdc2d7..b50e591 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -84,6 +84,7 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u16 vid;
 	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
-- 
2.6.2.307.g37023ba
