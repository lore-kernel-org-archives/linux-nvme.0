From: hare@suse.de (Hannes Reinecke)
Date: Mon, 18 Feb 2019 11:43:26 +0100
Subject: [PATCHv3] nvme-multipath: round-robin I/O policy
Message-ID: <20190218104326.46759-1-hare@suse.de>

Implement a simple round-robin I/O policy for multipathing.
Path selection is done in two rounds, first iterating across all
optimized paths, and, if that doesn't return any valid paths,
iterate over all optimized and non-optimized paths.
If no paths are found we're using the existing algorithm.
This patch also implements a sysfs attribute 'iopolicy' to switch
between the current, NUMA-aware I/O policy and the 'round-robin'
I/O policy.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      |  6 +++
 drivers/nvme/host/multipath.c | 86 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  9 +++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c365f0aa9433..f2f75831decd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2325,6 +2325,9 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&subsys_attr_iopolicy.attr,
+#endif
 	NULL,
 };
 
@@ -2377,6 +2380,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
+#ifdef CONFIG_NVME_MULTIPATH
+	subsys->iopolicy = NVME_IOPOLICY_NUMA;
+#endif
 
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b9fff3b8ed1b..1f7fe1bd2936 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,7 +141,10 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
-		distance = node_distance(node, ns->ctrl->numa_node);
+		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+			distance = node_distance(node, ns->ctrl->numa_node);
+		else
+			distance = LOCAL_DISTANCE;
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
@@ -168,6 +171,47 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 	return found;
 }
 
+static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
+		struct nvme_ns *ns)
+{
+	ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
+			siblings);
+	if (ns)
+		return ns;
+	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
+}
+
+static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
+		int node, struct nvme_ns *old)
+{
+	struct nvme_ns *ns, *found, *fallback = NULL;
+
+	if (list_is_singular(&head->list))
+		return old;
+
+	for (ns = nvme_next_ns(head, old);
+	     ns != old;
+	     ns = nvme_next_ns(head, ns)) {
+		if (ns->ctrl->state != NVME_CTRL_LIVE ||
+		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+			continue;
+
+		if (ns->ana_state == NVME_ANA_OPTIMIZED) {
+			found = ns;
+			goto out;
+		}
+		if (ns->ana_state == NVME_ANA_NONOPTIMIZED)
+			fallback = ns;
+	}
+
+	if (!fallback)
+		return NULL;
+	found = fallback;
+out:
+	rcu_assign_pointer(head->current_path[node], found);
+	return found;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return ns->ctrl->state == NVME_CTRL_LIVE &&
@@ -180,6 +224,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
+		ns = nvme_round_robin_path(head, node, ns);
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
 		ns = __nvme_find_path(head, node);
 	return ns;
@@ -471,6 +517,44 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 	cancel_work_sync(&ctrl->ana_work);
 }
 
+#define SUBSYS_ATTR_RW(_name, _mode, _show, _store)  \
+	struct device_attribute subsys_attr_##_name =	\
+		__ATTR(_name, _mode, _show, _store)
+
+static const char *nvme_iopolicy_names[] = {
+	[NVME_IOPOLICY_NUMA]	= "numa",
+	[NVME_IOPOLICY_RR]	= "round-robin",
+};
+
+static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return sprintf(buf, "%s\n",
+			nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
+}
+
+static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
+		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
+			WRITE_ONCE(subsys->iopolicy, i);
+			return count;
+		}
+	}
+
+	return -EINVAL;
+}
+SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
+		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
+
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a0cc733c753e..36d4b166a155 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,6 +251,11 @@ struct nvme_ctrl {
 	unsigned long discard_page_busy;
 };
 
+enum nvme_iopolicy {
+	NVME_IOPOLICY_NUMA,
+	NVME_IOPOLICY_RR,
+};
+
 struct nvme_subsystem {
 	int			instance;
 	struct device		dev;
@@ -270,6 +275,9 @@ struct nvme_subsystem {
 	u8			cmic;
 	u16			vendor_id;
 	struct ida		ns_ida;
+#ifdef CONFIG_NVME_MULTIPATH
+	enum nvme_iopolicy	iopolicy;
+#endif
 };
 
 /*
@@ -490,6 +498,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute subsys_attr_iopolicy;
 
 #else
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-- 
2.16.4
