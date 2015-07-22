From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 22 Jul 2015 19:51:03 +0200
Subject: [PATCH v5 4/5] null_blk: LightNVM support
In-Reply-To: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
References: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
Message-ID: <1437587464-7964-5-git-send-email-mb@lightnvm.io>

Initial support for LightNVM. The support can be used to benchmark
performance of targets and core implementation.

Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
---
 Documentation/block/null_blk.txt |   8 +++
 drivers/block/null_blk.c         | 138 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 140 insertions(+), 6 deletions(-)

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
index 69de41a..6531250 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
 #include <linux/hrtimer.h>
+#include <linux/lightnvm.h>
 
 struct nullb_cmd {
 	struct list_head list;
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
@@ -363,6 +372,110 @@ static void null_request_fn(struct request_queue *q)
 	}
 }
 
+#ifdef CONFIG_NVM
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
+	gf->rsp = NVM_RSP_L2P;
+	gf->ext = 0;
+
+	return 0;
+}
+
+static void null_nvm_end_io(struct request *rq, int error)
+{
+	struct nvm_rq *rqd = rq->end_io_data;
+	struct nvm_tgt_instance *ins = rqd->ins;
+
+	ins->tt->end_io(rq->end_io_data, error);
+
+	blk_put_request(rq);
+}
+
+static int null_nvm_submit_io(struct request_queue *q, struct nvm_rq *rqd)
+{
+	struct request *rq;
+	struct bio *bio = rqd->bio;
+
+	rq = blk_mq_alloc_request(q, bio_rw(bio), GFP_KERNEL, 0);
+	if (IS_ERR(rq))
+		return -ENOMEM;
+
+	rq->cmd_type = REQ_TYPE_DRV_PRIV;
+	rq->__sector = bio->bi_iter.bi_sector;
+	rq->ioprio = bio_prio(bio);
+
+	if (bio_has_data(bio))
+		rq->nr_phys_segments = bio_phys_segments(q, bio);
+
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->bio = rq->biotail = bio;
+
+	rq->end_io_data = rqd;
+
+	blk_execute_rq_nowait(q, NULL, rq, 0, null_nvm_end_io);
+
+	return 0;
+}
+
+static struct nvm_dev_ops null_nvm_dev_ops = {
+	.identify	= null_nvm_id,
+	.get_features	= null_nvm_get_features,
+	.submit_io	= null_nvm_submit_io,
+};
+
+static int null_nvm_register(struct nullb *nullb, struct gendisk *disk)
+{
+	return nvm_register(nullb->q, disk, &null_nvm_dev_ops);
+}
+
+static void null_nvm_unregister(struct gendisk *disk)
+{
+	nvm_unregister(disk);
+}
+#else
+static int null_nvm_register(struct nullb *nullb, struct gendisk *disk)
+{
+	return -EINVAL;
+}
+static void null_nvm_unregister(struct gendisk *disk) { }
+#endif /* CONFIG_NVM */
+
 static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -410,6 +523,9 @@ static void null_del_dev(struct nullb *nullb)
 {
 	list_del_init(&nullb->list);
 
+	if (nvm_enable)
+		null_nvm_unregister(nullb->disk);
+
 	del_gendisk(nullb->disk);
 	blk_cleanup_queue(nullb->q);
 	if (queue_mode == NULL_Q_MQ)
@@ -579,11 +695,6 @@ static int null_add_dev(void)
 		goto out_cleanup_blk_queue;
 	}
 
-	mutex_lock(&lock);
-	list_add_tail(&nullb->list, &nullb_list);
-	nullb->index = nullb_indexes++;
-	mutex_unlock(&lock);
-
 	blk_queue_logical_block_size(nullb->q, bs);
 	blk_queue_physical_block_size(nullb->q, bs);
 
@@ -598,9 +709,24 @@ static int null_add_dev(void)
 	disk->private_data	= nullb;
 	disk->queue		= nullb->q;
 	sprintf(disk->disk_name, "nullb%d", nullb->index);
-	add_disk(disk);
+
+	if (nvm_enable) {
+		rv = null_nvm_register(nullb, disk);
+		if (rv)
+			goto out_cleanup_disk;
+	} else {
+		add_disk(disk);
+	}
+
+	mutex_lock(&lock);
+	list_add_tail(&nullb->list, &nullb_list);
+	nullb->index = nullb_indexes++;
+	mutex_unlock(&lock);
+
 	return 0;
 
+out_cleanup_disk:
+	put_disk(disk);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
-- 
2.1.4
