From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Apr 2019 16:28:19 -0700
Subject: [PATCH] nvmet: protect discovery change log event list iteration
Message-ID: <20190429232819.9844-1-sagi@grimberg.me>

When we iterate on the discovery subsystem controllers
we need to protect against concurrent mutations to it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- don't protect nvmet_genctr with subsys lock
  but throw a lockdep_assert_held on nvmet_config_sem

 drivers/nvme/target/discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e8e09266bfa5..5baf269f3f8a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -30,14 +30,17 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 {
 	struct nvmet_ctrl *ctrl;
 
+	lockdep_assert_held(&nvmet_config_sem);
 	nvmet_genctr++;
 
+	mutex_lock(&nvmet_disc_subsys->lock);
 	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
 		if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
+	mutex_unlock(&nvmet_disc_subsys->lock);
 }
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
@@ -46,12 +49,14 @@ static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
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
