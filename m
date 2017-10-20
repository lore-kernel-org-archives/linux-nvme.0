From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 16:17:09 -0700
Subject: [PATCH v2 4/4] nvme-rdma: add support for duplicate_connect option
In-Reply-To: <20171020231709.3183-1-jsmart2021@gmail.com>
References: <20171020231709.3183-1-jsmart2021@gmail.com>
Message-ID: <20171020231709.3183-5-jsmart2021@gmail.com>

Adds support for the duplicate_connect option. When set to true,
checks whether there's an existing controller via the same target
address (traddr), target port (trsvcid), and if specified, host
address (host_traddr). Fails the connection request if there is
an existing controller.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/rdma.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a5577e06a620..523881444fee 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1848,6 +1848,83 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.reinit_request		= nvme_rdma_reinit_request,
 };
 
+static inline bool
+__nvme_rdma_options_match(struct nvme_rdma_ctrl *ctrl,
+	struct nvmf_ctrl_options *opts)
+{
+	char *stdport = __stringify(NVME_RDMA_IP_PORT);
+
+
+	if (!nvmf_ctlr_matches_baseopts(&ctrl->ctrl, opts) ||
+	    strcmp(opts->traddr, ctrl->ctrl.opts->traddr))
+		return false;
+
+	if (opts->mask & NVMF_OPT_TRSVCID &&
+	    ctrl->ctrl.opts->mask & NVMF_OPT_TRSVCID) {
+		if (strcmp(opts->trsvcid, ctrl->ctrl.opts->trsvcid))
+			return false;
+	} else if (opts->mask & NVMF_OPT_TRSVCID) {
+		if (strcmp(opts->trsvcid, stdport))
+			return false;
+	} else if (ctrl->ctrl.opts->mask & NVMF_OPT_TRSVCID) {
+		if (strcmp(stdport, ctrl->ctrl.opts->trsvcid))
+			return false;
+	}
+	/* else, it's a match as both have stdport. Fall to next checks */
+
+	/*
+	 * checking the local address is rough. In most cases, one
+	 * is not specified and the host port is selected by the stack.
+	 *
+	 * Assume no match if:
+	 *  local address is specified and address is not the same
+	 *  local address is not specified but remote is, or vice versa
+	 *    (admin using specific host_traddr when it matters).
+	 */
+	if (opts->mask & NVMF_OPT_HOST_TRADDR &&
+	    ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR) {
+		if (strcmp(opts->host_traddr, ctrl->ctrl.opts->host_traddr))
+			return false;
+	} else if (opts->mask & NVMF_OPT_HOST_TRADDR ||
+		   ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
+		return false;
+	/*
+	 * if neither controller had an host port specified, assume it's
+	 * a match as everything else matched.
+	 */
+
+	return true;
+}
+
+/*
+ * Fails a connection request if it matches an existing controller
+ * (association) with the same tuple:
+ * <Host NQN, Host ID, local address, remote address, remote port, SUBSYS NQN>
+ *
+ * if local address is not specified in the request, it will match an
+ * existing controller with all the other parameters the same and no
+ * local port address specified as well.
+ *
+ * The ports don't need to be compared as they are intrinsically
+ * already matched by the port pointers supplied.
+ */
+static bool
+nvme_rdma_existing_controller(struct nvmf_ctrl_options *opts)
+{
+	struct nvme_rdma_ctrl *ctrl;
+	bool found = false;
+
+	mutex_lock(&nvme_rdma_ctrl_mutex);
+	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
+		found = __nvme_rdma_options_match(ctrl, opts);
+		if (found)
+			break;
+	}
+	mutex_unlock(&nvme_rdma_ctrl_mutex);
+
+	return found;
+}
+
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -1884,6 +1961,11 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		}
 	}
 
+	if (!opts->duplicate_connect && nvme_rdma_existing_controller(opts)) {
+		ret = -EALREADY;
+		goto out_free_ctrl;
+	}
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)
-- 
2.13.1
