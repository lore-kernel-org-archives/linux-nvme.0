From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 13:00:03 +0200
Subject: [PATCH 1/2] nvmet: Move serial number from controller to subsystem
In-Reply-To: <20170714110004.11886-1-jthumshirn@suse.de>
References: <20170714110004.11886-1-jthumshirn@suse.de>
Message-ID: <20170714110004.11886-2-jthumshirn@suse.de>

The NVMe specification defines the serial number as:

"Serial Number (SN): Contains the serial number for the NVM subsystem
that is assigned by the vendor as an ASCII string. Refer to section
7.10 for unique identifier requirements. Refer to section 1.5 for ASCII
string requirements"

So move it from the controller to the subsystem, where it belongs.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/core.c      | 4 ++--
 drivers/nvme/target/nvmet.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 35f930db3c02..f7ba006d6a65 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -185,7 +185,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->ssvid = 0;
 
 	memset(id->sn, ' ', sizeof(id->sn));
-	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->serial);
+	snprintf(id->sn, sizeof(id->sn), "%llx", ctrl->subsys->serial);
 
 	memset(id->mn, ' ', sizeof(id->mn));
 	strncpy((char *)id->mn, "Linux", sizeof(id->mn));
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b5b4ac103748..e3ceff3d2d17 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -767,8 +767,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
 
-	/* generate a random serial number as our controllers are ephemeral: */
-	get_random_bytes(&ctrl->serial, sizeof(ctrl->serial));
+	if (!subsys->serial)
+		get_random_bytes(&subsys->serial, sizeof(subsys->serial));
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 747bbdb4f9c6..e3b244c7e443 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -112,7 +112,6 @@ struct nvmet_ctrl {
 
 	struct mutex		lock;
 	u64			cap;
-	u64			serial;
 	u32			cc;
 	u32			csts;
 
@@ -152,6 +151,7 @@ struct nvmet_subsys {
 	u16			max_qid;
 
 	u64			ver;
+	u64			serial;
 	char			*subsysnqn;
 
 	struct config_group	group;
-- 
2.12.3
