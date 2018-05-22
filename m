From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:10:04 +0200
Subject: [PATCHv2 11/11] nvmet: ANA support
In-Reply-To: <20180522091004.39620-1-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
Message-ID: <20180522091004.39620-12-hare@suse.de>

Add ANA support to the nvme target. The ANA configuration is optional, and
doesn't interfere with existing configurations.
ANA groups are created under each subsystem, the namespaces must to be linked
into this group to become part of the ANA group.
If ANA groups are created it is required to link the ANA groups into the
respective ports. Each ANA group can only be part of one port.
Linking the entire subsystem will be refused is ANA groups are specified.
Also this implementation has a limit of one single ANA state per group,
irrespective of the path. So when different ANA states are required one needs
 to create different ANA groups, one for each state.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 156 +++++++++++++++-
 drivers/nvme/target/configfs.c  | 381 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  94 +++++++++-
 drivers/nvme/target/discovery.c |  49 ++++--
 drivers/nvme/target/io-cmd.c    |  36 ++++
 drivers/nvme/target/nvmet.h     |  50 ++++++
 6 files changed, 747 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8becc7df47b7..e87906a9bf98 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -118,6 +118,79 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static u32 nvmet_format_ana_group(struct nvmet_req *req, struct nvmet_ag *ag,
+		struct nvme_ana_group_desc *desc)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_ns *ns;
+	u32 count = 0;
+
+	if (!(req->cmd->get_log_page.lsp & NVME_ANA_LOG_RGO)) {
+		struct nvmet_ns_link *n;
+
+		rcu_read_lock();
+		if (!ag->allow_any_ns && !list_empty(&ag->ns_link)) {
+			list_for_each_entry_rcu(n, &ag->ns_link, entry)
+				desc->nsids[count++] = cpu_to_le32(n->ns->nsid);
+		} else {
+			list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces,
+						dev_link)
+				desc->nsids[count++] = cpu_to_le32(ns->nsid);
+		}
+		rcu_read_unlock();
+	}
+
+	desc->grpid = cpu_to_le32(ag->grpid);
+	desc->nnsids = cpu_to_le32(count);
+	desc->chgcnt = cpu_to_le64(ag->change_count);
+	desc->state = ag->state;
+	memset(desc->rsvd17, 0, sizeof(desc->rsvd17));
+
+	return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
+}
+
+static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_ana_rsp_hdr hdr = { 0, };
+	struct nvme_ana_group_desc *desc;
+	struct nvmet_ag_link *a;
+	size_t offset = sizeof(struct nvme_ana_rsp_hdr); /* start beyond hdr */
+	size_t len;
+	u16 ngrps = 0;
+	u16 status;
+
+	status = NVME_SC_INTERNAL;
+	desc = kzalloc(sizeof(struct nvme_ana_group_desc) +
+			ctrl->subsys->nr_namespaces * sizeof(__le32),
+		       GFP_KERNEL);
+	if (!desc)
+		goto out;
+
+	down_read(&nvmet_config_sem);
+	list_for_each_entry(a, &req->port->ags, entry) {
+		if (a->ag->subsys != ctrl->subsys)
+			continue;
+		len = nvmet_format_ana_group(req, a->ag, desc);
+		status = nvmet_copy_to_sgl(req, offset, desc, len);
+		if (status)
+			break;
+		offset += len;
+		ngrps++;
+	}
+
+	hdr.chgcnt = cpu_to_le64(ctrl->subsys->ana_chgcnt);
+	hdr.ngrps = cpu_to_le16(ngrps);
+	up_read(&nvmet_config_sem);
+
+	kfree(desc);
+
+	/* copy the header last once we know the information */
+	status = nvmet_copy_to_sgl(req, 0, &hdr, sizeof(hdr));
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -149,9 +222,31 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	 * the safest is to leave it as zeroes.
 	 */
 
-	/* we support multiple ports and multiples hosts: */
+	/* we support multiple ports and multiple hosts */
 	id->cmic = (1 << 0) | (1 << 1);
 
