From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Oct 2018 15:24:37 -0700
Subject: [PATCH RFC] nvmet: emulate noiob boundary
Message-ID: <20181019222437.25289-1-sagi@grimberg.me>

Useful to exercise the host driver to noiob support without having device
that actually require it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c |  2 ++
 drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3554cb4c6387..7e187815e0ea 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -427,6 +427,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
+	id->noiob = cpu_to_le16(ns->noiob);
+
 	if (ns->readonly)
 		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 46d0a0bc630b..5225715269cb 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -555,6 +555,34 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_chunk_sectors_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%u\n", to_nvmet_ns(item)->noiob);
+}
+
+static ssize_t nvmet_ns_chunk_sectors_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	u16 noiob;
+
+	if (kstrtou16(page, 0, &noiob))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting chunk_sectors\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->noiob = noiob;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, chunk_sectors);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -562,6 +590,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
+	&nvmet_ns_attr_chunk_sectors,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 10c96d43868d..cb8b93c83c5b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -67,6 +67,7 @@ struct nvmet_ns {
 	u8			nguid[16];
 	uuid_t			uuid;
 	u32			anagrpid;
+	u16			noiob;
 
 	bool			buffered_io;
 	bool			enabled;
-- 
2.17.1
