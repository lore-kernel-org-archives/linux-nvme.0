From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:05 -0400
Subject: [PATCH 14/20] nvmet: add and restructure ns mgmt helpers
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-15-chaitanya.kulkarni@wdc.com>

We add new helper functions for the namespace management
and move the existing helper functions in admin-cmd.c.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 51 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 13 -----------
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 97fea3f1d3e4..e696f1e45e3a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -14,11 +14,62 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/rculist.h>
+#include <linux/namei.h>
+#include <linux/fs.h>
+#include <linux/statfs.h>
 
 #include <generated/utsrelease.h>
 #include <asm/unaligned.h>
 #include "nvmet.h"
 
+static u32 nvmet_get_next_nsid(struct nvmet_subsys *subsys)
+{
+	u32 nsid;
+
+	mutex_lock(&subsys->lock);
+	nsid = find_first_zero_bit(subsys->nsid_map,
+			sizeof(subsys->nsid_map) * 8);
+	set_bit(nsid, subsys->nsid_map);
+
+	mutex_unlock(&subsys->lock);
+
+	return nsid + 1;
+}
+
+static void nvmet_free_nsid(struct nvmet_subsys *subsys, int nsid)
+{
+	nsid -= 1;
+	mutex_lock(&subsys->lock);
+	clear_bit(nsid, subsys->nsid_map);
+	mutex_unlock(&subsys->lock);
+}
+
+int nvmet_vfs_stat(const char *filename, struct kstat *stat)
+{
+	int ret;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(KERNEL_DS);
+	ret = vfs_stat(filename, stat);
+	if (ret)
+		pr_err("vfs_stat failed %s: %d\n", filename, ret);
+	set_fs(old_fs);
+	return ret;
+}
+
+static int nvmet_vfs_statfs(const char *pathname, struct kstatfs *st)
+{
+	int ret;
+	struct path path;
+
+	kern_path(pathname, LOOKUP_DIRECTORY, &path);
+	ret = vfs_statfs(&path, st);
+	if (ret)
+		pr_err("vfs_statfs failed %d\n", ret);
+	path_put(&path);
+	return ret;
+}
+
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 {
 	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 34a2b8903ec0..0b0649dc705c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -289,19 +289,6 @@ static int nvmet_ns_enable_blk(struct nvmet_ns *ns)
 	return 0;
 }
 
-int nvmet_vfs_stat(const char *filename, struct kstat *stat)
-{
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret = vfs_stat(filename, stat);
-	if (ret)
-		pr_err("vfs_stat failed %s: %d\n", filename, ret);
-	set_fs(old_fs);
-	return ret;
-}
-
 static int nvmet_ns_enable_file(struct nvmet_ns *ns)
 {
 	int ret;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b185a2add99b..a365dc44a10e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -350,4 +350,5 @@ extern struct rw_semaphore nvmet_config_sem;
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
+int nvmet_vfs_stat(const char *filename, struct kstat *stat);
 #endif /* _NVMET_H */
-- 
2.14.1
