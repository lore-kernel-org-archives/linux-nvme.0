From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu,  3 May 2018 06:04:45 -0400
Subject: [PATCH] nvme-cli: fix get_nsid() return value check
Message-ID: <20180503100445.21899-1-chaitanya.kulkarni@wdc.com>

All the callers of the get_nsid() defined cfg.namespace_id as __u32.
The true return value of the call:-

cfg.namespace_id = get_nsid()

will not be used in case nvme_get_nsid() returns < 0 and
comparion of

if (cfg.namespace_id <= 0)

and will result is cfg.namespace_id > 0 due to type mismatch.

We fix this scenario by returning the 0 (invalid nsid on get_nsid()
for nvme_get_nsid() failure case) and adding

cfg.namespace_id == 0

for error checking in all the callers of the get_nsid().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 74 +++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/nvme.c b/nvme.c
index fdd2f4b..9e86894 100644
--- a/nvme.c
+++ b/nvme.c
@@ -862,7 +862,7 @@ static int get_nsid(int fd)
 			"%s: failed to return namespace id\n",
 			devicename);
 	}
-	return nsid;
+	return nsid < 0 ? 0 : nsid;
 }
 
 static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -895,7 +895,7 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 
 	if (S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0) {
+		if (cfg.namespace_id == 0) {
 			err = EINVAL;
 			goto close_fd;
 		}
@@ -1664,8 +1664,10 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 		fmt = BINARY;
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 
 	if (posix_memalign(&nsdescs, getpagesize(), 0x1000)) {
@@ -1755,8 +1757,10 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 		flags |= HUMAN;
 	if (!cfg.namespace_id && S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	else if(!cfg.namespace_id)
 		fprintf(stderr,
@@ -2457,8 +2461,10 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 
 	if (S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	if (cfg.namespace_id != NVME_NSID_ALL) {
 		err = nvme_identify_ns(fd, cfg.namespace_id, 0, &ns);
@@ -2917,8 +2923,10 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 
 	err = nvme_write_uncorrectable(fd, cfg.namespace_id, cfg.start_block,
@@ -2931,6 +2939,7 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 	else
 		printf("NVME Write Uncorrectable Success\n");
 
+close_fd:
 	close(fd);
 
 	return err;
@@ -3007,8 +3016,10 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 		control |= NVME_RW_DEAC;
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 
 	err = nvme_write_zeros(fd, cfg.namespace_id, cfg.start_block, cfg.block_count,
@@ -3098,8 +3109,10 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	if (!cfg.cdw11)
 		cfg.cdw11 = (cfg.ad << 2) | (cfg.idw << 1) | (cfg.idr << 0);
@@ -3152,8 +3165,14 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 	if (fd < 0)
 		return fd;
 
-	if (S_ISBLK(nvme_stat.st_mode))
+	if (S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
+	}
+
 	err = nvme_flush(fd, cfg.namespace_id);
 	if (err < 0)
 		perror("flush");
@@ -3162,6 +3181,7 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 				nvme_status_to_string(err), err);
 	else
 		printf("NVMe Flush: success\n");
+close_fd:
 	close(fd);
 	return err;
 }
@@ -3215,8 +3235,10 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	if (cfg.racqa > 7) {
 		fprintf(stderr, "invalid racqa:%d\n", cfg.racqa);
@@ -3284,8 +3306,10 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	if (cfg.cptpl > 3) {
 		fprintf(stderr, "invalid cptpl:%d\n", cfg.cptpl);
@@ -3355,8 +3379,10 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	if (cfg.rrela > 7) {
 		fprintf(stderr, "invalid rrela:%d\n", cfg.rrela);
@@ -3431,8 +3457,10 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
-		if (cfg.namespace_id <= 0)
-			return EINVAL;
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
 	}
 	if (!cfg.numd || cfg.numd > (0x1000 >> 2))
 		cfg.numd = 0x1000 >> 2;
-- 
2.14.1
