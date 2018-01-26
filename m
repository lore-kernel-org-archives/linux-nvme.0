From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 27 Jan 2018 02:39:48 +0900
Subject: [PATCH] nvme-cli: make return negative value in nvme_get_nsid() when
 not blkdev
Message-ID: <1516988388-27561-1-git-send-email-minwoo.im.dev@gmail.com>

If caller invokes get_nsid() with character device without checking
whether a given device is block device or not, ENOTBLK is returned from
nvme_get_nsid() which is a positive value, so that caller may treat this
value as a valid nsid.

Make it return a negative vaelue with -ENOTBLK and add error checking to
callers.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-ioctl.c |  2 +-
 nvme.c       | 54 +++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 6fdb636..180abe2 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -79,7 +79,7 @@ int nvme_get_nsid(int fd)
 	if (!S_ISBLK(nvme_stat.st_mode)) {
 		fprintf(stderr,
 			"Error: requesting namespace-id from non-block device\n");
-		return ENOTBLK;
+		return -ENOTBLK;
 	}
 	return ioctl(fd, NVME_IOCTL_ID);
 }
diff --git a/nvme.c b/nvme.c
index aa2b8ec..5b524fd 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1348,6 +1348,8 @@ static int get_nvme_info(int fd, struct list_item *item, const char *node)
 	if (err)
 		return err;
 	item->nsid = nvme_get_nsid(fd);
+	if (item->nsid <= 0)
+		return item->nsid;
 	err = nvme_identify_ns(fd, item->nsid,
 			       0, &item->ns);
 	if (err)
@@ -1460,8 +1462,8 @@ static int get_nsid(int fd)
 		fprintf(stderr,
 			"%s: failed to return namespace id\n",
 			devicename);
-		return errno;
 	}
+
 	return nsid;
 }
 
@@ -1576,8 +1578,11 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 		return fmt;
 	if (cfg.raw_binary)
 		fmt = BINARY;
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 
 	if (posix_memalign(&nsdescs, getpagesize(), 0x1000)) {
 		fprintf(stderr, "can not allocate controller list payload\n");
@@ -1658,8 +1663,11 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 		flags |= VS;
 	if (cfg.human_readable)
 		flags |= HUMAN;
-	if (!cfg.namespace_id && S_ISBLK(nvme_stat.st_mode))
+	if (!cfg.namespace_id && S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	else if(!cfg.namespace_id)
 		fprintf(stderr,
 			"Error: requesting namespace-id from non-block device\n");
@@ -2301,8 +2309,11 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	if (fd < 0)
 		return fd;
 
-	if (S_ISBLK(nvme_stat.st_mode))
+	if (S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	if (cfg.namespace_id != NVME_NSID_ALL) {
 		err = nvme_identify_ns(fd, cfg.namespace_id, 0, &ns);
 		if (err) {
@@ -2726,8 +2737,11 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 	if (fd < 0)
 		return fd;
 
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 
 	err = nvme_write_uncorrectable(fd, cfg.namespace_id, cfg.start_block,
 					cfg.block_count);
@@ -2808,8 +2822,11 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 		control |= NVME_RW_FUA;
 	if (cfg.deac)
 		control |= NVME_RW_DEAC;
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 
 	err = nvme_write_zeros(fd, cfg.namespace_id, cfg.start_block, cfg.block_count,
 			control, cfg.ref_tag, cfg.app_tag, cfg.app_tag_mask);
@@ -2892,8 +2909,11 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 		return EINVAL;
 	}
 
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	if (!cfg.cdw11)
 		cfg.cdw11 = (cfg.ad << 2) | (cfg.idw << 1) | (cfg.idr << 0);
 
@@ -3000,8 +3020,11 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 	if (fd < 0)
 		return fd;
 
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	if (cfg.racqa > 7) {
 		fprintf(stderr, "invalid racqa:%d\n", cfg.racqa);
 		return EINVAL;
@@ -3062,8 +3085,11 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 	if (fd < 0)
 		return fd;
 
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	if (cfg.cptpl > 3) {
 		fprintf(stderr, "invalid cptpl:%d\n", cfg.cptpl);
 		return EINVAL;
@@ -3126,8 +3152,11 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 	if (fd < 0)
 		return fd;
 
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	if (cfg.iekey > 1) {
 		fprintf(stderr, "invalid iekey:%d\n", cfg.iekey);
 		return EINVAL;
@@ -3197,8 +3226,11 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
-	if (!cfg.namespace_id)
+	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id <= 0)
+			return EINVAL;
+	}
 	if (!cfg.numd || cfg.numd > (0x1000 >> 2))
 		cfg.numd = 0x1000 >> 2;
 	if (cfg.numd < 3)
-- 
2.7.4
