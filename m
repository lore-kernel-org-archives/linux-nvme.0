Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A3C433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:28:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29046191C
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29046191C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6rgYyf3OUM3xm7/BxeBuDLA5loYRAmzU2ykAQI6AyPQ=; b=WvAGYLlC4IuXwV3q8U5V7k09+
	UhtRs7EhYK/As73jGVq4aa8oSAadiTkrV0p+IBQNeV6TCD+3bXMuUwiyDYQyqTpRJn+uhWVRC9uRK
	bVhPnN6PZPCNjx3Kcjvb2rBxyKmNwxjMaY7R0GwOhAieuGdABFfGLLHpPhFJs8/zR3tjQrpz0bwjn
	LteabnjpFGoSCAdztCcAYZMe+xwHokKm+BUCRzJcntDTYK4Kl2Wwv6F0gDIXtkh9G8AsYCMWdU8ek
	0SwegiTucuc+wDctp7xNZCUpmrRhQnZJb09d86yDRMQhV3QzsbQ2roGMCEq7CPRZO1IHec+jpFSKt
	anlz5i4mQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNIvG-007qP6-IC; Fri, 19 Mar 2021 17:28:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNIv9-007qNv-4G
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 17:28:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E2F8568BFE; Fri, 19 Mar 2021 18:28:17 +0100 (CET)
Date: Fri, 19 Mar 2021 18:28:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210319172817.GA23660@lst.de>
References: <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
 <20210319140532.GA7019@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319140532.GA7019@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_172825_284752_872A50FB 
X-CRM114-Status: GOOD (  17.18  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

What about something like this?

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff20849738..4344f3c9058282 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -792,7 +792,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static noinline_for_stack bool submit_bio_checks(struct bio *bio)
+noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev->bd_disk->queue;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa43966..4ff85692843b49 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2286,6 +2286,43 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+/**
+ * blk_mq_submit_bio_direct - hand a bio directly to the driver for I/O
+ * @bio:  The bio describing the location in memory and on the device.
+ *
+ * This function behaves similar to submit_bio_noacct(), but does never waits
+ * for the queue to be unfreozen, instead it return false and lets the caller
+ * deal with the fallout.  It also does not protect against recursion and thus
+ * must only be used if the called driver is known to be blk-mq based.
+ */
+bool blk_mq_submit_bio_direct(struct bio *bio, blk_qc_t *qc)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct request_queue *q = disk->queue;
+
+	if (WARN_ON_ONCE(!current->bio_list) ||
+	    WARN_ON_ONCE(disk->fops->submit_bio)) {
+		bio_io_error(bio);
+		goto fail;
+	}
+	if (!submit_bio_checks(bio))
+		goto fail;
+
+	if (unlikely(blk_queue_enter(q, BLK_MQ_REQ_NOWAIT)))
+		return false;
+	if (!blk_crypto_bio_prep(&bio))
+		goto fail_queue_exit;
+	*qc = blk_mq_submit_bio(bio);
+	return true;
+
+fail_queue_exit:
+	blk_queue_exit(disk->queue);
+fail:
+	*qc = BLK_QC_T_NONE;
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_mq_submit_bio_direct);
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e4e..c4c66b2a9ffb19 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -221,6 +221,7 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
+bool submit_bio_checks(struct bio *bio);
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac020f..92adebfaf86fd1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -309,6 +309,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	 */
 	blk_queue_split(&bio);
 
+retry:
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
@@ -316,7 +317,12 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = submit_bio_noacct(bio);
+
+		if (!blk_mq_submit_bio_direct(bio, &ret)) {
+			nvme_mpath_clear_current_path(ns);
+			srcu_read_unlock(&head->srcu, srcu_idx);
+			goto retry;
+		}
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b899089..6804f397106ada 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -615,6 +615,7 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 }
 
 blk_qc_t blk_mq_submit_bio(struct bio *bio);
+bool blk_mq_submit_bio_direct(struct bio *bio, blk_qc_t *qc);
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
 		struct lock_class_key *key);
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
