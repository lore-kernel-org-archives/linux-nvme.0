From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 27 Jan 2018 00:36:19 +0900
Subject: [PATCH] nvme-cli: move print-function to nvme-print
Message-ID: <1516980979-12952-1-git-send-email-minwoo.im.dev@gmail.com>

Code clean-up by moving print-functions for list and list-subsys
commands to nvme-print.c with no functional changes.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.h |  2 ++
 nvme.c       | 65 ++----------------------------------------------------------
 3 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 1ca4b71..fdfbb2f 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -6,6 +6,7 @@
 #include "nvme-print.h"
 #include "json.h"
 #include "nvme-models.h"
+#include "suffix.h"
 
 static long double int128_to_double(__u8 *data)
 {
@@ -1557,6 +1558,43 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	}
 }
 
+static void show_list_item(struct list_item list_item)
+{
+	long long int lba = 1 << list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ds;
+	double nsze       = le64_to_cpu(list_item.ns.nsze) * lba;
+	double nuse       = le64_to_cpu(list_item.ns.nuse) * lba;
+
+	const char *s_suffix = suffix_si_get(&nsze);
+	const char *u_suffix = suffix_si_get(&nuse);
+	const char *l_suffix = suffix_binary_get(&lba);
+
+	char usage[128];
+	char format[128];
+
+	sprintf(usage,"%6.2f %2sB / %6.2f %2sB", nuse, u_suffix,
+		nsze, s_suffix);
+	sprintf(format,"%3.0f %2sB + %2d B", (double)lba, l_suffix,
+		list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ms);
+	printf("%-16s %-*.*s %-*.*s %-9d %-26s %-16s %-.*s\n", list_item.node,
+            (int)sizeof(list_item.ctrl.sn), (int)sizeof(list_item.ctrl.sn), list_item.ctrl.sn,
+            (int)sizeof(list_item.ctrl.mn), (int)sizeof(list_item.ctrl.mn), list_item.ctrl.mn,
+            list_item.nsid, usage, format, (int)sizeof(list_item.ctrl.fr), list_item.ctrl.fr);
+}
+
+void show_list_items(struct list_item *list_items, unsigned len)
+{
+	unsigned i;
+
+	printf("%-16s %-20s %-40s %-9s %-26s %-16s %-8s\n",
+	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev");
+	printf("%-16s %-20s %-40s %-9s %-26s %-16s %-8s\n",
+            "----------------", "--------------------", "----------------------------------------",
+            "---------", "--------------------------", "----------------", "--------");
+	for (i = 0 ; i < len ; i++)
+		show_list_item(list_items[i]);
+
+}
+
 void json_print_list_items(struct list_item *list_items, unsigned len)
 {
 	struct json_object *root;
@@ -2065,6 +2103,28 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 	json_free_object(root);
 }
 
+static void show_nvme_subsystem(struct subsys_list_item *item)
+{
+	int i;
+
+	printf("%s - NQN=%s\n", item->name, item->subsysnqn);
+	printf("\\\n");
+
+	for (i = 0; i < item->nctrls; i++) {
+		printf(" +- %s %s %s\n", item->ctrls[i].name,
+				item->ctrls[i].transport,
+				item->ctrls[i].address);
+	}
+
+}
+
+void show_nvme_subsystem_list(struct subsys_list_item *slist, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		show_nvme_subsystem(&slist[i]);
+}
 void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 {
 	struct json_object *root;
diff --git a/nvme-print.h b/nvme-print.h
index 2c94477..748f6d0 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -29,6 +29,8 @@ void show_effects_log(struct nvme_effects_log_page *effects, unsigned int flags)
 void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mode, const char *devname);
 void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics);
 void show_nvme_id_ns_descs(void *data);
+void show_list_items(struct list_item *list_items, unsigned len);
+void show_nvme_subsystem_list(struct subsys_list_item *slist, int n);
 
 void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf);
 void nvme_directive_show_fields(__u8 dtype, __u8 doper, unsigned int result, unsigned char *buf);
