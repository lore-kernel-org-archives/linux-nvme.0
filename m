From: amit.engel@dell.com (amit.engel@dell.com)
Date: Thu, 15 Aug 2019 15:43:48 +0300
Subject: [PATCH] nvme/target/admin-cmd.c: Fix a bug in
 'nvmet_execute_get_log_page_error'
Message-ID: <20190815124348.125105-1-amit.engel@dell.com>

From: Amit <amit.engel@emc.com>

ensure that nvmet_copy_to_sgl does not exceed data_len

Signed-off-by: Amit <amit.engel at emc.com>
---
 drivers/nvme/target/admin-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 51800a9ce9a9..fd7749727f55 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -40,13 +40,14 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 	u16 status = NVME_SC_SUCCESS;
 	unsigned long flags;
 	off_t offset = 0;
+	size_t num_of_sgl_slots = req->data_len/sizeof(struct nvme_error_slot);
 	u64 slot;
 	u64 i;
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
 	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
 
-	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
+	for (i = 0; i < NVMET_ERROR_LOG_SLOTS && i < num_of_sgl_slots; i++) {
 		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
 				sizeof(struct nvme_error_slot));
 		if (status)
-- 
2.16.2
