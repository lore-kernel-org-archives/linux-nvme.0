From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 Aug 2018 09:29:07 +0200
Subject: [PATCH 5/6] nvme-list-subsys: Print PCIe controller address
In-Reply-To: <20180817072908.56784-1-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
Message-ID: <20180817072908.56784-6-hare@suse.de>

An NVMe PCIe controller doesn't have an address, so we should be
using the PCIe bus address.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvme.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/nvme.c b/nvme.c
index 99640cb..0438187 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1314,6 +1314,44 @@ err_free_trpath:
 	return NULL;
 }
 
+static char *get_nvme_pcie_address(char *path)
+{
+	char *devpath, *devlink, *str;
+	char *address = NULL;
+	ssize_t ret;
+
+	ret = asprintf(&devpath, "%s/device", path);
+	if (ret < 0)
+		return NULL;
+
+	devlink = calloc(1, 1024);
+	if (!devlink) {
+		free(devpath);
+		return NULL;
+	}
+
+	ret = readlink(devpath, devlink, 1024);
+	if (ret < 0) {
+		fprintf(stderr, "failed to read link %s, error %d\n",
+			devpath, (int)ret);
+		goto out;
+	}
+	str = strrchr(devlink, '/');
+	if (!str) {
+		fprintf(stderr, "invalid devlink %s\n", devlink);
+		goto out;
+	}
+	ret = asprintf(&address, "%s", str + 1);
+	if (ret < 0)
+		address = NULL;
+
+out:
+	free(devlink);
+	free(devpath);
+
+	return address;
+}
+
 static char *get_nvme_ctrl_address(char *path)
 {
 	char *addrpath;
@@ -1418,13 +1456,6 @@ int get_nvme_subsystem_info(char *name, char *path,
 		snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path,
 			 item->ctrls[ccnt].name);
 
-		item->ctrls[ccnt].address = get_nvme_ctrl_address(ctrl_path);
-		if (!item->ctrls[ccnt].address) {
-			fprintf(stderr, "failed to get controller[%d] address.\n", i);
-			free_ctrl_list_item(&item->ctrls[ccnt]);
-			continue;
-		}
-
 		item->ctrls[ccnt].transport =
 				get_nvme_ctrl_transport(ctrl_path);
 		if (!item->ctrls[ccnt].transport) {
@@ -1433,6 +1464,18 @@ int get_nvme_subsystem_info(char *name, char *path,
 			continue;
 		}
 
+		if (!strncmp(item->ctrls[ccnt].transport, "pcie", 4))
+			item->ctrls[ccnt].address =
+				get_nvme_pcie_address(ctrl_path);
+		else
+			item->ctrls[ccnt].address =
+				get_nvme_ctrl_address(ctrl_path);
+		if (!item->ctrls[ccnt].address) {
+			fprintf(stderr, "failed to get controller[%d] address.\n", i);
+			free_ctrl_list_item(&item->ctrls[ccnt]);
+			continue;
+		}
+
 		ccnt++;
 	}
 
-- 
2.13.7
