From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:30 +0200
Subject: [PATCH 4/6] nvme-list-subsys: Add device name argument and print out
 ANA state
In-Reply-To: <20180727102632.32455-1-hare@suse.de>
References: <20180727102632.32455-1-hare@suse.de>
Message-ID: <20180727102632.32455-5-hare@suse.de>

Update the 'nvme list-subsys' command to accept a device name and
print out the ANA state for all paths to that device.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Documentation/nvme-list-subsys.txt |   4 +-
 nvme-print.c                       |  10 +++-
 nvme.c                             | 115 +++++++++++++++++++++++++++++++++++--
 nvme.h                             |   1 +
 4 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/Documentation/nvme-list-subsys.txt b/Documentation/nvme-list-subsys.txt
index c7de7ef..c40b708 100644
--- a/Documentation/nvme-list-subsys.txt
+++ b/Documentation/nvme-list-subsys.txt
@@ -8,12 +8,14 @@ nvme-list-subsys - List all NVMe subsystems
 SYNOPSIS
 --------
 [verse]
-'nvme list-subsys' [-o <fmt> | --output-format=<fmt>]
+'nvme list-subsys' [-o <fmt> | --output-format=<fmt>] <device>
 
 DESCRIPTION
 -----------
 Scan the sysfs tree for NVM Express subsystems and return the controllers
 for those subsystems as well as some pertinent information about them.
+If a device is given, print out only the values for the controllers
+and subsystems leading to the device.
 
 OPTIONS
 -------
diff --git a/nvme-print.c b/nvme-print.c
index 692c903..e4c90bf 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2579,9 +2579,11 @@ static void show_nvme_subsystem(struct subsys_list_item *item)
 	printf("\\\n");
 
 	for (i = 0; i < item->nctrls; i++) {
-		printf(" +- %s %s %s\n", item->ctrls[i].name,
+		printf(" +- %s %s %s %s\n", item->ctrls[i].name,
 				item->ctrls[i].transport,
-				item->ctrls[i].address);
+				item->ctrls[i].address,
+				item->ctrls[i].ana_state ?
+					item->ctrls[i].ana_state : "");
 	}
 
 }
@@ -2627,6 +2629,10 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 					slist[i].ctrls[j].transport);
 			json_object_add_value_string(path_attrs, "Address",
 					slist[i].ctrls[j].address);
+			if (slist[i].ctrls[j].ana_state)
+				json_object_add_value_string(path_attrs,
+						"State",
+						slist[i].ctrls[j].ana_state);
 			json_array_add_value_object(paths, path_attrs);
 		}
 		if (j) {
diff --git a/nvme.c b/nvme.c
index 4815caa..74dfb61 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1288,6 +1288,73 @@ err_free_addrpath:
 
 	return NULL;
 }
+
+static int scan_ctrl_paths_filter(const struct dirent *d)
+{
+	int id, cntlid, nsid;
+
+	if (d->d_name[0] == '.')
+		return 0;
+
+	if (strstr(d->d_name, "nvme")) {
+		if (sscanf(d->d_name, "nvme%dc%dn%d", &id, &cntlid, &nsid) != 3)
+			return 0;
+		return 1;
+	}
+
+	return 0;
+}
+
+static char *get_nvme_ctrl_path_ana_state(char *path, int nsid)
+{
+	struct dirent **paths;
+	char *ana_state;
+	int i, n;
+
+	ana_state = calloc(1, 16);
+	if (!ana_state)
+		return NULL;
+
+	n = scandir(path, &paths, scan_ctrl_paths_filter, alphasort);
+	if (n <= 0) {
+		fprintf(stderr, "failed to scan controller path(s).\n");
+		free(ana_state);
+		return NULL;
+	}
+	for (i = 0; i < n; i++) {
+		int id, cntlid, ns, fd;
+		ssize_t ret;
+		char ctrl_path[256];
+
+		if (sscanf(paths[i]->d_name, "nvme%dc%dn%d",
+			   &id, &cntlid, &ns) != 3)
+			continue;
+
+		if (ns != nsid)
+			continue;
+
+		sprintf(ctrl_path, "%s/%s/ana_state", path, paths[i]->d_name);
+		fd = open(ctrl_path, O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "Failed to open ANA state %s\n",
+				ctrl_path);
+			return NULL;
+		}
+		ret = read(fd, ana_state, 16);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to read ANA state from %s\n",
+				ctrl_path);
+			free(ana_state);
+			ana_state = NULL;
+		} else if (ana_state[strlen(ana_state) - 1] == '\n')
+			ana_state[strlen(ana_state) - 1] = '\0';
+		close(fd);
+		break;
+	}
+
+	return ana_state;
+}
+
 static int scan_ctrls_filter(const struct dirent *d)
 {
 	int id, nsid;
@@ -1312,7 +1379,7 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 }
 
 int get_nvme_subsystem_info(char *name, char *path,
-				struct subsys_list_item *item)
+			    struct subsys_list_item *item, int nsid)
 {
 	char ctrl_path[512];
 	struct dirent **ctrls;
@@ -1360,7 +1427,9 @@ int get_nvme_subsystem_info(char *name, char *path,
 			free_ctrl_list_item(&item->ctrls[ccnt]);
 			continue;
 		}
-
+		if (nsid)
+			item->ctrls[ccnt].ana_state =
+				get_nvme_ctrl_path_ana_state(ctrl_path, nsid);
 		ccnt++;
 	}
 
