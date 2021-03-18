Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F323C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 21:53:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E1364F38
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 21:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E1364F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YVP4ZYug/2UscF/nOLxNIWaOVyKcm5jek5DAkllGcrk=; b=PquIz1PH0eI0zw+Jg9/+jRNBl
	RLES7SiWSHABt2+7yoht+Pzxs/xwOuSngJzWIhBZe0axkKyc4EQhij9nSiNSy+UEy/TlUWGyNE0jB
	lhIiKJ/vGenFh4mylw0wxnDXTqFZ8yqvorVsdYJITfM7fvPvldgbonoVMPhuy2qAbUrF1hDzxGMRG
	AYjAos49vK918eIgLUcfv+kofekCSnj607U2AatFbzziFH2nx/II+F0pooI+IySFQ75DNlG3Zem03
	oi7WEXoVhXv4V46as06TMb7Eyzl48ug/aqVQYk0vjU3WKcIn463oq4JPUaQnjsJVoTBTChg4PujcC
	jnnpeWNyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lN0Zr-0064tR-Su; Thu, 18 Mar 2021 21:53:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lN0Zm-0064se-UH
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 21:53:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F18964F1F;
 Thu, 18 Mar 2021 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616104383;
 bh=qf2NWNFBtyiyFT2PdYxXvWKMxlOchipOFLFaWfZFHss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GftvECO96MvtDP2UxUZmk+uB9MKo1L1lAs0zSzqFonDNY+ELZszokizBqYaT+YLMg
 8Z1+FRUvEguq6lIy0ZNH+SjxotPLlyzad4O6o4p6EIhWtmfTB83y+2yA0vwfa6Bz1K
 6aRhNSeXDQsGkdGnyjiwFdvuCwDMFanGtR/TZJCVTliRcId1jkktoxvPh8VSI7Ij7E
 zAK2+ytUJlSU6Wl83wgCHNnDjFfP67MhxooZ3x729hagkl4ZHW6lalvrxkgSS/SqUT
 ERrzm/w+GKF2zLNyXjPxh6BTlsaG4fJCMyg7bL4MxIY0lvYsFFgSsWBW5nAuM/sukq
 GHiMxDzii4WpA==
Date: Fri, 19 Mar 2021 06:52:56 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
References: <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_215307_759086_48870840 
X-CRM114-Status: GOOD (  31.13  )
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

On Thu, Mar 18, 2021 at 12:31:35PM -0700, Sagi Grimberg wrote:
> 
> > > Placing the request on the requeue_list is fine, but the question is
> > > when to kick the requeue_work, nothing guarantees that an alternate path
> > > exist or will in a sane period. So constantly requeue+kick sounds like
> > > a really bad practice to me.
> > 
> > nvme_mpath_set_live(), where you reported the deadlock, kicks the
> > requeue_list. The difference that NOWAIT provides is that
> > nvme_mpath_set_live's schronize_srcu() is no longer blocked forever
> > because the .submit_bio() isn't waiting for entery on a frozen queue, so
> > now it's free to schedule the dispatch.
> > 
> > There's probably an optimization to kick it sooner if there's a viable
> > alternate path, but that could be a follow on.
> 
> That would be mandatory I think, otherwise this would introduce
> a regression...
>
> > If there's no immediate viable path, then the requests would remain on
> > the requeue list. That currently happens as long as there's a potential
> > controller in a reset or connecting state.
> 
> Well, also worth to keep in mind that now we'll need to clone the bio
> because we need to override bi_end_io which adds us some overhead
> in the data path. Unless we make submit_bio return a status which
> is a much bigger scope of a change I would expect...

Having submit_bio() return the enter status was where I was going with
this, but the recursive handling makes this more complicated than I
initially thought.

If you use the NOWAIT flag today with a freezing queue, the IO will end
with BLK_STS_AGAIN and punt retry handling to the application. I'm
guessing you don't want that to happen, so a little more is required for
this idea.

Since it's an error path, perhaps a block operations callback is okay?
Something like this compile tested patch?

---
diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..423b89005a28 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -475,6 +475,16 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	}
 }
 
+static inline void bio_enter_error(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+	if (disk->fops->enter_err)
+		disk->fops->enter_err(bio);
+	else
+		bio_wouldblock_error(bio);
+}
+
 static inline int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
@@ -484,7 +494,7 @@ static inline int bio_queue_enter(struct bio *bio)
 	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
 	if (unlikely(ret)) {
 		if (nowait && !blk_queue_dying(q))
-			bio_wouldblock_error(bio);
+			bio_enter_error(bio);
 		else
 			bio_io_error(bio);
 	}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index edf19bbb904f..2c27eeaa83b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2366,9 +2366,24 @@ static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
 	nvme_put_ns_head(disk->private_data);
 }
 
+void nvme_ns_head_enter_err(struct bio *bio)
+{
+	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
+
+	if (nvme_available_path(head)) {
+		spin_lock_irq(&head->requeue_lock);
+		bio_list_add(&head->requeue_list, bio);
+		spin_unlock_irq(&head->requeue_lock);
+	} else {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+	}
+}
+
 const struct block_device_operations nvme_ns_head_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= nvme_ns_head_submit_bio,
+	.enter_err	= nvme_ns_head_enter_err,
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ioctl,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..47595bb09032 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -274,7 +274,7 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-static bool nvme_available_path(struct nvme_ns_head *head)
+bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
 
@@ -313,7 +313,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
-		bio->bi_opf |= REQ_NVME_MPATH;
+		bio->bi_opf |= REQ_NVME_MPATH | REQ_NOWAIT;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
 		ret = submit_bio_noacct(bio);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 815c032a190e..5dbd6baebd70 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -677,6 +677,7 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 blk_qc_t nvme_ns_head_submit_bio(struct bio *bio);
+bool nvme_available_path(struct nvme_ns_head *head);
 
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b43..b5ae1aa292c1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1862,6 +1862,7 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 struct block_device_operations {
 	blk_qc_t (*submit_bio) (struct bio *bio);
+	void (*enter_err) (struct bio *bio);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
