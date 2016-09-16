From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:26 +0200
Subject: [PATCH 15/21] blk-mq: Pair blk_mq_hctx_kobj_init() with
 blk_mq_hctx_kobj_put()
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <a0823d4674b19548c0053f9594ad73f1a3e4f303.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq-sysfs.c | 5 +++++
 block/blk-mq.c       | 2 +-
 block/blk-mq.h       | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index fe822aa..404ccd5 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -417,6 +417,11 @@ void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
 }
 
+void blk_mq_hctx_kobj_put(struct blk_mq_hw_ctx *hctx)
+{
+	kobject_put(&hctx->kobj);
+}
+
 static void blk_mq_sysfs_init(struct request_queue *q)
 {
 	struct blk_mq_ctx *ctx;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9e5cd1f..e14f7e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2009,7 +2009,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (!hctx)
 			continue;
 
-		kobject_put(&hctx->kobj);
+		blk_mq_hctx_kobj_put(hctx);
 
 		if (hctx->tags) {
 			blk_mq_free_rq_map(set, hctx->tags, j);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 97b0051..592e308 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -57,6 +57,7 @@ extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
+extern void blk_mq_hctx_kobj_put(struct blk_mq_hw_ctx *hctx);
 
 extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
-- 
1.8.3.1
