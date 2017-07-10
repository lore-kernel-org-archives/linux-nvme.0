From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:29 +0300
Subject: [PATCH 02/12] nvme: Add admin_tagset pointer to nvme_ctrl
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-3-git-send-email-sagi@grimberg.me>

Will be used when we centralize control flows. only
rdma for now.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 1 +
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d666ada39a9b..ac8ae67cdc07 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2730,6 +2730,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 	if (ret)
 		goto out_free_queues;
+	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8f2a168ddc01..0a43f3e1a52a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -125,6 +125,7 @@ struct nvme_ctrl {
 	struct kref kref;
 	int instance;
 	struct blk_mq_tag_set *tagset;
+	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73fddf2c99f9..81f7ccc58d70 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1340,6 +1340,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
 			return -ENOMEM;
+		dev->ctrl.admin_tagset = &dev->admin_tagset;
 
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 65e35824ceb6..564a15af7c34 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -700,6 +700,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 	if (error)
 		goto out_put_dev;
+	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 717ed7ddb2f6..92628c432926 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -375,6 +375,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 	if (error)
 		goto out_free_sq;
+	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
-- 
2.7.4
