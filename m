From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:29 +0200
Subject: [PATCH 08/10] nvmet: Set nanagrpid correctly
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-9-hare@suse.de>

We should be returning the actual number of namespaces for nanagrpid.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f2eedb13482a..a9d05eb03117 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -217,6 +217,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
 	const char model[] = "Linux";
+	u32 grpid;
+	u16 ngrps = 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -242,8 +244,26 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	 * the safest is to leave it as zeroes.
 	 */
 
-	/* we support multiple ports, multiples hosts and ANA: */
-	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
+	/* we support multiple ports and multiple hosts: */
+	id->cmic = (1 << 0) | (1 << 1);
+
+	/* ANA Support */
+	down_read(&nvmet_ana_sem);
+	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
+		if (nvmet_ana_group_enabled[grpid])
+			ngrps++;
+	}
+	up_read(&nvmet_ana_sem);
+
+	if (ngrps) {
+		id->cmic |= (1 << 3);
+		/* All ANA states are supported */
+		id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | \
+			(1 << 3) | (1 << 4);
+		id->anatt = ctrl->subsys->anatt;
+		id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
+		id->nanagrpid = cpu_to_le32(ngrps);
+	}
 
 	/* no limit on data transfer sizes for now */
 	id->mdts = 0;
@@ -311,11 +331,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->msdbd = ctrl->ops->msdbd;
 
-	id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
-	id->anatt = ctrl->subsys->anatt;
-	id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
-	id->nanagrpid = cpu_to_le32(NVMET_MAX_ANAGRPS);
-
 	/*
 	 * Meh, we don't really support any power state.  Fake up the same
 	 * values that qemu does.
-- 
2.12.3
