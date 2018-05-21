From: jsmart2021@gmail.com (James Smart)
Date: Mon, 21 May 2018 16:27:42 -0700
Subject: [PATCH] nvmet-fc: increase LS buffer count per fc port
Message-ID: <20180521232742.10813-1-jsmart2021@gmail.com>

Todays limit on concurrent LS's is very small - 4 buffers. With large
subsystem counts or large numbers of initiators connecting, the limit
may be exceeded.

Raise the LS buffer count to 256.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 33ee8d3145f8..408279cb6f2c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -31,7 +31,7 @@
 /* *************************** Data Structures/Defines ****************** */
 
 
-#define NVMET_LS_CTX_COUNT		4
+#define NVMET_LS_CTX_COUNT		256
 
 /* for this implementation, assume small single frame rqst/rsp */
 #define NVME_FC_MAX_LS_BUFFER_SIZE		2048
-- 
2.13.1
