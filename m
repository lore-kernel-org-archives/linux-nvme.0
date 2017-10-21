From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 21 Oct 2017 13:23:16 +0900
Subject: [PATCH] nvme-cli: make address print format more human-readable
Message-ID: <1508559796-7605-1-git-send-email-minwoo.im.dev@gmail.com>

Memory address would be great in hexadecimal format to be read easily.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 9636467..df4ed59 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1255,8 +1255,8 @@ static void show_auto_pst(struct nvme_auto_pst *apst)
 static void show_host_mem_buffer(struct nvme_host_mem_buffer *hmb)
 {
 	printf("\tHost Memory Descriptor List Entry Count (HMDLEC): %u\n", hmb->hmdlec);
-	printf("\tHost Memory Descriptor List Address     (HMDLAU): %u\n", hmb->hmdlau);
-	printf("\tHost Memory Descriptor List Address     (HMDLAL): %u\n", hmb->hmdlal);
+	printf("\tHost Memory Descriptor List Address     (HMDLAU): 0x%x\n", hmb->hmdlau);
+	printf("\tHost Memory Descriptor List Address     (HMDLAL): 0x%x\n", hmb->hmdlal);
 	printf("\tHost Memory Buffer Size                  (HSIZE): %u\n", hmb->hsize);
 }
 
-- 
2.7.4
