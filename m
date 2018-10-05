From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Fri,  5 Oct 2018 13:26:51 -0700
Subject: [PATCH v2 09/11] nvmet: Allow all hosts access to the Discovery
 subsystem
Message-ID: <1538771212-238331-1-git-send-email-jay.e.sternberg@intel.com>

From: Sagi Grimberg <sagi@grimberg.me>

All hosts should have access to the Discovery subsystem.

This change removes the need to pass the nvmet_req structure into
the nvmet_host_discovery_allowed function and removes the need for
the function nvmet_host_discovery_allowed.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Phil Cayton <phil.cayton at intel.com>
---
v2 - corrected author

 drivers/nvme/target/core.c      | 20 +++-----------------
 drivers/nvme/target/discovery.c |  2 +-
 drivers/nvme/target/nvmet.h     |  3 +--
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f5cd31e..67ea1d2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -890,26 +890,12 @@ static bool __nvmet_host_allowed(struct nvmet_subsys *subsys,
 	return false;
 }
 
-static bool nvmet_host_discovery_allowed(struct nvmet_req *req,
-		const char *hostnqn)
-{
-	struct nvmet_subsys_link *s;
-
-	list_for_each_entry(s, &req->port->subsystems, entry) {
-		if (__nvmet_host_allowed(s->subsys, hostnqn))
-			return true;
-	}
-
-	return false;
-}
-
-bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
-		const char *hostnqn)
+bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 {
 	lockdep_assert_held(&nvmet_config_sem);
 
 	if (subsys->type == NVME_NQN_DISC)
-		return nvmet_host_discovery_allowed(req, hostnqn);
+		return true;
 	else
 		return __nvmet_host_allowed(subsys, hostnqn);
 }
@@ -933,7 +919,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	down_read(&nvmet_config_sem);
-	if (!nvmet_host_allowed(req, subsys, hostnqn)) {
+	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
 			hostnqn, subsysnqn);
 		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 9ae8208..8798a2f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -107,7 +107,7 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 
 	down_read(&nvmet_config_sem);
 	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(req, p->subsys, ctrl->hostnqn))
+		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
 			continue;
 		if (residual_len >= entry_size) {
 			char traddr[NVMF_TRADDR_SIZE];
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ea93a46..0a65415 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -459,8 +459,7 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 extern u64 nvmet_ana_chgcnt;
 extern struct rw_semaphore nvmet_ana_sem;
 
-bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
-		const char *hostnqn);
+bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
-- 
1.8.3.1
