From: brandon.schulz@hgst.com (Brandon Schulz)
Date: Wed, 11 May 2016 19:00:33 +0000
Subject: [PATCH] NVMe: User initiated rescan
In-Reply-To: <1462919010-2569-1-git-send-email-keith.busch@intel.com>
References: <1462919010-2569-1-git-send-email-keith.busch@intel.com>
Message-ID: <98A88B30-6D55-464F-9FD5-1F9691466E13@hgst.com>

I would like to see some version of this patch go in.  It?s useful for our pre-NVMe 1.2 devices at a minimum.

Brandon Schulz
Technologist - Systems & Software Architecture 
SSD Device Development
Western Digital Corporation
e: brandon.schulz at hgst.com
o: (507) 322-2257










On 5/10/16, 5:23 PM, "Linux-nvme on behalf of Keith Busch" <linux-nvme-bounces@lists.infradead.org on behalf of keith.busch@intel.com> wrote:

>This provides user ioctl and sysfs methods that can be used to request
>the driver rescan a controller and its namespaces. This is less harsh
>than doing a controller reset, which temporarily halts all IO just to
>surface a newly attached namespace.
>
>This is mainly useful for controllers that implement namespace management,
>but do not support the namespace notify change asynchronous event
>notification.
>
>Signed-off-by: Keith Busch <keith.busch at intel.com>
>---
> drivers/nvme/host/core.c        | 22 ++++++++++++++++++++--
> drivers/nvme/host/nvme.h        |  2 +-
> include/uapi/linux/nvme_ioctl.h |  1 +
> 3 files changed, 22 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 2df0351d..b85c4b1 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -1216,6 +1216,8 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
> 		return ctrl->ops->reset_ctrl(ctrl);
> 	case NVME_IOCTL_SUBSYS_RESET:
> 		return nvme_reset_subsystem(ctrl);
>+	case NVME_IOCTL_RESCAN:
>+		return nvme_queue_scan(ctrl);
> 	default:
> 		return -ENOTTY;
> 	}
>@@ -1243,6 +1245,20 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
> }
> static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
> 
>+static ssize_t nvme_sysfs_rescan(struct device *dev,
>+				struct device_attribute *attr, const char *buf,
>+				size_t count)
>+{
>+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>+	int ret;
>+
>+	ret = nvme_queue_scan(ctrl);
>+	if (ret < 0)
>+		return ret;
>+	return count;
>+}
>+static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
>+
> static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
> 								char *buf)
> {
>@@ -1346,6 +1362,7 @@ nvme_show_int_function(cntlid);
> 
> static struct attribute *nvme_dev_attrs[] = {
> 	&dev_attr_reset_controller.attr,
>+	&dev_attr_rescan_controller.attr,
> 	&dev_attr_model.attr,
> 	&dev_attr_serial.attr,
> 	&dev_attr_firmware_rev.attr,
>@@ -1569,14 +1586,15 @@ static void nvme_scan_work(struct work_struct *work)
> 		ctrl->ops->post_scan(ctrl);
> }
> 
>-void nvme_queue_scan(struct nvme_ctrl *ctrl)
>+int nvme_queue_scan(struct nvme_ctrl *ctrl)
> {
> 	/*
> 	 * Do not queue new scan work when a controller is reset during
> 	 * removal.
> 	 */
> 	if (ctrl->state == NVME_CTRL_LIVE)
>-		schedule_work(&ctrl->scan_work);
>+		return schedule_work(&ctrl->scan_work);
>+	return -EBUSY;
> }
> EXPORT_SYMBOL_GPL(nvme_queue_scan);
> 
>diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>index 114b928..997b9ec 100644
>--- a/drivers/nvme/host/nvme.h
>+++ b/drivers/nvme/host/nvme.h
>@@ -217,7 +217,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
> void nvme_put_ctrl(struct nvme_ctrl *ctrl);
> int nvme_init_identify(struct nvme_ctrl *ctrl);
> 
>-void nvme_queue_scan(struct nvme_ctrl *ctrl);
>+int nvme_queue_scan(struct nvme_ctrl *ctrl);
> void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
> 
> #define NVME_NR_AERS	1
>diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
>index c4b2a3f..50ff21f 100644
>--- a/include/uapi/linux/nvme_ioctl.h
>+++ b/include/uapi/linux/nvme_ioctl.h
>@@ -61,5 +61,6 @@ struct nvme_passthru_cmd {
> #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
> #define NVME_IOCTL_RESET	_IO('N', 0x44)
> #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
>+#define NVME_IOCTL_RESCAN	_IO('N', 0x46)
> 
> #endif /* _UAPI_LINUX_NVME_IOCTL_H */
>-- 
>2.7.2
>
>
>_______________________________________________
>Linux-nvme mailing list
>Linux-nvme at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-nvme
