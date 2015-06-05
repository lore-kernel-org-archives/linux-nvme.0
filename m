From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  5 Jun 2015 14:54:29 +0200
Subject: [PATCH v4 7/8] null_blk: LightNVM support
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <1433508870-28251-8-git-send-email-m@bjorling.me>

Initial support for LightNVM. The support can be used to benchmark
performance of targets and core implementation.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 Documentation/block/null_blk.txt |   8 +++
 drivers/block/null_blk.c         | 133 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 2f6c6ff..a34f50a 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -70,3 +70,11 @@ use_per_node_hctx=[0/1]: Default: 0
      parameter.
   1: The multi-queue block layer is instantiated with a hardware dispatch
      queue for each CPU node in the system.
+
+IV: LightNVM specific parameters
+
+nvm_enable=[x]: Default: 0
+  Enable LightNVM for null block devices. Requires blk-mq to be used.
+
+nvm_num_channels=[x]: Default: 1
+  Number of LightNVM channels that is exposed to the LightNVM driver.
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 79972ab..1337541 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
 #include <linux/hrtimer.h>
+#include <linux/lightnvm.h>
 
 struct nullb_cmd {
 	struct list_head list;
@@ -17,6 +18,7 @@ struct nullb_cmd {
 	struct bio *bio;
 	unsigned int tag;
 	struct nullb_queue *nq;
+	struct nvm_rq_data nvm_rqdata;
 };
 
 struct nullb_queue {
@@ -147,6 +149,14 @@ static bool use_per_node_hctx = false;
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
@@ -273,6 +283,9 @@ static void null_softirq_done_fn(struct request *rq)
 
 static inline void null_handle_cmd(struct nullb_cmd *cmd)
 {
+	if (nvm_enable)
+		nvm_unprep_rq(cmd->rq, &cmd->nvm_rqdata);
+
 	/* Complete IO by inline, softirq or timer */
 	switch (irqmode) {
 	case NULL_IRQ_SOFTIRQ:
@@ -351,6 +364,85 @@ static void null_request_fn(struct request_queue *q)
 	}
 }
 
+#ifdef CONFIG_NVM
+
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
+static int null_nvm_internal_rw(struct request_queue *q,
+						struct nvm_internal_cmd *cmd)
+{
+	struct request *req;
+	int ret;
+
+	req = blk_mq_alloc_request(q, cmd->rw, GFP_KERNEL, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->cmd_type = REQ_TYPE_DRV_PRIV;
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	req->__data_len = 0;
+	req->__sector = (sector_t) -1;
+	req->bio = req->biotail = NULL;
+	req->timeout = 30;
+	req->special = cmd;
+
+	blk_execute_rq(req->q, NULL, req, 0);
+	ret = req->errors;
+	blk_mq_free_request(req);
+	return ret;
+}
+
+static struct nvm_dev_ops null_nvm_dev_ops = {
+	.identify		= null_nvm_id,
+	.get_features		= null_nvm_get_features,
+	.internal_rw		= null_nvm_internal_rw,
+};
+#else
+static struct nvm_dev_ops null_nvm_dev_ops;
+#endif /* CONFIG_NVM */
+
 static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -359,6 +451,22 @@ static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->rq = bd->rq;
 	cmd->nq = hctx->driver_data;
 
+	if (nvm_enable) {
+		nvm_init_rq_data(&cmd->nvm_rqdata);
+		switch (nvm_prep_rq(cmd->rq, &cmd->nvm_rqdata)) {
+		case NVM_PREP_DONE:
+			return BLK_MQ_RQ_QUEUE_OK;
+		case NVM_PREP_REQUEUE:
+			blk_mq_requeue_request(bd->rq);
+			blk_mq_kick_requeue_list(hctx->queue);
+			return BLK_MQ_RQ_QUEUE_OK;
+		case NVM_PREP_BUSY:
+			return BLK_MQ_RQ_QUEUE_BUSY;
+		case NVM_PREP_ERROR:
+			return BLK_MQ_RQ_QUEUE_ERROR;
+		}
+	}
+
 	blk_mq_start_request(bd->rq);
 
 	null_handle_cmd(cmd);
@@ -517,14 +625,21 @@ static int null_add_dev(void)
 		goto out_free_nullb;
 
 	if (queue_mode == NULL_Q_MQ) {
+		int cmd_size = sizeof(struct nullb_cmd);
+
+		if (nvm_enable)
+			cmd_size += sizeof(struct nvm_per_rq);
+
 		nullb->tag_set.ops = &null_mq_ops;
 		nullb->tag_set.nr_hw_queues = submit_queues;
 		nullb->tag_set.queue_depth = hw_queue_depth;
 		nullb->tag_set.numa_node = home_node;
-		nullb->tag_set.cmd_size	= sizeof(struct nullb_cmd);
-		nullb->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+		nullb->tag_set.cmd_size = cmd_size;
 		nullb->tag_set.driver_data = nullb;
 
+		if (!nvm_enable)
+			nullb->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+
 		rv = blk_mq_alloc_tag_set(&nullb->tag_set);
 		if (rv)
 			goto out_cleanup_queues;
@@ -568,8 +683,8 @@ static int null_add_dev(void)
 	}
 
 	mutex_lock(&lock);
-	list_add_tail(&nullb->list, &nullb_list);
 	nullb->index = nullb_indexes++;
+	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
 
 	blk_queue_logical_block_size(nullb->q, bs);
@@ -578,16 +693,23 @@ static int null_add_dev(void)
 	size = gb * 1024 * 1024 * 1024ULL;
 	set_capacity(disk, size >> 9);
 
+	if (nvm_enable && nvm_register(nullb->q, disk, &null_nvm_dev_ops))
+		goto out_cleanup_disk;
+
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
 	disk->first_minor	= nullb->index;
 	disk->fops		= &null_fops;
 	disk->private_data	= nullb;
 	disk->queue		= nullb->q;
+
 	sprintf(disk->disk_name, "nullb%d", nullb->index);
 	add_disk(disk);
+	nvm_attach_sysfs(disk);
 	return 0;
 
+out_cleanup_disk:
+	put_disk(disk);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
@@ -611,6 +733,11 @@ static int __init null_init(void)
 		bs = PAGE_SIZE;
 	}
 
+	if (nvm_enable && bs != 4096) {
+		pr_warn("null_blk: only 4K sectors are supported for Open-Channel SSDs. bs is set to 4K.\n");
+		bs = 4096;
+	}
+
 	if (queue_mode == NULL_Q_MQ && use_per_node_hctx) {
 		if (submit_queues < nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.",
-- 
2.1.4
