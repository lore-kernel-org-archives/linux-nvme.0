From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  2 May 2018 00:48:40 -0400
Subject: [PATCH] nvme-cli: allow block device for delete-ns
Message-ID: <20180502044840.28801-1-chaitanya.kulkarni@wdc.com>

This patch allows block device to be used for the
NVMe delete-ns command while keeping the -n options
as it is.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/nvme.c b/nvme.c
index 4b62daf..f0a1474 100644
--- a/nvme.c
+++ b/nvme.c
@@ -853,6 +853,18 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 	return err;
 }
 
+static int get_nsid(int fd)
+{
+	int nsid = nvme_get_nsid(fd);
+
+	if (nsid <= 0) {
+		fprintf(stderr,
+			"%s: failed to return namespace id\n",
+			devicename);
+	}
+	return nsid;
+}
+
 static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Delete the given namespace by "\
@@ -881,7 +893,13 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	if (fd < 0)
 		return fd;
 
-	if (!cfg.namespace_id) {
+	if (S_ISBLK(nvme_stat.st_mode)) {
+		cfg.namespace_id = get_nsid(fd);
+		if (cfg.namespace_id == 0) {
+			err = EINVAL;
+			goto close_fd;
+		}
+	} else if (!cfg.namespace_id) {
 		fprintf(stderr, "%s: namespace-id parameter required\n",
 						cmd->name);
 		err = EINVAL;
@@ -1526,18 +1544,6 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	return 0;
 }
 
-static int get_nsid(int fd)
-{
-	int nsid = nvme_get_nsid(fd);
-
-	if (nsid <= 0) {
-		fprintf(stderr,
-			"%s: failed to return namespace id\n",
-			devicename);
-	}
-	return nsid;
-}
-
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root))
 {
 	const char *desc = "Send an Identify Controller command to "\
-- 
2.14.1