+	/* ANA support */
+	if (!list_empty(&ctrl->subsys->ana_groups)) {
+		u32 grpmax = 0, grpnum = 0;
+		struct nvmet_ag *ag;
+
+		id->cmic |= (1 << 3);
+
+		/* All ANA states are supported */
+		id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | \
+			(1 << 3) | (1 << 4);
+		id->anatt = ctrl->subsys->anatt;
+		down_read(&nvmet_config_sem);
+		list_for_each_entry(ag, &ctrl->subsys->ana_groups, entry) {
+			if (grpmax < ag->grpid)
+				grpmax = ag->grpid;
+			grpnum++;
+		}
+		up_read(&nvmet_config_sem);
+		id->anagrpmax = cpu_to_le32(grpmax);
+		id->nanagrpid = cpu_to_le32(grpnum);
+	}
+
 	/* no limit on data transfer sizes for now */
 	id->mdts = 0;
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
@@ -188,6 +283,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
+	id->mnan = cpu_to_le32(ctrl->subsys->nr_namespaces);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
@@ -236,7 +332,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
+	struct nvmet_ag_link *a;
+	struct nvmet_ns_link *n;
+	struct nvmet_ag *ag = NULL;
 	u16 status = 0;
+	u8 ag_state = 0;
 
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
 	if (!ns) {
@@ -244,18 +344,44 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out;
 	}
 
+	list_for_each_entry(a, &req->port->ags, entry) {
+		if (a->ag->subsys != req->sq->ctrl->subsys)
+			continue;
+		list_for_each_entry(n, &a->ag->ns_link, entry) {
+			if (a->ag->allow_any_ns || n->ns == ns) {
+				ag = a->ag;
+				break;
+			}
+		}
+	}
+	if (!ag) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
 	}
 
+	if (ag) {
+		id->anagrpid = cpu_to_le32(ag->grpid);
+		ag_state = ag->state;
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
+	if ((ag_state == NVME_ANA_INACCESSIBLE) ||
+	    (ag_state == NVME_ANA_PERSISTENT_LOSS))
+		id->nuse = id->nsze = 0;
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -300,6 +426,27 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	}
 
 	rcu_read_lock();
+	if (!list_empty(&req->port->ags)) {
+		struct nvmet_ag_link *a;
+
+		list_for_each_entry_rcu(a, &req->port->ags, entry) {
+			struct nvmet_ns_link *n;
+
+			if (a->ag->subsys != ctrl->subsys)
+				continue;
+			if (a->ag->allow_any_ns)
+				goto list_subsys;
+			list_for_each_entry(n, &a->ag->ns_link, entry) {
+				if (n->ns->nsid <= min_nsid)
+					continue;
+				list[i++] = cpu_to_le32(n->ns->nsid);
+				if (i == buf_size / sizeof(__le32))
+					break;
+			}
+		}
+		goto skip_subsys;
+	}
+list_subsys:
 	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
 		if (ns->nsid <= min_nsid)
 			continue;
@@ -307,6 +454,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 		if (i == buf_size / sizeof(__le32))
 			break;
 	}
+skip_subsys:
 	rcu_read_unlock();
 
 	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
@@ -406,7 +554,8 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_ASYNC_EVENT:
 		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
-		req->sq->ctrl->aen_cfg = val32 & NVME_AEN_CFG_NS_ATTR;
+		req->sq->ctrl->aen_cfg = val32 &
+			(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE);
 		nvmet_set_result(req, req->sq->ctrl->aen_cfg);
 		break;
 	case NVME_FEAT_HOST_ID:
@@ -543,6 +692,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_LOG_SMART:
 			req->execute = nvmet_execute_get_log_page_smart;
 			return 0;