diff --git a/nvme.c b/nvme.c
index aa2b8ec..a1c922e 100644
--- a/nvme.c
+++ b/nvme.c
@@ -51,7 +51,6 @@
 #include "plugin.h"
 
 #include "argconfig.h"
-#include "suffix.h"
 
 #include "fabrics.h"
 
@@ -1100,29 +1099,6 @@ static int scan_ctrls_filter(const struct dirent *d)
 	return 0;
 }
 
-void print_nvme_subsystem(struct subsys_list_item *item)
-{
-	int i;
-
-	printf("%s - NQN=%s\n", item->name, item->subsysnqn);
-	printf("\\\n");
-
-	for (i = 0; i < item->nctrls; i++) {
-		printf(" +- %s %s %s\n", item->ctrls[i].name,
-				item->ctrls[i].transport,
-				item->ctrls[i].address);
-	}
-
-}
-
-void print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
-{
-	int i;
-
-	for (i = 0; i < n; i++)
-		print_nvme_subsystem(&slist[i]);
-}
-
 int get_nvme_subsystem_info(char *name, char *path,
 				struct subsys_list_item *item)
 {
@@ -1291,7 +1267,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	if (fmt == JSON)
 		json_print_nvme_subsystem_list(slist, n);
 	else
-		print_nvme_subsystem_list(slist, n);
+		show_nvme_subsystem_list(slist, n);
 
 free_subsys:
 	free_subsys_list(slist, n);
@@ -1303,43 +1279,6 @@ free_subsys:
 	return ret;
 }
 
-static void print_list_item(struct list_item list_item)
-{
-	long long int lba = 1 << list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ds;
-	double nsze       = le64_to_cpu(list_item.ns.nsze) * lba;
-	double nuse       = le64_to_cpu(list_item.ns.nuse) * lba;
-
-	const char *s_suffix = suffix_si_get(&nsze);
-	const char *u_suffix = suffix_si_get(&nuse);
-	const char *l_suffix = suffix_binary_get(&lba);
-
-	char usage[128];
-	char format[128];
-
-	sprintf(usage,"%6.2f %2sB / %6.2f %2sB", nuse, u_suffix,
-		nsze, s_suffix);
-	sprintf(format,"%3.0f %2sB + %2d B", (double)lba, l_suffix,
-		list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ms);
-	printf("%-16s %-*.*s %-*.*s %-9d %-26s %-16s %-.*s\n", list_item.node,
-            (int)sizeof(list_item.ctrl.sn), (int)sizeof(list_item.ctrl.sn), list_item.ctrl.sn,
-            (int)sizeof(list_item.ctrl.mn), (int)sizeof(list_item.ctrl.mn), list_item.ctrl.mn,
-            list_item.nsid, usage, format, (int)sizeof(list_item.ctrl.fr), list_item.ctrl.fr);
-}
-
-static void print_list_items(struct list_item *list_items, unsigned len)
-{
-	unsigned i;
-
-	printf("%-16s %-20s %-40s %-9s %-26s %-16s %-8s\n",
-	    "Node", "SN", "Model", "Namespace", "Usage", "Format", "FW Rev");
-	printf("%-16s %-20s %-40s %-9s %-26s %-16s %-8s\n",
-            "----------------", "--------------------", "----------------------------------------",
-            "---------", "--------------------------", "----------------", "--------");
-	for (i = 0 ; i < len ; i++)
-		print_list_item(list_items[i]);
-
-}
-
 static int get_nvme_info(int fd, struct list_item *item, const char *node)
 {
 	int err;
@@ -1442,7 +1381,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	if (fmt == JSON)
 		json_print_list_items(list_items, n);
 	else
-		print_list_items(list_items, n);
+		show_list_items(list_items, n);
 
 	for (i = 0; i < n; i++)
 		free(devices[i]);
-- 
2.7.4
