From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 13 Dec 2017 15:34:17 +0100
Subject: [PATCH nvme-cli v2] nvme: Introduce new 'list-subsys' command
Message-ID: <20171213143417.19489-1-jthumshirn@suse.de>

Introduce a 'nvme list-subsys' command to give basic information about
connected NVMe subsystems.

Here's an example output of a host connected to two subsystems on the
target with two paths to each subsystem:
root at host# nvme list-subsys
nvme-subsys0 - NQN=nvmf-test
\
 +- nvme0 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
 +- nvme1 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
nvme-subsys1 - NQN=nvmf-test2
\
 +- nvme2 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
 +- nvme3 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

---
Changes to v1:
- Fix manpage build
- Check return of asprintf()
---
 Documentation/nvme-list-subsys.txt  |  81 +++++++++
 completions/bash-nvme-completion.sh |   2 +-
 nvme-builtin.h                      |   1 +
 nvme-print.c                        |  49 ++++++
 nvme-print.h                        |   1 +
 nvme.c                              | 340 ++++++++++++++++++++++++++++++++++++
 nvme.h                              |  13 ++
 7 files changed, 486 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme-list-subsys.txt

diff --git a/Documentation/nvme-list-subsys.txt b/Documentation/nvme-list-subsys.txt
new file mode 100644
index 000000000000..c7de7efba654
--- /dev/null
+++ b/Documentation/nvme-list-subsys.txt
@@ -0,0 +1,81 @@
+nvme-list-subsys(1)
+===================
+
+NAME
+----
+nvme-list-subsys - List all NVMe subsystems
+
+SYNOPSIS
+--------
+[verse]
+'nvme list-subsys' [-o <fmt> | --output-format=<fmt>]
+
+DESCRIPTION
+-----------
+Scan the sysfs tree for NVM Express subsystems and return the controllers
+for those subsystems as well as some pertinent information about them.
+
+OPTIONS
+-------
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'normal' or 'json'. Only one output
+	format can be used at a time.
+
+EXAMPLES
+--------
+root at host# nvme list-subsys
+nvme-subsys0 - NQN=nvmf-test
+\
+ +- nvme0 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
+ +- nvme1 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
+nvme-subsys1 - NQN=nvmf-test2
+\
+ +- nvme2 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
+ +- nvme3 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
+
+root at host# nvme list-subsys -o json
+{
+  "Subsystems" : [
+    {
+      "Name" : "nvme-subsys0",
+      "NQN" : "nvmf-test"
+    },
+    {
+      "Paths" : [
+        {
+          "Name" : "nvme0",
+          "Transport" : "rdma",
+          "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1"
+        },
+        {
+          "Name" : "nvme1",
+          "Transport" : "rdma",
+          "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2"
+        }
+      ]
+    },
+    {
+      "Name" : "nvme-subsys1",
+      "NQN" : "nvmf-test2"
+    },
+    {
+      "Paths" : [
+        {
+          "Name" : "nvme2",
+          "Transport" : "rdma",
+          "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2"
+        },
+        {
+          "Name" : "nvme3",
+          "Transport" : "rdma",
+          "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1"
+        }
+      ]
+    }
+  ]
+}
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/completions/bash-nvme-completion.sh b/completions/bash-nvme-completion.sh
index da16f0e2b145..5abc30e8086a 100644
--- a/completions/bash-nvme-completion.sh
+++ b/completions/bash-nvme-completion.sh
@@ -11,7 +11,7 @@ _cmds="list id-ctrl id-ns list-ns create-ns delete-ns \
 	resv-report dsm flush compare read write write-zeroes \
 	write-uncor reset subsystem-reset show-regs discover \
 	connect-all connect disconnect version help \
-	intel lnvm memblaze"
+	intel lnvm memblaze list-subsys"
 
 nvme_list_opts () {
         local opts=""
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 1a5ab361e9f3..23e8dd9ebcda 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -56,6 +56,7 @@ COMMAND_LIST(
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
+	ENTRY("list-subsys", "List nvme subsystems", list_subsys)
 );
 
 #endif
diff --git a/nvme-print.c b/nvme-print.c
index d50c3b6084fb..81fa4f50ec9f 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1867,6 +1867,55 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	json_free_object(root);
 }
 
