From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 12:00:56 +0300
Subject: [PATCH 7/9] nvme-print: Introduce show_nvme_ctrl helper
In-Reply-To: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
References: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558602058-29434-8-git-send-email-maxg@mellanox.com>

This is a preparation patch for adding namespaces attribute for each
controller.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme-print.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 7316117..7e1f9ea 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2843,6 +2843,13 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 	json_free_object(root);
 }
 
+static void show_nvme_ctrl(struct ctrl_list_item *item)
+{
+	printf(" +- %s %s %s %s\n", item->name, item->transport, item->address,
+	       item->state);
+}
+
+
 static void show_nvme_subsystem(struct subsys_list_item *item)
 {
 	int i;
@@ -2850,13 +2857,8 @@ static void show_nvme_subsystem(struct subsys_list_item *item)
 	printf("%s - NQN=%s\n", item->name, item->subsysnqn);
 	printf("\\\n");
 
-	for (i = 0; i < item->nctrls; i++) {
-		printf(" +- %s %s %s %s\n", item->ctrls[i].name,
-				item->ctrls[i].transport,
-				item->ctrls[i].address,
-				item->ctrls[i].state);
-	}
-
+	for (i = 0; i < item->nctrls; i++)
+		show_nvme_ctrl(&item->ctrls[i]);
 }
 
 void show_nvme_subsystem_list(struct subsys_list_item *slist, int n)
-- 
1.8.3.1
