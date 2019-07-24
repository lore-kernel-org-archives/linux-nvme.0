From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Jul 2019 11:48:41 +0800
Subject: [PATCH V2 3/5] nvme: don't abort completed request in
 nvme_cancel_request
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
Message-ID: <20190724034843.10879-4-ming.lei@redhat.com>

Before aborting in-flight requests, all IO queues and their interrupts
have been shutdown. However, request's completion function may not be
done yet because it can be scheduled to run via IPI.

So don't abort one request if it is marked as completed, otherwise
we may abort one normal completed request.

Cc: Max Gurtovoy <maxg at mellanox.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81fc7f4..e98490b98cbd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -288,6 +288,10 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
+	/* don't abort one completed request */
+	if (blk_mq_request_completed(req))
+		return true;
+
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
 	blk_mq_complete_request_sync(req);
 	return true;
-- 
2.20.1