+void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
+{
+	struct json_object *root;
+	struct json_array *subsystems;
+	struct json_object *subsystem_attrs;
+	struct json_array *paths;
+	struct json_object *path_attrs;
+	struct json_object *path_object;
+	int i, j;
+
+	root = json_create_object();
+	subsystems = json_create_array();
+
+	for (i = 0; i < n; i++) {
+		subsystem_attrs = json_create_object();
+
+		json_object_add_value_string(subsystem_attrs,
+					     "Name", slist[i].name);
+		json_object_add_value_string(subsystem_attrs,
+					     "NQN", slist[i].subsysnqn);
+
+		json_array_add_value_object(subsystems, subsystem_attrs);
+
+		paths = json_create_array();
+		path_object = json_create_object();
+
+		for (j = 0; j < slist[i].nctrls; j++) {
+			path_attrs = json_create_object();
+			json_object_add_value_string(path_attrs, "Name",
+					slist[i].ctrls[j].name);
+			json_object_add_value_string(path_attrs, "Transport",
+					slist[i].ctrls[j].transport);
+			json_object_add_value_string(path_attrs, "Address",
+					slist[i].ctrls[j].address);
+			json_array_add_value_object(paths, path_attrs);
+		}
+		if (j) {
+			json_object_add_value_array(path_object, "Paths",
+					paths);
+			json_array_add_value_object(subsystems, path_object);
+		}
+
+	}
+
+	if (i)
+		json_object_add_value_array(root, "Subsystems", subsystems);
+	json_print_object(root, NULL);
+}
+
 void show_registers_cap(struct nvme_bar_cap *cap)
 {
 	printf("\tMemory Page Size Maximum      (MPSMAX): %u bytes\n", 1 <<  (12 + ((cap->mpsmax_mpsmin & 0xf0) >> 4)));
diff --git a/nvme-print.h b/nvme-print.h
index d110b980c461..64bdb7edcbeb 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -43,6 +43,7 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void json_print_list_items(struct list_item *items, unsigned amnt);
 void json_nvme_id_ns_descs(void *data);
+void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n);
 
 
 #endif
diff --git a/nvme.c b/nvme.c
index 7830ea2de4ac..323aca65ee1e 100644
--- a/nvme.c
+++ b/nvme.c
@@ -826,6 +826,346 @@ static void *get_registers(void)
 	return membase;
 }
 
