From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:33 -0800
Subject: [PATCH 3/7] nvme-cli: error-log: Fix memory leak for JSON.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-4-git-send-email-chaitanya.kulkarni@hgst.com>

This patch fixes the following memory leak when error-log command
executed with JSON option:-
==7690==
==7690== HEAP SUMMARY:
==7690==     in use at exit: 49,779 bytes in 1,708 blocks
==7690==   total heap usage: 2,242 allocs, 534 frees, 87,392 bytes allocated
==7690==
==7690== LEAK SUMMARY:
==7690==    definitely lost: 24 bytes in 1 blocks
==7690==    indirectly lost: 49,755 bytes in 1,707 blocks
==7690==      possibly lost: 0 bytes in 0 blocks
==7690==    still reachable: 0 bytes in 0 blocks
==7690==         suppressed: 0 bytes in 0 blocks

Fix:-
==8015==
==8015== HEAP SUMMARY:
==8015==     in use at exit: 0 bytes in 0 blocks
==8015==   total heap usage: 2,242 allocs, 2,242 frees, 87,392 bytes allocated
==8015==

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index 5cdc327..187b164 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1387,6 +1387,7 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(root);
 }
 
 void json_nvme_resv_report(struct nvme_reservation_status *status)
-- 
1.9.1
