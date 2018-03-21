From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 21 Mar 2018 20:27:07 +0100
Subject: [PATCH] nvme: make nvme_get_log_ext non-static
Message-ID: <20180321192707.17749-1-mb@lightnvm.io>

Enable the lightnvm integration to use the nvme_get_log_ext()
function.

Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00ad24728074..e33527c84cd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2215,7 +2215,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			    u8 log_page, void *log,
 			    size_t size, size_t offset)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index eaa3af096eec..4cfd890ff5ca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -428,6 +428,9 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
+int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 log_page, void *log, size_t size, size_t offset);
+
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
-- 
2.11.0
