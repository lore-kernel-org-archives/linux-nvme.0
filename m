From: jsmart2021@gmail.com (James Smart)
Date: Fri, 27 Apr 2018 10:27:33 -0700
Subject: [PATCH] nvme-cli: show partial results if controller fails during
 list and list-subsys
Message-ID: <20180427172733.3325-1-jsmart2021@gmail.com>

For the current versions of "list" and "list-subsys":
If a command to a controller fails, which is possible if the controller
is going through a reconnect, the operation will fail and all results
gathered up to that point is dropped. Thus, the operation shows no
results.

Revise the commands so that they will report an error if one of the
controllers fail, but will now skip over the failing controller and
continue with the next one.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 nvme.c | 72 ++++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/nvme.c b/nvme.c
index ac255ba..4b62daf 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1217,12 +1217,19 @@ static int scan_ctrls_filter(const struct dirent *d)
 	return 0;
 }
 
+static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
+{
+	free(ctrls->name);
+	free(ctrls->transport);
+	free(ctrls->address);
+}
+
 int get_nvme_subsystem_info(char *name, char *path,
 				struct subsys_list_item *item)
 {
 	char ctrl_path[512];
 	struct dirent **ctrls;
-	int n, i, ret = 1;
+	int n, i, ret = 1, ccnt = 0;
 
 	item->subsysnqn = get_nvme_subsnqn(path);
 	if (!item->subsysnqn) {
@@ -1247,24 +1254,31 @@ int get_nvme_subsystem_info(char *name, char *path,
 	item->nctrls = n;
 
 	for (i = 0; i < n; i++) {
-		item->ctrls[i].name = strdup(ctrls[i]->d_name);
+		item->ctrls[ccnt].name = strdup(ctrls[i]->d_name);
 
 		snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path,
-			 item->ctrls[i].name);
+			 item->ctrls[ccnt].name);
 
-		item->ctrls[i].address = get_nvme_ctrl_address(ctrl_path);
-		if (!item->ctrls[i].address) {
+		item->ctrls[ccnt].address = get_nvme_ctrl_address(ctrl_path);
+		if (!item->ctrls[ccnt].address) {
 			fprintf(stderr, "failed to get controller[%d] address.\n", i);
-			goto free_ctrls;
+			free_ctrl_list_item(&item->ctrls[ccnt]);
+			continue;
 		}
 
-		item->ctrls[i].transport = get_nvme_ctrl_transport(ctrl_path);
-		if (!item->ctrls[i].transport) {
+		item->ctrls[ccnt].transport =
+				get_nvme_ctrl_transport(ctrl_path);
+		if (!item->ctrls[ccnt].transport) {
 			fprintf(stderr, "failed to get controller[%d] transport.\n", i);
-			goto free_ctrls;
+			free_ctrl_list_item(&item->ctrls[ccnt]);
+			continue;
 		}
+
+		ccnt++;
 	}
 
+	item->nctrls = ccnt;
+
 	ret = 0;
 
 free_ctrls:
@@ -1306,11 +1320,8 @@ static void free_subsys_list_item(struct subsys_list_item *item)
 {
 	int i;
 
-	for (i = 0; i < item->nctrls; i++) {
-		free(item->ctrls[i].name);
-		free(item->ctrls[i].transport);
-		free(item->ctrls[i].address);
-	}
+	for (i = 0; i < item->nctrls; i++)
+		free_ctrl_list_item(&item->ctrls[i]);
 
 	free(item->ctrls);
 	free(item->subsysnqn);
@@ -1333,7 +1344,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	char path[310];
 	struct dirent **subsys;
 	struct subsys_list_item *slist;
-	int fmt, n, i, ret = 0;
+	int fmt, n, i, ret = 0, subcnt = 0;
 	const char *desc = "Retrieve information for subsystems";
 	struct config {
 		char *output_format;
@@ -1372,18 +1383,24 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	for (i = 0; i < n; i++) {
 		snprintf(path, sizeof(path), "%s%s", subsys_dir,
 			subsys[i]->d_name);
-		ret = get_nvme_subsystem_info(subsys[i]->d_name, path, &slist[i]);
-		if (ret)
-			goto free_subsys;
+		ret = get_nvme_subsystem_info(subsys[i]->d_name, path,
+				&slist[subcnt]);
+		if (ret) {
+			fprintf(stderr,
+				"%s: failed to get subsystem info: %s\n",
+				path, strerror(errno));
+			free_subsys_list_item(&slist[subcnt]);
+		} else
+			subcnt++;
 	}
 
 	if (fmt == JSON)
-		json_print_nvme_subsystem_list(slist, n);
+		json_print_nvme_subsystem_list(slist, subcnt);
 	else
-		show_nvme_subsystem_list(slist, n);
+		show_nvme_subsystem_list(slist, subcnt);
 
 free_subsys:
-	free_subsys_list(slist, n);
+	free_subsys_list(slist, subcnt);
 
 	for (i = 0; i < n; i++)
 		free(subsys[i]);
@@ -1442,7 +1459,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	char path[264];
 	struct dirent **devices;
 	struct list_item *list_items;
-	unsigned int i, n;
+	unsigned int i, n, list_cnt = 0;
 	int fmt, ret, fd;
 	const char *desc = "Retrieve basic information for the given device";
 	struct config {
@@ -1487,16 +1504,19 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 					strerror(errno));
 			return errno;
 		}
-		ret = get_nvme_info(fd, &list_items[i], path);
+		ret = get_nvme_info(fd, &list_items[list_cnt], path);
 		close(fd);
 		if (ret)
-			return ret;
+			fprintf(stderr, "%s: failed to obtain nvme info: %s\n",
+				path, strerror(errno));
+		else
+			list_cnt++;
 	}
 
 	if (fmt == JSON)
-		json_print_list_items(list_items, n);
+		json_print_list_items(list_items, list_cnt);
 	else
-		show_list_items(list_items, n);
+		show_list_items(list_items, list_cnt);
 
 	for (i = 0; i < n; i++)
 		free(devices[i]);
-- 
2.13.1