+		case NVME_LOG_ANA:
+			req->execute = nvmet_execute_get_log_page_ana;
+			return 0;
 		}
 		break;
 	case nvme_admin_identify:
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27234b5..5bb554e75e78 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -22,6 +22,7 @@
 
 static const struct config_item_type nvmet_host_type;
 static const struct config_item_type nvmet_subsys_type;
+static const struct config_item_type nvmet_ag_type;
 
 static const struct nvmet_transport_name {
 	u8		type;
@@ -478,6 +479,10 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
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
@@ -542,6 +547,338 @@ static const struct config_item_type nvmet_port_subsys_type = {
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
+	nvmet_genctr++;
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
+	struct nvmet_ag_link *p;
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
+	nvmet_genctr++;
+	if (list_empty(&port->ags))
+		nvmet_disable_port(port);
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
+static int nvmet_ag_ns_allow_link(struct config_item *parent,
+		struct config_item *target)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(parent->ci_parent);
+	struct nvmet_ns *ns;
+	struct nvmet_ns_link *link, *l;
+	int ret;
+
+	if (target->ci_type != &nvmet_ns_type) {
+		pr_err("can only link namespaces into the namespaces dir.!\n");
+		return -EINVAL;
+	}
+	if (ag->allow_any_ns) {
+		pr_err("can't add namespaces when allow_any_ns is set!\n");
+		return -EINVAL;
+	}
+	ns = to_nvmet_ns(target);
+	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+	link->ns = ns;
+
+	down_write(&nvmet_config_sem);
+	ret = -EEXIST;
+	list_for_each_entry(l, &ag->ns_link, entry) {
+		if (l->ns == ns)
+			goto out_free_link;
+	}
+	list_add_tail(&link->entry, &ag->ns_link);
+	nvmet_genctr++;
+	up_write(&nvmet_config_sem);
+	return 0;
+
+out_free_link:
+	up_write(&nvmet_config_sem);
+	kfree(link);
+	return ret;
+}
+
+static void nvmet_ag_ns_drop_link(struct config_item *parent,
+		struct config_item *target)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(parent->ci_parent);
+	struct nvmet_ns *ns = to_nvmet_ns(target);
+	struct nvmet_ns_link *l;
+
+	down_write(&nvmet_config_sem);
+	list_for_each_entry(l, &ag->ns_link, entry) {
+		if (l->ns == ns)
+			goto found;
+	}
+	up_write(&nvmet_config_sem);
+	return;
+
+found:
+	list_del(&l->entry);
+	nvmet_genctr++;
+	up_write(&nvmet_config_sem);
+	kfree(l);
+}
+
+static struct configfs_item_operations nvmet_ag_ns_item_ops = {
+	.allow_link		= nvmet_ag_ns_allow_link,
+	.drop_link		= nvmet_ag_ns_drop_link,
+};
+
+static const struct config_item_type nvmet_ag_ns_type = {
+	.ct_item_ops		= &nvmet_ag_ns_item_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+static ssize_t nvmet_ag_state_show(struct config_item *item, char *page)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(item);
+
+	switch (ag->state) {
+	case NVME_ANA_OPTIMIZED:
+		return sprintf(page, "optimized\n");
+	case NVME_ANA_NONOPTIMIZED:
+		return sprintf(page, "nonoptimized\n");
+	case NVME_ANA_INACCESSIBLE:
+		return sprintf(page, "inaccessible\n");
+	case NVME_ANA_PERSISTENT_LOSS:
+		return sprintf(page, "persistent-loss\n");
+	case NVME_ANA_CHANGE:
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
+		state = NVME_ANA_OPTIMIZED;
+	} else if (sysfs_streq(page, "nonoptimized")) {
+		state = NVME_ANA_NONOPTIMIZED;
+	} else if (sysfs_streq(page, "inaccessible")) {
+		state = NVME_ANA_INACCESSIBLE;
+	} else if (sysfs_streq(page, "persistent-loss")) {
+		state = NVME_ANA_PERSISTENT_LOSS;
+	} else {
+		pr_err("Invalid state '%s' for state\n", page);
+		return -EINVAL;
+	}
+	down_write(&nvmet_config_sem);
+	ag->state = NVME_ANA_CHANGE;
+	ag->pending_state = state;
+	ag->subsys->ana_chgcnt++;
+	ag->change_count++;
+	/* ANA TP mandates that tha ANA group change counter rolls over to 1 */
+	if (!ag->change_count)
+		ag->change_count++;
+	up_write(&nvmet_config_sem);
+	/*
+	 * Reduce the delay timeout by one second to guarantee that
+	 * the transition is finished by ana_tt.
+	 */
+	if (ag->subsys->anatt > 0)
+		schedule_delayed_work(&ag->state_change_work,
+				      (ag->subsys->anatt - 1) * HZ);
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ag_, state);
+
+static ssize_t nvmet_ag_allow_any_ns_show(struct config_item *item,
+		char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n",
+		to_nvmet_ag(item)->allow_any_ns);
+}
+
+static ssize_t nvmet_ag_allow_any_ns_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(item);
+	bool allow_any_ns;
+	int ret = 0;
+
+	if (strtobool(page, &allow_any_ns))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (allow_any_ns && !list_empty(&ag->ns_link)) {
+		pr_err("Can't set allow_any_ns when explicit namespaces are set!\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ag->allow_any_ns = allow_any_ns;
+out_unlock:
+	up_write(&nvmet_config_sem);
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ag_, allow_any_ns);
+
+static struct configfs_attribute *nvmet_ag_attrs[] = {
+	&nvmet_ag_attr_state,
+	&nvmet_ag_attr_allow_any_ns,
+	NULL,
+};
+
+static void nvmet_ag_release(struct config_item *item)
+{
+	struct nvmet_ag *ag = to_nvmet_ag(item);
+	struct nvmet_subsys *subsys = ag->subsys;
+
+	down_write(&nvmet_config_sem);
+	list_del_init(&ag->entry);
+	if (list_empty(&subsys->ana_groups))
+		subsys->anatt = 0;
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
+	if (list_empty(&subsys->ana_groups)) {
+		list_add_tail_rcu(&ag->entry, &subsys->ana_groups);
+		/* NVMe-oF requires us to set anatt != 0 for ANA support */
+		subsys->anatt = NVMET_DEFAULT_ANA_TT;
+	} else {
+		/* Keep an ordered list of ANA groups */
+		list_for_each_entry_rcu(a, &subsys->ana_groups, entry) {
+			if (a->grpid == agid) {
+				up_write(&nvmet_config_sem);
+				nvmet_ag_free(ag);
+				goto out;
+			}
+			if (agid < a->grpid)
+				break;
+		}
+		list_add_tail_rcu(&ag->entry, &subsys->ana_groups);
+	}
+	subsys->ana_chgcnt++;
+	up_write(&nvmet_config_sem);
+	config_group_init_type_name(&ag->group, name, &nvmet_ag_type);
+
+	config_group_init_type_name(&ag->ns_group,
+				    "namespaces", &nvmet_ag_ns_type);
+	configfs_add_default_group(&ag->ns_group, &ag->group);
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
@@ -704,10 +1041,45 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_anatt_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	if (list_empty(&subsys->ana_groups))
+		return snprintf(page, PAGE_SIZE, "0\n");
+	return snprintf(page, PAGE_SIZE, "%d\n", subsys->anatt);
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
+	subsys->anatt = ana_tt;
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
+	&nvmet_subsys_attr_attr_anatt,
 	NULL,
 };
 
@@ -752,6 +1124,10 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 			"namespaces", &nvmet_namespaces_type);
 	configfs_add_default_group(&subsys->namespaces_group, &subsys->group);
 
