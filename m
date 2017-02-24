From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:35 -0800
Subject: [PATCH 5/7] nvme-cli: smart-log: Fix memory leak for JSON.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-6-git-send-email-chaitanya.kulkarni@hgst.com>

This patch fixes the following memory leak when smart-log command
executed with JSON option:-
==7725== HEAP SUMMARY:
==7725==     in use at exit: 1,661 bytes in 53 blocks
==7725==   total heap usage: 99 allocs, 46 frees, 6,559 bytes allocated
==7725==
==7725== LEAK SUMMARY:
==7725==    definitely lost: 24 bytes in 1 blocks
==7725==    indirectly lost: 1,637 bytes in 52 blocks
==7725==      possibly lost: 0 bytes in 0 blocks
==7725==    still reachable: 0 bytes in 0 blocks
==7725==         suppressed: 0 bytes in 0 blocks

Fix:-
==8322==
==8322== HEAP SUMMARY:
==8322==     in use at exit: 0 bytes in 0 blocks
==8322==   total heap usage: 99 allocs, 99 frees, 6,559 bytes allocated
==8322==

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index d93a97c..5bcd307 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1542,6 +1542,7 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(root);
 }
 
 void show_registers_cap(struct nvme_bar_cap *cap)
-- 
1.9.1
