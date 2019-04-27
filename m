From: sashal@kernel.org (Sasha Levin)
Date: Fri, 26 Apr 2019 21:38:26 -0400
Subject: [PATCH AUTOSEL 5.0 67/79] nvme: cancel request synchronously
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
Message-ID: <20190427013838.6596-67-sashal@kernel.org>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit eb3afb75b57c28599af0dfa03a99579d410749e9 ]

nvme_cancel_request() is used in error handler, and it is always
reliable to cancel request synchronously, and avoids possible race
in which request may be completed after real hw queue is destroyed.

One issue is reported by our customer on NVMe RDMA, in which freed ib
queue pair may be used in nvme_rdma_complete_rq().

Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Bart Van Assche <bvanassche at acm.org>
Cc: James Smart <james.smart at broadcom.com>
Cc: linux-nvme at lists.infradead.org
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68c0f4f..4c4413ad3ceb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -291,7 +291,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 				"Cancelling I/O %d", req->tag);
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request(req);
+	blk_mq_complete_request_sync(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.19.1
