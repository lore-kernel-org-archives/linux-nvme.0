From: jsmart2021@gmail.com (James Smart)
Date: Mon, 11 Sep 2017 16:14:50 -0700
Subject: [PATCH] nvmet: bump NVMET_NR_QUEUES to 128
Message-ID: <20170911231450.20409-1-jsmart2021@gmail.com>

Raise the max number of IO queues to 128. There are several hosts with
more than 64 cpus/threads.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7b8e20adf760..e342f02845c1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -314,7 +314,7 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 
 #define NVMET_QUEUE_SIZE	1024
-#define NVMET_NR_QUEUES		64
+#define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
-- 
2.13.1
