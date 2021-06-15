Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AB9C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC956142E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC956142E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CgmjiADdkhTUaJm5D/MR0BodYQwZ5X3Fx0iC87cMKQk=; b=RFls5bzmI7WZpS
	zga6iKqMfFAxH57ITjTy63oqNLGV8/r2tNMPoa0eCQkh0o1wGDenT34rujbbYS6a1vFcmW1vEjMSa
	WF1tA2YgqALXIesbzi2X6f5S1DDccmQd18WDsDF7GL6iSq0Nw8rpFlgd9gUvmpQqaFVLttlwL7fa5
	L567sp2b7OfyAdJloY4QlWTAuVAMo8Uk/wMzfS1e2+pCSbTYUs5WUX4L24uE68+KoAvcqkqh7tc48
	vZLnlsHP9Afw9RradJosuIFakSG2A5hKJsfr1ZJYlbVehHhikIsmRHE3X3Dg7/s0NTRwvDci/Azhn
	ikT3aBTeRsLwKjXLk5fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltAKg-000gyG-CM; Tue, 15 Jun 2021 14:46:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PM-000FmL-4M
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=W/pOuZ3M/Lxyf6zyvw6KnC+PJbg0MBF8SbrADjI35Bc=; b=cpVXYflDYw5fOdSZKZhTGio9mg
 C7Y3wPFf2oIoegSt12QuwWKJ7eGCFAOfUKLOfcNWTz7gtJSRY2DxfRuEToYbTUmUoF0qVAWqkXUns
 OiC5b81RwZGIUFj3y0T+LYaykXF3nh8CcfWIYR6XbbaW92pAAtBnVFwnLH/mUz+fssD1T3TTETomP
 vvMVQOaz5WrG4gU8BifO7VA4xxcHYnO9C0GP1gWqJYBDLpL1ADaG5aO3eh3a9p1OhLgObn3fdqnwF
 +IZTNQHBfV1xefjn3KFG5mQ8C3TrkQc1mEHrjKUFIGd4TH0hPt2PSoSLyGEqWf8P+YDvo0rQTQatk
 PNLVWTBQ==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8qA-006n7q-6V; Tue, 15 Jun 2021 13:10:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 01/16] direct-io: remove blk_poll support
Date: Tue, 15 Jun 2021 15:10:19 +0200
Message-Id: <20210615131034.752623-2-hch@lst.de>
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
index b2e86e739d7a..453dcff0e7f5 100644
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
