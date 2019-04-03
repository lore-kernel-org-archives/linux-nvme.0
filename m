From: mheyne@amazon.de (Maximilian Heyne)
Date: Wed, 3 Apr 2019 12:35:06 +0000
Subject: [PATCH v2 2/2] nvme: add sysfs controls for io and admin timeouts
In-Reply-To: <20190403123506.122904-1-mheyne@amazon.de>
References: <20190403123506.122904-1-mheyne@amazon.de>
Message-ID: <20190403123506.122904-3-mheyne@amazon.de>

Add two sysfs files for reading and updating the admin and io timeouts
of individual NVMe controllers.

The controller must be in the LIVE or ADMIN_ONLY state for this to work
so that setting timeouts doesn't race with the creation or deletion of
tagset, admin_tagset, admin_q and connect_q of nvme_ctrl.

Original-patch-by: Milan Pandurov <milanpa at amazon.com>
Signed-off-by: Maximilian Heyne <mheyne at amazon.de>
---
v2: 
 - rework setting timeouts to work with all relevant nvme drivers
 - add check for state LIVE to not race with controller creation/deletion

 drivers/nvme/host/core.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d0530bf7a677..51f359d78f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2768,6 +2768,116 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static int nvme_set_io_timeout(struct nvme_ctrl *ctrl, unsigned int timeout)
+{
+	struct nvme_ns *ns;
+	unsigned long flags;
+	int ret = -EBUSY;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE) {
+		ctrl->io_timeout = timeout;
+		if (ctrl->tagset)
+			ctrl->tagset->timeout = timeout;
+		if (ctrl->connect_q)
+			blk_queue_rq_timeout(ctrl->connect_q, timeout);
+
+		down_write(&ctrl->namespaces_rwsem);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			blk_queue_rq_timeout(ns->queue, timeout);
+		}
+		up_write(&ctrl->namespaces_rwsem);
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return ret;
+}
+
+static int nvme_set_admin_timeout(struct nvme_ctrl *ctrl, unsigned int timeout)
+{
+	unsigned long flags;
+	int ret = -EBUSY;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE ||
+	    ctrl->state == NVME_CTRL_ADMIN_ONLY) {
+		ctrl->admin_timeout = timeout;
+		ctrl->admin_tagset->timeout = timeout;
+		blk_queue_rq_timeout(ctrl->admin_q, timeout);
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return ret;
+}
+
+static ssize_t io_timeout_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ctrl->io_timeout / HZ);
+}
+
+static ssize_t io_timeout_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int timeout;
+	int ret;
+
+	ret = kstrtouint(buf, 10u, &timeout);
+	if (ret == -EINVAL) {
+		dev_warn(ctrl->dev, "Error parsing timeout value.\n");
+		return ret;
+	}
+	if (ret == -ERANGE || timeout == 0 || timeout > UINT_MAX / HZ) {
+		dev_warn(ctrl->dev,
+			 "Timeout value out of range (0 < timeout <= %u).\n",
+			 UINT_MAX / HZ);
+		return -ERANGE;
+	}
+	ret = nvme_set_io_timeout(ctrl, timeout * HZ);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(io_timeout);
+
+static ssize_t admin_timeout_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ctrl->admin_timeout / HZ);
+}
+
+static ssize_t admin_timeout_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int timeout;
+	int ret;
+
+	ret = kstrtouint(buf, 10u, &timeout);
+	if (ret == -EINVAL) {
+		dev_warn(ctrl->dev, "Error parsing timeout value.\n");
+		return ret;
+	}
+	if (ret == -ERANGE || timeout == 0 || timeout > UINT_MAX / HZ) {
+		dev_warn(ctrl->dev,
+			 "Timeout value out of range (0 < timeout <= %u).\n",
+			 UINT_MAX / HZ);
+		return -ERANGE;
+	}
+	ret = nvme_set_admin_timeout(ctrl, timeout * HZ);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(admin_timeout);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -3008,6 +3118,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_io_timeout.attr,
+	&dev_attr_admin_timeout.attr,
 	NULL
 };
 
-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
