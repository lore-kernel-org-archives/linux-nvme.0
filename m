From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 May 2019 19:39:50 +0300
Subject: [PATCH 6/9] nvme: update list-subsys command to show the entire list
In-Reply-To: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558543193-24752-7-git-send-email-maxg@mellanox.com>

Make it similar to "nvme list" command. For that, remove the
unnecessary ana_state parsing (was introduced only if specific namespace
handle was given).

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 fabrics.c    |   5 +-
 nvme-print.c |  10 +---
 nvme.c       | 149 +++++++----------------------------------------------------
 nvme.h       |   3 +-
 4 files changed, 23 insertions(+), 144 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index b42a3ce..3dadb4e 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1190,7 +1190,10 @@ int disconnect_all(const char *desc, int argc, char **argv)
 	if (ret)
 		return ret;
 
-	slist = get_subsys_list(&subcnt, NULL, NVME_NSID_ALL);
+	ret = get_subsys_list(&subcnt, &slist);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < subcnt; i++) {
 		struct subsys_list_item *subsys = &slist[i];
 
diff --git a/nvme-print.c b/nvme-print.c
index 6f85e73..7316117 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2851,12 +2851,10 @@ static void show_nvme_subsystem(struct subsys_list_item *item)
 	printf("\\\n");
 
 	for (i = 0; i < item->nctrls; i++) {
-		printf(" +- %s %s %s %s %s\n", item->ctrls[i].name,
+		printf(" +- %s %s %s %s\n", item->ctrls[i].name,
 				item->ctrls[i].transport,
 				item->ctrls[i].address,
-				item->ctrls[i].state,
-				item->ctrls[i].ana_state ?
-					item->ctrls[i].ana_state : "");
+				item->ctrls[i].state);
 	}
 
 }
@@ -2902,10 +2900,6 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 					slist[i].ctrls[j].address);
 			json_object_add_value_string(path_attrs, "State",
 					slist[i].ctrls[j].state);
-			if (slist[i].ctrls[j].ana_state)
-				json_object_add_value_string(path_attrs,
-						"ANAState",
-						slist[i].ctrls[j].ana_state);
 			json_array_add_value_object(paths, path_attrs);
 		}
 		if (j) {
diff --git a/nvme.c b/nvme.c
index 62f01c8..0fa141b 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1394,85 +1394,6 @@ err_free_path:
 	return NULL;
 }
 
-static int scan_ctrl_paths_filter(const struct dirent *d)
-{
-	int id, cntlid, nsid;
-
-	if (d->d_name[0] == '.')
-		return 0;
-
-	if (strstr(d->d_name, "nvme")) {
-		if (sscanf(d->d_name, "nvme%dc%dn%d", &id, &cntlid, &nsid) == 3)
-			return 1;
-		if (sscanf(d->d_name, "nvme%dn%d", &id, &nsid) == 2)
-			return 1;
-	}
-
-	return 0;
-}
-
-static char *get_nvme_ctrl_path_ana_state(char *path, int nsid)
-{
-	struct dirent **paths;
-	char *ana_state;
-	int i, n;
-
-	ana_state = calloc(1, 16);
-	if (!ana_state)
-		return NULL;
-
-	n = scandir(path, &paths, scan_ctrl_paths_filter, alphasort);
-	if (n <= 0) {
-		free(ana_state);
-		return NULL;
-	}
-	for (i = 0; i < n; i++) {
-		int id, cntlid, ns, fd;
-		ssize_t ret;
-		char *ctrl_path;
-
-		if (sscanf(paths[i]->d_name, "nvme%dc%dn%d",
-			   &id, &cntlid, &ns) != 3) {
-			if (sscanf(paths[i]->d_name, "nvme%dn%d",
-				   &id, &ns) != 2) {
-				continue;
-			}
-		}
-		if (ns != nsid)
-			continue;
-
-		ret = asprintf(&ctrl_path, "%s/%s/ana_state",
-			       path, paths[i]->d_name);
-		if (ret < 0) {
-			free(ana_state);
-			ana_state = NULL;
-			break;
-		}
-		fd = open(ctrl_path, O_RDONLY);
-		if (fd < 0) {
-			free(ctrl_path);
-			free(ana_state);
-			ana_state = NULL;
-			break;
-		}
-		ret = read(fd, ana_state, 16);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to read ANA state from %s\n",
-				ctrl_path);
-			free(ana_state);
-			ana_state = NULL;
-		} else if (ana_state[strlen(ana_state) - 1] == '\n')
-			ana_state[strlen(ana_state) - 1] = '\0';
-		close(fd);
-		free(ctrl_path);
-		break;
-	}
-	for (i = 0; i < n; i++)
-		free(paths[i]);
-	free(paths);
-	return ana_state;
-}
-
 static int scan_ctrls_filter(const struct dirent *d)
 {
 	int id, nsid;
@@ -1495,11 +1416,10 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 	free(ctrls->transport);
 	free(ctrls->address);
 	free(ctrls->state);
-	free(ctrls->ana_state);
 }
 
 static int get_nvme_subsystem_info(char *name, char *path,
-				struct subsys_list_item *item, __u32 nsid)
+				   struct subsys_list_item *item)
 {
 	char ctrl_path[512];
 	struct dirent **ctrls;
@@ -1557,9 +1477,6 @@ static int get_nvme_subsystem_info(char *name, char *path,
 			continue;
 		}
 
-		if (nsid != NVME_NSID_ALL)
-			item->ctrls[ccnt].ana_state =
-				get_nvme_ctrl_path_ana_state(ctrl_path, nsid);
 		ccnt++;
 	}
 
