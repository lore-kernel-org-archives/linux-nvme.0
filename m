From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 24 Apr 2017 21:26:57 +0800
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the same
 path gain.
Message-ID: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>

From: Junxiong Guan <guanjunxiong@huawei.com>

Current code has the defect that we will get more /dev/nvme#n#
generated in the /dev node if we execute the same connect command
with nvme-cli tools more than once. To fix it, this patch iterate
the allocated controller list to check if the same subsystem with
the same path of topology exists before create new controller. If
exists, just log and return. The path identifier is combined with
tranport type, transport address, target subsystem nqn and hostnqn.
---
 drivers/nvme/host/core.c   | 33 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/rdma.c   |  8 ++++++++
 drivers/nvme/target/loop.c |  6 ++++++
 4 files changed, 48 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6dcd7a123b50..1d3a077cba78 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2318,6 +2318,39 @@ void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_put_ctrl);
 
+bool nvme_is_ctrl_existed(const struct nvmf_ctrl_options *opts)
+{
+	struct nvme_ctrl *ctrl;
+	bool find = false;
+
+	spin_lock(&dev_list_lock);
+	list_for_each_entry(ctrl, &nvme_ctrl_list, node) {
+		if(strcmp(ctrl->opts->transport, opts->transport))
+			continue;
+		if((opts->mask&NVMF_OPT_TRADDR) \
+				&& (ctrl->opts->traddr != NULL)) {
+			if(strcmp(ctrl->opts->traddr, opts->traddr))
+				continue;
+		}
+		if((opts->mask & NVMF_OPT_TRSVCID) \
+				&& (ctrl->opts->trsvcid != NULL)) {
+			if(strcmp(ctrl->opts->trsvcid, opts->trsvcid))
+				continue;
+		}
+		if(strcmp(ctrl->opts->subsysnqn, opts->subsysnqn))
+			continue;
+		if(strcmp(ctrl->opts->host->nqn, opts->host->nqn))
+			continue;
+		find = true;
+		break;
+	}
+	spin_unlock(&dev_list_lock);
+
+	return find;
+}
+EXPORT_SYMBOL_GPL(nvme_is_ctrl_existed);
+
+
 /*
  * Initialize a NVMe controller structures.  This needs to be called during
  * earliest initialization so that we have the initialized structured around
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 72dc98f6a6c6..07635522b691 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -261,6 +261,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
+bool nvme_is_ctrl_existed(const struct nvmf_ctrl_options *opts);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53b611f9ba5d..6696ed0fdd87 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1858,6 +1858,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	bool changed;
 	char *port;
 
+	if(!(opts->mask & NVMF_OPT_TRSVCID))
+		opts->trsvcid = __stringify(NVME_RDMA_IP_PORT);
+	if(nvme_is_ctrl_existed(opts)) {
+		pr_err("connect to the same subsystem from the same path\n");
+		ret = -EBUSY;
+		return ERR_PTR(ret);
+	}
+
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 8260ee1f8e48..1e0fa2397aa7 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -621,6 +621,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	bool changed;
 	int ret;
 
+	if(nvme_is_ctrl_existed(opts)) {
+		pr_err("connect to the same subsystem from the same path\n");
+		ret = -EBUSY;
+		return ERR_PTR(ret);
+	}
+
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
-- 
2.11.1
