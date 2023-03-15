Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52287C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiLifj+InbQR44WdOf+NdexSGO2Bv85ZoAhHiEtfvkg=; b=BMuMbTENT2LRC4qsHfep9JvgU3
	wVuRRyl0KDNLN9bnL4Oc1DMz55WQJw9r7B5In/UzGkvESBl4Tfb3ADmSY6sF/cD72QT83+9U6rq5b
	UR8S+WonAMtBdasFDbeonCLT7mIIbngzaGmsV7ZHHSw28B+s+f7/mxRbrezviRWUJlUDcMMQ6bCty
	Zy4YZbfiz4z0mx+zTIo9OUKeqx4lKU3wcknNR7i9YcgRPJGpipi1Clm825Hz7vfGS8BeOaKgNDr2R
	vOpqdvy7AupSYJ081m+Ulho/gYoSES3eUlDddLIvFDz2pXxBSBhXLik3Y0dLMyJL499fW3C8Y/KNZ
	aN1l+u/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZXy-00Earl-2O;
	Wed, 15 Mar 2023 22:24:38 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZXv-00Eaqq-23
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 22:24:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3D9E6B81F87;
	Wed, 15 Mar 2023 22:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54D0C433D2;
	Wed, 15 Mar 2023 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678919071;
	bh=lbJMY1hEbGvOW37JJnpT+KrUfhpgi2exe+1/6Tl/zWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBjwaltAqbgyqD5PnCpi5JHZuZvPqrow+lmRO8AZvnsUpDDUaLP6XazpWpV9FpjR2
	 NXvRqH8cJjuesxwmxl2jEE9eE0gnJxykYPdvW6OO3tmZrMO6C/u/obKof2D4Nba/0p
	 02tDvxkKUu8KDvJgbjLum6oIdQ0EYzJhRZHWdabNFzD9tIZcDtB2w0AsHgJD+3iHDM
	 3WqGpqFv84zMwVxun61baE0toz3x2BNXfPdYbVhS/h1uyexbnX6g8m0rdZ6Li+k1ls
	 fVj/1K7aB3zcOIImevxRTtpYp2rqizkBiPiUOnVoMhiExbREcHJne46BmXbLeAE6Hh
	 NOsgKjyeGVgSA==
Date: Wed, 15 Mar 2023 16:24:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_152435_973634_5CA8EFC9 
X-CRM114-Status: GOOD (  14.63  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Could you try this patch with your tcp polling queues enabled?

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 9e5e0277a4d95..12f7ab369f7ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -844,30 +844,12 @@ void submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
-/**
- * bio_poll - poll for BIO completions
- * @bio: bio to poll for
- * @iob: batches of IO
- * @flags: BLK_POLL_* flags that control the behavior
- *
- * Poll for completions on queue associated with the bio. Returns number of
- * completed entries found.
- *
- * Note: the caller must either be the context that submitted @bio, or
- * be in a RCU critical section to prevent freeing of @bio.
- */
-int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
+static int blk_poll(struct request_queue *q, struct io_comp_batch *iob,
+		    struct bio *bio, unsigned int flags)
 {
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
-	struct block_device *bdev;
-	struct request_queue *q;
 	int ret = 0;
 
-	bdev = READ_ONCE(bio->bi_bdev);
-	if (!bdev)
-		return 0;
-
-	q = bdev_get_queue(bdev);
 	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
@@ -902,6 +884,39 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	blk_queue_exit(q);
 	return ret;
 }
+
+/**
+ * blk_rq_poll - poll for request completions
+ * @rq: request to poll for
+ */
+int blk_rq_poll(struct request *rq)
+{
+	return blk_poll(rq->q, NULL, rq->bio, 0);
+}
+EXPORT_SYMBOL_GPL(blk_rq_poll);
+
+/**
+ * bio_poll - poll for BIO completions
+ * @bio: bio to poll for
+ * @iob: batches of IO
+ * @flags: BLK_POLL_* flags that control the behavior
+ *
+ * Poll for completions on queue associated with the bio. Returns number of
+ * completed entries found.
+ *
+ * Note: the caller must either be the context that submitted @bio, or
+ * be in a RCU critical section to prevent freeing of @bio.
+ */
+int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
+{
+	struct block_device *bdev;
+
+	bdev = READ_ONCE(bio->bi_bdev);
+	if (!bdev)
+		return 0;
+
+	return blk_poll(bdev_get_queue(bdev), iob, bio, flags);
+}
 EXPORT_SYMBOL_GPL(bio_poll);
 
 /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0cb2ef18fe21..2ada72cbfb24e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1368,7 +1368,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		bio_poll(rq->bio, NULL, 0);
+		blk_rq_poll(rq);
 		cond_resched();
 	} while (!completion_done(wait));
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c181..70532cafd3a96 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -872,6 +872,7 @@ blk_status_t errno_to_blk_status(int errno);
 #define BLK_POLL_ONESHOT		(1 << 0)
 /* do not sleep to wait for the expected completion time */
 #define BLK_POLL_NOSLEEP		(1 << 1)
+int blk_rq_poll(struct request *rq);
 int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
 int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 			unsigned int flags);
--

