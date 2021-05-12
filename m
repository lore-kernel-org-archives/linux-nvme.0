Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B16C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:16:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FAD613CA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FAD613CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jGf8VjTeVlGe7XqcLJ3BZNGsyX9MQ8wUKSzFqXOtffk=; b=rLM1Tw8YkPJGlYmLdnKJZH6q7
	z8/MoOPILXSwD2AyyDSOIXJpP0unrLH66iuzcuM/ijA+LeyoX26GzaIl5UROplmFpfexmKXvVt9J3
	FHv7OJEbtEYEy9AIFaqsIjlinLYTwcwTeEzGtLMCp4aygmQR9UDQ7CirHnNOomdPKOKD/zZlYpKJU
	ZCSMaH8XUh41V5TzjkEJ2yADEMVUz7qeEgVn2jYn+cKTa4lNTFyYbTTAIEAd8DyaXJmdXlbqJSk1l
	OgsaUb9dq1pkMICBfOI9t9KPcIRbnHEsFYQhpTRJ/K/hlaBSvIzjlwXPszyfpBznvx+b9+PWr/qgH
	J6qNA8Hpg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgoit-002reK-FF; Wed, 12 May 2021 13:16:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiU-002raq-3m
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ITcDnMcQEFSlEsP6OeKRIsg7UYiJLbM8pLCK5/AYNmI=; b=ilmrki/Qi7MB0JiGh4JaY+GbtD
 Wvl5thPN5GNtQT4n6fZ/vd1ZnlCChqXtapVZ1fzcXgokbddK+tGD3hS1OSM+o8Mmq06ixLFuxetlY
 tY/II5Iix77vw91F9tBajof90Tn5pBGtAYhrq9nfM6qTT+iWpdpGoaG6w+4zbB7RVMqHG90J2GNt3
 8qfbOHWL9ni3GXhfJ78X1CHeU1v6Kq1Dp2Zcspl/giETn6hZqK7DdloZoGHT0gG+T9zWtJZ+5hdb2
 +G6jvmF6P7HseN5tWsXudOUGSqP0Qhj/n6mvHWCZKieNie8Os1gZoB5e5kAPsb0T7yuqtNJLK8EHn
 Y8+8FTpw==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiO-00AO1o-Po; Wed, 12 May 2021 13:15:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 02/15] block: don't try to poll multi-bio I/Os in
 __blkdev_direct_IO
Date: Wed, 12 May 2021 15:15:32 +0200
Message-Id: <20210512131545.495160-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

If an iocb is split into multiple bios we can't poll for both.  So don't
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8abccd03e5d..0080a3b710b4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -375,7 +375,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -437,22 +437,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		pos += bio->bi_iter.bi_size;
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
-		if (!nr_pages) {
-			bool polled = false;
-
-			if (iocb->ki_flags & IOCB_HIPRI) {
-				bio_set_polled(bio, iocb);
-				polled = true;
-			}
-
-			qc = submit_bio(bio);
-
-			if (polled)
-				WRITE_ONCE(iocb->ki_cookie, qc);
-			break;
-		}
-
-		if (!dio->multi_bio) {
+		if (dio->multi_bio) {
+			atomic_inc(&dio->ref);
+		} else if (nr_pages) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
 			 * structure which is embedded into the first bio
@@ -462,11 +449,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
-		} else {
-			atomic_inc(&dio->ref);
+		} else if (is_poll) {
+			bio_set_polled(bio, iocb);
+			do_poll = true;
+		}
+		qc = submit_bio(bio);
+		if (!nr_pages) {
+			if (do_poll)
+				WRITE_ONCE(iocb->ki_cookie, qc);
+			break;
 		}
-
-		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
@@ -481,8 +473,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
