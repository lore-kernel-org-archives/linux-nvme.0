From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu,  1 Aug 2019 17:45:07 -0600
Subject: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
In-Reply-To: <20190801234514.7941-1-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
Message-ID: <20190801234514.7941-9-logang@deltatee.com>

This patch rejects any new connection to the passthru-ctrl if this
controller is already connected to a different host. At the time of
allocating the controller we check if the subsys associated with
the passthru ctrl is already connected to a host and reject it
if the hostnqn differs.

Connections from the same host (by hostnqn) are supported to allow
for multipath.

[chaitanya.kulkarni at wdc.com: based conceptually on a similar patch but
  different implementation]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/core.c            |  4 ++++
 drivers/nvme/target/io-cmd-passthru.c | 31 +++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h           |  7 ++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2e75968af7f4..c655f26db3da 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1278,6 +1278,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
+	ret = nvmet_passthru_alloc_ctrl(subsys, hostnqn);
+	if (ret)
+		goto out_free_sqs;
+
 	ret = ida_simple_get(&cntlid_ida,
 			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
 			     GFP_KERNEL);
diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index b199785500ad..06a919283cc5 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -104,6 +104,37 @@ void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 	mutex_unlock(&subsys->lock);
 }
 
+int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys,
+			      const char *hostnqn)
+{
+	struct nvmet_ctrl *ctrl;
+
+	/*
+	 * Check here if this subsystem is already connected to the passthru
+	 * ctrl. We allow only one host to connect to a given passthru
+	 * subsystem.
+	 */
+	int rc = 0;
+
+	mutex_lock(&subsys->lock);
+
+	if (!subsys->passthru_ctrl)
+		goto out;
+
+	if (list_empty(&subsys->ctrls))
+		goto out;
+
+	ctrl = list_first_entry(&subsys->ctrls, struct nvmet_ctrl,
+				subsys_entry);
+
+	if (strcmp(hostnqn, ctrl->hostnqn))
+		rc = -ENODEV;
+
+out:
+	mutex_unlock(&subsys->lock);
+	return rc;
+}
+
 static void nvmet_passthru_req_complete(struct nvmet_req *req,
 		struct request *rq, u16 status)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index aff4db03269d..6436cb990905 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -513,6 +513,8 @@ void nvmet_passthru_destroy(void);
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
 void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
+int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys,
+			      const char *hostnqn);
 u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
 
 static inline
@@ -536,6 +538,11 @@ static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 static inline void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 }
+static inline int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys,
+					    const char *hostnqn)
+{
+	return 0;
+}
 static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
 {
 	return 0;
-- 
2.20.1
