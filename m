From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 27 May 2019 13:01:50 +0300
Subject: [PATCH 9/9] nvme: Retrieve namespaces during list-subsys cmd
In-Reply-To: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558951310-31066-10-git-send-email-maxg@mellanox.com>

Add an association between subsystems/ctrls/namespaces using
"nvme list-subsys" command. Now this command will show the following
(notice that nvme-subsys4 is a dual controller subsystem that runs a
native multipath configuration. Hidden block devices not presented):

nvme-subsys3 - NQN=nqn.2014.08.org.nvmexpress:80868086CVCQ5234001C400AGN INTEL SSDPEDMW400G4
\
 +- nvme0 pcie 0000:08:00.0 live
 \
  +- nvme3n1
nvme-subsys4 - NQN=testsubsystem_0
\
 +- nvme4 rdma traddr=1.212.99.85 trsvcid=4420 live
 \
  +- nvme4n1
  +- nvme4n2
  +- nvme4n3
 +- nvme5 rdma traddr=1.212.99.85 trsvcid=4420 live
 \
  +- nvme4n1
  +- nvme4n2
  +- nvme4n3

Instead of:
----------------
nvme-subsys3 - NQN=nqn.2014.08.org.nvmexpress:80868086CVCQ5234001C400AGN INTEL SSDPEDMW400G4
\
 +- nvme0 pcie 0000:08:00.0
nvme-subsys4 - NQN=testsubsystem_0
\
 +- nvme4 rdma traddr=1.212.99.85 trsvcid=4420
 +- nvme5 rdma traddr=1.212.99.85 trsvcid=4420

The new json output is (partial):
--------------------------
{
      "Name" : "nvme-subsys4",
      "NQN" : "testsubsystem_0",
      "Ctrls" : [
        {
          "Name" : "nvme4",
          "Transport" : "rdma",
          "Address" : "traddr=1.212.99.85 trsvcid=4420",
          "State" : "live",
          "Namespaces" : [
            {
              "Name" : "nvme4n1"
            },
            {
              "Name" : "nvme4n2"
            },
            {
              "Name" : "nvme4n3"
            }
          ]
        },
        {
          "Name" : "nvme5",
          "Transport" : "rdma",
          "Address" : "traddr=1.212.99.85 trsvcid=4420",
          "State" : "live",
          "Namespaces" : [
            {
              "Name" : "nvme4n1"
            },
            {
              "Name" : "nvme4n2"
            },
            {
              "Name" : "nvme4n3"
            }
          ]
        }
      ]
}

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme-print.c |  23 ++++++++++-
 nvme.c       | 130 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 nvme.h       |   6 +++
 3 files changed, 130 insertions(+), 29 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index b3f08cf..7625559 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2845,8 +2845,15 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 
 static void show_nvme_ctrl(struct ctrl_list_item *item)
 {
+	int i;
+
 	printf(" +- %s %s %s %s\n", item->name, item->transport, item->address,
 	       item->state);
+	for (i = 0; i < item->ns_num; i++) {
+		if (!i)
+			printf(" \\\n");
+		printf("  +- %s\n", item->namespaces[i].name);
+	}
 }
 
 
@@ -2875,7 +2882,9 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 	struct json_object *subsystem_attrs;
 	struct json_array *paths;
 	struct json_object *path_attrs;
-	int i, j;
+	struct json_array *namespaces;
+	struct json_object *ns_attrs;
+	int i, j, k;
 
 	root = json_create_object();
 	subsystems = json_create_array();
@@ -2902,6 +2911,18 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 					slist[i].ctrls[j].address);
 			json_object_add_value_string(path_attrs, "State",
 					slist[i].ctrls[j].state);
+
+			namespaces = json_create_array();
+			for (k = 0; k < slist[i].ctrls[j].ns_num; k++) {
+				ns_attrs = json_create_object();
+				json_object_add_value_string(ns_attrs, "Name",
+							     slist[i].ctrls[j].namespaces[k].name);
+				json_array_add_value_object(namespaces, ns_attrs);
+			}
+			if (k)
+				json_object_add_value_array(path_attrs, "Namespaces",
+							    namespaces);
+
 			json_array_add_value_object(paths, path_attrs);
 		}
 		if (j)
diff --git a/nvme.c b/nvme.c
index 518a396..ef01ead 100644
--- a/nvme.c
+++ b/nvme.c
@@ -60,6 +60,9 @@ const char *devicename;
 
 static const char nvme_version_string[] = NVME_VERSION;
 
+static void free_ctrl_list_item(struct ctrl_list_item *ctrls);
+static char *get_nvme_ctrl_attr(char *path, const char *attr);
+
 #define CREATE_CMD
 #include "nvme-builtin.h"
 
@@ -1313,6 +1316,82 @@ static void *get_registers(void)
 
 static const char *subsys_dir = "/sys/class/nvme-subsystem/";
 
