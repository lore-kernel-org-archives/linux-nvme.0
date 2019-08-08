From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Thu, 8 Aug 2019 17:35:02 +0200
Subject: [PATCH v2] nvme: exclude completion trace from non-multipath builds
Message-ID: <01a54b2ad1810fc9354c1586ebcb104364c0234a.1565348491.git.mskorzhinskiy@solarflare.com>

This trace point have no meaning without native multipath support and
break compilation on configurations without enabled multipath.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6956041224ec..1202b7461031 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -260,10 +260,24 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
+#ifdef CONFIG_NVME_MULTIPATH
+static void nvme_trace_bio_complete(struct request *req, blk_status_t status)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+
+	if (req->bio && ns && ns->head->disk)
+		trace_block_bio_complete(ns->head->disk->queue,
+					 req->bio, status);
+}
+#else
+static void nvme_trace_bio_complete(struct request *req, blk_status_t status)
+{
+}
+#endif
+
 void nvme_complete_rq(struct request *req)
 {
 	blk_status_t status = nvme_error_status(req);
-	struct nvme_ns *ns = req->q->queuedata;
 
 	trace_nvme_complete_rq(req);
 
@@ -282,9 +296,8 @@ void nvme_complete_rq(struct request *req)
 			return;
 		}
 	}
-	if (req->bio && ns && ns->head->disk)
-		trace_block_bio_complete(ns->head->disk->queue,
-					 req->bio, status);
+
+	nvme_trace_bio_complete(req, status);
 	blk_mq_end_request(req, status);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.22.0
