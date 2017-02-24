From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:32 -0800
Subject: [PATCH 2/7] nvme-cli: id-ns: Fix memory leak for JSON.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-3-git-send-email-chaitanya.kulkarni@hgst.com>

This patch fixes the following memory leak when id-ns command
executed with JSON option:-
==7642==
==7642== HEAP SUMMARY:
==7642==     in use at exit: 3,297 bytes in 120 blocks
==7642==   total heap usage: 182 allocs, 62 frees, 9,204 bytes allocated
==7642==
==7642== LEAK SUMMARY:
==7642==    definitely lost: 24 bytes in 1 blocks
==7642==    indirectly lost: 3,273 bytes in 119 blocks
==7642==      possibly lost: 0 bytes in 0 blocks
==7642==    still reachable: 0 bytes in 0 blocks
==7642==         suppressed: 0 bytes in 0 blocks
==7642== Rerun with --leak-check=full to see details of leaked memory
==7642==

Fix:-
==7949==
==7949== HEAP SUMMARY:
==7949==     in use at exit: 0 bytes in 0 blocks
==7949==   total heap usage: 182 allocs, 182 frees, 9,204 bytes allocated
==7949==

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index bcc67ff..5cdc327 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1256,6 +1256,7 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(root);
 }
 
 void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
-- 
1.9.1
