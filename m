From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:37 -0800
Subject: [PATCH 7/7] nvme-cli: json_add_smart_log(): Fix memory leak for JSON.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-8-git-send-email-chaitanya.kulkarni@hgst.com>

This patch fixes the following memory leak for json_add_smart_log()
when used by the external function:-
==8637== HEAP SUMMARY:
==8637==     in use at exit: 1,807 bytes in 56 blocks
==8637==   total heap usage: 101 allocs, 45 frees, 6,577 bytes allocated
==8637==
==8637== LEAK SUMMARY:
==8637==    definitely lost: 24 bytes in 1 blocks
==8637==    indirectly lost: 1,783 bytes in 55 blocks
==8637==      possibly lost: 0 bytes in 0 blocks
==8637==    still reachable: 0 bytes in 0 blocks
==8637==         suppressed: 0 bytes in 0 blocks

Fix:-
==8667== HEAP SUMMARY:
==8667==     in use at exit: 0 bytes in 0 blocks
==8667==   total heap usage: 101 allocs, 152 frees, 6,577 bytes allocated
==8667==

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 3d8b32c..b466aee 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1500,6 +1500,8 @@ void json_add_smart_log(struct nvme_additional_smart_log *smart,
 	snprintf(fmt, sizeof(fmt), "Additional Smart Log for %s", devname);
 	json_object_add_value_object(root, fmt, data);
 	json_print_object(root, NULL);
+	json_free_object(data);
+	json_free_object(root);
 }
 
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname)
-- 
1.9.1
