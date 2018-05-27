From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:15 +0300
Subject: [PATCH 10/17] nvme: export nvme_ns_has_pi function
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-11-git-send-email-maxg@mellanox.com>

This function will be used by transports that support T10-PI
mechanism.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1830978..cc71a86 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -168,10 +168,11 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_delete_ctrl_sync);
 
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
+bool nvme_ns_has_pi(struct nvme_ns *ns)
 {
 	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
 }
+EXPORT_SYMBOL_GPL(nvme_ns_has_pi);
 
 static blk_status_t nvme_error_status(struct request *req)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 49759ca..b2352de 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -429,6 +429,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
+bool nvme_ns_has_pi(struct nvme_ns *ns);
 
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		u8 log_page, void *log, size_t size, u64 offset);
-- 
1.8.3.1
