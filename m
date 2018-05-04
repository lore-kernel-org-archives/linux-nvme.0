From: hare@suse.de (Hannes Reinecke)
Date: Fri,  4 May 2018 13:28:43 +0200
Subject: [PATCH 3/5] nvmet: Add ANA base support
In-Reply-To: <20180504112845.38820-1-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
Message-ID: <20180504112845.38820-4-hare@suse.de>

Add ANA support to the nvme target. The ANA configuration is optional,
and doesn't interfere with existing configurations.
Each subsystem has distinct ANA groups; if ANA groups are created
it is required to link the ANA groups into the individual ports.
Linking the entire subsystem will be refused if ANA groups are
specified.
Also this implementation has a limit of one single ANA state per
groups, irrespective of the path. So when distinct ANA states
are required one needs to create different ANA groups.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c |  69 +++++++++-
 drivers/nvme/target/configfs.c  | 272 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c      |  78 +++++++++++-
 drivers/nvme/target/discovery.c |  16 +++
 drivers/nvme/target/io-cmd.c    |  10 ++
 drivers/nvme/target/nvmet.h     |  44 +++++++
 6 files changed, 483 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a53259e1082e..7e47527963e4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -102,6 +102,35 @@ static u16 nvmet_get_smart_log(struct nvmet_req *req,
 	return status;
 }
 
+static u16 nvmet_get_ana_log(struct nvmet_req *req,
+			     struct nvmf_ana_rsp_page_header *alog)
+{
+	struct nvmf_ana_group_descriptor *desc;
+	struct nvmet_ns *ns;
+	struct nvmet_ctrl *ctrl;
+	int nsid = 0;
+
+	ctrl = req->sq->ctrl;
+
+	put_unaligned_le64(ctrl->subsys->change_count, &alog->chgcnt);
+	/* We only have one ANA group per controller for now */
+	put_unaligned_le64(1, &alog->grpid_num);
+	desc = &alog->desc[0];
+
+	put_unaligned_le32(ctrl->ag->grpid, &desc->groupid);
+	put_unaligned_le64(ctrl->ag->change_count, &desc->chgcnt);
+	desc->ana_state = ctrl->ag->state;
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		put_unaligned_le32(ns->nsid, &desc->nsid[nsid]);
+		nsid++;
+	}
+	rcu_read_unlock();
+	put_unaligned_le32(nsid, &desc->nsid_num);
+
+	return NVME_SC_SUCCESS;
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	struct nvme_smart_log *smart_log;
@@ -149,6 +178,11 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * still claim to fully implement this mandatory log page.
 		 */
 		break;
+	case NVME_LOG_ANA:
+		status = nvmet_get_ana_log(req, buf);
+		if (status)
+			goto err;
+		break;
 	default:
 		BUG();
 	}
@@ -165,6 +199,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
+	struct nvmet_ag *ag;
+	u32 num_ag = 0;
 	u16 status = 0;
 	const char model[] = "Linux";
 
@@ -189,9 +225,26 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	memcpy(id->ieee, &ctrl->subsys->oui, 3);
 
-	/* we support multiple ports and multiples hosts: */
+	rcu_read_lock();
+	list_for_each_entry_rcu(ag, &ctrl->subsys->ana_groups, entry)
+		num_ag++;
+	rcu_read_unlock();
+
+	/* we support multiple ports and multiple hosts */
 	id->cmic = (1 << 0) | (1 << 1);
 
