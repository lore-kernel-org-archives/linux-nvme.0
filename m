From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  8 May 2019 11:36:32 -0700
Subject: [PATCH 1/3] nvme: introduce and use RAE bit macro
In-Reply-To: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190508183634.4682-2-chaitanya.kulkarni@wdc.com>

Introduce a macro instead of hardcoding RAE bit value in several places.
Also this uses RAE bit macro and removes the open coding in the NVMeOF
target. This is a preparation patch for filtering out the NVMe user
commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 2 +-
 include/linux/nvme.h        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c25d88fc9dec..47d9f5838828 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -343,7 +343,7 @@ struct nvmet_async_event {
 
 static inline void nvmet_clear_aen_bit(struct nvmet_req *req, u32 bn)
 {
-	int rae = le32_to_cpu(req->cmd->common.cdw10) & 1 << 15;
+	int rae = le32_to_cpu(req->cmd->common.cdw10) & NVME_LOG_PAGE_RAE;
 
 	if (!rae)
 		clear_bit(bn, &req->sq->ctrl->aen_masked);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720cb59ac..d439c129d8af 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -840,6 +840,8 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+#define NVME_LOG_PAGE_RAE	(1 << 15)
+
 /* NVMe Namespace Write Protect State */
 enum {
 	NVME_NS_NO_WRITE_PROTECT = 0,
-- 
2.17.0
