From: yi.zhang@redhat.com (Yi Zhang)
Date: Thu, 20 Sep 2018 19:41:57 +0800
Subject: [PATCH] nvme-cli: print "\n" after nvme list-subsys -o json
Message-ID: <20180920114157.6043-1-yi.zhang@redhat.com>

Signed-off-by: Yi Zhang <yi.zhang at redhat.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index 17b5eaf..df7df4d 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2823,6 +2823,7 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 	if (i)
 		json_object_add_value_array(root, "Subsystems", subsystems);
 	json_print_object(root, NULL);
+	printf("\n");
 }
 
 static void show_registers_cap(struct nvme_bar_cap *cap)
-- 
2.17.1
