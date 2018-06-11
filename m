From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 17:46:46 +0200
Subject: [PATCH 3/4] nvme-fabrics: handle the admin-only case properly in
 nvmf_check_ready
In-Reply-To: <20180611154647.32558-1-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
Message-ID: <20180611154647.32558-4-hch@lst.de>

In the ADMIN_ONLY state we don't have any I/O queues, but we should accept
all admin commands without further checks.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 2ea949a3868c..e1818a27aa2d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -169,7 +169,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
-	if (likely(ctrl->state == NVME_CTRL_LIVE))
+	if (likely(ctrl->state == NVME_CTRL_LIVE ||
+		   ctrl->state == NVME_CTRL_ADMIN_ONLY))
 		return true;
 	return __nvmf_check_ready(ctrl, rq, queue_live);
 }
-- 
2.17.1
