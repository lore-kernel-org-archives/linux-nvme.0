From: hch@lst.de (Christoph Hellwig)
Date: Fri,  1 Jun 2018 09:11:28 +0200
Subject: [PATCH 9/9] nvmet: make ANATT configurable
In-Reply-To: <20180601071128.7630-1-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
Message-ID: <20180601071128.7630-10-hch@lst.de>

From: Hannes Reinecke <hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 128b7e773a8b..04c3dd513bcf 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -315,7 +315,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->msdbd = ctrl->ops->msdbd;
 
 	id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
-	id->anatt = 10; /* random value */
+	id->anatt = ctrl->subsys->anatt;
 	id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
 	id->nanagrpid = cpu_to_le32(NVMET_MAX_ANAGRPS);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ddc3fa9fd92f..706b42b7935e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -738,10 +738,39 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_anatt_show(struct config_item *item,
+					    char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
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
+	ret = kstrtou8(page, 0, &ana_tt);
+	if (ret)
+		return ret;
+	if (ana_tt == 0)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	subsys->anatt = ana_tt;
+	up_write(&nvmet_config_sem);
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
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b38c129642f3..cebc57876889 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1115,6 +1115,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		return NULL;
 	}
 	subsys->type = type;
+	subsys->anatt = NVMET_DEFAULT_ANATT;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
 	if (!subsys->subsysnqn) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 74ba9c3e90e5..ba4aca31aa60 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -178,6 +178,7 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
+	u8			anatt;
 
 	struct list_head	ctrls;
 
@@ -398,6 +399,7 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
  */
 #define NVMET_MAX_ANAGRPS	128
 #define NVMET_DEFAULT_ANA_GRPID	1
+#define NVMET_DEFAULT_ANATT	10
 
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
-- 
2.17.0
