From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 12:31:16 +0200
Subject: [PATCH 2/5] nvmet: Make cntlid globally unique
In-Reply-To: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
References: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484217079-9259-3-git-send-email-sagi@grimberg.me>

We usually log the cntlid which is confusing in case
we have multiple subsystems each with it's own cntlid ida.
Instead make cntlid ida globally unique and log the initial
association.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/core.c        | 10 ++++------
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 drivers/nvme/target/nvmet.h       |  1 -
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4a367549eb93..16a1c5e85826 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -17,6 +17,7 @@
 #include "nvmet.h"
 
 static struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
+static DEFINE_IDA(cntlid_ida);
 
 /*
  * This read/write semaphore is used to synchronize access to configuration
@@ -749,7 +750,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
-	ret = ida_simple_get(&subsys->cntlid_ida,
+	ret = ida_simple_get(&cntlid_ida,
 			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
 			     GFP_KERNEL);
 	if (ret < 0) {
@@ -816,7 +817,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	list_del(&ctrl->subsys_entry);
 	mutex_unlock(&subsys->lock);
 
-	ida_simple_remove(&subsys->cntlid_ida, ctrl->cntlid);
+	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 	nvmet_subsys_put(subsys);
 
 	kfree(ctrl->sqs);
@@ -915,9 +916,6 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	mutex_init(&subsys->lock);
 	INIT_LIST_HEAD(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
-
-	ida_init(&subsys->cntlid_ida);
-
 	INIT_LIST_HEAD(&subsys->hosts);
 
 	return subsys;
@@ -930,7 +928,6 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
-	ida_destroy(&subsys->cntlid_ida);
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
@@ -973,6 +970,7 @@ static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
+	ida_destroy(&cntlid_ida);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index f4088198cd0d..18dc314601c3 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -153,8 +153,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating controller %d for NQN %s.\n",
-			ctrl->cntlid, ctrl->hostnqn);
+	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
+		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
 	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cc7ad06b43a7..1370eee0a3c0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -142,7 +142,6 @@ struct nvmet_subsys {
 	unsigned int		max_nsid;
 
 	struct list_head	ctrls;
-	struct ida		cntlid_ida;
 
 	struct list_head	hosts;
 	bool			allow_any_host;
-- 
2.7.4
