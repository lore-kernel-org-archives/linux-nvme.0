From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Thu, 8 Aug 2019 17:35:02 +0200
Subject: [PATCH] nvme: exclude completion trace from non-multipath builds
Message-ID: <9efc495c41b7bf050362a3a7eb64b5809092afd6.1565280170.git.mskorzhinskiy@solarflare.com>

This trace point have no meaning without native multipath support and
break compilation on configurations without enabled multipath.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6956041224ec..9fd4397ff158 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -260,10 +260,20 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
+#ifdef CONFIG_NVME_MULTIPATH
+static void nvme_trace_compl(struct request *req, blk_status_t status)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+
+	if (req->bio && ns && ns->head->disk)
+		trace_block_bio_complete(ns->head->disk->queue,
+					 req->bio, status);
+}
+#endif
+
 void nvme_complete_rq(struct request *req)
 {
 	blk_status_t status = nvme_error_status(req);
-	struct nvme_ns *ns = req->q->queuedata;
 
 	trace_nvme_complete_rq(req);
 
@@ -282,9 +292,10 @@ void nvme_complete_rq(struct request *req)
 			return;
 		}
 	}
-	if (req->bio && ns && ns->head->disk)
-		trace_block_bio_complete(ns->head->disk->queue,
-					 req->bio, status);
+
+#ifdef CONFIG_NVME_MULTIPATH
+	nvme_trace_compl(req, status);
+#endif
 	blk_mq_end_request(req, status);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.22.0
