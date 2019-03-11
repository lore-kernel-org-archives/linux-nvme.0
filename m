From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:11:57 -0700
Subject: [PATCH] nvmet: protect discovery change log event
Message-ID: <20190311221157.25266-1-sagi@grimberg.me>

When we iterate on the discovery subsystem controllers
we need to protect against concurrent mutations to it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/discovery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index a34cf4986a49..dd6e8248e643 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -38,14 +38,15 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 {
 	struct nvmet_ctrl *ctrl;
 
+	mutex_lock(&nvmet_disc_subsys->lock);
 	nvmet_genctr++;
-
 	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
 		if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
+	mutex_unlock(&nvmet_disc_subsys->lock);
 }
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
@@ -54,12 +55,14 @@ static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
 {
 	struct nvmet_ctrl *ctrl;
 
+	mutex_lock(&nvmet_disc_subsys->lock);
 	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
 		if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
+	mutex_unlock(&nvmet_disc_subsys->lock);
 }
 
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
-- 
2.17.1
