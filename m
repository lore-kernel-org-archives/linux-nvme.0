From: zouming.zouming@huawei.com (Zou Ming)
Date: Tue, 25 Apr 2017 06:40:21 +0000
Subject: [PATCH] nvme-cli:fix free json object memory after print
Message-ID: <1493102421-18988-1-git-send-email-zouming.zouming@huawei.com>

The json_print_list_items function need to free json object memory after
print,this patch fix it.
---
 nvme-print.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index a86902e..e3c35f4 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1151,6 +1151,8 @@ void json_print_list_items(struct list_item *list_items, unsigned len)
 	}
 	json_object_add_value_array(root, "Devices", devices);
 	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);    
 }
 
 void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
-- 
2.6.4.windows.1
