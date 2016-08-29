From: luto@kernel.org (Andy Lutomirski)
Date: Mon, 29 Aug 2016 02:25:46 -0700
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <cover.1472462539.git.luto@kernel.org>
References: <cover.1472462539.git.luto@kernel.org>
Message-ID: <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>

NVME devices can advertise multiple power states.  These states can
be either "operational" (the device is fully functional but possibly
slow) or "non-operational" (the device is asleep until woken up).
Some devices can automatically enter a non-operational state when
idle for a specified amount of time and then automatically wake back
up when needed.

The hardware configuration is a table.  For each state, an entry in
the table indicates the next deeper non-operational state, if any,
to autonomously transition to and the idle time required before
transitioning.

This patch teaches the driver to program APST so that each
successive non-operational state will be entered after an idle time
equal to 100% of the total latency (entry plus exit) associated with
that state.  A sysfs attribute 'apst_max_latency_ns' gives the
maximum acceptable latency in ns; non-operational states with total
latency greater than this value will not be used.  As a special
case, apst_max_latency_ns=0 will disable APST entirely.

On hardware without APST support, apst_max_latency_ns will not be
exposed in sysfs.

In theory, the device can expose "default" APST table, but this
doesn't seem to function correctly on my device (Samsung 950), nor
does it seem particularly useful.  There is also an optional
mechanism by which a configuration can be "saved" so it will be
automatically loaded on reset.  This can be configured from
userspace, but it doesn't seem useful to support in the driver.

On my laptop, enabling APST seems to save nearly 1W.

The hardware tables can be decoded in userspace with nvme-cli.
'nvme id-ctrl /dev/nvmeN' will show the power state table and
'nvme get-feature -f 0x0c -H /dev/nvme0' will show the current APST
configuration.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   6 ++
 include/linux/nvme.h     |   6 ++
 3 files changed, 179 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3f7561ab54dc..042137ad2437 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1223,6 +1223,98 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+static void nvme_configure_apst(struct nvme_ctrl *ctrl)
+{
+	/*
+	 * APST (Autonomous Power State Transition) lets us program a
+	 * table of power state transitions that the controller will
+	 * perform automatically.  We configure it with a simple
+	 * heuristic: we are willing to spend at most 2% of the time
+	 * transitioning between power states.  Therefore, when running
+	 * in any given state, we will enter the next lower-power
+	 * non-operational state after waiting 100 * (enlat + exlat)
+	 * microseconds, as long as that state's total latency is under
+	 * the requested maximum latency.
+	 *
+	 * We will not autonomously enter any non-operational state for
+	 * which the total latency exceeds apst_max_latency_ns.  Users
+	 * can set apst_max_latency_ns to zero to turn off APST.
+	 */
+
+	unsigned apste;
+	struct nvme_feat_auto_pst *table;
+	int ret;
+
+	if (!ctrl->apsta)
+		return;	/* APST isn't supported. */
+
+	if (ctrl->npss > 31) {
+		dev_warn(ctrl->device, "NPSS is invalid; disabling APST\n");
+		return;
+	}
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return;
+
+	if (ctrl->apst_max_latency_ns == 0) {
+		/* Turn off APST. */
+		apste = 0;
+	} else {
+		__le64 target = cpu_to_le64(0);
+		int state;
+
+		/*
+		 * Walk through all states from lowest- to highest-power.
+		 * According to the spec, lower-numbered states use more
+		 * power.  NPSS, despite the name, is the index of the
+		 * lowest-power state, not the number of states.
+		 */
+		for (state = (int)ctrl->npss; state >= 0; state--) {
+			u64 total_latency_us, transition_ms;
+
+			if (target)
+				table->entries[state] = target;
+
+			/*
+			 * Is this state a useful non-operational state for
+			 * higher-power states to autonomously transition to?
+			 */
+			if (!(ctrl->psd[state].flags & 2))
+				continue;  /* It's an operational state. */
+
+			total_latency_us =
+				(u64)cpu_to_le32(ctrl->psd[state].entry_lat) +
+				+ cpu_to_le32(ctrl->psd[state].exit_lat);
+			if (total_latency_us * 1000 > ctrl->apst_max_latency_ns)
+				continue;
+
+			/*
+			 * This state is good.  Use it as the APST idle
+			 * target for higher power states.
+			 */
+			transition_ms = total_latency_us + 19;
+			do_div(transition_ms, 20);
+			if (transition_ms >= (1 << 24))
+				transition_ms = (1 << 24);
+
+			target = cpu_to_le64((state << 3) |
+					     (transition_ms << 8));
+		}
+
+		apste = 1;
+	}
+
+	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
+				table, sizeof(*table), NULL);
+	if (ret)
+		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
+
+	kfree(table);
+}
+
+static struct attribute_group nvme_dev_dynamic_attrs_group;
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -1289,6 +1381,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 
+	ctrl->npss = id->npss;
+	ctrl->apsta = id->apsta;
+	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
+
 	if (ctrl->ops->is_fabrics) {
 		ctrl->icdoff = le16_to_cpu(id->icdoff);
 		ctrl->ioccsz = le32_to_cpu(id->ioccsz);
@@ -1312,6 +1408,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	kfree(id);
+
+	nvme_configure_apst(ctrl);
+
+	sysfs_update_group(&ctrl->device->kobj, &nvme_dev_dynamic_attrs_group);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);
@@ -1582,6 +1682,41 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_sysfs_show_apst_max_latency_ns(
+	struct device *dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n", ctrl->apst_max_latency_ns);
+}
+
+static ssize_t nvme_sysfs_store_apst_max_latency_ns(
+	struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t size)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+	u64 val;
+
+	ret = kstrtoull(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (ctrl->apst_max_latency_ns != val) {
+		ctrl->apst_max_latency_ns = val;
+		nvme_configure_apst(ctrl);
+	}
+
+	return size;
+}
+
+static DEVICE_ATTR(apst_max_latency_ns, 0644,
+		   nvme_sysfs_show_apst_max_latency_ns,
+		   nvme_sysfs_store_apst_max_latency_ns);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -1623,8 +1758,33 @@ static struct attribute_group nvme_dev_attrs_group = {
 	.is_visible	= nvme_dev_attrs_are_visible,
 };
 
