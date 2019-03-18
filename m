From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 18 Mar 2019 11:29:50 +0800
Subject: [PATCH 2/2] nvme: cancel request synchronously
In-Reply-To: <20190318032950.17770-1-ming.lei@redhat.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
Message-ID: <20190318032950.17770-3-ming.lei@redhat.com>

nvme_cancel_request() is used in error handler, and it is always
reliable to cancel request synchronously, and avoids possible race
in which request may be completed after real hw queue is destroyed.

One issue is reported by our customer on NVMe RDMA, in which freed ib
queue pair may be used in nvme_rdma_complete_rq().

Cc: Christoph Hellwig <hch at lst.de>
Cc: linux-nvme at lists.infradead.org
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 470601980794..2c43e12b70af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -288,7 +288,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 				"Cancelling I/O %d", req->tag);
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request(req);
+	blk_mq_complete_request_sync(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.9.5
