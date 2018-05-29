From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:28 +0200
Subject: [PATCH 07/10] nvmet: make ANATT configurable
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-8-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 28 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c2fba1c92cd8..f2eedb13482a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -312,7 +312,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->msdbd = ctrl->ops->msdbd;
 
 	id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
-	id->anatt = 10; /* random value */
+	id->anatt = ctrl->subsys->anatt;
 	id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
 	id->nanagrpid = cpu_to_le32(NVMET_MAX_ANAGRPS);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ddc3fa9fd92f..2c6de9961ef4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -738,10 +738,38 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
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
+	if (ret || ana_tt == 0) {
+		return -EINVAL;
+	}
+	down_write(&nvmet_config_sem);
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
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1301a7e8b354..f47916481d8b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1103,6 +1103,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		return NULL;
 	}
 	subsys->type = type;
+	subsys->anatt = NVMET_DEFAULT_ANATT;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
 	if (!subsys->subsysnqn) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7195e313b375..04dec38ffe74 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -166,6 +166,7 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
+	u8			anatt;
 
 	struct list_head	ctrls;
 
@@ -386,6 +387,7 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
  */
 #define NVMET_MAX_ANAGRPS	128
 #define NVMET_DEFAULT_ANA_GRPID	1
+#define NVMET_DEFAULT_ANATT	10
 
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
-- 
2.12.3
