From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Jul 2019 11:48:40 +0800
Subject: [PATCH V2 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
Message-ID: <20190724034843.10879-3-ming.lei@redhat.com>

blk-mq may schedule to call queue's complete function on remote CPU via
IPI, but doesn't provide any way to synchronize the request's complete
fn. The current queue freeze interface can't provide the synchonization
because aborted requests stay at blk-mq queues during EH.

In some driver's EH(such as NVMe), hardware queue's resource may be freed &
re-allocated. If the completed request's complete fn is run finally after the
hardware queue's resource is released, kernel crash will be triggered.

Prepare for fixing this kind of issue by introducing
blk_mq_tagset_wait_completed_request().

Cc: Max Gurtovoy <maxg at mellanox.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq-tag.c     | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index da19f0bc8876..008388e82b5c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 
 #include <linux/blk-mq.h>
+#include <linux/delay.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
@@ -354,6 +355,37 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
+		void *data, bool reserved)
+{
+	unsigned *count = data;
+
+	if (blk_mq_request_completed(rq))
+		(*count)++;
+	return true;
+}
+
+/**
+ * blk_mq_tagset_wait_completed_request - wait until all completed req's
+ * complete funtion is run
+ * @tagset:	Tag set to drain completed request
+ *
+ * Note: This function has to be run after all IO queues are shutdown
+ */
+void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
+{
+	while (true) {
+		unsigned count = 0;
+
+		blk_mq_tagset_busy_iter(tagset,
+				blk_mq_tagset_count_completed_rqs, &count);
+		if (!count)
+			break;
+		msleep(5);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cc5115ca0e19..f9f722aeb535 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -329,6 +329,7 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.20.1
