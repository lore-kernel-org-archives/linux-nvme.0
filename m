From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:22 -0700
Subject: [PATCH v2 10/11] nvmet: Provide adding AENs for multiple controller
 types
In-Reply-To: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1539709883-12424-11-git-send-email-jay.e.sternberg@intel.com>

From: Phil Cayton <phil.cayton@intel.com>

Make nvmet_add_async_event a non-static function in preparation
for use by other controllers, initally the discovery controller.

Signed-off-by: Phil Cayton <phil.cayton at intel.com>
Reviewed-by: Jay Sternberg <jay.e.sternberg at intel.com>
---
v2 - unchanged

 drivers/nvme/target/core.c  | 2 +-
 drivers/nvme/target/nvmet.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 67ea1d2..e9f9996 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,7 +129,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	}
 }
 
-static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 0a65415..9bb546d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -422,6 +422,8 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 
 extern struct list_head *nvmet_ports;
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page);
 
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
-- 
1.8.3.1
