From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:21:44 +0300
Subject: [PATCH rfc 10/30] nvme: Add admin_tagset pointer to nvme_ctrl
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-11-git-send-email-sagi@grimberg.me>

Will be used when we centralize control flows. only
rdma for now.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/rdma.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 415a5ea4759c..3be59634b4af 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -126,6 +126,7 @@ struct nvme_ctrl {
 	struct kref kref;
 	int instance;
 	struct blk_mq_tag_set *tagset;
+	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2b23f88bedfe..58ed2ae3cd35 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -801,6 +801,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 		error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 		if (error)
 			goto out_put_dev;
+		ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 		if (IS_ERR(ctrl->ctrl.admin_q)) {
-- 
2.7.4
