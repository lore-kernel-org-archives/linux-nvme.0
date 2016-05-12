From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 May 2016 07:58:17 -0600
Subject: [PATCHv2] NVMe: Allow user initiated rescan
Message-ID: <1463061497-8742-1-git-send-email-keith.busch@intel.com>

This exposes ioctl and sysfs methods a user can invoke to request the
driver rescan a controller and its namespaces. This is less harsh than
doing a controller reset, which temporarilly halts all IO, just to
surface a newly attached namespace.

This is mainly useful for controllers that implement the namespace
management command, but do not support the namespace notify change
asynchronous event notification.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Removed the nvme_queue_scan error returns. It had a wrong return
  code in the successful case before, but even in the error case, the
  information it conveys to the user isn't userful.

 drivers/nvme/host/core.c        | 15 +++++++++++++++
 include/uapi/linux/nvme_ioctl.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2df0351d..a6a89da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1216,6 +1216,9 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		return ctrl->ops->reset_ctrl(ctrl);
 	case NVME_IOCTL_SUBSYS_RESET:
 		return nvme_reset_subsystem(ctrl);
+	case NVME_IOCTL_RESCAN:
+		nvme_queue_scan(ctrl);
+		return 0;
 	default:
 		return -ENOTTY;
 	}
@@ -1243,6 +1246,17 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+static ssize_t nvme_sysfs_rescan(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	nvme_queue_scan(ctrl);
+	return count;
+}
+static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
+
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -1346,6 +1360,7 @@ nvme_show_int_function(cntlid);
 
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
+	&dev_attr_rescan_controller.attr,
 	&dev_attr_model.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_rev.attr,
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index c4b2a3f..50ff21f 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -61,5 +61,6 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
 #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
+#define NVME_IOCTL_RESCAN	_IO('N', 0x46)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.7.2
