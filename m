From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 08:52:29 -0600
Subject: [PATCH 1/7] nvme: mark the result argument to
 nvme_complete_async_event volatile
In-Reply-To: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526655155-4006-2-git-send-email-axboe@kernel.dk>

From: Christoph Hellwig <hch@lst.de>

We'll need that in the PCIe driver soon as we'll read it straight off the
CQ.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e5a7a9..c7c1298c6dc5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3323,7 +3323,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 }
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
-		union nvme_result *res)
+		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7cf3fed..de78eae52673 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -405,7 +405,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send);
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
-		union nvme_result *res);
+		volatile union nvme_result *res);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
-- 
2.7.4
