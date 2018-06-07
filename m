From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 09:35:54 +0200
Subject: [PATCH 2/4] nvmet: ANA transition timeout handling
In-Reply-To: <20180607073556.39050-1-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
Message-ID: <20180607073556.39050-3-hare@suse.de>

Whenever an ANA state change is triggered the ANA state for that
group ID is set to 'state change' and a delayed work is started,
which will be setting the port to the actual state after anatt
has expired.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/configfs.c |  5 ++-
 drivers/nvme/target/core.c     | 78 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    | 12 +++++++
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index cca4de356818..a39e35399dba 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -967,7 +967,9 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
 	nvmet_ana_chgcnt++;
 	up_write(&nvmet_ana_sem);
 
-	nvmet_port_send_ana_event(grp->port);
+	nvmet_port_ana_state_change(grp->port, grp->grpid,
+				    nvmet_ana_state_names[i].state);
+
 	return count;
 }
 
@@ -1110,6 +1112,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
+	INIT_LIST_HEAD(&port->anatt_list);
 	port->anatt = NVMET_DEFAULT_ANATT;
 
 	port->disc_addr.portid = cpu_to_le16(portid);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 72c573c0a8df..dfd163d98488 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -20,6 +20,7 @@
 
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
+static struct workqueue_struct *nvmet_ana_wq;
 
 /*
  * This read/write semaphore is used to synchronize access to configuration
@@ -217,6 +218,65 @@ void nvmet_port_send_ana_event(struct nvmet_port *port)
 	up_read(&nvmet_config_sem);
 }
 
+void nvmet_ana_state_change_work(struct work_struct *work)
+{
+	struct nvmet_ana_change_event *ev = container_of(work,
+		struct nvmet_ana_change_event, work.work);
+	struct nvmet_port *port = ev->port;
+
+	if (!port->enabled)
+		return;
+	mutex_lock(&port->anatt_list_lock);
+	list_del_init(&ev->entry);
+	mutex_unlock(&port->anatt_list_lock);
+
+	down_write(&nvmet_ana_sem);
+	port->ana_state[ev->grpid] = ev->state;
+	nvmet_ana_chgcnt++;
+	up_write(&nvmet_ana_sem);
+	kfree(ev);
+
+	nvmet_port_send_ana_event(port);
+}
+
+void nvmet_port_ana_state_change(struct nvmet_port *port,
+				 u32 grpid, enum nvme_ana_state state)
+{
+	struct nvmet_ana_change_event *ev;
+	enum nvme_ana_state tmp_state = NVME_ANA_CHANGE;
+
+	if (!port->enabled)
+		return;
+
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		tmp_state = state;
+
+	down_write(&nvmet_ana_sem);
+	port->ana_state[grpid] = tmp_state;
+	nvmet_ana_chgcnt++;
+	up_write(&nvmet_ana_sem);
+
+	if (!ev) {
+		nvmet_port_send_ana_event(port);
+		return;
+	}
+
+	INIT_DELAYED_WORK(&ev->work, nvmet_ana_state_change_work);
+	ev->port = port;
+	ev->grpid = grpid;
+	ev->state = state;
+	mutex_lock(&port->anatt_list_lock);
+	list_add_tail(&ev->entry, &port->anatt_list);
+	mutex_unlock(&port->anatt_list_lock);
+	/*
+	 * Reduce the delay by 1 sec to not accidentally trigger an
+	 * ANA transition timeout failure on the host.
+	 */
+	queue_delayed_work(nvmet_ana_wq, &ev->work,
+			   (port->anatt - 1) * HZ);
+}
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
@@ -276,11 +336,22 @@ int nvmet_enable_port(struct nvmet_port *port)
 void nvmet_disable_port(struct nvmet_port *port)
 {
 	const struct nvmet_fabrics_ops *ops;
+	struct nvmet_ana_change_event *ev, *tmp;
 
 	lockdep_assert_held(&nvmet_config_sem);
 
 	port->enabled = false;
 
+	mutex_lock(&port->anatt_list_lock);
+	list_for_each_entry_safe(ev, tmp, &port->anatt_list, entry) {
+		if (ev->port == port) {
+			list_del_init(&ev->entry);
+			cancel_delayed_work_sync(&ev->work);
+			kfree(ev);
+		}
+	}
+	mutex_unlock(&port->anatt_list_lock);
+
 	ops = nvmet_transports[port->disc_addr.trtype];
 	ops->remove_port(port);
 	module_put(ops->owner);
@@ -1162,6 +1233,11 @@ static int __init nvmet_init(void)
 {
 	int error;
 
+	nvmet_ana_wq = alloc_workqueue("nvmet_ana_wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvmet_ana_wq)
+		return -ENOMEM;
+
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
 	error = nvmet_init_discovery();
@@ -1176,6 +1252,7 @@ static int __init nvmet_init(void)
 out_exit_discovery:
 	nvmet_exit_discovery();
 out:
+	destroy_workqueue(nvmet_ana_wq);
 	return error;
 }
 
@@ -1184,6 +1261,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
+	destroy_workqueue(nvmet_ana_wq);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 948209d5f803..a5a309ca003a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -129,6 +129,8 @@ struct nvmet_port {
 	struct list_head		referrals;
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_group1;
+	struct list_head		anatt_list;
+	struct mutex			anatt_list_lock;
 	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
@@ -320,6 +322,14 @@ struct nvmet_async_event {
 	u8			log_page;
 };
 
+struct nvmet_ana_change_event {
+	struct delayed_work	work;
+	struct list_head	entry;
+	struct nvmet_port	*port;
+	enum nvme_ana_state	state;
+	u8			grpid;
+};
+
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
@@ -364,6 +374,8 @@ void nvmet_ns_free(struct nvmet_ns *ns);
 
 void nvmet_send_ana_event(struct nvmet_subsys *subsys);
 void nvmet_port_send_ana_event(struct nvmet_port *port);
+void nvmet_port_ana_state_change(struct nvmet_port *port,
+				 u32 grpid, enum nvme_ana_state state);
 
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
 void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
-- 
2.12.3
