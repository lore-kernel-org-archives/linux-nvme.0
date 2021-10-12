Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:14:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60086101D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A60086101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aWY0b0knK8jcfRLVKWvkzV5sjpf+x/q317BUxv/3qmM=; b=0OwKQDjFO5WA3d
	culO2J3WQU1Kah1ieYhSuqs7SpjiQM+quyxJ/DvO+zo1v1i4N82ryghL1rXqKRtBwiD31fyxR7NVh
	773zDhdMA+mUBPbELIx6GWxHiZOjyhdPgSSOYeOKG26s7U//UvyWameJCDlltp5V799hDTsx/NO5Q
	geE2RxZzwQG9XMvj8QYFkifbCCIY68XDaaJVK76EnCPGpusqNF1xWhcvErL3hQ4t0kkBiHzT2w+ig
	bPZkjyK5BVwA8OU0dP6c7SDG4ULR+jWKW1COpiFYxah0AKvEOuojIvTE3wdTeL9COg+CuKRQcr1du
	1qylAjUJl0FqgoFuTq1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFjy-00CWus-AR; Tue, 12 Oct 2021 11:14:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFjx-00CWui-AK
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:14:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=YaEjgBUtA2vphpQF+wTXe+cEE2KjTqL1g0deqC72xfw=; b=Wuw2nnoeDoSc5/sdrwK7HU846r
 RKD4ltUY6vFVZZKPlOXpFeA763wxLA2TC1vpwO2Gp/sGw+G1Oi5SEiYZ7AUupQ20sTIeXF29fKVHd
 FHFV+fJ8w67vrTYyB7m5lGCuDF/hb63pbcGzi3Ox6nQb7hOxSq2wJhFf8ztZMCqCUz7BF290FB+gd
 xzPXt1cSrf2b0EOQZhXgkCX4B/LralYfUBCOV1D6CF2co8UPJBNN47D8rIliYlThRSN+s7E2YZCHJ
 kCmENJEkBnC6xckKE3ks3aIpBsp6xWLLGewpCpFwsOCrx1dJL5QEY9V86K9yDsmUISw35JJpy3BuC
 fh8N0ikg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFiq-006RQP-Eu; Tue, 12 Oct 2021 11:13:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 01/16] direct-io: remove blk_poll support
Date: Tue, 12 Oct 2021 13:12:11 +0200
Message-Id: <20211012111226.760968-2-hch@lst.de>
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

The polling support in the legacy direct-io support is a little crufty.
It already doesn't support the asynchronous polling needed for io_uring
polling, and is hard to adopt to upcoming changes in the polling
interfaces.  Given that all the major file systems already use the iomap
direct I/O code, just drop the polling support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 fs/direct-io.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a1..453dcff0e7f56 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -119,7 +119,6 @@ struct dio {
 	int flags;			/* doesn't change */
 	int op;
 	int op_flags;
-	blk_qc_t bio_cookie;
 	struct gendisk *bio_disk;
 	struct inode *inode;
 	loff_t i_size;			/* i_size when submitted */
@@ -438,11 +437,10 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 
 	dio->bio_disk = bio->bi_bdev->bd_disk;
 
-	if (sdio->submit_io) {
+	if (sdio->submit_io)
 		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
-		dio->bio_cookie = BLK_QC_T_NONE;
-	} else
-		dio->bio_cookie = submit_bio(bio);
+	else
+		submit_bio(bio);
 
 	sdio->bio = NULL;
 	sdio->boundary = 0;
@@ -481,9 +479,7 @@ static struct bio *dio_await_one(struct dio *dio)
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
-		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
-			blk_io_schedule();
+		blk_io_schedule();
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
 		dio->waiter = NULL;
@@ -1214,8 +1210,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	} else {
 		dio->op = REQ_OP_READ;
 	}
-	if (iocb->ki_flags & IOCB_HIPRI)
-		dio->op_flags |= REQ_HIPRI;
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
