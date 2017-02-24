From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:31 -0800
Subject: [PATCH 1/7] nvme-cli: id-ctrl: Fix memory leak for JSON.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-2-git-send-email-chaitanya.kulkarni@hgst.com>

This patch fixes the following memory leak when id-ctrl command
executed with JSON option:-
==7680==
==7680== HEAP SUMMARY:
==7680==     in use at exit: 9,796 bytes in 338 blocks
==7680==   total heap usage: 474 allocs, 136 frees, 24,729 bytes allocated
==7680==
==7680== LEAK SUMMARY:
==7680==    definitely lost: 24 bytes in 1 blocks
==7680==    indirectly lost: 9,772 bytes in 337 blocks
==7680==      possibly lost: 0 bytes in 0 blocks
==7680==    still reachable: 0 bytes in 0 blocks
==7680==         suppressed: 0 bytes in 0 blocks

Fix:-
==7971==
==7971== HEAP SUMMARY:
==7971==     in use at exit: 0 bytes in 0 blocks
==7971==   total heap usage: 474 allocs, 474 frees, 24,729 bytes allocated
==7971==

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index 2467d27..bcc67ff 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1354,6 +1354,7 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
 
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(root);
 }
 
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname)
-- 
1.9.1
