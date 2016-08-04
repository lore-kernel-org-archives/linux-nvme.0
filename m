From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 Aug 2016 13:43:24 +0300
Subject: [PATCH] nvmet: Fix controller serial number inconsistency
Message-ID: <1470307404-17193-1-git-send-email-sagi@grimberg.me>

The host is allowed to issue identify as many times
as it wants, we need to stay consistent when reporting
the serial number for a given controller.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 6 +-----
 drivers/nvme/target/core.c      | 4 ++++
 drivers/nvme/target/nvmet.h     | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2fac17a5ad53..47c564b5a289 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -13,7 +13,6 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
-#include <linux/random.h>
 #include <generated/utsrelease.h>
 #include "nvmet.h"
 
@@ -83,7 +82,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
-	u64 serial;
 	u16 status = 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -96,10 +94,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
-	/* generate a random serial number as our controllers are ephemeral: */
-	get_random_bytes(&serial, sizeof(serial));
 	memset(id->sn, ' ', sizeof(id->sn));
-	snprintf(id->sn, sizeof(id->sn), "%llx", serial);
+	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->serial);
 
 	memset(id->mn, ' ', sizeof(id->mn));
 	strncpy((char *)id->mn, "Linux", sizeof(id->mn));
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8a891ca53367..6559d5afa7bf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -13,6 +13,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/random.h>
 #include "nvmet.h"
 
 static struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
@@ -728,6 +729,9 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
 
+	/* generate a random serial number as our controllers are ephemeral: */
+	get_random_bytes(&ctrl->serial, sizeof(ctrl->serial));
+
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 57dd6d834c28..76b6eedccaf9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -113,6 +113,7 @@ struct nvmet_ctrl {
 
 	struct mutex		lock;
 	u64			cap;
+	u64			serial;
 	u32			cc;
 	u32			csts;
 
-- 
1.9.1