+static struct attribute *nvme_dev_dynamic_attrs[] = {
+	&dev_attr_apst_max_latency_ns.attr,
+	NULL
+};
+
+static umode_t nvme_dev_dynamic_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (a == &dev_attr_apst_max_latency_ns.attr) {
+		if (!ctrl->apsta)
+			return 0;
+	}
+
+	return a->mode;
+}
+
+static struct attribute_group nvme_dev_dynamic_attrs_group = {
+	.attrs		= nvme_dev_dynamic_attrs,
+	.is_visible	= nvme_dev_dynamic_attrs_are_visible,
+};
+
 static const struct attribute_group *nvme_dev_attr_groups[] = {
 	&nvme_dev_attrs_group,
+	&nvme_dev_dynamic_attrs_group,
 	NULL,
 };
 
@@ -2010,6 +2170,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 
+	/*
+	 * By default, allow up to 25ms of APST-induced latency.  This will
+	 * have no effect on non-APST supporting controllers (i.e. any
+	 * controller with APSTA == 0).
+	 */
+	ctrl->apst_max_latency_ns = 25000000;
+
 	ret = nvme_set_instance(ctrl);
 	if (ret)
 		goto out;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 383ae22e169e..88cabd643bda 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -129,13 +129,19 @@ struct nvme_ctrl {
 	u32 vs;
 	u32 sgls;
 	u16 kas;
+	u8 npss;
+	u8 apsta;
 	unsigned int kato;
 	bool subsystem;
 	unsigned long quirks;
+	struct nvme_id_power_state psd[32];
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 
+	/* APSTA configuration */
+	u64 apst_max_latency_ns;
+
 	/* Fabrics only */
 	u16 sqsize;
 	u32 ioccsz;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d8b37bab2887..a76237dac4b0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -543,6 +543,12 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
 
+/* Features */
+
+struct nvme_feat_auto_pst {
+	__le64 entries[32];
+};
+
 /* Admin commands */
 
 enum nvme_admin_opcode {
-- 
2.7.4
