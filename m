From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 25 May 2018 14:53:22 +0200
Subject: [PATCH 3/3] nvme multipath: add dev_attr_mpath_personality
In-Reply-To: <20180525125322.15398-1-jthumshirn@suse.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
Message-ID: <20180525125322.15398-4-jthumshirn@suse.de>

From: Mike Snitzer <snitzer@redhat.com>

Allows the ability to consistently access 'mpath_personality' regardless
of which mode we're in (native vs other), using:
/sys/block/nvmeXn1/device/mpath_personality

Signed-off-by: Mike Snitzer <snitzer at redhat.com>
---
 drivers/nvme/host/core.c | 57 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7105980dde3f..e953712086ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2119,12 +2119,9 @@ nvme_subsys_show_str_function(serial);
 nvme_subsys_show_str_function(firmware_rev);
 
 #ifdef CONFIG_NVME_MULTIPATH
-static ssize_t nvme_subsys_show_mpath_personality(struct device *dev,
-						  struct device_attribute *attr,
-						  char *buf)
+static ssize_t __nvme_subsys_show_mpath_personality(struct nvme_subsystem *subsys,
+						    char *buf)
 {
-	struct nvme_subsystem *subsys =
-		container_of(dev, struct nvme_subsystem, dev);
 	ssize_t ret;
 
 	if (subsys->native_mpath)
@@ -2135,12 +2132,9 @@ static ssize_t nvme_subsys_show_mpath_personality(struct device *dev,
 	return ret;
 }
 
-static ssize_t nvme_subsys_store_mpath_personality(struct device *dev,
-						   struct device_attribute *attr,
-						   const char *buf, size_t count)
+static ssize_t __nvme_subsys_store_mpath_personality(struct nvme_subsystem *subsys,
+						     const char *buf, size_t count)
 {
-	struct nvme_subsystem *subsys =
-		container_of(dev, struct nvme_subsystem, dev);
 	bool native_mpath = false;
 	int ret = 0;
 
@@ -2162,6 +2156,24 @@ static ssize_t nvme_subsys_store_mpath_personality(struct device *dev,
 out:
 	return ret ? ret : count;
 }
+
+static ssize_t nvme_subsys_show_mpath_personality(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	return __nvme_subsys_show_mpath_personality(subsys, buf);
+}
+
+static ssize_t nvme_subsys_store_mpath_personality(struct device *dev,
+						   struct device_attribute *attr,
+						   const char *buf, size_t count)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	return __nvme_subsys_store_mpath_personality(subsys, buf, count);
+}
 static SUBSYS_ATTR_RW(mpath_personality, nvme_subsys_show_mpath_personality,
 		      nvme_subsys_store_mpath_personality);
 #endif
@@ -2819,6 +2831,28 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+#ifdef CONFIG_NVME_MULTIPATH
+static ssize_t nvme_sysfs_show_mpath_personality(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return __nvme_subsys_show_mpath_personality(ctrl->subsys, buf);
+}
+
+static ssize_t nvme_sysfs_store_mpath_personality(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return __nvme_subsys_store_mpath_personality(ctrl->subsys, buf, count);
+}
+static DEVICE_ATTR(mpath_personality, 0644,
+		   nvme_sysfs_show_mpath_personality, nvme_sysfs_store_mpath_personality);
+#endif
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -2831,6 +2865,9 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_subsysnqn.attr,
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&dev_attr_mpath_personality.attr,
+#endif
 	NULL
 };
 
-- 
2.16.3
