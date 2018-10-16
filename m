From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:23 -0700
Subject: [PATCH v2 11/11] nvmet: Enable Discovery Controller AENs
In-Reply-To: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1539709883-12424-12-git-send-email-jay.e.sternberg@intel.com>

Add functions to find connections requesting Discovery Change events
and send a notification to hosts that maintain an explicit persistent
connection and have and active Asynchronous Event Request pending.
Only Hosts that have access to the Subsystem effected by the change
will receive notifications of Discovery Change event.

Call these functions each time there is a configfs change that effects
the Discover Log Pages.

Set the OAES field in the Identify Controller response to advertise the
support for Asynchronous Event Notifications.

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Phil Cayton <phil.cayton at intel.com>
---
v2 - updated commit description

 drivers/nvme/target/configfs.c  | 14 +++++++++-
 drivers/nvme/target/discovery.c | 60 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  4 +++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index c1ad175..8917c62 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -603,6 +603,8 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 
 	list_add_tail(&link->entry, &port->subsystems);
 	nvmet_genctr++;
+	nvmet_port_disc_change_event(port, subsys);
+
 	up_write(&nvmet_config_sem);
 	return 0;
 
@@ -630,6 +632,8 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
 found:
 	list_del(&p->entry);
 	nvmet_genctr++;
+	nvmet_port_disc_change_event(port, subsys);
+
 	if (list_empty(&port->subsystems))
 		nvmet_disable_port(port);
 	up_write(&nvmet_config_sem);
@@ -679,6 +683,8 @@ static int nvmet_allowed_hosts_allow_link(struct config_item *parent,
 	}
 	list_add_tail(&link->entry, &subsys->hosts);
 	nvmet_genctr++;
+	nvmet_subsys_disc_change_event(subsys, host);
+
 	up_write(&nvmet_config_sem);
 	return 0;
 out_free_link:
@@ -705,6 +711,8 @@ static void nvmet_allowed_hosts_drop_link(struct config_item *parent,
 found:
 	list_del(&p->entry);
 	nvmet_genctr++;
+	nvmet_subsys_disc_change_event(subsys, host);
+
 	up_write(&nvmet_config_sem);
 	kfree(p);
 }
@@ -743,7 +751,11 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 		goto out_unlock;
 	}
 
-	subsys->allow_any_host = allow_any_host;
+	if (subsys->allow_any_host != allow_any_host) {
+		subsys->allow_any_host = allow_any_host;
+		nvmet_subsys_disc_change_event(subsys, NULL);
+	}
+
 out_unlock:
 	up_write(&nvmet_config_sem);
 	return ret ? ret : count;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 8798a2f..f9f8c3e 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -20,6 +20,60 @@
 
 u64 nvmet_genctr;
 
+static void __nvmet_disc_change_event(struct nvmet_port *port,
+				      struct nvmet_ctrl *ctrl)
+{
+	if (ctrl->port != port)
+		return;
+
+	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_DISC_CHANGE))
+		return;
+
+	nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+			      NVME_AER_NOTICE_DISC_CHANGED, NVME_LOG_DISC);
+}
+
+void nvmet_port_disc_change_event(struct nvmet_port *port,
+				  struct nvmet_subsys *subsys)
+{
+	struct nvmet_ctrl *ctrl;
+
+	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+		if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
+			continue;
+
+		__nvmet_disc_change_event(port, ctrl);
+	}
+}
+
+static void __nvmet_subsys_disc_change_event(struct nvmet_port *port,
+					     struct nvmet_subsys *subsys,
+					     struct nvmet_host *host)
+{
+	struct nvmet_ctrl *ctrl;
+
+	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+		if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
+			continue;
+
+		__nvmet_disc_change_event(port, ctrl);
+	}
+}
+
+void nvmet_subsys_disc_change_event(struct nvmet_subsys *subsys,
+				    struct nvmet_host *host)
+{
+	struct nvmet_port *port;
+	struct nvmet_subsys_link *s;
+
+	list_for_each_entry(port, nvmet_ports, global_entry)
+		list_for_each_entry(s, &port->subsystems, entry) {
+			if (s->subsys != subsys)
+				continue;
+			__nvmet_subsys_disc_change_event(port, subsys, host);
+		}
+}
+
 void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port)
 {
 	down_write(&nvmet_config_sem);
@@ -27,6 +81,7 @@ void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port)
 		list_add_tail(&port->entry, &parent->referrals);
 		port->enabled = true;
 		nvmet_genctr++;
+		nvmet_port_disc_change_event(parent, NULL);
 	}
 	up_write(&nvmet_config_sem);
 }
@@ -38,6 +93,7 @@ void nvmet_referral_disable(struct nvmet_port *parent, struct nvmet_port *port)
 		port->enabled = false;
 		list_del_init(&port->entry);
 		nvmet_genctr++;
+		nvmet_port_disc_change_event(parent, NULL);
 	}
 	up_write(&nvmet_config_sem);
 }
@@ -136,6 +192,8 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	hdr->numrec = cpu_to_le64(numrec);
 	hdr->recfmt = cpu_to_le16(0);
 
+	nvmet_clear_aen_bit(req, NVME_AEN_BIT_DISC_CHANGE);
+
 	up_read(&nvmet_config_sem);
 
 	status = nvmet_copy_to_sgl(req, 0, hdr, data_len);
@@ -174,6 +232,8 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 	if (req->port->inline_data_size)
 		id->sgls |= cpu_to_le32(1 << 20);
 
+	id->oaes = cpu_to_le32(NVMET_DISC_AEN_CFG_OPTIONAL);
+
 	strcpy(id->subnqn, ctrl->subsys->subsysnqn);
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9bb546d..3f5651f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -422,6 +422,10 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 
 extern struct list_head *nvmet_ports;
+void nvmet_port_disc_change_event(struct nvmet_port *port,
+		struct nvmet_subsys *subsys);
+void nvmet_subsys_disc_change_event(struct nvmet_subsys *subsys,
+		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
 
-- 
1.8.3.1
