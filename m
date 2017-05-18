From: zouming.zouming@huawei.com (Zou Ming)
Date: Thu, 18 May 2017 04:18:13 +0000
Subject: [PATCH] nvme-cli:add a parameter for NVME_IOCTL_ID to get NS ID
Message-ID: <1495081093-14084-1-git-send-email-zouming.zouming@huawei.com>

According to nvme spec, the possible range of Namespaces ID is form 1 to
FFFFFFFe.
For distinguish return value ,Add a parameter for  NVME_IOCTL_ID to get
Namespaces ID.
---
 huawei-nvme.c |  7 +++++--
 nvme-ioctl.c  |  6 +++---
 nvme-ioctl.h  |  2 +-
 nvme.c        | 43 +++++++++++++++++++++++++------------------
 nvme.h        |  2 +-
 5 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/huawei-nvme.c b/huawei-nvme.c
index f941533..add67eb 100644
--- a/huawei-nvme.c
+++ b/huawei-nvme.c
@@ -49,7 +49,7 @@
 struct huawei_list_item {
 	char                node[1024];
 	struct nvme_id_ctrl ctrl;
-	int                 nsid;
+	__u32               nsid;
 	struct nvme_id_ns   ns;
 	unsigned            block;
 	char                ns_name[NS_NAME_LEN];
@@ -111,7 +111,10 @@ static int huawei_get_nvme_info(int fd, struct huawei_list_item *item, const cha
 	else
 		item->huawei_device = true;
 
-	item->nsid = nvme_get_nsid(fd);
+	nvme_get_nsid(fd, &item->nsid);
+	if (err)
+		return err;
+
 	err = nvme_identify_ns(fd, item->nsid,
 							0, &item->ns);
 	if (err)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index a22399a..2fb1d37 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -58,7 +58,7 @@ int nvme_reset_controller(int fd)
 	return ioctl(fd, NVME_IOCTL_RESET);
 }
 
-int nvme_get_nsid(int fd)
+int nvme_get_nsid(int fd, __u32 *ns_id)
 {
 	static struct stat nvme_stat;
 	int err = fstat(fd, &nvme_stat);
@@ -69,9 +69,9 @@ int nvme_get_nsid(int fd)
 	if (!S_ISBLK(nvme_stat.st_mode)) {
 		fprintf(stderr,
 			"Error: requesting namespace-id from non-block device\n");
-		return ENOTBLK;
+		return -ENOTBLK;
 	}
-	return ioctl(fd, NVME_IOCTL_ID);
+	return ioctl(fd, NVME_IOCTL_ID, ns_id);
 }
 
 int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd)
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 3beddf8..1cf24e8 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -6,7 +6,7 @@
 #include "linux/nvme_ioctl.h"
 #include "nvme.h"
 
-int nvme_get_nsid(int fd);
+int nvme_get_nsid(int fd, __u32 *ns_id);
 
 /* Generic passthrough */
 int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd);
diff --git a/nvme.c b/nvme.c
index 98f96be..fbb6e01 100644
--- a/nvme.c
+++ b/nvme.c
@@ -770,7 +770,11 @@ static int get_nvme_info(int fd, struct list_item *item, const char *node)
 	err = nvme_identify_ctrl(fd, &item->ctrl);
 	if (err)
 		return err;
-	item->nsid = nvme_get_nsid(fd);
+
+	err = nvme_get_nsid(fd, &item->nsid);
+	if (err)
+		return err;
+
 	err = nvme_identify_ns(fd, item->nsid,
 			       0, &item->ns);
 	if (err)
@@ -864,17 +868,19 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	return 0;
 }
 
-static int get_nsid(int fd)
+static int get_nsid(int fd, __u32 *nsid)
 {
-	int nsid = nvme_get_nsid(fd);
+	int err;
+
+	err = nvme_get_nsid(fd, nsid);
 
-	if (nsid <= 0) {
+	if (err) {
 		fprintf(stderr,
 			"%s: failed to return namespace id\n",
 			devicename);
-		return errno;
+		return err;
 	}
-	return nsid;
+	return 0;
 }
 
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root))
@@ -1003,7 +1009,7 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 	if (cfg.human_readable)
 		flags |= HUMAN;
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 
 	err = nvme_identify_ns(fd, cfg.namespace_id, cfg.force, &ns);
 	if (!err) {
@@ -1026,13 +1032,14 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 
 static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
-	int nsid, fd;
+	int err, fd;
+	__u32 nsid;
 
 	fd = get_dev(argc, argv);
 	if (fd < 0)
 		return fd;
-	nsid = nvme_get_nsid(fd);
-	if (nsid <= 0) {
+	err = nvme_get_nsid(fd, &nsid);
+	if (err) {
 		perror(devicename);
 		return errno;
 	}
@@ -1438,7 +1445,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 		return fd;
 
 	if (S_ISBLK(nvme_stat.st_mode))
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 	if (cfg.namespace_id != 0xffffffff) {
 		err = nvme_identify_ns(fd, cfg.namespace_id, 0, &ns);
 		if (err) {
@@ -1715,7 +1722,7 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 		return fd;
 
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 
 	err = nvme_write_uncorrectable(fd, cfg.namespace_id, cfg.start_block,
 					cfg.block_count);
@@ -1792,7 +1799,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 	if (cfg.force_unit_access)
 		control |= NVME_RW_FUA;
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 
 	err = nvme_write_zeros(fd, cfg.namespace_id, cfg.start_block, cfg.block_count,
 			control, cfg.ref_tag, cfg.app_tag, cfg.app_tag_mask);
@@ -1876,7 +1883,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 	}
 
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 	if (!cfg.cdw11)
 		cfg.cdw11 = (cfg.ad << 2) | (cfg.idw << 1) | (cfg.idr << 0);
 
@@ -1983,7 +1990,7 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 		return fd;
 
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 	if (cfg.racqa > 7) {
 		fprintf(stderr, "invalid racqa:%d\n", cfg.racqa);
 		return EINVAL;
@@ -2045,7 +2052,7 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 		return fd;
 
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 	if (cfg.cptpl > 3) {
 		fprintf(stderr, "invalid cptpl:%d\n", cfg.cptpl);
 		return EINVAL;
@@ -2109,7 +2116,7 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 		return fd;
 
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 	if (cfg.iekey > 1) {
 		fprintf(stderr, "invalid iekey:%d\n", cfg.iekey);
 		return EINVAL;
@@ -2176,7 +2183,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		fmt = BINARY;
 
 	if (!cfg.namespace_id)
-		cfg.namespace_id = get_nsid(fd);
+		get_nsid(fd, &cfg.namespace_id);
 	if (!cfg.numd || cfg.numd > (0x1000 >> 2))
 		cfg.numd = 0x1000 >> 2;
 
diff --git a/nvme.h b/nvme.h
index 397a1a5..53dff4a 100644
--- a/nvme.h
+++ b/nvme.h
@@ -106,7 +106,7 @@ struct nvme_bar_cap {
 struct list_item {
 	char                node[1024];
 	struct nvme_id_ctrl ctrl;
-	int                 nsid;
+	__u32               nsid;
 	struct nvme_id_ns   ns;
 	unsigned            block;
 };
-- 
2.6.4.windows.1
