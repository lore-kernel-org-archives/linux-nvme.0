From: mlin@kernel.org (Ming Lin)
Date: Fri, 26 Feb 2016 13:24:19 -0800
Subject: [PATCH] nvme: expose cntlid in sysfs
Message-ID: <1456521859-26357-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

For NVMe over Fabrics, the cntlid will be used by systemd/udev to
create link to the device, for example,

/dev/disk/by-path/<fabrics-info>-<cntlid>-<namespace> -> /dev/nvme0n1

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++----
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c7df0ab..0b04119 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -901,6 +901,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
+	ctrl->cntlid = le16_to_cpup(&id->cntlid);
 	memcpy(ctrl->serial, id->sn, sizeof(id->sn));
 	memcpy(ctrl->model, id->mn, sizeof(id->mn));
 	memcpy(ctrl->firmware_rev, id->fr, sizeof(id->fr));
@@ -1088,7 +1089,7 @@ static const struct attribute_group nvme_ns_attr_group = {
 	.is_visible	= nvme_attrs_are_visible,
 };
 
-#define nvme_show_function(field)						\
+#define nvme_show_str_function(field)						\
 static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
@@ -1097,15 +1098,26 @@ static ssize_t  field##_show(struct device *dev,				\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
-nvme_show_function(model);
-nvme_show_function(serial);
-nvme_show_function(firmware_rev);
+#define nvme_show_int_function(field)						\
+static ssize_t  field##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)		\
+{										\
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
+        return sprintf(buf, "%d\n", ctrl->field);	\
+}										\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+
+nvme_show_str_function(model);
+nvme_show_str_function(serial);
+nvme_show_str_function(firmware_rev);
+nvme_show_int_function(cntlid);
 
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_model.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_rev.attr,
+	&dev_attr_cntlid.attr,
 	NULL
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 63ba8a5..2e041e7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -77,6 +77,7 @@ struct nvme_ctrl {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
+	int cntlid;
 
 	u32 ctrl_config;
 
-- 
1.9.1
