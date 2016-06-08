From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Jun 2016 14:31:05 +0200
Subject: [PATCH 10/11] nvme: keep alive should use any queue
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Message-ID: <1465389066-19119-11-git-send-email-hch@lst.de>

No need to specify a queue ID for admin commands.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd2fd7..86886c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -499,7 +499,8 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_keep_alive;
 
-	rq = nvme_alloc_request(ctrl->admin_q, &c, BLK_MQ_REQ_RESERVED, 0);
+	rq = nvme_alloc_request(ctrl->admin_q, &c, BLK_MQ_REQ_RESERVED,
+			NVME_QID_ANY);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
-- 
2.1.4
