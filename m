From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 17:46:45 +0200
Subject: [PATCH 2/4] nvme-fabrics: handle queue ready fast path inline
In-Reply-To: <20180611154647.32558-1-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
Message-ID: <20180611154647.32558-3-hch@lst.de>

Avoid a function call for the queue live fast path.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c |  7 ++-----
 drivers/nvme/host/fabrics.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 72d290c71a1e..6b4e253b9347 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -553,14 +553,11 @@ blk_status_t nvmf_fail_nonready_command(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
 
-bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
+bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 
-	if (likely(ctrl->state == NVME_CTRL_LIVE))
-		return true;
-
 	switch (ctrl->state) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
@@ -588,7 +585,7 @@ bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(nvmf_check_ready);
+EXPORT_SYMBOL_GPL(__nvmf_check_ready);
 
 static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 2b7033d95cbd..2ea949a3868c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -163,7 +163,15 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 blk_status_t nvmf_fail_nonready_command(struct request *rq);
-bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
+bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live);
 
+static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
+		bool queue_live)
+{
+	if (likely(ctrl->state == NVME_CTRL_LIVE))
+		return true;
+	return __nvmf_check_ready(ctrl, rq, queue_live);
+}
+
 #endif /* _NVME_FABRICS_H */
-- 
2.17.1