+static int scan_ns_filter(const struct dirent *d)
+{
+	int id, nsid;
+
+	if (strstr(d->d_name, "nvme")) {
+		if (sscanf(d->d_name, "nvme%dn%d", &id, &nsid) == 2)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int get_nvme_ctrl_info(char *name, char *ctrl_path,
+			      struct ctrl_list_item *item, int heads_num,
+			      struct dirent **heads)
+{
+	struct dirent **namespaces;
+	int ret = 0, n, i;
+
+	item->name = strdup(name);
+
+	if (heads_num) {
+		n = heads_num;
+		namespaces = heads;
+	} else {
+		n = scandir(ctrl_path, &namespaces, scan_ns_filter, alphasort);
+		if (n < 0) {
+			fprintf(stderr, "failed to scan namespace(s).\n");
+			return n;
+		}
+	}
+
+	item->namespaces = calloc(n, sizeof(struct ns_list_item));
+	if (!item->namespaces) {
+		ret = -ENOMEM;
+		fprintf(stderr, "failed to allocate controller namespace(s)\n");
+		goto free_namespaces;
+	}
+
+	item->ns_num = n;
+
+	for (i = 0; i < n; i++)
+		item->namespaces[i].name = strdup(namespaces[i]->d_name);
+
+	item->address = get_nvme_ctrl_attr(ctrl_path, "address");
+	if (!item->address) {
+		fprintf(stderr, "failed to get %s address.\n", name);
+		free_ctrl_list_item(item);
+		ret = -EAGAIN;
+		goto free_namespaces;
+	}
+	item->transport = get_nvme_ctrl_attr(ctrl_path, "transport");
+	if (!item->transport) {
+		fprintf(stderr, "failed to get %s transport.\n", name);
+		free_ctrl_list_item(item);
+		ret = -EAGAIN;
+		goto free_namespaces;
+	}
+	item->state = get_nvme_ctrl_attr(ctrl_path, "state");
+	if (!item->state) {
+		fprintf(stderr, "failed to get %s state.\n", name);
+		free_ctrl_list_item(item);
+		ret = -EAGAIN;
+		goto free_namespaces;
+	}
+
+free_namespaces:
+	if (!heads) {
+		for (i = 0; i < n; i++)
+			free(namespaces[i]);
+		free(namespaces);
+	}
+
+	return ret;
+}
+
 static char *get_nvme_subsnqn(char *path)
 {
 	char sspath[320];
@@ -1419,10 +1498,15 @@ static int scan_ctrls_filter(const struct dirent *d)
 
 static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 {
+	int i;
+
 	free(ctrls->name);
 	free(ctrls->transport);
 	free(ctrls->address);
 	free(ctrls->state);
+	for (i = 0; i < ctrls->ns_num; i++)
+		free(ctrls->namespaces[i].name);
+	free(ctrls->namespaces);
 }
 
 static int get_nvme_subsystem_info(char *name, char *path,
@@ -1430,7 +1514,8 @@ static int get_nvme_subsystem_info(char *name, char *path,
 {
 	char ctrl_path[512];
 	struct dirent **ctrls;
-	int n, i, ret = 1, ccnt = 0;
+	struct dirent **heads;
+	int n, heads_num, i, ret = 1, ccnt = 0;
 
 	item->subsysnqn = get_nvme_subsnqn(path);
 	if (!item->subsysnqn) {
@@ -1454,43 +1539,32 @@ static int get_nvme_subsystem_info(char *name, char *path,
 
 	item->nctrls = n;
 
+	heads_num = scandir(path, &heads, scan_ns_filter, alphasort);
+	if (heads_num < 0) {
+		fprintf(stderr, "failed to scan heads(s).\n");
+		goto free_ctrls;
+	}
+
 	for (i = 0; i < n; i++) {
-		item->ctrls[ccnt].name = strdup(ctrls[i]->d_name);
 
 		snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path,
-			 item->ctrls[ccnt].name);
-
-		item->ctrls[ccnt].address =
-				get_nvme_ctrl_attr(ctrl_path, "address");
-		if (!item->ctrls[ccnt].address) {
-			fprintf(stderr, "failed to get controller[%d] address.\n", i);
-			free_ctrl_list_item(&item->ctrls[ccnt]);
-			continue;
-		}
+			 ctrls[i]->d_name);
 
-		item->ctrls[ccnt].transport =
-				get_nvme_ctrl_attr(ctrl_path, "transport");
-		if (!item->ctrls[ccnt].transport) {
-			fprintf(stderr, "failed to get controller[%d] transport.\n", i);
-			free_ctrl_list_item(&item->ctrls[ccnt]);
-			continue;
-		}
-
-		item->ctrls[ccnt].state =
-				get_nvme_ctrl_attr(ctrl_path, "state");
-		if (!item->ctrls[ccnt].state) {
-			fprintf(stderr, "failed to get controller[%d] state.\n", i);
-			free_ctrl_list_item(&item->ctrls[ccnt]);
-			continue;
-		}
-
-		ccnt++;
+		ret = get_nvme_ctrl_info(ctrls[i]->d_name, ctrl_path,
+					 &(item->ctrls[ccnt]), heads_num, heads);
+		if (!ret)
+			ccnt++;
 	}
 
 	item->nctrls = ccnt;
 
 	ret = 0;
 
+	if (heads_num) {
+		for (i = 0; i < heads_num; i++)
+			free(heads[i]);
+		free(heads);
+	}
 free_ctrls:
 	for (i = 0; i < n; i++)
 		free(ctrls[i]);
diff --git a/nvme.h b/nvme.h
index 7c444a4..84eaa9f 100644
--- a/nvme.h
+++ b/nvme.h
@@ -142,11 +142,17 @@ struct list_item {
 	unsigned            block;
 };
 
+struct ns_list_item {
+	char *name;
+};
+
 struct ctrl_list_item {
 	char *name;
 	char *address;
 	char *transport;
 	char *state;
+	int ns_num;
+	struct ns_list_item *namespaces;
 };
 
 struct subsys_list_item {
-- 
1.8.3.1
