From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:23 -0600
Subject: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-5-logang@deltatee.com>

nvme_get_by_path() is analagous to blkdev_get_by_path() except it
gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).

The purpose of this function is to support NVMe-OF target passthru.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00399c3536fa..61e7b016ec36 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2816,6 +2816,29 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
+{
+	struct nvme_ctrl *ctrl;
+	struct cdev *cdev;
+
+	cdev = cdev_get_by_path(path);
+	if (IS_ERR(cdev))
+		return ERR_CAST(cdev);
+
+	if (cdev->ops != &nvme_dev_fops) {
+		ctrl = ERR_PTR(-EINVAL);
+		goto out_cdev_put;
+	}
+
+	ctrl = container_of(cdev, struct nvme_ctrl, cdev);
+	nvme_get_ctrl(ctrl);
+
+out_cdev_put:
+	cdev_put(cdev);
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(nvme_ctrl_get_by_path);
+
 static ssize_t nvme_sysfs_reset(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da3d130773c4..a19bd0091de6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -484,6 +484,8 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
+
 #ifdef CONFIG_NVME_MULTIPATH
 bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
-- 
2.20.1
