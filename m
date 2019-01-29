From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Jan 2019 09:21:40 +0100
Subject: [PATCHv2] nvme-multipath: round-robin I/O policy
In-Reply-To: <34088d585b47fdb764821b32d5c7bbb168ede900.camel@suse.de>
References: <20181221141330.96599-1-hare@suse.de>
 <833821226d78f0e947b14434c188d64d4838337a.camel@suse.de>
 <bb159cba-ce3a-32ca-d79c-3dece6a71fd0@suse.com>
 <34088d585b47fdb764821b32d5c7bbb168ede900.camel@suse.de>
Message-ID: <20190129082140.GA4465@lst.de>

This looks mostly good to me.  I think we can simplify the sysfs
attribute parsing a bit, though and clean up the path selector
and use the same patterns as in the normal NUMA one.  Untestested
incremental patch below:

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index bfd4f0aa9de1..ed02cc31eb88 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -171,51 +171,48 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 	return found;
 }
 
-static struct nvme_ns *__nvme_rr_next_path(struct nvme_ns_head *head, int node,
-					   struct nvme_ns *old)
+static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
+		struct nvme_ns *ns)
 {
-	struct nvme_ns *ns, *found = NULL;
-	bool try_nonoptimized = false;
+	ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
+			siblings);
+	if (ns)
+		return ns;
+	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
+}
 
-	if (!old)
-		return NULL;
-retry:
-	ns = old;
-	do {
-		ns = list_next_or_null_rcu(&head->list, &ns->siblings,
-					   struct nvme_ns, siblings);
-		if (!ns) {
-			ns = list_first_or_null_rcu(&head->list, struct nvme_ns,
-						    siblings);
-			if (!ns)
-				return NULL;
-
-			if (ns == old)
-				/*
-				 * The list consists of just one entry.
-				 * Sorry for the noise :-)
-				 */
-				return old;
-		}
-		if (ns->disk && ns->ctrl->state == NVME_CTRL_LIVE) {
-			if (ns->ana_state == NVME_ANA_OPTIMIZED) {
-				found = ns;
-				break;
-			}
-			if (try_nonoptimized &&
-			    ns->ana_state == NVME_ANA_NONOPTIMIZED) {
-				found = ns;
-				break;
-			}
-		}
-	} while (ns != old);
+static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
+		int node, struct nvme_ns *old)
+{
+	struct nvme_ns *ns, *found, *fallback = NULL;
 
-	if (found)
-		rcu_assign_pointer(head->current_path[node], found);
-	else if (!try_nonoptimized) {
-		try_nonoptimized = true;
-		goto retry;
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
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			found = ns;
+			goto out;
+		case NVME_ANA_NONOPTIMIZED:
+			fallback = ns;
+			break;
+		default:
+			break;
+		}
 	}
+
+	if (!fallback)
+		return NULL;
+	found = fallback;
+out:
+	rcu_assign_pointer(head->current_path[node], found);
 	return found;
 }
 
@@ -231,8 +228,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
-		ns = __nvme_rr_next_path(head, node, ns);
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
+		ns = nvme_round_robin_path(head, node, ns);
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
 		ns = __nvme_find_path(head, node);
 	return ns;
@@ -529,9 +526,8 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 		__ATTR(_name, _mode, _show, _store)
 
 static const char *nvme_iopolicy_names[] = {
-	[NVME_IOPOLICY_UNKNOWN] = "unknown",
-	[NVME_IOPOLICY_NUMA] = "numa",
-	[NVME_IOPOLICY_RR] = "round-robin",
+	[NVME_IOPOLICY_NUMA]	= "numa",
+	[NVME_IOPOLICY_RR]	= "round-robin",
 };
 
 static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
@@ -539,32 +535,26 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
-	int iopolicy = NVME_IOPOLICY_UNKNOWN;
 
-	if (iopolicy < ARRAY_SIZE(nvme_iopolicy_names))
-		iopolicy = READ_ONCE(subsys->iopolicy);
-	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
+	return sprintf(buf, "%s\n",
+			nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	enum nvme_iopolicy iopolicy = NVME_IOPOLICY_UNKNOWN;
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
+	int i;
 
-	if (!strncmp(buf, nvme_iopolicy_names[NVME_IOPOLICY_NUMA],
-		     strlen(nvme_iopolicy_names[NVME_IOPOLICY_NUMA])))
-		iopolicy = NVME_IOPOLICY_NUMA;
-	else if (!strncmp(buf, nvme_iopolicy_names[NVME_IOPOLICY_RR],
-		     strlen(nvme_iopolicy_names[NVME_IOPOLICY_RR])))
-		iopolicy = NVME_IOPOLICY_RR;
-
-	if (iopolicy == NVME_IOPOLICY_UNKNOWN)
-		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
+		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
+			WRITE_ONCE(subsys->iopolicy, i);
+			return count;
+		}
+	}
 
-	WRITE_ONCE(subsys->iopolicy, iopolicy);
-	return count;
+	return -EINVAL;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0fb1f9dc6800..36d4b166a155 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -251,13 +251,10 @@ struct nvme_ctrl {
 	unsigned long discard_page_busy;
 };
 
-#ifdef CONFIG_NVME_MULTIPATH
 enum nvme_iopolicy {
-	NVME_IOPOLICY_UNKNOWN,
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 };
-#endif
 
 struct nvme_subsystem {
 	int			instance;
