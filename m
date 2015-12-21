From: ianb@mellanox.com (Ian Bakshan)
Date: Mon, 21 Dec 2015 10:26:43 +0200
Subject: [PATCH] nvme: Add sysfs parameter to show subsystem nqn
Message-ID: <1450686403-60662-1-git-send-email-ianb@mellanox.com>

Added 'subsysnqn' parameter to /sys/class/nvme-fabrics/ctl/nvmeX/ that
shows the subsystem nqn of the configured device.

Signed-off-by: Ian Bakshan <ianb at mellanox.com>
---
 drivers/nvme/host/core.c   | 24 ++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/rdma.c   | 10 +++++++++-
 drivers/nvme/target/loop.c |  8 ++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 49c721c..663ad56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1011,6 +1011,20 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 }
 static DEVICE_ATTR(delete_controller, S_IWUSR, NULL, nvme_sysfs_delete);
 
+static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	ssize_t count = 0;
+
+	if (ctrl->ops->get_subsysnqn)
+		count = sprintf(buf, "%s\n", ctrl->ops->get_subsysnqn(ctrl));
+
+	return count;
+}
+static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -1246,6 +1260,8 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	if (ctrl->ops->get_subsysnqn)
+		device_remove_file(ctrl->device, &dev_attr_subsysnqn);
 	device_remove_file(ctrl->device, &dev_attr_reset_controller);
 	if (ctrl->ops->delete_ctrl)
 		device_remove_file(ctrl->device, &dev_attr_delete_controller);
@@ -1316,12 +1332,20 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 			goto out_remove_reset_attr;
 	}
 
+	if (ctrl->ops->get_subsysnqn) {
+		ret = device_create_file(ctrl->device, &dev_attr_subsysnqn);
+		if (ret)
+			goto out_remove_delete_attr;
+	}
+
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
 	spin_unlock(&dev_list_lock);
 
 	return 0;
 
+out_remove_delete_attr:
+	device_remove_file(ctrl->device, &dev_attr_delete_controller);
 out_remove_reset_attr:
 	device_remove_file(ctrl->device, &dev_attr_reset_controller);
 out_put_device:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 16edf85..8bc6660 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -103,6 +103,7 @@ struct nvme_ctrl_ops {
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
+	const char *(*get_subsysnqn)(struct nvme_ctrl *ctrl);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0ce063d..cacecd3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1443,6 +1443,13 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 	return 0;
 }
 
+static const char *nvme_rdma_get_subsysnqn(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	return ctrl->subsysnqn;
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.module			= THIS_MODULE,
 	.reg_read32		= nvmf_reg_read32,
@@ -1451,7 +1458,8 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.io_incapable		= nvme_rdma_io_incapable,
 	.reset_ctrl		= nvme_rdma_reset_ctrl,
 	.free_ctrl		= nvme_rdma_free_ctrl,
-	.delete_ctrl		= nvme_rdma_del_ctrl
+	.delete_ctrl		= nvme_rdma_del_ctrl,
+	.get_subsysnqn		= nvme_rdma_get_subsysnqn,
 };
 
 static int nvme_rdma_create_ctrl(struct device *dev,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a680db6..2feeee2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -353,6 +353,13 @@ static int nvme_loop_del_ctrl(struct nvme_ctrl *nctrl)
 	return 0;
 }
 
+static const char *nvme_loop_get_subsysnqn(struct nvme_ctrl *nctrl)
+{
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
+
+	return ctrl->subsysnqn;
+}
+
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.module			= THIS_MODULE,
 	.reg_read32		= nvmf_reg_read32,
@@ -362,6 +369,7 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.reset_ctrl		= nvme_loop_reset_ctrl,
 	.free_ctrl		= nvme_loop_free_ctrl,
 	.delete_ctrl		= nvme_loop_del_ctrl,
+	.get_subsysnqn		= nvme_loop_get_subsysnqn,
 };
 
 static int nvme_loop_create_ctrl(struct device *dev,
-- 
1.8.4.3
