From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 30 Dec 2015 10:47:59 -0700
Subject: [PATCH 3/3] NVMe: Create CMB resource sysfs file
In-Reply-To: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
References: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1451497679-1195-4-git-send-email-jonathan.derrick@intel.com>

Creates a CMB resource file which lists the whole CMB resource in the
first line, and allocations in each line below it. This information is
already reflected in /proc/iomem in the PCI NVMe driver.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5d12ae4..c691c57 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -969,6 +969,29 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+static ssize_t nvme_cmb_resource_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_cmb *cmb = ctrl->cmb;
+	struct resource *res = cmb->res;
+	char *str = buf;
+
+	str += sprintf(str, "0x%016llx 0x%016llx 0x%016llx\n",
+			(unsigned long long)res->start,
+			(unsigned long long)res->end,
+			(unsigned long long)res->flags);
+	for (res = res->child; res; res = res->sibling) {
+		str += sprintf(str, "0x%016llx 0x%016llx 0x%016llx\n",
+				(unsigned long long)res->start,
+				(unsigned long long)res->end,
+				(unsigned long long)res->flags);
+	}
+	return (str - buf);
+}
+static DEVICE_ATTR(cmb_resource, S_IRUGO, nvme_cmb_resource_show, NULL);
+
 static ssize_t nvme_cmb_sq_depth_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -1024,6 +1047,7 @@ static DEVICE_ATTR(cmb_sq_offset, S_IWUSR | S_IRUGO, nvme_cmb_sq_offset_show,
 						nvme_cmb_sq_offset_store);
 
 static struct attribute *nvme_cmb_attrs[] = {
+	&dev_attr_cmb_resource.attr,
 	&dev_attr_cmb_sq_depth.attr,
 	&dev_attr_cmb_sq_offset.attr,
 	NULL
@@ -1036,6 +1060,10 @@ static umode_t nvme_cmb_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvme_cmb *cmb = ctrl->cmb;
 
+	if (a == &dev_attr_cmb_resource.attr) {
+		if (!cmb->res || !resource_size(cmb->res))
+			return 0;
+	}
 	if ((a == &dev_attr_cmb_sq_depth.attr) ||
 	    (a == &dev_attr_cmb_sq_offset.attr)) {
 		if (!(cmb->flags & NVME_CMB_SQ_SUPPORTED))
-- 
2.1.4
