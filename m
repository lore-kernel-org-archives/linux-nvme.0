From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 15 Apr 2015 14:34:43 +0200
Subject: [PATCH 4/5 v2] null_blk: LightNVM support
In-Reply-To: <1429101284-19490-1-git-send-email-m@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
Message-ID: <1429101284-19490-5-git-send-email-m@bjorling.me>

Initial support for LightNVM. The support can be used to benchmark
performance of targets and core implementation.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 Documentation/block/null_blk.txt |  8 ++++
 drivers/block/null_blk.c         | 89 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 2f6c6ff..b907ecc 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -70,3 +70,11 @@ use_per_node_hctx=[0/1]: Default: 0
      parameter.
   1: The multi-queue block layer is instantiated with a hardware dispatch
      queue for each CPU node in the system.
+
+IV: LightNVM specific parameters
+
+lightnvm_enable=[x]: Default: 0
+  Enable LightNVM for null block devices. Requires blk-mq to be used.
+
+lightnvm_num_channels=[x]: Default: 1
+  Number of LightNVM channels that are exposed to the LightNVM driver.
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 65cd61a..9cf566e 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
+#include <linux/lightnvm.h>
 #include <linux/hrtimer.h>
 
 struct nullb_cmd {
@@ -147,6 +148,14 @@ static bool use_per_node_hctx = false;
 module_param(use_per_node_hctx, bool, S_IRUGO);
 MODULE_PARM_DESC(use_per_node_hctx, "Use per-node allocation for hardware context queues. Default: false");
 
+static bool nvm_enable;
+module_param(nvm_enable, bool, S_IRUGO);
+MODULE_PARM_DESC(nvm_enable, "Enable Open-channel SSD. Default: false");
+
+static int nvm_num_channels = 1;
+module_param(nvm_num_channels, int, S_IRUGO);
+MODULE_PARM_DESC(nvm_num_channels, "Number of channels to be exposed from the Open-Channel SSD. Default: 1");
+
 static void put_tag(struct nullb_queue *nq, unsigned int tag)
 {
 	clear_bit_unlock(tag, nq->tag_map);
@@ -351,6 +360,50 @@ static void null_request_fn(struct request_queue *q)
 	}
 }
 
+static int null_nvm_id(struct request_queue *q, struct nvm_id *id)
+{
+	sector_t size = gb * 1024 * 1024 * 1024ULL;
+	unsigned long per_chnl_size =
+				size / bs / nvm_num_channels;
+	struct nvm_id_chnl *chnl;
+	int i;
+
+	id->ver_id = 0x1;
+	id->nvm_type = NVM_NVMT_BLK;
+	id->nchannels = nvm_num_channels;
+
+	id->chnls = kmalloc_array(id->nchannels, sizeof(struct nvm_id_chnl),
+								GFP_KERNEL);
+	if (!id->chnls)
+		return -ENOMEM;
+
+	for (i = 0; i < id->nchannels; i++) {
+		chnl = &id->chnls[i];
+		chnl->queue_size = hw_queue_depth;
+		chnl->gran_read = bs;
+		chnl->gran_write = bs;
+		chnl->gran_erase = bs * 256;
+		chnl->oob_size = 0;
+		chnl->t_r = chnl->t_sqr = 25000; /* 25us */
+		chnl->t_w = chnl->t_sqw = 500000; /* 500us */
+		chnl->t_e = 1500000; /* 1.500us */
+		chnl->io_sched = NVM_IOSCHED_CHANNEL;
+		chnl->laddr_begin = per_chnl_size * i;
+		chnl->laddr_end = per_chnl_size * (i + 1) - 1;
+	}
+
+	return 0;
+}
+
+static int null_nvm_get_features(struct request_queue *q,
+						struct nvm_get_features *gf)
+{
+	gf->rsp = 0;
+	gf->ext = 0;
+
+	return 0;
+}
+
 static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -387,6 +440,11 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
+static struct nvm_dev_ops null_nvm_dev_ops = {
+	.identify		= null_nvm_id,
+	.get_features		= null_nvm_get_features,
+};
+
 static struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
 	.map_queue      = blk_mq_map_queue,
@@ -525,6 +583,17 @@ static int null_add_dev(void)
 		nullb->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 		nullb->tag_set.driver_data = nullb;
 
+		if (nvm_enable) {
+			nullb->tag_set.flags &= ~BLK_MQ_F_SHOULD_MERGE;
+			nullb->tag_set.flags |= BLK_MQ_F_NVM;
+
+			if (bs != 4096) {
+				pr_warn("null_blk: only 4K block is supported for Open-Channel SSDs. bs is set to 4K.\n");
+				bs = 4096;
+			}
+
+		}
+
 		rv = blk_mq_alloc_tag_set(&nullb->tag_set);
 		if (rv)
 			goto out_cleanup_queues;
@@ -567,11 +636,6 @@ static int null_add_dev(void)
 		goto out_cleanup_blk_queue;
 	}
 
-	mutex_lock(&lock);
-	list_add_tail(&nullb->list, &nullb_list);
-	nullb->index = nullb_indexes++;
-	mutex_unlock(&lock);
-
 	blk_queue_logical_block_size(nullb->q, bs);
 	blk_queue_physical_block_size(nullb->q, bs);
 
@@ -579,16 +643,31 @@ static int null_add_dev(void)
 	sector_div(size, bs);
 	set_capacity(disk, size);
 
+	mutex_lock(&lock);
+	nullb->index = nullb_indexes++;
+	list_add_tail(&nullb->list, &nullb_list);
+	mutex_unlock(&lock);
+
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
 	disk->first_minor	= nullb->index;
 	disk->fops		= &null_fops;
 	disk->private_data	= nullb;
 	disk->queue		= nullb->q;
+
+	if (nvm_enable && queue_mode == NULL_Q_MQ) {
+		if (blk_nvm_register(nullb->q, &null_nvm_dev_ops))
+			goto out_cleanup_nvm;
+
+		nullb->q->nvm->drv_cmd_size = sizeof(struct nullb_cmd);
+	}
+
 	sprintf(disk->disk_name, "nullb%d", nullb->index);
 	add_disk(disk);
 	return 0;
 
+out_cleanup_nvm:
+	put_disk(disk);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
-- 
1.9.1
