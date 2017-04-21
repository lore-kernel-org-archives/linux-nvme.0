From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 08:30:17 +0200
Subject: [PATCH] nvme/lightnvm: add missing endianess conversion in
 nvme_nvm_end_io
Message-ID: <20170421063017.26380-1-hch@lst.de>

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index de61a4a03d78..e4e4e60b1224 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -483,7 +483,7 @@ static void nvme_nvm_end_io(struct request *rq, int error)
 {
 	struct nvm_rq *rqd = rq->end_io_data;
 
-	rqd->ppa_status = nvme_req(rq)->result.u64;
+	rqd->ppa_status = le64_to_cpu(nvme_req(rq)->result.u64);
 	rqd->error = nvme_req(rq)->status;
 	nvm_end_io(rqd);
 
-- 
2.11.0
