Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32732C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:46:21 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB11C61494
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB11C61494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eWnNEJN2JkrC5CcFj7Q7uobokySq2nwmtPec4AvU33E=; b=yC62jKYphQ3+0N
	QRdYhE5dB7wdByXJ5HcgSn1vMiVZLq5MPvPuGBVz+DjtTtTvwD4rgujjDmbftHuXM+BLkUoJljsOV
	WD67g78smw3WglHUoHQU2cX52jfvI/SdU5Fzosvr1UvkYU0/BtbiqNDwVQmFht8YDIED1kHtEZMaW
	SuNmGgR+8KzYD9TUEInRhCg++PspyIjYu5RaAa6NoOt8N6gzfzTLRvrx+KTRqjQTvJtI1t/ZX/jS4
	WaCnBPBs9HZhfft293En2cjd/NUHOdcfVK18RKNLq+LXAXOuT+YsWjCyWdiIpqh7rz+SHz3mlrCEr
	M5c3yv5oLcRg4AZmVexA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltAK4-000gkv-PJ; Tue, 15 Jun 2021 14:45:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PA-000FmL-TE
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=UhccBBYCc1ZiWlTYjKkEiiEHgVybsbHZcY8gPohuFNg=; b=Rx/Ht22g1Nhl49WZC4qXze76n9
 MgctLwG5ZbOfh40lYWZz6u7QVvU/2Ymqrjwx6Pnxru+vzKb0KMzsW/NXyUpowLsI7I4HfHjahQFxQ
 Rry9JxKz1gCzTguYY6Ua/E7fDNX1xcCi/7K13yrhsMzn+2MFDvGt6+04xysp9cOssSy8yh+EEeZtO
 ZbzcIIM/u0oW+G3SswwOn1ul0676URkj/Bus9NZxJBODf9PcvGb5bZdssTt8RdEzb4/GeKPCx4s6n
 e6PynuwBJjsBwd0r4r+wsgDi46Kd5o0GynhiFN1rU6RDOLc3HW12icvloYtPAbgFJpKi8vgPzSYHO
 NuGXiyKA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8qP-006n8E-NH; Tue, 15 Jun 2021 13:11:09 +0000
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
Date: Tue, 15 Jun 2021 15:10:20 +0200
Message-Id: <20210615131034.752623-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
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
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ac9b3c158a77..8600c651b0b0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -375,7 +375,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -404,7 +404,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	 * Don't plug for HIPRI/polled IO, as those should go straight
 	 * to issue
 	 */
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_start_plug(&plug);
 
 	for (;;) {
@@ -438,20 +438,13 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
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
@@ -462,6 +455,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
+			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -470,7 +464,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_finish_plug(&plug);
 
 	if (!is_sync)
@@ -481,8 +475,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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
