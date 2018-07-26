From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 17:35:03 +0200
Subject: [PATCH 7/9] nvmet: track and limit the number of namespaces per
 subsystem
In-Reply-To: <20180726153505.4153-1-hch@lst.de>
References: <20180726153505.4153-1-hch@lst.de>
Message-ID: <20180726153505.4153-8-hch@lst.de>

TP 4004 introduces a new 'Maximum Number of Allocated Namespaces' field
in the Identify controller data to help the host size resources.  Put
an upper limit on the supported namespaces to be able to support this
value as supporting 32-bits worth of namespaces would lead to very
large buffers.  The limit is completely arbitrary at this point.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 drivers/nvme/target/core.c      | 8 +++++++-
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 16a9b24270f9..55f2bf4b5d07 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -252,6 +252,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
+	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cbcd19f52121..42e8565015d5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -337,9 +337,13 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&subsys->lock);
+	ret = -EMFILE;
+	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
+		goto out_unlock;
+	ret = 0;
 	if (ns->enabled)
 		goto out_unlock;
 
@@ -374,6 +378,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
 	}
+	subsys->nr_namespaces++;
 
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
@@ -414,6 +419,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	percpu_ref_exit(&ns->ref);
 
 	mutex_lock(&subsys->lock);
+	subsys->nr_namespaces--;
 	nvmet_ns_changed(subsys, ns->nsid);
 	nvmet_ns_dev_disable(ns);
 out_unlock:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index de12dcbfd3f3..701017f7f3df 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -170,6 +170,7 @@ struct nvmet_subsys {
 	struct kref		ref;
 
 	struct list_head	namespaces;
+	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
 
 	struct list_head	ctrls;
@@ -362,6 +363,13 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
+
+/*
+ * Nice round number that makes a list of nsids fit into a page.
+ * Should become tunable at some point in the future.
+ */
+#define NVMET_MAX_NAMESPACES	1024
+
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
 
-- 
2.18.0
