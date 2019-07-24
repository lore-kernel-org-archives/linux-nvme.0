From: hare@suse.de (Hannes Reinecke)
Date: Wed, 24 Jul 2019 15:47:55 +0200
Subject: [PATCH] nvme: trace bio completion
Message-ID: <20190724134755.96315-1-hare@suse.de>

When native multipathing is enabled we cannot enable blktrace for
the underlying paths, so any completion is never traced.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5ca937..ba5a23475314 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -22,6 +22,8 @@
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
+#include <trace/events/block.h>
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
@@ -261,6 +263,7 @@ static void nvme_retry_req(struct request *req)
 void nvme_complete_rq(struct request *req)
 {
 	blk_status_t status = nvme_error_status(req);
+	struct nvme_ns *ns = req->q->queuedata;
 
 	trace_nvme_complete_rq(req);
 
@@ -279,6 +282,9 @@ void nvme_complete_rq(struct request *req)
 			return;
 		}
 	}
+	if (req->bio && ns && ns->head->disk)
+		trace_block_bio_complete(ns->head->disk->queue,
+					 req->bio, status);
 	blk_mq_end_request(req, status);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.16.4
