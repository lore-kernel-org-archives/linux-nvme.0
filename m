From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 22 May 2019 19:39:48 +0300
Subject: [PATCH 4/9] nvme-print: fix json object memory leak
In-Reply-To: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
References: <1558543193-24752-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558543193-24752-5-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index 2c4822e..6f85e73 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2918,6 +2918,7 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 		json_object_add_value_array(root, "Subsystems", subsystems);
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(root);
 }
 
 static void show_registers_cap(struct nvme_bar_cap *cap)
-- 
1.8.3.1
