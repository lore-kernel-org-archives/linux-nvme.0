From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Tue, 28 Feb 2017 18:14:08 -0800
Subject: [PATCH 2/4] nvme-cli: nvme.c: Allow plug-ins to access to output
 formats and helper.
In-Reply-To: <1488334450-13952-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1488334450-13952-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1488334450-13952-3-git-send-email-chaitanya.kulkarni@hgst.com>

This patch allows plug-ins to access output format enums and
its helper by moving the enum definition and helper declaration
to the header file.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme.c | 8 +-------
 nvme.h | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/nvme.c b/nvme.c
index 246736d..4971683 100644
--- a/nvme.c
+++ b/nvme.c
@@ -157,13 +157,7 @@ int parse_and_open(int argc, char **argv, const char *desc,
 
 static const char *output_format = "Output format: normal|json|binary";
 
-enum {
-	NORMAL,
-	JSON,
-	BINARY,
-};
-
-static int validate_output_format(char *format)
+int validate_output_format(char *format)
 {
 	if (!format)
 		return -EINVAL;
diff --git a/nvme.h b/nvme.h
index d3d8a93..fb2a3a3 100644
--- a/nvme.h
+++ b/nvme.h
@@ -149,6 +149,12 @@ struct list_item {
 	unsigned            block;
 };
 
+enum {
+	NORMAL,
+	JSON,
+	BINARY,
+};
+
 void register_extension(struct plugin *plugin);
 
 #include "argconfig.h"
@@ -158,5 +164,6 @@ int parse_and_open(int argc, char **argv, const char *desc,
 extern const char *devicename;
 
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root));
+int	validate_output_format(char *format);
 
 #endif /* _NVME_H */
-- 
1.9.1
