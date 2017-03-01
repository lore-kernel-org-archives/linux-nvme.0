From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Tue, 28 Feb 2017 18:14:07 -0800
Subject: [PATCH 1/4] nvme-cli: id-ctrl: Add vendor fields in JSON id-ctrl.
In-Reply-To: <1488334450-13952-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1488334450-13952-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1488334450-13952-2-git-send-email-chaitanya.kulkarni@hgst.com>

As a part of the id-ctrl command vendor specific callback is issued.
This patch allows the vendor-specific callback to print the extended
vendor unique (ctrl->vs) information from identify controller
data structure in the JSON format. It also enables id-ctrl command
to print vendor specific fields along with generic id-ctrl fields
in one JSON object. This modifies Intel plug-in which is the only
one uses extended id-ctrl (cs->vs) information in current
implementation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 intel-nvme.c | 21 ++++++++++++++-------
 nvme-print.c |  8 +++++---
 nvme-print.h |  5 +++--
 nvme.c       |  4 ++--
 nvme.h       |  3 ++-
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index 1863e7b..df0155a 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -12,6 +12,7 @@
 #include "nvme.h"
 #include "nvme-print.h"
 #include "nvme-ioctl.h"
+#include "json.h"
 #include "plugin.h"
 
 #include "argconfig.h"
@@ -20,7 +21,7 @@
 #define CREATE_CMD
 #include "intel-nvme.h"
 
-static void intel_id_ctrl(__u8 *vs)
+static void intel_id_ctrl(__u8 *vs, struct json_object *root)
 {
 	char bl[9];
         char health[21];
@@ -28,12 +29,18 @@ static void intel_id_ctrl(__u8 *vs)
 	memcpy(bl, &vs[28], sizeof(bl));
 	memcpy(health, &vs[4], sizeof(health));
 
-        bl[sizeof(bl) - 1] = '\0';
-        health[sizeof(health) - 1] = '\0';
-
-	printf("ss      : %d\n", vs[3]);
-	printf("health  : %s\n", health[0] ? health : "healthy");
-	printf("bl      : %s\n", bl);
+	bl[sizeof(bl) - 1] = '\0';
+	health[sizeof(health) - 1] = '\0';
+
+	if (root) {
+		json_object_add_value_int(root, "ss", vs[3]);
+		json_object_add_value_string(root, "health", health[0] ? health : "healthy");
+		json_object_add_value_string(root, "bl", bl);
+	} else {
+		printf("ss      : %d\n", vs[3]);
+		printf("health  : %s\n", health[0] ? health : "healthy");
+		printf("bl      : %s\n", bl);
+	}
 }
 
 static int id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
diff --git a/nvme-print.c b/nvme-print.c
index 526efd4..6f40303 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -590,7 +590,7 @@ static void show_nvme_id_ctrl_power(struct nvme_id_ctrl *ctrl)
 	}
 }
 
-void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs))
+void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs, struct json_object *root))
 {
 	int human = mode & HUMAN, vs = mode & VS;
 
@@ -675,7 +675,7 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 
 	show_nvme_id_ctrl_power(ctrl);
 	if (vendor_show)
-		vendor_show(ctrl->vs);
+		vendor_show(ctrl->vs, NULL);
 	else if (vs) {
 		printf("vs[]:\n");
 		d(ctrl->vs, sizeof(ctrl->vs), 16, 1);
@@ -1262,7 +1262,7 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	json_free_object(root);
 }
 
-void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
+void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(__u8 *vs, struct json_object *root))
 {
 	struct json_object *root;
 	struct json_array *psds;
@@ -1356,6 +1356,8 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
 		json_array_add_value_object(psds, psd);
 	}
 
+	if(vs)
+		vs(ctrl->vs, root);
 	json_print_object(root, NULL);
 	printf("\n");
 	json_free_object(root);
diff --git a/nvme-print.h b/nvme-print.h
index 6a9e77f..f5e4c8f 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -2,6 +2,7 @@
 #define NVME_PRINT_H
 
 #include "nvme.h"
+#include "json.h"
 #include <inttypes.h>
 
 enum {
@@ -16,7 +17,7 @@ void d_raw(unsigned char *buf, unsigned len);
 
 uint64_t int48_to_long(__u8 *data);
 
-void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs));
+void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs, struct json_object *root));
 void show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode);
 void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void show_nvme_resv_report(struct nvme_reservation_status *status);
@@ -32,7 +33,7 @@ char *nvme_status_to_string(__u32 status);
 char *nvme_select_to_string(int sel);
 char *nvme_feature_to_string(int feature);
 
-void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode);
+void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs, struct json_object *root));
 void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void json_nvme_resv_report(struct nvme_reservation_status *status);
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
diff --git a/nvme.c b/nvme.c
index a6651ca..246736d 100644
--- a/nvme.c
+++ b/nvme.c
@@ -883,7 +883,7 @@ static int get_nsid(int fd)
 	return nsid;
 }
 
-int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs))
+int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root))
 {
 	const char *desc = "Send an Identify Controller command to "\
 		"the given device and report information about the specified "\
@@ -936,7 +936,7 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 		if (fmt == BINARY)
 			d_raw((unsigned char *)&ctrl, sizeof(ctrl));
 		else if (fmt == JSON)
-			json_nvme_id_ctrl(&ctrl, flags);
+			json_nvme_id_ctrl(&ctrl, flags, vs);
 		else {
 			printf("NVME Identify Controller:\n");
 			__show_nvme_id_ctrl(&ctrl, flags, vs);
diff --git a/nvme.h b/nvme.h
index 5481916..d3d8a93 100644
--- a/nvme.h
+++ b/nvme.h
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <endian.h>
 #include "plugin.h"
+#include "json.h"
 
 #define unlikely(x) x
 #include "linux/nvme.h"
@@ -156,6 +157,6 @@ int parse_and_open(int argc, char **argv, const char *desc,
 
 extern const char *devicename;
 
-int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs));
+int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root));
 
 #endif /* _NVME_H */
-- 
1.9.1