@@ -1429,9 +1498,10 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 		       struct plugin *plugin)
 {
 	char path[310];
+	char *subsysnqn = NULL;
 	struct dirent **subsys;
 	struct subsys_list_item *slist;
-	int fmt, n, i, ret = 0, subcnt = 0;
+	int fmt, n = 1, i, ret = 0, subcnt = 0, nsid = 0, id;
 	const char *desc = "Retrieve information for subsystems";
 	struct config {
 		char *output_format;
@@ -1451,13 +1521,42 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 	if (ret < 0)
 		return ret;
 
+	devicename = NULL;
+	if (optind < argc) {
+		devicename = basename(argv[optind]);
+		if (sscanf(devicename, "nvme%dn%d", &id, &nsid) != 2) {
+			fprintf(stderr, "%s is not a NVMe namespace device\n",
+				argv[optind]);
+			return -EINVAL;
+		}
+		sprintf(path, "/sys/block/%s/device", devicename);
+		subsysnqn = get_nvme_subsnqn(path);
+		if (!subsysnqn) {
+			fprintf(stderr, "Cannot read subsys NQN from %s\n",
+				devicename);
+			return -EINVAL;
+		}
+		optind++;
+	}
+
+	if (ret < 0) {
+		argconfig_print_help(desc, opts);
+		if (subsysnqn)
+			free(subsysnqn);
+		return ret;
+	}
 	fmt = validate_output_format(cfg.output_format);
 
-	if (fmt != JSON && fmt != NORMAL)
+	if (fmt != JSON && fmt != NORMAL) {
+		if (subsysnqn)
+			free(subsysnqn);
 		return -EINVAL;
+	}
 	n = scandir(subsys_dir, &subsys, scan_subsys_filter, alphasort);
 	if (n < 0) {
 		fprintf(stderr, "no NVMe subsystem(s) detected.\n");
+		if (subsysnqn)
+			free(subsysnqn);
 		return n;
 	}
 
@@ -1471,12 +1570,15 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 		snprintf(path, sizeof(path), "%s%s", subsys_dir,
 			subsys[i]->d_name);
 		ret = get_nvme_subsystem_info(subsys[i]->d_name, path,
-				&slist[subcnt]);
+				&slist[subcnt], nsid);
 		if (ret) {
 			fprintf(stderr,
 				"%s: failed to get subsystem info: %s\n",
 				path, strerror(errno));
 			free_subsys_list_item(&slist[subcnt]);
+		} else if (subsysnqn &&
+			   strncmp(slist[subcnt].subsysnqn, subsysnqn, 255)) {
+			free_subsys_list_item(&slist[subcnt]);
 		} else
 			subcnt++;
 	}
@@ -1492,7 +1594,8 @@ free_subsys:
 	for (i = 0; i < n; i++)
 		free(subsys[i]);
 	free(subsys);
-
+		if (subsysnqn)
+			free(subsysnqn);
 	return ret;
 }
 
diff --git a/nvme.h b/nvme.h
index 5098b0e..26d5b85 100644
--- a/nvme.h
+++ b/nvme.h
@@ -129,6 +129,7 @@ struct ctrl_list_item {
 	char *name;
 	char *address;
 	char *transport;
+	char *ana_state;
 };
 
 struct subsys_list_item {
-- 
2.13.7
