From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 18:31:46 +0200
Subject: [PATCH 1/7] nvme: mark the result argument to
 nvme_complete_async_event volatile
In-Reply-To: <20180517163152.23155-1-hch@lst.de>
References: <20180517163152.23155-1-hch@lst.de>
Message-ID: <20180517163152.23155-2-hch@lst.de>

We'll need that in the PCIe driver soon as we'll read it straight off the
CQ.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62262fac7a5d..b070c659391f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3344,7 +3344,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 }
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
-		union nvme_result *res)
+		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecfd44f5..7a872b0d53a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -400,7 +400,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send);
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
-		union nvme_result *res);
+		volatile union nvme_result *res);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
-- 
2.17.0
