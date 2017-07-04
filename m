From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Tue,  4 Jul 2017 11:58:46 -0700
Subject: [PATCH] nvme-cli : only print help text and return for nvme list -h
 option.
Message-ID: <20170704185846.1411-1-chaitanya.kulkarni@hgst.com>

For " nvme list -h " don't print list after help text,
only print help text and return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/nvme.c b/nvme.c
index 17d9d9e..5ac1117 100644
--- a/nvme.c
+++ b/nvme.c
@@ -871,8 +871,8 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	char path[264];
 	struct dirent **devices;
 	struct list_item *list_items;
-	unsigned int i, n, fd, ret;
-	int fmt;
+	unsigned int i, n, fd;
+	int fmt, ret;
 	const char *desc = "Retrieve basic information for the given device";
 	struct config {
 		char *output_format;
@@ -887,7 +887,10 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 		{NULL}
 	};
 
-	argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+	ret = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+	if (ret < 0)
+		return ret;
+
 	fmt = validate_output_format(cfg.output_format);
 
 	if (fmt != JSON && fmt != NORMAL)
-- 
2.13.0
