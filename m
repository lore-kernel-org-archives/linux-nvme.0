From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:36 -0800
Subject: [PATCH 6/7] nvme-cli: fw-log: Fix memory leak for JSON.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-7-git-send-email-chaitanya.kulkarni@hgst.com>

This patch fixes the following memory leak when fw-log command
executed with JSON option:-
==7822==
==7822== HEAP SUMMARY:
==7822==     in use at exit: 1,104 bytes in 38 blocks
==7822==   total heap usage: 75 allocs, 37 frees, 5,103 bytes allocated
==7822==
==7822== LEAK SUMMARY:
==7822==    definitely lost: 24 bytes in 1 blocks
==7822==    indirectly lost: 1,080 bytes in 37 blocks
==7822==      possibly lost: 0 bytes in 0 blocks
==7822==    still reachable: 0 bytes in 0 blocks
==7822==         suppressed: 0 bytes in 0 blocks

Fix:-
==8436==
==8436== HEAP SUMMARY:
==8436==     in use at exit: 0 bytes in 0 blocks
==8436==   total heap usage: 75 allocs, 75 frees, 5,103 bytes allocated
==8436==

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 5bcd307..3d8b32c 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1447,6 +1447,8 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
 
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(fwsi);
+	json_free_object(root);
 }
 
 void json_add_smart_log(struct nvme_additional_smart_log *smart,
-- 
1.9.1