+	/* ANA support */
+	if (num_ag > 0) {
+		id->cmic |= (1 << 3);
+
+		/* All ANA states are supported */
+		id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | \
+			(1 << 3) | (1 << 4);
+		id->anatt = ctrl->subsys->ana_tt;
+		id->anagrpmax = cpu_to_le32((u32)-1);
+		id->nanagrpid = cpu_to_le32(num_ag);
+	}
+
 	/* no limit on data transfer sizes for now */
 	id->mdts = 0;
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
@@ -277,6 +330,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
+	u8 ag_state = NVME_ANA_STATE_OPTIMIZED;
 
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
 	if (!ns) {
@@ -290,12 +344,24 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
+	if (req->sq->ctrl->ag) {
+		id->anagrpid = cpu_to_le32(req->sq->ctrl->ag->grpid);
+		ag_state = req->sq->ctrl->ag->state;
+	}
+
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
 	 */
 	id->ncap = id->nuse = id->nsze =
 		cpu_to_le64(ns->size >> ns->blksize_shift);
+	/*
+	 * nuse and nsze should be zero for inaccessible or
+	 * persistent loss ANA state.
+	 */
+	if ((ag_state == NVME_ANA_STATE_INACCESSIBLE) ||
+	    (ag_state == NVME_ANA_STATE_PERSISTENT_LOSS))
+		id->nuse = id->nsze = 0;
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -560,6 +626,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_LOG_ERROR:
 		case NVME_LOG_SMART:
 		case NVME_LOG_FW_SLOT:
+		case NVME_LOG_ANA:
 			req->execute = nvmet_execute_get_log_page;
 			return 0;
 		}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3dc2b2ae56e5..851ad26550c4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -22,6 +22,7 @@
 
 static const struct config_item_type nvmet_host_type;
 static const struct config_item_type nvmet_subsys_type;
+static const struct config_item_type nvmet_ag_type;
 
 static const struct nvmet_transport_name {
 	u8		type;
@@ -381,7 +382,7 @@ CONFIGFS_ATTR(nvmet_ns_, device_nguid);
 static ssize_t nvmet_ns_device_eui64_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%llx\n",
-		       (unsigned long long)&to_nvmet_ns(item)->eui64);
+		       (unsigned long long)to_nvmet_ns(item)->eui64);
 }
 
 static ssize_t nvmet_ns_device_eui64_store(struct config_item *item,
@@ -522,6 +523,10 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 		pr_err("can only link subsystems into the subsystems dir.!\n");
 		return -EINVAL;
 	}
+	if (!list_empty(&port->ags)) {
+		pr_err("can only link subsystems if no ANA groups are active!\n");
+		return -EAGAIN;
+	}
 	subsys = to_subsys(target);
 	link = kmalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