+	config_group_init_type_name(&subsys->ana_group,
+			"ana_groups", &nvmet_ana_group_group_type);
+	configfs_add_default_group(&subsys->ana_group, &subsys->group);
+
 	config_group_init_type_name(&subsys->allowed_hosts_group,
 			"allowed_hosts", &nvmet_allowed_hosts_type);
 	configfs_add_default_group(&subsys->allowed_hosts_group,
@@ -899,6 +1275,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
+	INIT_LIST_HEAD(&port->ags);
 
 	port->disc_addr.portid = cpu_to_le16(portid);
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
@@ -907,6 +1284,10 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
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
index 3b9e9eccc950..05a09bb5dbb5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -144,6 +144,33 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
+static void nvmet_ana_state_change_work(struct work_struct *work)
+{
+	struct nvmet_ag *ag = container_of(work, struct nvmet_ag,
+					   state_change_work.work);
+	struct nvmet_ctrl *ctrl;
+	struct nvmet_ag_link *a;
+
+	if (list_empty(&ag->entry))
+		return;
+	ag->state = ag->pending_state;
+	mutex_lock(&ag->subsys->lock);
+	list_for_each_entry(ctrl, &ag->subsys->ctrls, subsys_entry) {
+		if (list_empty(&ctrl->port->ags))
+			continue;
+
+		list_for_each_entry(a, &ctrl->port->ags, entry) {
+			if (a->ag == ag &&
+			    ctrl->aen_cfg & NVME_AEN_CFG_ANA_CHANGE)
+				nvmet_add_async_event(ctrl,
+						      NVME_AER_TYPE_NOTICE,
+						      NVME_AER_NOTICE_ANA,
+						      NVME_LOG_ANA);
+		}
+	}
+	mutex_unlock(&ag->subsys->lock);
+}
+
 static void nvmet_send_ns_changed_event(struct nvmet_subsys *subsys)
 {
 	/*
@@ -254,6 +281,32 @@ static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
+void nvmet_ag_free(struct nvmet_ag *ag)
+{
+	cancel_delayed_work_sync(&ag->state_change_work);
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
+	INIT_LIST_HEAD(&ag->ns_link);
+	INIT_DELAYED_WORK(&ag->state_change_work, nvmet_ana_state_change_work);
+
+	ag->grpid = agid;
+	ag->subsys = subsys;
+	ag->state = ag->pending_state = NVME_ANA_OPTIMIZED;
+	ag->change_count = 1;
+
+	return ag;
+}
+
 static struct nvmet_ns *__nvmet_find_namespace(struct nvmet_ctrl *ctrl,
 		__le32 nsid)
 {
@@ -339,8 +392,9 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
 	}
-
+	subsys->nr_namespaces++;
 	nvmet_send_ns_changed_event(subsys);
+
 	ns->enabled = true;
 	ret = 0;
 out_unlock:
@@ -380,7 +434,9 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	percpu_ref_exit(&ns->ref);
 
 	mutex_lock(&subsys->lock);
+	subsys->nr_namespaces--;
 	nvmet_send_ns_changed_event(subsys);
+
 	if (ns->bdev)
 		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
 out_unlock:
@@ -759,10 +815,20 @@ static bool nvmet_host_discovery_allowed(struct nvmet_req *req,
 		const char *hostnqn)
 {
 	struct nvmet_subsys_link *s;
+	struct nvmet_ag_link *a;
 
-	list_for_each_entry(s, &req->port->subsystems, entry) {
-		if (__nvmet_host_allowed(s->subsys, hostnqn))
-			return true;
+	if (!list_empty(&req->port->ags)) {
+		list_for_each_entry(a, &req->port->ags, entry) {
+			if (__nvmet_host_allowed(a->ag->subsys, hostnqn)) {
+				rcu_read_unlock();
+				return true;
+			}
+		}
+	} else {
+		list_for_each_entry(s, &req->port->subsystems, entry) {
+			if (__nvmet_host_allowed(s->subsys, hostnqn))
+				return true;
+		}
 	}
 
 	return false;
@@ -813,7 +879,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl)
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
-
 	nvmet_init_cap(ctrl);
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
@@ -824,7 +889,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
-	ctrl->aen_cfg = NVME_AEN_CFG_NS_ATTR;
+	ctrl->port = req->port;
+	ctrl->aen_cfg = NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE;
 
 	ctrl->cqs = kcalloc(subsys->max_qid + 1,
 			sizeof(struct nvmet_cq *),
@@ -949,6 +1015,8 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
 	struct nvmet_subsys_link *p;
+	struct nvmet_ag_link *a;
+	struct nvmet_subsys *subsys;
 
 	if (!port)
 		return NULL;
@@ -961,13 +1029,24 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	}
 
 	down_read(&nvmet_config_sem);
+	list_for_each_entry(a, &port->ags, entry) {
+		if (!strncmp(a->ag->subsys->subsysnqn, subsysnqn,
+			     NVMF_NQN_SIZE)) {
+			if (!kref_get_unless_zero(&a->ag->subsys->ref))
+				break;
+			subsys = a->ag->subsys;
+			up_read(&nvmet_config_sem);
+			return subsys;
+		}
+	}
 	list_for_each_entry(p, &port->subsystems, entry) {
 		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
 				NVMF_NQN_SIZE)) {
 			if (!kref_get_unless_zero(&p->subsys->ref))
 				break;
+			subsys = p->subsys;
 			up_read(&nvmet_config_sem);
-			return p->subsys;
+			return subsys;
 		}
 	}
 	up_read(&nvmet_config_sem);
@@ -1013,6 +1092,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
+	INIT_LIST_HEAD(&subsys->ana_groups);
 
 	return subsys;
 }
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 231e04e0a496..f7a7bab1f9de 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -90,6 +90,7 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	size_t alloc_len = max(data_len, sizeof(*hdr));
 	int residual_len = data_len - sizeof(*hdr);
 	struct nvmet_subsys_link *p;
+	struct nvmet_ag_link *a, *b;
 	struct nvmet_port *r;
 	u32 numrec = 0;
 	u16 status = 0;
@@ -106,19 +107,47 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
 	}
 
 	down_read(&nvmet_config_sem);
-	list_for_each_entry(p, &req->port->subsystems, entry) {
-		if (!nvmet_host_allowed(req, p->subsys, ctrl->hostnqn))
-			continue;
-		if (residual_len >= entry_size) {
-			char traddr[NVMF_TRADDR_SIZE];
-
-			nvmet_set_disc_traddr(req, req->port, traddr);
-			nvmet_format_discovery_entry(hdr, req->port,
+	if (!list_empty(&req->port->ags)) {
+		list_for_each_entry(a, &req->port->ags, entry) {
+			bool dup = false;
+			if (!nvmet_host_allowed(req, a->ag->subsys,
+						ctrl->hostnqn))
+				continue;
+			/* Filter out duplicate entries */
+			list_for_each_entry(b, &req->port->ags, entry) {
+				if (a == b)
+					break;
+				if (a->ag->subsys == b->ag->subsys)
+					dup = true;
+			}
+			if (dup)
+				continue;
+			if (residual_len >= entry_size) {
+				char traddr[NVMF_TRADDR_SIZE];
+
+				nvmet_set_disc_traddr(req, req->port, traddr);
+				nvmet_format_discovery_entry(hdr, req->port,
+					a->ag->subsys->subsysnqn, traddr,
+					NVME_NQN_NVME, numrec);
+				residual_len -= entry_size;
+			}
+			numrec++;
+		}
+	} else {
+		list_for_each_entry(p, &req->port->subsystems, entry) {
+			if (!nvmet_host_allowed(req, p->subsys, ctrl->hostnqn))
+				continue;
+			if (residual_len >= entry_size) {
+				char traddr[NVMF_TRADDR_SIZE];
+
+				nvmet_set_disc_traddr(req, req->port, traddr);
+				nvmet_format_discovery_entry(hdr, req->port,
 					p->subsys->subsysnqn, traddr,
 					NVME_NQN_NVME, numrec);
-			residual_len -= entry_size;
+				residual_len -= entry_size;
+			}
+			numrec++;
 		}
-		numrec++;
 	}
 
 	list_for_each_entry(r, &req->port->referrals, entry) {
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd2344179673..7fecf8d3baac 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -189,6 +189,38 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static u16 nvmet_check_ana_state(struct nvmet_req *req)
+{
+	struct nvmet_ag_link *a;
+	struct nvmet_ns_link *n;
+	struct nvmet_ag *ag = NULL;
+	enum nvme_ana_state state = 0;
+
+	if (list_empty(&req->port->ags))
+		return 0;
+
+	list_for_each_entry(a, &req->port->ags, entry) {
+		list_for_each_entry(n, &a->ag->ns_link, entry) {
+			if (n->ns == req->ns) {
+				ag = a->ag;
+				break;
+			}
+		}
+	}
+	if (ag) {
+		if (work_pending(&ag->state_change_work.work))
+			return NVME_SC_ANA_TRANSITION;
+		state = ag->state;
+	}
+	if (unlikely(state == NVME_ANA_INACCESSIBLE))
+		return NVME_SC_ANA_INACCESSIBLE;
+	if (unlikely(state == NVME_ANA_PERSISTENT_LOSS))
+		return NVME_SC_ANA_PERSISTENT_LOSS;
+	if (unlikely(state == NVME_ANA_CHANGE))
+		return NVME_SC_ANA_TRANSITION;
+	return 0;
+}
+
 u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -204,6 +236,10 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
+	ret = nvmet_check_ana_state(req);
+	if (unlikely(ret))
+		return ret;
+
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f5f7c1398173..a2fbe93bb735 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -29,6 +29,7 @@
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
+#define NVMET_DEFAULT_ANA_TT		2
 
 /* Helper Macros when NVMe error is NVME_SC_CONNECT_INVALID_PARAM
  * The 16 bit shift is to set IATTR bit to 1, which means offending
@@ -39,6 +40,25 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+struct nvmet_ag {
+	struct list_head	entry;
+	struct list_head	ns_link;
+	struct config_group	group;
+	struct config_group	ns_group;
+	struct nvmet_subsys	*subsys;
+	struct delayed_work	state_change_work;
+	u64			change_count;
+	u32			grpid;
+	u8			state;
+	u8			pending_state;
+	bool			allow_any_ns;
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
@@ -96,6 +116,8 @@ struct nvmet_port {
 	struct list_head		subsystems;
 	struct config_group		referrals_group;
 	struct list_head		referrals;
+	struct config_group		ana_group;
+	struct list_head		ags;
 	void				*priv;
 	bool				enabled;
 };
@@ -108,6 +130,7 @@ static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
 
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
+	struct nvmet_port	*port;
 	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
 
@@ -144,8 +167,14 @@ struct nvmet_subsys {
 	struct kref		ref;
 
 	struct list_head	namespaces;
+	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
 
+	struct list_head	ana_groups;
+	u32			max_grpid;
+	u8			anatt;
+	u64			ana_chgcnt;
+
 	struct list_head	ctrls;
 
 	struct list_head	hosts;
@@ -160,6 +189,7 @@ struct nvmet_subsys {
 	struct config_group	group;
 
 	struct config_group	namespaces_group;
+	struct config_group	ana_group;
 	struct config_group	allowed_hosts_group;
 };
 
@@ -175,6 +205,13 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
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
@@ -199,6 +236,16 @@ struct nvmet_subsys_link {
 	struct nvmet_subsys	*subsys;
 };
 
+struct nvmet_ag_link {
+	struct list_head	entry;
+	struct nvmet_ag		*ag;
+};
+
+struct nvmet_ns_link {
+	struct list_head	entry;
+	struct nvmet_ns		*ns;
+};
+
 struct nvmet_req;
 struct nvmet_fabrics_ops {
 	struct module *owner;
@@ -292,6 +339,9 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
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
