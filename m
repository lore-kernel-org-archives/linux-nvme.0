From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 23 Feb 2017 18:39:34 -0800
Subject: [PATCH 4/7] nvme-cli: resv-report: Fix memory leak.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1487903977-11963-5-git-send-email-chaitanya.kulkarni@hgst.com>

 This patch fixes the following memory leak for resv-report command:-
 ==7705==
 ==7705== HEAP SUMMARY:
 ==7705==     in use at exit: 4,096 bytes in 1 blocks
 ==7705==   total heap usage: 31 allocs, 30 frees, 7,941 bytes allocated
 ==7705==
 ==7705== LEAK SUMMARY:
 ==7705==    definitely lost: 4,096 bytes in 1 blocks
 ==7705==    indirectly lost: 0 bytes in 0 blocks
 ==7705==      possibly lost: 0 bytes in 0 blocks
 ==7705==    still reachable: 0 bytes in 0 blocks
 ==7705==         suppressed: 0 bytes in 0 blocks

 Fix:-
 ==8253==
 ==8253== HEAP SUMMARY:
 ==8253==     in use at exit: 0 bytes in 0 blocks
 ==8253==   total heap usage: 31 allocs, 31 frees, 7,941 bytes allocated
 ==8253==

 Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 1 +
 nvme.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 187b164..d93a97c 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1421,6 +1421,7 @@ void json_nvme_resv_report(struct nvme_reservation_status *status)
 
 	json_print_object(root, NULL);
 	printf("\n");
+	json_free_object(root);
 }
 
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
diff --git a/nvme.c b/nvme.c
index 00a6466..4fe908f 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2177,6 +2177,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 			show_nvme_resv_report(status);
 		}
 	}
+	free(status);
 	return err;
 }
 
-- 
1.9.1
