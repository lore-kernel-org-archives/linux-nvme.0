From: keith.busch@intel.com (Keith Busch)
Date: Tue, 14 Mar 2017 11:54:17 -0400
Subject: [PATCH] nvme-cli/format: use existing LBAF if none requested
Message-ID: <1489506857-24366-1-git-send-email-keith.busch@intel.com>

We previously default to LBAF 0 if the user didn't specify one. If a
specific LBAF is not explicitly requested, most people expect format
to not change their currently in use LBAF. This patch uses the current
format if we have a namespace to query. If we don't have a namespace,
and the user did not request a specific LBAF, the value will default to
0 as before.

https://github.com/linux-nvme/nvme-cli/issues/164

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 nvme.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/nvme.c b/nvme.c
index 17318b4..c56ebb4 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1397,7 +1397,9 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	const char *ms = "[0-1]: extended format off/on";
 	const char *reset = "Automatically reset the controller after successful format";
 	const char *timeout = "timeout value, in milliseconds";
+	struct nvme_id_ns ns;
 	int err, fd;
+	__u8 prev_lbaf = 0;
 
 	struct config {
 		__u32 namespace_id;
@@ -1413,7 +1415,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	struct config cfg = {
 		.namespace_id = 0xffffffff,
 		.timeout      = 120000,
-		.lbaf         = 0,
+		.lbaf         = 0xff,
 		.ses          = 0,
 		.pi           = 0,
 		.reset        = 0,
@@ -1435,6 +1437,24 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	if (fd < 0)
 		return fd;
 
+	if (S_ISBLK(nvme_stat.st_mode))
+		cfg.namespace_id = get_nsid(fd);
+	if (cfg.namespace_id) {
+		err = nvme_identify_ns(fd, cfg.namespace_id, 0, &ns);
+		if (err) {
+			if (err < 0)
+				perror("identify-namespace");
+			else
+				fprintf(stderr,
+					"NVME Admin command error:%s(%x)\n",
+					nvme_status_to_string(err), err);
+			return err;
+		}
+		prev_lbaf = ns.flbas & 0xf;
+	}
+	if (cfg.lbaf == 0xff)
+		cfg.lbaf = prev_lbaf;
+
 	/* ses & pi checks set to 7 for forward-compatibility */
 	if (cfg.ses > 7) {
 		fprintf(stderr, "invalid secure erase settings:%d\n", cfg.ses);
@@ -1456,8 +1476,6 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 		fprintf(stderr, "invalid ms:%d\n", cfg.ms);
 		return EINVAL;
 	}
-	if (S_ISBLK(nvme_stat.st_mode))
-		cfg.namespace_id = get_nsid(fd);
 
 	err = nvme_format(fd, cfg.namespace_id, cfg.lbaf, cfg.ses, cfg.pi,
 				cfg.pil, cfg.ms, cfg.timeout);
-- 
2.5.5
