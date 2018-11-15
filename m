From: hare@suse.de (Hannes Reinecke)
Date: Thu, 15 Nov 2018 13:29:26 +0100
Subject: [PATCH 1/2] nvme-multipath: add 'iopolicy' subsystem attribute
In-Reply-To: <20181115122927.40431-1-hare@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
Message-ID: <20181115122927.40431-2-hare@suse.de>

Add a sysfs attribute 'iopolicy' to the subsystem to allow for
distinct I/O policies.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      |  6 ++++++
 drivers/nvme/host/multipath.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  7 +++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e1c6ddf0368..f4f5b4991f1e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2176,6 +2176,9 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&subsys_attr_iopolicy.attr,
+#endif
 	NULL,
 };
 
@@ -2228,6 +2231,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
+#ifdef CONFIG_NVME_MULTIPATH
+	subsys->iopolicy = NVME_IOPOLICY_NUMA;
+#endif
 
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8e03cda770c5..1f97293380e2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,7 +141,10 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
-		distance = node_distance(node, ns->ctrl->numa_node);
+		if (head->subsys->iopolicy == NVME_IOPOLICY_NUMA)
+			distance = node_distance(node, ns->ctrl->numa_node);
+		else
+			distance = LOCAL_DISTANCE;
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
@@ -486,6 +489,43 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 	cancel_work_sync(&ctrl->ana_work);
 }
 
+#define SUBSYS_ATTR_RW(_name, _mode, _show, _store)  \
+	struct device_attribute subsys_attr_##_name =	\
+		__ATTR(_name, _mode, _show, _store)
+
+static const char *nvme_iopolicy_names[] = {
+	[NVME_IOPOLICY_UNKNOWN] = "unknown",
+	[NVME_IOPOLICY_NONE] = "none",
+	[NVME_IOPOLICY_NUMA] = "numa",
+};
+
+static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return sprintf(buf, "%s\n", nvme_iopolicy_names[subsys->iopolicy]);
+}
+
+static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned int iopolicy = NVME_IOPOLICY_UNKNOWN;
+
+	if (!strncmp(buf, "none", 4))
+		iopolicy = NVME_IOPOLICY_NONE;
+	else if (!strncmp(buf, "numa", 4))
+		iopolicy = NVME_IOPOLICY_NUMA;
+
+	if (iopolicy == NVME_IOPOLICY_UNKNOWN)
+		return -EINVAL;
+
+	return count;
+}
+SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
+		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
+
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9e1a51fed0c1..c8642ebeb4a3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -259,6 +259,12 @@ struct nvme_subsystem {
 	u8			cmic;
 	u16			vendor_id;
 	struct ida		ns_ida;
+#ifdef CONFIG_NVME_MULTIPATH
+#define NVME_IOPOLICY_UNKNOWN 0
+#define NVME_IOPOLICY_NONE 1
+#define NVME_IOPOLICY_NUMA 2
+	unsigned int		iopolicy;
+#endif
 };
 
 /*
@@ -489,6 +495,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute subsys_attr_iopolicy;
 
 #else
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-- 
2.16.4
