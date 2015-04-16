From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 16 Apr 2015 13:34:51 +0200
Subject: [PATCH 2/5 v2] blk-mq: Support for Open-Channel SSDs
In-Reply-To: <552F8D84.8030504@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-3-git-send-email-m@bjorling.me>
 <1429175408.16771.45.camel@x220> <552F8D84.8030504@bjorling.me>
Message-ID: <1429184091.16771.60.camel@x220>

On Thu, 2015-04-16@12:23 +0200, Matias Bj?rling wrote:
> On 04/16/2015 11:10 AM, Paul Bolle wrote:
> > A few things I spotted (while actually fiddling with 3/5).
> 
> Thanks. I'll fix them up.

Please note that just using #ifdef instead of #if is not all that's
needed. See, I had some fun playing whack-a-mole with warnings and
errors showing up in the "CONFIG_BLK_DEV_NVM is not set" case (because I
was looking into things outside of this series that I don't understand).

After adding the changes pasted at the end of this message (which I gave
almost no thought whatsoever) I ran into:
    block/blk-mq.c: In function ?blk_mq_init_rq_map?:
    block/blk-mq.c:1473:22: error: invalid application of ?sizeof? to incomplete type ?struct nvm_per_rq?
       cmd_size += sizeof(struct nvm_per_rq);
                          ^

Then I admitted defeat.

Have fun with your turn of that game.


Paul Bolle

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 95fbc98307a5..27d4ebf36a80 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -223,7 +223,7 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
-#if CONFIG_BLK_DEV_NVM
+#ifdef CONFIG_BLK_DEV_NVM
 	rq->phys_sector = 0;
 #endif
 
diff --git a/block/blk.h b/block/blk.h
index 3e4abee7c194..19c037041006 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -294,9 +294,9 @@ extern void blk_nvm_unregister(struct request_queue *);
 extern int blk_nvm_init_sysfs(struct device *);
 extern void blk_nvm_remove_sysfs(struct device *);
 #else
-static void blk_nvm_unregister(struct request_queue *q) { }
-static int blk_nvm_init_sysfs(struct device *) { return 0; }
-static void blk_nvm_remove_sysfs(struct device *) { }
+static inline void blk_nvm_unregister(struct request_queue *q) { }
+static inline int blk_nvm_init_sysfs(struct device *dev) { return 0; }
+static inline void blk_nvm_remove_sysfs(struct device *dev) { }
 #endif /* CONFIG_BLK_DEV_NVM */
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 56f963586112..77d7b35a27c7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -209,7 +209,7 @@ struct request {
 
 	/* for bidi */
 	struct request *next_rq;
-#if CONFIG_BLK_DEV_NVM
+#ifdef CONFIG_BLK_DEV_NVM
 	sector_t phys_sector;
 #endif
 };
@@ -914,11 +914,6 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
 	return blk_rq_cur_bytes(rq) >> 9;
 }
 
-static inline sector_t blk_rq_phys_pos(const struct request *rq)
-{
-	return rq->phys_sector;
-}
-
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     unsigned int cmd_flags)
 {
@@ -1780,35 +1775,32 @@ static inline struct nvm_dev *blk_nvm_get_dev(struct request_queue *q)
 	return q->nvm;
 }
 #else
+struct nvm_dev;
 struct nvm_dev_ops;
 struct nvm_lun;
 struct nvm_block;
 struct nvm_target_type;
 
-struct nvm_target_type *nvm_find_target_type(const char *)
+static inline struct nvm_target_type *nvm_find_target_type(const char *name)
 {
 	return NULL;
 }
-int nvm_register_target(struct nvm_target_type *tt) { return -EINVAL; }
-void nvm_unregister_target(struct nvm_target_type *tt) {}
-static inline int blk_nvm_register(struct request_queue *,
-						struct nvm_dev_ops *)
+static inline int nvm_register_target(struct nvm_target_type *tt) { return -EINVAL; }
+static inline void nvm_unregister_target(struct nvm_target_type *tt) {}
+static inline int blk_nvm_register(struct request_queue *q,
+						struct nvm_dev_ops *ops)
 {
 	return -EINVAL;
 }
-static inline struct nvm_block *blk_nvm_get_blk(struct nvm_lun *, int)
+static inline struct nvm_block *blk_nvm_get_blk(struct nvm_lun *lun, int is_gc)
 {
 	return NULL;
 }
-static inline void blk_nvm_put_blk(struct nvm_block *) {}
-static inline int blk_nvm_erase_blk(struct nvm_dev *, struct nvm_block *)
+static inline void blk_nvm_put_blk(struct nvm_block *block) {}
+static inline int blk_nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blok)
 {
 	return -EINVAL;
 }
-static inline int blk_nvm_get_dev(struct request_queue *)
-{
-	return NULL;
-}
 static inline sector_t blk_nvm_alloc_addr(struct nvm_block *block)
 {
 	return 0;
