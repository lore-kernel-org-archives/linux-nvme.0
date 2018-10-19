From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Oct 2018 17:40:39 -0700
Subject: [PATCH v2 1/2] nvme-rdma: always have a valid trsvcid
Message-ID: <20181019004040.28527-1-sagi@grimberg.me>

If not passed, we set the default trsvcid. We can rely on having trsvcid
and can simplify the controller matching logic.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- fixed change log

 drivers/nvme/host/rdma.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e7be903041a8..ca18fe67f856 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1860,26 +1860,11 @@ static inline bool
 __nvme_rdma_options_match(struct nvme_rdma_ctrl *ctrl,
 	struct nvmf_ctrl_options *opts)
 {
-	char *stdport = __stringify(NVME_RDMA_IP_PORT);
-
-
 	if (!nvmf_ctlr_matches_baseopts(&ctrl->ctrl, opts) ||
-	    strcmp(opts->traddr, ctrl->ctrl.opts->traddr))
+	    strcmp(opts->traddr, ctrl->ctrl.opts->traddr) ||
+	    strcmp(opts->trsvcid, ctrl->ctrl.opts->trsvcid))
 		return false;
 
-	if (opts->mask & NVMF_OPT_TRSVCID &&
-	    ctrl->ctrl.opts->mask & NVMF_OPT_TRSVCID) {
-		if (strcmp(opts->trsvcid, ctrl->ctrl.opts->trsvcid))
-			return false;
-	} else if (opts->mask & NVMF_OPT_TRSVCID) {
-		if (strcmp(opts->trsvcid, stdport))
-			return false;
-	} else if (ctrl->ctrl.opts->mask & NVMF_OPT_TRSVCID) {
-		if (strcmp(stdport, ctrl->ctrl.opts->trsvcid))
-			return false;
-	}
-	/* else, it's a match as both have stdport. Fall to next checks */
-
 	/*
 	 * checking the local address is rough. In most cases, one
 	 * is not specified and the host port is selected by the stack.
@@ -1939,7 +1924,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	struct nvme_rdma_ctrl *ctrl;
 	int ret;
 	bool changed;
-	char *port;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -1947,15 +1931,17 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
-	if (opts->mask & NVMF_OPT_TRSVCID)
-		port = opts->trsvcid;
-	else
-		port = __stringify(NVME_RDMA_IP_PORT);
+	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
+		opts->trsvcid =
+			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);
+		opts->mask |= NVMF_OPT_TRSVCID;
+	}
 
 	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
-			opts->traddr, port, &ctrl->addr);
+			opts->traddr, opts->trsvcid, &ctrl->addr);
 	if (ret) {
-		pr_err("malformed address passed: %s:%s\n", opts->traddr, port);
+		pr_err("malformed address passed: %s:%s\n",
+			opts->traddr, opts->trsvcid);
 		goto out_free_ctrl;
 	}
 
-- 
2.17.1