@@ -586,6 +591,227 @@ static const struct config_item_type nvmet_port_subsys_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static int nvmet_port_ags_allow_link(struct config_item *parent,
+		struct config_item *target)
+{
+	struct nvmet_port *port = to_nvmet_port(parent->ci_parent);
+	struct nvmet_ag *ag;
+	struct nvmet_ag_link *link, *p;
+	int ret;
+
+	if (target->ci_type != &nvmet_ag_type) {
+		pr_err("can only link ana_groups into the ana_groups dir.!\n");
+		return -EINVAL;
+	}
+	if (!list_empty(&port->subsystems)) {
+		pr_err("can only link ana_groups if no subsystems are specified!\n");
+		return -EAGAIN;
+	}
+	ag = to_nvmet_ag(target);
+	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+	link->ag = ag;
+
+	down_write(&nvmet_config_sem);
+	ret = -EEXIST;
+	list_for_each_entry(p, &port->ags, entry) {
+		if (p->ag == ag)
+			goto out_free_link;
+	}
+	if (list_empty(&port->ags)) {
+		ret = nvmet_enable_port(port);
+		if (ret)
+			goto out_free_link;
+	}
+	list_add_tail(&link->entry, &port->ags);
+	list_add_tail(&link->ag_list, &ag->port_link);
+	link->port = port;
+	nvmet_genctr++;
+	/* NVMe-oF requires us to set ana_tt != 0 for ANA support */
+	if (ag->subsys->ana_tt == 0)
+		ag->subsys->ana_tt = 1;
+	up_write(&nvmet_config_sem);
+	return 0;
+
+out_free_link:
+	up_write(&nvmet_config_sem);
+	kfree(link);
+	return ret;
+}
+
+static void nvmet_port_ags_drop_link(struct config_item *parent,
+		struct config_item *target)
+{
+	struct nvmet_port *port = to_nvmet_port(parent->ci_parent);
+	struct nvmet_ag *ag = to_nvmet_ag(target);
+	struct nvmet_subsys *subsys = ag->subsys;
+	struct nvmet_ag_link *p;
+	int ana_active = 0;
+
+	down_write(&nvmet_config_sem);
+	list_for_each_entry(p, &port->ags, entry) {
+		if (p->ag == ag)
+			goto found;
+	}
+	up_write(&nvmet_config_sem);
+	return;
+
+found:
+	list_del(&p->entry);
+	list_del(&p->ag_list);
+	nvmet_genctr++;
+	if (list_empty(&port->ags))
+		nvmet_disable_port(port);
+	list_for_each_entry(ag, &subsys->ana_groups, entry) {
+		if (!list_empty(&ag->port_link))
+			ana_active++;
+	}
+	if (!ana_active)
+		subsys->ana_tt = 0;
+	up_write(&nvmet_config_sem);
+	kfree(p);
+}
+
+static struct configfs_item_operations nvmet_port_ags_item_ops = {
+	.allow_link		= nvmet_port_ags_allow_link,
+	.drop_link		= nvmet_port_ags_drop_link,
+};
+
+static const struct config_item_type nvmet_port_ag_type = {
+	.ct_item_ops		= &nvmet_port_ags_item_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+static ssize_t nvmet_ag_state_show(struct config_item *item, char *page)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(item);
+
+	switch (ag->state) {
+	case NVME_ANA_STATE_OPTIMIZED:
+		return sprintf(page, "optimized\n");
+	case NVME_ANA_STATE_NONOPTIMIZED:
+		return sprintf(page, "nonoptimized\n");
+	case NVME_ANA_STATE_INACCESSIBLE:
+		return sprintf(page, "inaccessible\n");
+	case NVME_ANA_STATE_PERSISTENT_LOSS:
+		return sprintf(page, "persistent-loss\n");
+	case NVME_ANA_STATE_CHANGE_STATE:
+		return sprintf(page, "change-state\n");
+	default:
+		return sprintf(page, "<invalid>\n");
+	}
+}
+
+static ssize_t nvmet_ag_state_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(item);
+	u8 state;
+
+	if (sysfs_streq(page, "optimized")) {
+		state = NVME_ANA_STATE_OPTIMIZED;
+	} else if (sysfs_streq(page, "nonoptimized")) {
+		state = NVME_ANA_STATE_NONOPTIMIZED;
+	} else if (sysfs_streq(page, "inaccessible")) {
+		state = NVME_ANA_STATE_INACCESSIBLE;
+	} else if (sysfs_streq(page, "persistent-loss")) {
+		state = NVME_ANA_STATE_PERSISTENT_LOSS;
+	} else {
+		pr_err("Invalid state '%s' for state\n", page);
+		return -EINVAL;
+	}
+	down_write(&nvmet_config_sem);
+	ag->state = NVME_ANA_STATE_CHANGE_STATE;
+	ag->pending_state = state;
+	ag->subsys->change_count++;
+	ag->change_count++;
+	up_write(&nvmet_config_sem);
+	/*
+	 * Reduce the delay timeout by one second to guarantee that
+	 * the transition is finished by ana_tt.
+	 */
+	if (ag->subsys->ana_tt > 1)
+		schedule_delayed_work(&ag->state_change_work,
+				      (ag->subsys->ana_tt - 1) * HZ);
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ag_, state);
+
+static struct configfs_attribute *nvmet_ag_attrs[] = {
+	&nvmet_ag_attr_state,
+	NULL,
+};
+
+static void nvmet_ag_release(struct config_item *item)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(item);
+
+	down_write(&nvmet_config_sem);
+	list_del_init(&ag->entry);
+	up_write(&nvmet_config_sem);
+	nvmet_ag_free(ag);
+}
+
+static struct configfs_item_operations nvmet_ag_item_ops = {
+	.release		= nvmet_ag_release,
+};
+
+static const struct config_item_type nvmet_ag_type = {
+	.ct_item_ops		= &nvmet_ag_item_ops,
+	.ct_attrs		= nvmet_ag_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_ag_make(struct config_group *group,
+		const char *name)
+{
+	struct nvmet_subsys *subsys = ag_to_subsys(&group->cg_item);
+	struct nvmet_ag *ag, *a;
+	int ret;
+	u32 agid;
+
+	ret = kstrtou32(name, 0, &agid);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	if (agid == 0)
+		goto out;
+	ret = -ENOMEM;
+	ag = nvmet_ag_alloc(subsys, agid);
+	if (!ag)
+		goto out;
+	ret = -EEXIST;
+	down_write(&nvmet_config_sem);
+	list_for_each_entry_rcu(a, &subsys->ana_groups, entry) {
+		if (a->grpid == agid) {
+			nvmet_ag_free(ag);
+			goto out;
+		}
+	}
+	list_add_tail(&ag->entry, &subsys->ana_groups);
+	up_write(&nvmet_config_sem);
+	config_group_init_type_name(&ag->group, name, &nvmet_ag_type);
+
+	pr_info("adding ana groupid %d to subsystem %s\n",
+		agid, subsys->subsysnqn);
+	return &ag->group;
+out:
+	return ERR_PTR(ret);
+}
+
+static struct configfs_group_operations nvmet_ana_group_group_ops = {
+	.make_group		= nvmet_ag_make,
+};
+
+static const struct config_item_type nvmet_ana_group_group_type = {
+	.ct_group_ops		= &nvmet_ana_group_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
 static int nvmet_allowed_hosts_allow_link(struct config_item *parent,
 		struct config_item *target)
 {
@@ -761,11 +987,46 @@ static ssize_t nvmet_subsys_attr_oui_show(struct config_item *item,
 
 CONFIGFS_ATTR_RO(nvmet_subsys_, attr_oui);
 
+static ssize_t nvmet_subsys_attr_anatt_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	if (list_empty(&subsys->ana_groups))
+		return snprintf(page, PAGE_SIZE, "0\n");
+	return snprintf(page, PAGE_SIZE, "%d\n", subsys->ana_tt);
+}
+
+static ssize_t nvmet_subsys_attr_anatt_store(struct config_item *item,
+					     const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret;
+	u8 ana_tt;
+
+	down_write(&nvmet_config_sem);
+	if (list_empty(&subsys->ana_groups)) {
+		up_write(&nvmet_config_sem);
+		return -EAGAIN;
+	}
+	ret = kstrtou8(page, 0, &ana_tt);
+	if (ret || ana_tt == 0) {
+		up_write(&nvmet_config_sem);
+		return -EINVAL;
+	}
+	subsys->ana_tt = ana_tt;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_anatt);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
 	&nvmet_subsys_attr_attr_oui,
+	&nvmet_subsys_attr_attr_anatt,
 	NULL,
 };
 
@@ -810,6 +1071,10 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 			"namespaces", &nvmet_namespaces_type);
 	configfs_add_default_group(&subsys->namespaces_group, &subsys->group);
 
+	config_group_init_type_name(&subsys->ana_group,
+			"ana_groups", &nvmet_ana_group_group_type);
+	configfs_add_default_group(&subsys->ana_group, &subsys->group);
+
 	config_group_init_type_name(&subsys->allowed_hosts_group,
 			"allowed_hosts", &nvmet_allowed_hosts_type);
 	configfs_add_default_group(&subsys->allowed_hosts_group,
@@ -957,6 +1222,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
+	INIT_LIST_HEAD(&port->ags);
 
 	port->disc_addr.portid = cpu_to_le16(portid);
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
@@ -965,6 +1231,10 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 			"subsystems", &nvmet_port_subsys_type);
 	configfs_add_default_group(&port->subsys_group, &port->group);
 
+	config_group_init_type_name(&port->ana_group,
+			"ana_groups", &nvmet_port_ag_type);
+	configfs_add_default_group(&port->ana_group, &port->group);
+
 	config_group_init_type_name(&port->referrals_group,
 			"referrals", &nvmet_referrals_type);
 	configfs_add_default_group(&port->referrals_group, &port->group);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f172fd..4d17da2d76bb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -137,6 +137,22 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
+static void nvmet_ana_state_change_work(struct work_struct *work)
+{
+	struct nvmet_ag *ag = container_of(work, struct nvmet_ag,
+					   state_change_work.work);
+	struct nvmet_ctrl *ctrl;
+
+	ag->state = ag->pending_state;
+	down_read(&nvmet_config_sem);
+	list_for_each_entry(ctrl, &ag->subsys->ctrls, subsys_entry) {
+		if (ctrl->ag == ag)
+			nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+					      0x03, 0);
+	}
+	up_read(&nvmet_config_sem);
+}
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
@@ -233,6 +249,30 @@ static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
+void nvmet_ag_free(struct nvmet_ag *ag)
+{
+	kfree(ag);
+}
+
+struct nvmet_ag *nvmet_ag_alloc(struct nvmet_subsys *subsys, u32 agid)
+{
+	struct nvmet_ag *ag;
+
+	ag = kzalloc(sizeof(*ag), GFP_KERNEL);
+	if (!ag)
+		return NULL;
+
+	INIT_LIST_HEAD(&ag->entry);
+	INIT_LIST_HEAD(&ag->port_link);
+	INIT_DELAYED_WORK(&ag->state_change_work, nvmet_ana_state_change_work);
+
+	ag->grpid = agid;
+	ag->subsys = subsys;
+	ag->state = ag->pending_state = NVME_ANA_STATE_OPTIMIZED;
+
+	return ag;
+}
+
 static struct nvmet_ns *__nvmet_find_namespace(struct nvmet_ctrl *ctrl,
 		__le32 nsid)
 {
@@ -744,10 +784,18 @@ static bool nvmet_host_discovery_allowed(struct nvmet_req *req,
 		const char *hostnqn)
 {
 	struct nvmet_subsys_link *s;
+	struct nvmet_ag_link *a;
 
-	list_for_each_entry(s, &req->port->subsystems, entry) {
-		if (__nvmet_host_allowed(s->subsys, hostnqn))
-			return true;
+	if (!list_empty(&req->port->ags)) {
+		list_for_each_entry(a, &req->port->ags, entry) {
+			if (__nvmet_host_allowed(a->ag->subsys, hostnqn))
+				return true;
+		}
+	} else {
+		list_for_each_entry(s, &req->port->subsystems, entry) {
+			if (__nvmet_host_allowed(s->subsys, hostnqn))
+				return true;
+		}
 	}
 
 	return false;
@@ -769,6 +817,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 {
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_ag_link *l;
+	struct nvmet_ag *ag = NULL;
 	int ret;
 	u16 status;
 
@@ -783,6 +833,12 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	down_read(&nvmet_config_sem);
+	list_for_each_entry(l, &req->port->ags, entry) {
+		if (l->ag->subsys == subsys) {
+			ag = l->ag;
+			break;
+		}
+	}
 	if (!nvmet_host_allowed(req, subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
 			hostnqn, subsysnqn);
@@ -798,7 +854,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl)
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
-
+	ctrl->ag = ag;
 	nvmet_init_cap(ctrl);
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
@@ -891,6 +947,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_stop_keep_alive_timer(ctrl);
 
+	if (ctrl->ag)
+		cancel_delayed_work(&ctrl->ag->state_change_work);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
@@ -933,6 +991,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
 	struct nvmet_subsys_link *p;
+	struct nvmet_ag_link *a;
 
 	if (!port)
 		return NULL;
@@ -945,6 +1004,15 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	}
 
 	down_read(&nvmet_config_sem);
+	list_for_each_entry(a, &port->ags, entry) {
+		if (!strncmp(a->ag->subsys->subsysnqn, subsysnqn,
+			     NVMF_NQN_SIZE)) {
+			if (!kref_get_unless_zero(&a->ag->subsys->ref))
+				break;
+			up_read(&nvmet_config_sem);
+			return a->ag->subsys;
+		}
+	}
 	list_for_each_entry(p, &port->subsystems, entry) {
 		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
 				NVMF_NQN_SIZE)) {
@@ -997,6 +1065,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
+	INIT_LIST_HEAD(&subsys->ana_groups);
+	subsys->ana_tt = NVMET_DEFAULT_ANA_TT;
 
 	return subsys;
 }
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 231e04e0a496..7caa46691702 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -90,6 +90,7 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	size_t alloc_len = max(data_len, sizeof(*hdr));
 	int residual_len = data_len - sizeof(*hdr);
 	struct nvmet_subsys_link *p;
+	struct nvmet_ag_link *a;
 	struct nvmet_port *r;
 	u32 numrec = 0;
 	u16 status = 0;
@@ -106,6 +107,21 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	}
 
 	down_read(&nvmet_config_sem);
+	list_for_each_entry(a, &req->port->ags, entry) {
+		if (!nvmet_host_allowed(req, a->ag->subsys, ctrl->hostnqn))
+			continue;
+		if (residual_len >= entry_size) {
+			char traddr[NVMF_TRADDR_SIZE];
+
+			nvmet_set_disc_traddr(req, req->port, traddr);
+			nvmet_format_discovery_entry(hdr, req->port,
+					a->ag->subsys->subsysnqn, traddr,
+					NVME_NQN_NVME, numrec);
+			residual_len -= entry_size;
+		}
+		numrec++;
+	}
+
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(req, p->subsys, ctrl->hostnqn))
 			continue;
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd2344179673..c25d459bb787 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -204,6 +204,16 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
+	if (req->sq->ctrl->ag) {
+		struct nvmet_ag *ag = req->sq->ctrl->ag;
+
+		if (work_pending(&ag->state_change_work.work))
+			return NVME_SC_ANA_TRANSITION | NVME_SC_DNR;
+		if (ag->state == NVME_ANA_STATE_INACCESSIBLE)
+			return NVME_SC_ANA_INACCESSIBLE | NVME_SC_DNR;
+		if (ag->state == NVME_ANA_STATE_PERSISTENT_LOSS)
+			return NVME_SC_ANA_PERSISTENT_LOSS | NVME_SC_DNR;
+	}
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cd42ed37314..6d947cab9bf7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -29,6 +29,7 @@
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
+#define NVMET_DEFAULT_ANA_TT		2
 
 /* Helper Macros when NVMe error is NVME_SC_CONNECT_INVALID_PARAM
  * The 16 bit shift is to set IATTR bit to 1, which means offending
@@ -39,6 +40,23 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+struct nvmet_ag {
+	struct list_head	entry;
+	struct list_head	port_link;
+	struct config_group	group;
+	struct nvmet_subsys	*subsys;
+	struct delayed_work	state_change_work;
+	u64			change_count;
+	u32			grpid;
+	u8			state;
+	u8			pending_state;
+};
+
+static inline struct nvmet_ag *to_nvmet_ag(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_ag, group);
+}
+
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
@@ -97,6 +115,8 @@ struct nvmet_port {
 	struct list_head		subsystems;
 	struct config_group		referrals_group;
 	struct list_head		referrals;
+	struct config_group		ana_group;
+	struct list_head		ags;
 	void				*priv;
 	bool				enabled;
 };
@@ -111,6 +131,7 @@ struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
+	struct nvmet_ag		*ag;
 
 	struct mutex		lock;
 	u64			cap;
@@ -146,6 +167,11 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		max_nsid;
 
+	struct list_head	ana_groups;
+	u32			max_grpid;
+	u8			ana_tt;
+	u64			change_count;
+
 	struct list_head	ctrls;
 
 	struct list_head	hosts;
@@ -161,6 +187,7 @@ struct nvmet_subsys {
 	struct config_group	group;
 
 	struct config_group	namespaces_group;
+	struct config_group	ana_group;
 	struct config_group	allowed_hosts_group;
 };
 
@@ -176,6 +203,13 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 			namespaces_group);
 }
 
+static inline struct nvmet_subsys *ag_to_subsys(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_subsys,
+			ana_group);
+}
+
 struct nvmet_host {
 	struct config_group	group;
 };
@@ -200,6 +234,13 @@ struct nvmet_subsys_link {
 	struct nvmet_subsys	*subsys;
 };
 
+struct nvmet_ag_link {
+	struct list_head	entry;
+	struct list_head	ag_list;
+	struct nvmet_ag		*ag;
+	struct nvmet_port	*port;
+};
+
 struct nvmet_req;
 struct nvmet_fabrics_ops {
 	struct module *owner;
@@ -293,6 +334,9 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 
+void nvmet_ag_free(struct nvmet_ag *ag);
+struct nvmet_ag *nvmet_ag_alloc(struct nvmet_subsys *subsys, u32 agid);
+
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
-- 
2.12.3
