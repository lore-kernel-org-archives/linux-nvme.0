From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 25 Feb 2016 19:36:36 -0700
Subject: [Patchv2 1/3] blk-mq: helper to reduce queue depth on all hardware
 contexts
In-Reply-To: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>
References: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1456454198-26683-2-git-send-email-jonathan.derrick@intel.com>

Creates helper that limits the tags on all request_queues attached to
the tagset. This functionality is used to reassign queues in host memory
to controller memory buffers with lower queue depths.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 block/blk-mq.c         | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 645eb9e..c8bbb62 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2345,6 +2345,26 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
+void blk_mq_update_nr_hw_requests(struct blk_mq_tag_set *set,
+				  int nr_requests)
+{
+	struct request_queue *q;
+
+	if (nr_requests < set->reserved_tags + 1 ||
+	    nr_requests == set->queue_depth)
+		return;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue(q);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_update_nr_requests(q, nr_requests);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unfreeze_queue(q);
+}
+EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_requests);
+
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
 	struct request_queue *q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15a73d4..2596be6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -244,6 +244,7 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
 
+void blk_mq_update_nr_hw_requests(struct blk_mq_tag_set *set, int nr_requests);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 /*
-- 
2.1.4
