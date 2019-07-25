From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:30 -0600
Subject: [PATCH v6 11/16] nvmet-core: allow one host per passthru-ctrl
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-12-logang@deltatee.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This patch rejects any new connection to the passthru-ctrl if this
controller is already connected to host. At the time of allocating the
controller we check if the subsys associated with the passthru ctrl is
already connected to the host.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
[logang at deltatee.com:
   * drop the overide of the target cntlid with the passthru cntlid;
     this seemed like a really bad idea especially in the presence of
     mixed systems as you could end up with two ctrlrs with the same
     cntlid
   * push the check to ensure only one ctrlr per subsys into
     functions in passthru-cmd.c to avoid excess inline #ifdefs
]
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/core.c            |  6 +++++
 drivers/nvme/target/io-cmd-passthru.c | 32 +++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h           | 10 +++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2e75968af7f4..9e92486e2ee9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -13,6 +13,7 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+#include "../host/nvme.h"
 #include "nvmet.h"
 
 struct workqueue_struct *buffered_io_wq;
@@ -1278,6 +1279,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
+	ret = nvmet_passthru_alloc_ctrl(subsys);
+	if (ret)
+		goto out_free_sqs;
+
 	ret = ida_simple_get(&cntlid_ida,
 			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
 			     GFP_KERNEL);
@@ -1341,6 +1346,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
+	nvmet_passthru_ctrl_free(subsys);
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
 	kfree(ctrl->sqs);
diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index 9ddcdb8415fc..aefdd534cb4a 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -104,6 +104,38 @@ void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 	mutex_unlock(&subsys->lock);
 }
 
+int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys)
+{
+	/*
+	 * Check here if this subsystem is already connected to the passthru
+	 * ctrl. We allow only one target ctrl for one passthru subsystem.
+	 */
+
+	mutex_lock(&subsys->lock);
+
+	if (!subsys->passthru_ctrl)
+		goto out;
+
+	if (subsys->passthru_connected) {
+		mutex_unlock(&subsys->lock);
+		return -ENODEV;
+	}
+
+	subsys->passthru_connected = true;
+
+out:
+	mutex_unlock(&subsys->lock);
+
+	return 0;
+}
+
+void nvmet_passthru_ctrl_free(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	subsys->passthru_connected = false;
+	mutex_unlock(&subsys->lock);
+}
+
 static void nvmet_passthru_req_complete(struct nvmet_req *req,
 		struct request *rq, u16 status)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index aff4db03269d..004949b6b666 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -231,6 +231,7 @@ struct nvmet_subsys {
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
 	char			*passthru_ctrl_path;
+	bool			passthru_connected;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
@@ -513,6 +514,8 @@ void nvmet_passthru_destroy(void);
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
 void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
+int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys);
+void nvmet_passthru_ctrl_free(struct nvmet_subsys *subsys);
 u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
 
 static inline
@@ -536,6 +539,13 @@ static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 static inline void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 }
+static inline int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys)
+{
+	return 0;
+}
+static inline void nvmet_passthru_ctrl_free(struct nvmet_subsys *subsys)
+{
+}
 static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
 {
 	return 0;
-- 
2.20.1
