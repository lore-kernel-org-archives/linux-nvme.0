From: hare@suse.de (Hannes Reinecke)
Date: Tue, 21 Aug 2018 15:43:28 +0200
Subject: [PATCH 3/4] nvme: implement 'discovery' sysfs entry and discovery
 uevents
In-Reply-To: <20180821134329.69577-1-hare@suse.de>
References: <20180821134329.69577-1-hare@suse.de>
Message-ID: <20180821134329.69577-4-hare@suse.de>

When establishing a connection to the discovery controller with the
'async-connect' option the cli has no means of actually getting the
discovery log page entries.
This patch implements a 'discovery' sysfs attribute for the controller
which holds the information of the discovery log page. Additionally
an uevent is generated for each discovery log page entry.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |   1 +
 2 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..358be6d217d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2325,6 +2325,133 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static int nvme_get_discovery_log(struct nvme_ctrl *ctrl)
+{
+	int ret, disc_log_len = 4096;
+
+retry:
+	if (!ctrl->discovery)
+		ctrl->discovery = kzalloc(disc_log_len, GFP_KERNEL);
+
+	if (!ctrl->discovery)
+		return 0;
+
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_DISC, 0,
+			   ctrl->discovery, disc_log_len, 0);
+	if (ret) {
+		kfree(ctrl->discovery);
+		ctrl->discovery = NULL;
+		return ret;
+	}
+	if (ctrl->discovery->numrec > 3 && disc_log_len == 4096) {
+		disc_log_len = (ctrl->discovery->numrec + 1) * 1024;
+		kfree(ctrl->discovery);
+		ctrl->discovery = NULL;
+		goto retry;
+	}
+	return ret;
+}
+
+static void nvme_discovery_uevent(struct nvme_ctrl *ctrl,
+				  struct nvmf_disc_rsp_page_entry *entry)
+
+{
+	char *envp[8], *envstr;
+	size_t envlen = 0;
+	const char *trtype, *adrfam;
+
+	envstr = kzalloc(4096, GFP_KERNEL);
+	if (!envstr)
+		return;
+
+	envp[0] = envstr;
+	envlen += snprintf(envstr, 4096, "NVME_EVENT=discovery");
+	envlen ++;
+	switch (entry->trtype) {
+	case NVMF_TRTYPE_RDMA:
+		trtype = "rdma";
+		break;
+	case NVMF_TRTYPE_FC:
+		trtype = "fc";
+		break;
+	case NVMF_TRTYPE_LOOP:
+		trtype = "loop";
+		break;
+	default:
+		trtype = "unknown";
+		break;
+	}
+	envp[1] = envstr + envlen;
+	envlen += snprintf(envstr + envlen, 4096 - envlen,
+			   "NVME_DISCOVERY_TRTYPE=%s", trtype);
+	envlen++;
+	switch (entry->adrfam) {
+	case NVMF_ADDR_FAMILY_IP4:
+		adrfam = "ipv4";
+		break;
+	case NVMF_ADDR_FAMILY_IP6:
+		adrfam = "ipv6";
+		break;
+	case NVMF_ADDR_FAMILY_IB:
+		adrfam = "ib";
+		break;
+	case NVMF_ADDR_FAMILY_FC:
+		adrfam = "fc";
+		break;
+	default:
+		adrfam = "unknown";
+		break;
+	}
+	envp[2] = envstr + envlen;
+	envlen += snprintf(envstr + envlen, 4096 - envlen,
+			   "NVME_DISCOVERY_ADRFAM=%s", adrfam);
+	envlen++;
+	envp[3] = envstr + envlen;
+	envlen += snprintf(envstr + envlen, 4096 - envlen,
+			   "NVME_DISCOVERY_TRADDR=%s", strim(entry->traddr));
+	envlen++;
+	envp[4] = envstr + envlen;
+	envlen += snprintf(envstr + envlen, 4096 - envlen,
+			   "NVME_DISCOVERY_TRSVCID=%s", strim(entry->trsvcid));
+	envlen++;
+	envp[5] = envstr + envlen;
+	envlen += snprintf(envstr + envlen, 4096 - envlen,
+			   "NVME_DISCOVERY_HOST_TRADDR=%s",
+			   ctrl->opts->host_traddr);
+	envlen++;
+	envp[6] = envstr + envlen;
+	envlen += snprintf(envstr + envlen, 4096 - envlen,
+			   "NVME_DISCOVERY_SUBNQN=%s", strim(entry->subnqn));
+	envlen++;
+	envp[7] = NULL;
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+	kfree(envstr);
+}
+
+static int nvme_configure_discovery(struct nvme_ctrl *ctrl)
+{
+	int ret = 0;
+
+	if (!ctrl->opts || !ctrl->opts->discovery_nqn)
+		return 0;
+
+	if (!ctrl->opts->async_connect)
+		return 0;
+
+	ret = nvme_get_discovery_log(ctrl);
+	if (!ret && ctrl->discovery) {
+		int i;
+		struct nvmf_disc_rsp_page_entry *entry =
+			ctrl->discovery->entries;
+
+		for (i = 0; i < ctrl->discovery->numrec; i++) {
+			nvme_discovery_uevent(ctrl, entry);
+			entry++;
+		}
+	}
+	return ret;
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -2491,6 +2618,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	ret = nvme_configure_discovery(ctrl);
+	if (ret < 0)
+		return ret;
+
 	ctrl->identified = true;
 
 	return 0;
@@ -2825,6 +2956,32 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_discovery_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_disc_rsp_page_entry *entry;
+	int i;
+	ssize_t len = 0;
+
+	if (!ctrl->discovery)
+		return -EINVAL;
+
+	entry = ctrl->discovery->entries;
+	for (i = 0; i < ctrl->discovery->numrec; i++) {
+		len += snprintf(buf, PAGE_SIZE,
+				"trtype %d adrfam %d traddr %s "
+				"trsvcid %s portid %d subnqn %s\n",
+				entry->trtype, entry->adrfam, entry->traddr,
+				entry->trsvcid, le16_to_cpu(entry->portid),
+				entry->subnqn);
+		entry++;
+	}
+	return len;
+}
+static DEVICE_ATTR(discovery, S_IRUGO, nvme_discovery_show, NULL);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -2836,6 +2993,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_transport.attr,
 	&dev_attr_subsysnqn.attr,
 	&dev_attr_address.attr,
+	&dev_attr_discovery.attr,
 	&dev_attr_state.attr,
 	NULL
 };
@@ -2850,7 +3008,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
 		return 0;
-
+	if (a == &dev_attr_discovery.attr && ctrl->opts &&
+	    !ctrl->opts->discovery_nqn)
+		return 0;
 	return a->mode;
 }
 
@@ -3496,6 +3656,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
+	kfree(ctrl->discovery);
 	nvme_mpath_uninit(ctrl);
 
 	if (subsys) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..8a4ed46b986b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -199,6 +199,7 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
+	struct nvmf_disc_rsp_page_hdr *discovery;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
-- 
2.16.4