+static const char *subsys_dir = "/sys/class/nvme-subsystem/";
+
+static char *get_nvme_subsnqn(char *path)
+{
+	char sspath[319];
+	char *subsysnqn;
+	int fd;
+	int ret;
+
+	snprintf(sspath, sizeof(sspath), "%s/subsysnqn", path);
+
+	fd = open(sspath, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+
+	subsysnqn = calloc(1, 256);
+	if (!subsysnqn)
+		goto close_fd;
+
+	ret = read(fd, subsysnqn, 256);
+	if (ret < 0) {
+		free(subsysnqn);
+		subsysnqn = NULL;
+	}
+
+	if (subsysnqn[strlen(subsysnqn) - 1] == '\n')
+		subsysnqn[strlen(subsysnqn) - 1] = '\0';
+
+close_fd:
+	close(fd);
+
+	return subsysnqn;
+}
+
+static char *get_nvme_ctrl_transport(char *path)
+{
+	char *trpath;
+	char *transport;
+	int fd;
+	ssize_t ret;
+
+	ret = asprintf(&trpath, "%s/transport", path);
+	if (ret < 0)
+		return NULL;
+
+	transport = calloc(1, 1024);
+	if (!transport)
+		goto err_free_trpath;
+
+	fd = open(trpath, O_RDONLY);
+	if (fd < 0)
+		goto err_free_tr;
+
+	ret = read(fd, transport, 1024);
+	if (ret < 0)
+		goto err_close_fd;
+
+	if (transport[strlen(transport) - 1] == '\n')
+		transport[strlen(transport) - 1] = '\0';
+
+	close(fd);
+	free(trpath);
+
+	return transport;
+
+err_close_fd:
+	close(fd);
+err_free_tr:
+	free(transport);
+err_free_trpath:
+	free(trpath);
+
+	return NULL;
+}
+
+static char *get_nvme_ctrl_address(char *path)
+{
+	char *addrpath;
+	char *address;
+	int fd;
+	ssize_t ret;
+	int i;
+
+	ret = asprintf(&addrpath, "%s/address", path);
+	if (ret < 0)
+		return NULL;
+
+	address = calloc(1, 1024);
+	if (!address)
+		goto err_free_addrpath;
+
+	fd = open(addrpath, O_RDONLY);
+	if (fd < 0)
+		goto err_free_addr;
+
+	ret = read(fd, address, 1024);
+	if (ret < 0)
+		goto err_close_fd;
+
+	if (address[strlen(address) - 1] == '\n')
+		address[strlen(address) - 1] = '\0';
+
+	for (i = 0; i < strlen(address); i++) {
+		if (address[i] == ',' )
+			address[i] = ' ';
+	}
+
+	close(fd);
+	free(addrpath);
+
+	return address;
+
+err_close_fd:
+	close(fd);
+err_free_addr:
+	free(address);
+err_free_addrpath:
+	free(addrpath);
+
+	return NULL;
+}
+static int scan_ctrls_filter(const struct dirent *d)
+{
+	int id, nsid;
+
+	if (d->d_name[0] == '.')
+		return 0;
+
+	if (strstr(d->d_name, "nvme")) {
+		if (sscanf(d->d_name, "nvme%dn%d", &id, &nsid) == 2)
+			return 0;
+		return 1;
+	}
+
+	return 0;
+}
+
+void print_nvme_subsystem(struct subsys_list_item *item)
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
+void print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		print_nvme_subsystem(&slist[i]);
+}
+
+int get_nvme_subsystem_info(char *name, char *path,
+				struct subsys_list_item *item)
+{
+	char ctrl_path[512];
+	struct dirent **ctrls;
+	int n, i;
+
+	item->subsysnqn = get_nvme_subsnqn(path);
+	if (!item->subsysnqn)
+		return 1;
+
+	item->name = strdup(name);
+
+	n = scandir(path, &ctrls, scan_ctrls_filter, alphasort);
+	if (n < 0)
+		goto free_subysynqn;
+
+	item->ctrls = calloc(n, sizeof(struct ctrl_list_item));
+	if (!item->ctrls)
+		goto free_ctrls;
+
+	item->nctrls = n;
+
+	for (i = 0; i < n; i++) {
+		item->ctrls[i].name = strdup(ctrls[i]->d_name);
+
+		snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path,
+			 item->ctrls[i].name);
+
+		item->ctrls[i].address = get_nvme_ctrl_address(ctrl_path);
+		if (!item->ctrls[i].address) {
+			free(item->ctrls[i].name);
+			goto free_ctrl_list;
+		}
+
+		item->ctrls[i].transport = get_nvme_ctrl_transport(ctrl_path);
+		if (!item->ctrls[i].transport) {
+			free(item->ctrls[i].name);
+			free(item->ctrls[i].address);
+			goto free_ctrl_list;
+		}
+	}
+
+	for (i = 0; i < n; i++)
+		free(ctrls[i]);
+	free(ctrls);
+
+	return 0;
+
+free_ctrl_list:
+	free(item->ctrls);
+
+free_ctrls:
+	for (i = 0; i < n; i++)
+		free(ctrls[i]);
+	free(ctrls);
+
+free_subysynqn:
+	free(item->subsysnqn);
+	free(item->name);
+
+	return 1;
+}
+
+static int scan_subsys_filter(const struct dirent *d)
+{
+	char path[310];
+	struct stat ss;
+	int id;
+	int tmp;
+
+	if (d->d_name[0] == '.')
+		return 0;
+
+	/* sanity checking, probably unneeded */
+	if (strstr(d->d_name, "nvme-subsys")) {
+		snprintf(path, sizeof(path), "%s%s", subsys_dir, d->d_name);
+		if (stat(path, &ss))
+			return 0;
+		if (!S_ISDIR(ss.st_mode))
+			return 0;
+		tmp = sscanf(d->d_name, "nvme-subsys%d", &id);
+		if (tmp != 1)
+			return 0;
+		return 1;
+	}
+
+	return 0;
+}
+
+static void free_subsys_list_item(struct subsys_list_item *item)
+{
+	int i;
+
+	for (i = 0; i < item->nctrls; i++) {
+		free(item->ctrls[i].name);
+		free(item->ctrls[i].transport);
+		free(item->ctrls[i].address);
+	}
+
+	free(item->ctrls);
+	free(item->subsysnqn);
+	free(item->name);
+}
+
+static void free_subsys_list(struct subsys_list_item *slist, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		free_subsys_list_item(&slist[i]);
+
+	free(slist);
+}
+
+static int list_subsys(int argc, char **argv, struct command *cmd,
+		       struct plugin *plugin)
+{
+	char path[310];
+	struct dirent **subsys;
+	struct subsys_list_item *slist;
+	int fmt, n, i, ret = 0;
+	const char *desc = "Retrieve information for subsystems";
+	struct config {
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options opts[] = {
+		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format,
+			required_argument, "Output Format: normal|json"},
+		{NULL}
+	};
+
+	ret = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
+	if (ret < 0)
+		return ret;
+
+	fmt = validate_output_format(cfg.output_format);
+
+	if (fmt != JSON && fmt != NORMAL)
+		return -EINVAL;
+	n = scandir(subsys_dir, &subsys, scan_subsys_filter, alphasort);
+	if (n < 0) {
+		fprintf(stderr, "no NVMe subsystem(s) detected.\n");
+		return n;
+	}
+
+	slist = calloc(n, sizeof(struct subsys_list_item));
+	if (!slist) {
+		ret = ENOMEM;
+		goto free_subsys;
+	}
+
+	for (i = 0; i < n; i++) {
+		snprintf(path, sizeof(path), "%s%s", subsys_dir,
+			subsys[i]->d_name);
+		ret = get_nvme_subsystem_info(subsys[i]->d_name, path, &slist[i]);
+		if (ret)
+			goto free_subsys;
+	}
+
+	if (fmt == JSON)
+		json_print_nvme_subsystem_list(slist, n);
+	else
+		print_nvme_subsystem_list(slist, n);
+
+free_subsys:
+	free_subsys_list(slist, n);
+
+	for (i = 0; i < n; i++)
+		free(subsys[i]);
+	free(subsys);
+
+	return ret;
+}
+
 static void print_list_item(struct list_item list_item)
 {
 	long long int lba = 1 << list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ds;
diff --git a/nvme.h b/nvme.h
index ec68f1748128..b134be1e251c 100644
--- a/nvme.h
+++ b/nvme.h
@@ -117,6 +117,19 @@ struct list_item {
 	unsigned            block;
 };
 
+struct ctrl_list_item {
+	char *name;
+	char *address;
+	char *transport;
+};
+
+struct subsys_list_item {
+	char *name;
+	char *subsysnqn;
+	int nctrls;
+	struct ctrl_list_item *ctrls;
+};
+
 enum {
 	NORMAL,
 	JSON,
-- 
2.13.6
