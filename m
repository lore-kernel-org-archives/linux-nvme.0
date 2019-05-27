From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 27 May 2019 13:01:49 +0300
Subject: [PATCH 8/9] nvme-print: Rename "Paths" --> "Ctrls" for json output in
 list-subsys
In-Reply-To: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558951310-31066-9-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme-print.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 7e1f9ea..b3f08cf 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2904,10 +2904,8 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
 					slist[i].ctrls[j].state);
 			json_array_add_value_object(paths, path_attrs);
 		}
-		if (j) {
-			json_object_add_value_array(subsystem_attrs, "Paths", paths);
-		}
-
+		if (j)
+			json_object_add_value_array(subsystem_attrs, "Ctrls", paths);
 	}
 
 	if (i)
-- 
1.8.3.1
