From: hare@suse.de (Hannes Reinecke)
Date: Fri, 29 Mar 2019 13:04:04 +0100
Subject: [PATCH 2/2] nvmet: make CNTLID range configurable
In-Reply-To: <20190329120404.55637-1-hare@suse.de>
References: <20190329120404.55637-1-hare@suse.de>
Message-ID: <20190329120404.55637-3-hare@suse.de>

When trying to run in a clustered environment we need to keep the
controller ID values unique. So this patch add to additional config
attributes 'cntlid_min' and 'cntlid_max' to only allow specific ranges
for the controller ID.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/configfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  4 ++-
 drivers/nvme/target/nvmet.h    |  2 ++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 63b9991de79e..07f837abea62 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -885,11 +885,71 @@ static ssize_t nvmet_subsys_attr_mdts_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_mdts);
 
+static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
+						 char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%u\n", subsys->min_cntlid);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
+						  const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	unsigned int min;
+	int ret;
+
+	ret = kstrtou32(page, 0, &min);
+	if (ret)
+		return ret;
+	down_write(&nvmet_config_sem);
+	if (min >= subsys->max_cntlid || min < NVME_CNTLID_MIN)
+		ret = -EINVAL;
+	else
+		subsys->min_cntlid = min;
+	up_write(&nvmet_config_sem);
+
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_min);
+
+static ssize_t nvmet_subsys_attr_cntlid_max_show(struct config_item *item,
+						 char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%u\n", subsys->max_cntlid);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
+						  const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	unsigned int max;
+	int ret;
+
+	ret = kstrtou32(page, 0, &max);
+	if (ret)
+		return ret;
+	down_write(&nvmet_config_sem);
+	if (max >= NVME_CNTLID_MAX || max < subsys->min_cntlid)
+		ret = -EINVAL;
+	else
+		subsys->max_cntlid = max;
+	up_write(&nvmet_config_sem);
+
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
 	&nvmet_subsys_attr_attr_mdts,
+	&nvmet_subsys_attr_attr_cntlid_min,
+	&nvmet_subsys_attr_attr_cntlid_max,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2d73b66e3686..fe60734b421d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1241,7 +1241,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_free_cqs;
 
 	ret = ida_simple_get(&cntlid_ida,
-			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+			     subsys->min_cntlid, subsys->max_cntlid,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
@@ -1382,6 +1382,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return NULL;
 	}
+	subsys->min_cntlid = NVME_CNTLID_MIN;
+	subsys->max_cntlid = NVME_CNTLID_MAX;
 	subsys->type = type;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f05f069f83ea..7bc81bf7d45e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -212,6 +212,8 @@ struct nvmet_subsys {
 	unsigned int		max_nsid;
 
 	struct list_head	ctrls;
+	unsigned int		min_cntlid;
+	unsigned int		max_cntlid;
 
 	struct list_head	hosts;
 	bool			allow_any_host;
-- 
2.16.4
