From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 11:15:54 +0100
Subject: [PATCH 2/3] nvme: fixes for NVME_IOCTL_IO_CMD on the char device
In-Reply-To: <1450952155-8693-1-git-send-email-hch@lst.de>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
Message-ID: <1450952155-8693-3-git-send-email-hch@lst.de>

Make sure we synchronize access to the namespaces list and grab a reference
to the namespace before doing I/O.  Make sure to reject the ioctl if multiple
namespaces are present as it's entirely unsafe, and warn when using it even
with a single namespace.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eba7e96..19b854e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -922,21 +922,50 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+{
+	struct nvme_ns *ns;
+	int ret;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	if (list_empty(&ctrl->namespaces)) {
+		ret = -ENOTTY;
+		goto out_unlock;
+	}
+
+	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
+		dev_warn(ctrl->dev,
+			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	dev_warn(ctrl->dev,
+		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
+	kref_get(&ns->kref);
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	ret = nvme_user_cmd(ctrl, ns, argp);
+	nvme_put_ns(ns);
+	return ret;
+
+out_unlock:
+	mutex_unlock(&ctrl->namespaces_mutex);
+	return ret;
+}
+
 static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
 	struct nvme_ctrl *ctrl = file->private_data;
 	void __user *argp = (void __user *)arg;
-	struct nvme_ns *ns;
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_IO_CMD:
-		if (list_empty(&ctrl->namespaces))
-			return -ENOTTY;
-		ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-		return nvme_user_cmd(ctrl, ns, argp);
+		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
 		dev_warn(ctrl->dev, "resetting controller\n");
 		return ctrl->ops->reset_ctrl(ctrl);
-- 
1.9.1
