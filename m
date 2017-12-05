From: hare@suse.de (Hannes Reinecke)
Date: Tue,  5 Dec 2017 09:04:42 +0100
Subject: [PATCH] nvme-fc: Implement async-connect option
Message-ID: <1512461082-41520-1-git-send-email-hare@suse.de>

By opening the control fd with O_NONBLOCK the fabrics module will
attempt an async connect if implemented.
This is especially useful when calling 'nvme connect' from an udev
rule, as there each program should return as fast as possible to
avoid an udev event processing stall.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c |  9 ++++++---
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/fc.c      | 10 +++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 76b4fe6..b577e7e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -568,6 +568,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 	opts->kato = NVME_DEFAULT_KATO;
 	opts->duplicate_connect = false;
+	opts->async_connect = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -831,7 +832,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT)
 
 static struct nvme_ctrl *
-nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
+nvmf_create_ctrl(struct device *dev, const char *buf, size_t count, bool async)
 {
 	struct nvmf_ctrl_options *opts;
 	struct nvmf_transport_ops *ops;
@@ -846,6 +847,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	if (ret)
 		goto out_free_opts;
 
+	opts->async_connect = async;
 
 	request_module("nvme-%s", opts->transport);
 
@@ -882,7 +884,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 		goto out_unlock;
 	}
 
-	if (strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
+	if (ctrl->subsys && strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
 		dev_warn(ctrl->device,
 			"controller returned incorrect NQN: \"%s\".\n",
 			ctrl->subsys->subnqn);
@@ -926,7 +928,8 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
 		goto out_unlock;
 	}
 
-	ctrl = nvmf_create_ctrl(nvmf_device, buf, count);
+	ctrl = nvmf_create_ctrl(nvmf_device, buf, count,
+				file->f_flags & O_NONBLOCK);
 	if (IS_ERR(ctrl)) {
 		ret = PTR_ERR(ctrl);
 		goto out_unlock;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 9ba6149..081c94c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -98,6 +98,7 @@ struct nvmf_ctrl_options {
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
 	bool			duplicate_connect;
+	bool			async_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
 	int			max_reconnects;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 26ff51b..fc0a7b8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3190,6 +3190,14 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	if (ctrl->ctrl.opts->async_connect) {
+		nvme_get_ctrl(&ctrl->ctrl);
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: starting async-connect\n", ctrl->cnum);
+		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
+		goto done;
+	}
+
 	/*
 	 * It's possible that transactions used to create the association
 	 * may fail. Examples: CreateAssociation LS or CreateIOConnection
@@ -3243,7 +3251,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	}
 
 	nvme_get_ctrl(&ctrl->ctrl);
-
+done:
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
 		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
-- 
1.8.5.6
