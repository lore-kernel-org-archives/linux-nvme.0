Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBCBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FF26101D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63FF26101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TihxsBwnHxXJpdB2/M3N0znOFA09ZI0p0O3kFRXB1OM=; b=WO99I76/qDhPU/
	0rbimUDziHGfTpbibARMQSGbkO/S7cAEpiimHs0G9AQPXcTPZD1DOq5eM5ebNtVlzQB3jgIITdS6Y
	U8DWan8+Ls4TtQUJFwxi3QR/eiTq3FnSzZomido6Y2xl2xhKIASyUFpQkjceWiXbFVYQA5nOo0lG7
	AFOS/LpbjppU++UnK6ZP8BkJKlTxNUy0kDLgDjH1afSONOXwaLlrWo5y23NcBCCdfAeAVRKbb42mz
	DBv6KgYiTVfiiLHZCWSwqIm6/5WkTy2vTL/omfPGjbj7DvTfieyW5e7n1yhFt/vqpEnn7dyylLd47
	nbE3r/+xzhURkmHbvAEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFl4-00CX3O-AD; Tue, 12 Oct 2021 11:15:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFl3-00CX3E-DZ
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=dfLmHdTHOwWISM4CncKHIKnO5smotSMqN/rH5FtxI78=; b=Kqxx435kkCiUFQIp4oMzCwpYRB
 K7v4Jjd3+GFd8TMk/VZV/Zn+xrOHIT2LoyeMKbE9Amrsgj2D3jXEIwnPHIm5140Ks80bkpy2NSCs8
 4NWjUAWpEO89oTT3qIQs6QzS3ZszT1fKc/Bj0cAX2nHz9CsriEZ1WWhutLnntwYntFq/53S6FaIO7
 jAUV4I15B+Lr65oTQREY3ks3+Kr1wn/VrBisn5a1hTnvEE3shIfoe4jfOuflh78FEqNDJqeIUpXFZ
 gEUU8RXWqLoWKvn3hVEzBXwLW6w1i7WquxYaXVwE6bj4q7U43oEG6z1sLbakyZZkhuj4qinOQyNVU
 klO2T7cA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFjw-006RRs-Kj; Tue, 12 Oct 2021 11:15:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 02/16] block: don't try to poll multi-bio I/Os in
 __blkdev_direct_IO
Date: Tue, 12 Oct 2021 13:12:12 +0200
Message-Id: <20211012111226.760968-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
even bother to try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 7bb9581a146cf..15324f2e5a914 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -197,7 +197,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -226,7 +226,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	 * Don't plug for HIPRI/polled IO, as those should go straight
 	 * to issue
 	 */
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_start_plug(&plug);
 
 	for (;;) {
@@ -260,20 +260,13 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
-			bool polled = false;
-
-			if (iocb->ki_flags & IOCB_HIPRI) {
+			if (do_poll)
 				bio_set_polled(bio, iocb);
-				polled = true;
-			}
-
 			qc = submit_bio(bio);
-
-			if (polled)
+			if (do_poll)
 				WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
-
 		if (!dio->multi_bio) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
@@ -284,6 +277,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
+			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -292,7 +286,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_finish_plug(&plug);
 
 	if (!is_sync)
@@ -303,8 +297,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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
