From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 12:07:52 +0200
Subject: [PATCH 4.15-rc 3/3] nvme-fabrics: Protect against module unload
 during create_ctrl
In-Reply-To: <20171221100752.18386-1-sagi@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
Message-ID: <20171221100752.18386-4-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

nvme transport driver module unload may (and usually does) trigger iteration
over the active controllers and delete them all (sometimes under a mutex).
However, a controller can be created concurrently with module unload
which can lead to leakage of resources (most important char device node
leakage) in case the controller create occured after the unload delete and drain
sequence. To protect against this, we take a module reference to guarantee that
the nvme transport driver is not unloaded while creating a controller.

Signed-off-by: roy shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 16 ++++++++++++----
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/target/loop.c  |  1 +
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 76b4fe6816a0..11bf2d70570f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -492,7 +492,7 @@ EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
  */
 int nvmf_register_transport(struct nvmf_transport_ops *ops)
 {
-	if (!ops->create_ctrl)
+	if (!ops->create_ctrl || !ops->module)
 		return -EINVAL;
 
 	down_write(&nvmf_transports_rwsem);
@@ -868,24 +868,30 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		goto out_unlock;
 	}
 
+	if (!try_module_get(ops->module)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	ret = nvmf_check_required_opts(opts, ops->required_opts);
 	if (ret)
-		goto out_unlock;
+		goto out_module_put;
 	ret = nvmf_check_allowed_opts(opts, NVMF_ALLOWED_OPTS |
 				ops->allowed_opts | ops->required_opts);
 	if (ret)
-		goto out_unlock;
+		goto out_module_put;
 
 	ctrl = ops->create_ctrl(dev, opts);
 	if (IS_ERR(ctrl)) {
 		ret = PTR_ERR(ctrl);
-		goto out_unlock;
+		goto out_module_put;
 	}
 
 	if (strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
 		dev_warn(ctrl->device,
 			"controller returned incorrect NQN: \"%s\".\n",
 			ctrl->subsys->subnqn);
+		module_put(ops->module);
 		up_read(&nvmf_transports_rwsem);
 		nvme_delete_ctrl_sync(ctrl);
 		return ERR_PTR(-EINVAL);
@@ -894,6 +900,8 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 	up_read(&nvmf_transports_rwsem);
 	return ctrl;
 
+out_module_put:
+	module_put(ops->module);
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 9ba614953607..25b19f722f5b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -108,6 +108,7 @@ struct nvmf_ctrl_options {
  *			       fabric implementation of NVMe fabrics.
  * @entry:		Used by the fabrics library to add the new
  *			registration entry to its linked-list internal tree.
+ * @module:             Transport module reference
  * @name:		Name of the NVMe fabric driver implementation.
  * @required_opts:	sysfs command-line options that must be specified
  *			when adding a new NVMe controller.
@@ -126,6 +127,7 @@ struct nvmf_ctrl_options {
  */
 struct nvmf_transport_ops {
 	struct list_head	entry;
+	struct module		*module;
 	const char		*name;
 	int			required_opts;
 	int			allowed_opts;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e2ade0237ffe..e68c6b84c177 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3380,6 +3380,7 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 
 static struct nvmf_transport_ops nvme_fc_transport = {
 	.name		= "fc",
+	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR | NVMF_OPT_HOST_TRADDR,
 	.allowed_opts	= NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO,
 	.create_ctrl	= nvme_fc_create_ctrl,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ff56d86467de..596a3dde47fd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2006,6 +2006,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 static struct nvmf_transport_ops nvme_rdma_transport = {
 	.name		= "rdma",
+	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cab6ded4dca6..098d5b978691 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -686,6 +686,7 @@ static struct nvmet_fabrics_ops nvme_loop_ops = {
 
 static struct nvmf_transport_ops nvme_loop_transport = {
 	.name		= "loop",
+	.module		= THIS_MODULE,
 	.create_ctrl	= nvme_loop_create_ctrl,
 };
 
-- 
2.14.1
