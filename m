From: hch@lst.de (Christoph Hellwig)
Date: Mon, 21 Sep 2015 11:40:53 -0700
Subject: [PATCH 7/7] nvme: micro optimize nvme_submit_priv
In-Reply-To: <1442860853-26447-1-git-send-email-hch@lst.de>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
Message-ID: <1442860853-26447-8-git-send-email-hch@lst.de>

Avoid a copy of the command from the request to the stack.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 6cc8f58..35236df 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -581,16 +581,15 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
 		struct nvme_iod *iod)
 {
-	struct nvme_command cmnd;
+	struct nvme_command *cmnd = (struct nvme_command *)req->cmd;
 
-	memcpy(&cmnd, req->cmd, sizeof(cmnd));
-	cmnd.rw.command_id = req->tag;
+	cmnd->common.command_id = req->tag;
 	if (req->nr_phys_segments) {
-		cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
+		cmnd->common.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		cmnd->common.prp2 = cpu_to_le64(iod->first_dma);
 	}
 
-	__nvme_submit_cmd(nvmeq, &cmnd);
+	__nvme_submit_cmd(nvmeq, cmnd);
 }
 
 /*
-- 
1.9.1