@@ -1624,8 +1541,7 @@ void free_subsys_list(struct subsys_list_item *slist, int n)
 	free(slist);
 }
 
-struct subsys_list_item *get_subsys_list(int *subcnt, char *subsysnqn,
-					 __u32 nsid)
+int get_subsys_list(int *subcnt, struct subsys_list_item **pslist)
 {
 	char path[310];
 	struct dirent **subsys;
@@ -1635,36 +1551,37 @@ struct subsys_list_item *get_subsys_list(int *subcnt, char *subsysnqn,
 	n = scandir(subsys_dir, &subsys, scan_subsys_filter, alphasort);
 	if (n < 0) {
 		fprintf(stderr, "no NVMe subsystem(s) detected.\n");
-		return NULL;
+		return -EINVAL;
 	}
 
 	slist = calloc(n, sizeof(struct subsys_list_item));
-	if (!slist)
+	if (!slist) {
+		ret = -ENOMEM;
 		goto free_subsys;
+	}
 
 	for (i = 0; i < n; i++) {
 		snprintf(path, sizeof(path), "%s%s", subsys_dir,
 			subsys[i]->d_name);
 		ret = get_nvme_subsystem_info(subsys[i]->d_name, path,
-				&slist[*subcnt], nsid);
+				&slist[*subcnt]);
 		if (ret) {
 			fprintf(stderr,
 				"%s: failed to get subsystem info: %s\n",
 				path, strerror(errno));
 			free_subsys_list_item(&slist[*subcnt]);
-		} else if (subsysnqn &&
-			   strncmp(slist[*subcnt].subsysnqn, subsysnqn, 255))
-			free_subsys_list_item(&slist[*subcnt]);
-		else
+		} else {
 			(*subcnt)++;
+		}
 	}
 
+	*pslist = slist;
 free_subsys:
 	for (i = 0; i < n; i++)
 		free(subsys[i]);
 	free(subsys);
 
-	return slist;
+	return ret;
 }
 
 static int list_subsys(int argc, char **argv, struct command *cmd,
@@ -1672,15 +1589,12 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 {
 	struct subsys_list_item *slist;
 	int fmt, ret, subcnt = 0;
-	char *subsysnqn = NULL;
-	const char *desc = "Retrieve information for subsystems";
+	const char *desc = "Retrieve information for all NVMe subsystems.";
 	struct config {
-		__u32 namespace_id;
 		char *output_format;
 	};
 
 	struct config cfg = {
-		.namespace_id  = NVME_NSID_ALL,
 		.output_format = "normal",
 	};
 
@@ -1694,42 +1608,13 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	if (ret < 0)
 		return ret;
 
-	devicename = NULL;
-	if (optind < argc) {
-		char path[512];
-		int id;
-
-		devicename = basename(argv[optind]);
-		if (sscanf(devicename, "nvme%dn%d", &id,
-			   &cfg.namespace_id) != 2) {
-			fprintf(stderr, "%s is not a NVMe namespace device\n",
-				argv[optind]);
-			return -EINVAL;
-		}
-		sprintf(path, "/sys/block/%s/device", devicename);
-		subsysnqn = get_nvme_subsnqn(path);
-		if (!subsysnqn) {
-			fprintf(stderr, "Cannot read subsys NQN from %s\n",
-				devicename);
-			return -EINVAL;
-		}
-		optind++;
-	}
-
-	if (ret < 0) {
-		argconfig_print_help(desc, opts);
-		if (subsysnqn)
-			free(subsysnqn);
-		return ret;
-	}
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt != JSON && fmt != NORMAL) {
-		if (subsysnqn)
-			free(subsysnqn);
+	if (fmt != JSON && fmt != NORMAL)
 		return -EINVAL;
-	}
 
-	slist = get_subsys_list(&subcnt, subsysnqn, cfg.namespace_id);
+	ret = get_subsys_list(&subcnt, &slist);
+	if (ret)
+		return ret;
 
 	if (fmt == JSON)
 		json_print_nvme_subsystem_list(slist, subcnt);
@@ -1737,8 +1622,6 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 		show_nvme_subsystem_list(slist, subcnt);
 
 	free_subsys_list(slist, subcnt);
-	if (subsysnqn)
-		free(subsysnqn);
 	return ret;
 }
 
diff --git a/nvme.h b/nvme.h
index a149005..7c444a4 100644
--- a/nvme.h
+++ b/nvme.h
@@ -147,7 +147,6 @@ struct ctrl_list_item {
 	char *address;
 	char *transport;
 	char *state;
-	char *ana_state;
 };
 
 struct subsys_list_item {
@@ -174,7 +173,7 @@ extern const char *devicename;
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root));
 int	validate_output_format(char *format);
 
-struct subsys_list_item *get_subsys_list(int *subcnt, char *subsysnqn, __u32 nsid);
+int get_subsys_list(int *subcnt, struct subsys_list_item **pslist);
 void free_subsys_list(struct subsys_list_item *slist, int n);
 char *nvme_char_from_block(char *block);
 
-- 
1.8.3.1
