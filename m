From: hare@suse.de (Hannes Reinecke)
Date: Thu, 15 Nov 2018 13:29:27 +0100
Subject: [PATCH 2/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181115122927.40431-1-hare@suse.de>
References: <20181115122927.40431-1-hare@suse.de>
Message-ID: <20181115122927.40431-3-hare@suse.de>

Add a simple round-robin I/O policy for multipathing.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1f97293380e2..fed3eea9da9a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -177,14 +177,52 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
+inline struct nvme_ns *__nvme_next_path(struct nvme_ns_head *head, int node,
+					struct nvme_ns *old)
+{
+	struct nvme_ns *ns, *found = NULL;
+
+	do {
+		ns = list_next_or_null_rcu(&head->list, &old->siblings,
+					   struct nvme_ns, siblings);
+		if (!ns) {
+			ns = list_first_or_null_rcu(&head->list, struct nvme_ns,
+						    siblings);
+			if (ns && ns == old)
+				/*
+				 * The list consists of just one entry.
+				 * Sorry for the noise :-)
+				 */
+				return old;
+			else if (!ns)
+				break;
+		}
+		if (nvme_path_is_optimized(ns)) {
+			found = ns;
+			break;
+		}
+	} while (ns != old);
+
+	if (found)
+		rcu_assign_pointer(head->current_path[node], found);
+
+	return found;
+}
+
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
+retry:
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
 		ns = __nvme_find_path(head, node);
+	else if (head->subsys->iopolicy == NVME_IOPOLICY_RR) {
+		ns = __nvme_next_path(head, node, ns);
+		if (!ns)
+			goto retry;
+	}
 	return ns;
 }
 
@@ -497,6 +535,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_UNKNOWN] = "unknown",
 	[NVME_IOPOLICY_NONE] = "none",
 	[NVME_IOPOLICY_NUMA] = "numa",
+	[NVME_IOPOLICY_RR] = "round-robin",
 };
 
 static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
@@ -512,15 +551,22 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned int iopolicy = NVME_IOPOLICY_UNKNOWN;
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
 
 	if (!strncmp(buf, "none", 4))
 		iopolicy = NVME_IOPOLICY_NONE;
 	else if (!strncmp(buf, "numa", 4))
 		iopolicy = NVME_IOPOLICY_NUMA;
+	else if (!strncmp(buf, "round-robin", 11))
+		iopolicy = NVME_IOPOLICY_RR;
 
 	if (iopolicy == NVME_IOPOLICY_UNKNOWN)
 		return -EINVAL;
 
+	mutex_lock(&subsys->lock);
+	subsys->iopolicy = iopolicy;
+	mutex_unlock(&subsys->lock);
 	return count;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c8642ebeb4a3..2fb124548c0c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -263,6 +263,7 @@ struct nvme_subsystem {
 #define NVME_IOPOLICY_UNKNOWN 0
 #define NVME_IOPOLICY_NONE 1
 #define NVME_IOPOLICY_NUMA 2
+#define NVME_IOPOLICY_RR 3
 	unsigned int		iopolicy;
 #endif
 };
-- 
2.16.4
