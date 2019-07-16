From: jsmart2021@gmail.com (James Smart)
Date: Tue, 16 Jul 2019 14:12:35 -0700
Subject: [PATCH 04/10] nvme-cli: Refactor to create a get_nvme_ctrl_info
 routine
In-Reply-To: <20190716211241.7650-1-jsmart2021@gmail.com>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
Message-ID: <20190716211241.7650-5-jsmart2021@gmail.com>

In preparation for searching controllers to match with connect args:

Refactor the get_nvme_subsystem_info() routine to take the portion
that creates a ctrl_list_item and sets its values and put it in a
separate get_nvme_ctrl_info() routine.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvme.c | 77 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/nvme.c b/nvme.c
index 6fe99eb..dabbbe0 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1544,10 +1544,50 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 	free(ctrls->ana_state);
 }
 
+static int get_nvme_ctrl_info(char *name, char *path,
+			struct ctrl_list_item *ctrl, __u32 nsid)
+{
+	char ctrl_path[512];
+
+	ctrl->name = strdup(name);
+
+	snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path, ctrl->name);
+
+	ctrl->address = get_nvme_ctrl_attr(ctrl_path, "address");
+	if (!ctrl->address) {
+		fprintf(stderr, "%s: failed to get controller address.\n",
+			ctrl->name);
+		goto free_ctrl_items;
+	}
+
+	ctrl->transport = get_nvme_ctrl_attr(ctrl_path, "transport");
+	if (!ctrl->transport) {
+		fprintf(stderr, "%s: failed to get controller transport.\n",
+			ctrl->name);
+		goto free_ctrl_items;
+	}
+
+	ctrl->state = get_nvme_ctrl_attr(ctrl_path, "state");
+	if (!ctrl->state) {
+		fprintf(stderr, "%s: failed to get controller state.\n",
+			ctrl->name);
+		goto free_ctrl_items;
+	}
+
+	if (nsid != NVME_NSID_ALL)
+		ctrl->ana_state = get_nvme_ctrl_path_ana_state(ctrl_path, nsid);
+
+	return 0;	/* success */
+
+free_ctrl_items:
+	free_ctrl_list_item(ctrl);
+
+	return 1;	/* failure */
+}
+
 static int get_nvme_subsystem_info(char *name, char *path,
 				struct subsys_list_item *item, __u32 nsid)
 {
-	char ctrl_path[512];
 	struct dirent **ctrls;
 	int n, i, ret = 1, ccnt = 0;
 
@@ -1574,38 +1614,11 @@ static int get_nvme_subsystem_info(char *name, char *path,
 	item->nctrls = n;
 
 	for (i = 0; i < n; i++) {
-		item->ctrls[ccnt].name = strdup(ctrls[i]->d_name);
-
-		snprintf(ctrl_path, sizeof(ctrl_path), "%s/%s", path,
-			 item->ctrls[ccnt].name);
-
-		item->ctrls[ccnt].address =
-				get_nvme_ctrl_attr(ctrl_path, "address");
-		if (!item->ctrls[ccnt].address) {
-			fprintf(stderr, "failed to get controller[%d] address.\n", i);
-			free_ctrl_list_item(&item->ctrls[ccnt]);
-			continue;
+		if (get_nvme_ctrl_info(ctrls[i]->d_name, path,
+				&item->ctrls[ccnt], nsid)) {
+			fprintf(stderr, "failed to get controller[%d] info.\n",
+					i);
 		}
-
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
-		if (nsid != NVME_NSID_ALL)
-			item->ctrls[ccnt].ana_state =
-				get_nvme_ctrl_path_ana_state(ctrl_path, nsid);
 		ccnt++;
 	}
 
-- 
2.13.7
