Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C56C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C39C60724
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C39C60724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VQXYplI8X9QCTsGCmjnk3wP4WupxsExdh43cDCm5B3Q=; b=i4tPbiA1IT3ujW
	K9MezldF8ZZsJKouboNzHumP3HwrMMtXQsVC+LHaAnm3u2eEx7FvqThzOpy0uPoVNB9lbPSJ9AAwT
	QdqFcbM+udhWI++P0JqRqXpPp+bw/wzpd+gOZYehAhb2DHjdPadUuZqrmU6ptQV6JnZ16uGZQdJHZ
	vm/SFZkraxzkHcZwOloniYvWGqzE5GbWKc+jX0hyh9wzb84FxAc+IaJ5AhuIdLvoGPARi9t+UqVpv
	e9GdZcBpN/qlJLzX2PDUoSJzxV/XatcmH2Ex6xqdKvsne6YDrhFPJKUQ/VV3LfMqKatedn3+e3uCH
	CpzkhXR9dSlD4E3yxuGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFlx-00CXG2-CN; Tue, 12 Oct 2021 11:16:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFlv-00CXFZ-WC
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=nZF79gsmzNGgf+VO3Jfy8LzuzWQO/z8SfWOzMB5jNuA=; b=EXkduW/rz8T6tPjJE/GzzwCCb4
 AqyJFJJ9UbvjVt3uD5xWNd9cLHfNcCuyG7WPGag/30liB2xVuf+zGITNplzVJn5hWixsTv2ocdHZW
 DNLSifkrKiDemogzUhAHFf74dgkrKI7ZuCBwXcqKSuu/orTd9zQlgXQo62m1COWFK3emMzX6v+OxZ
 KqcdZwokwiGmp8LsisR2NTdDK7bApWW8ZNDUhhKDjQX9uIBOr3Tn6wg1zkWMd6H+NGY20n6ROB93+
 681F4Wq+AJBbnLP4H71ZbzKAKHMweFytGLEr56XOdpzP0Fl916cttoXQ4dqknyoAHhDZoUaEmZhA+
 +HXDQwhQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFl2-006RVq-LO; Tue, 12 Oct 2021 11:15:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 03/16] iomap: don't try to poll multi-bio I/Os in
 __iomap_dio_rw
Date: Tue, 12 Oct 2021 13:12:13 +0200
Message-Id: <20211012111226.760968-4-hch@lst.de>
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
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 fs/iomap/direct-io.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4ecd255e0511c..560ae967f70e8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -282,6 +282,13 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	if (!iov_iter_count(dio->submit.iter))
 		goto out;
 
+	/*
+	 * We can only poll for single bio I/Os.
+	 */
+	if (need_zeroout ||
+	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
+		dio->iocb->ki_flags &= ~IOCB_HIPRI;
+
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
@@ -339,6 +346,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 
 		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
 						 BIO_MAX_VECS);
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		if (nr_pages)
+			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(iter, dio, bio, pos);
 		pos += n;
 	} while (nr_pages);
@@ -565,8 +577,15 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	inode_dio_begin(inode);
 
 	blk_start_plug(&plug);
-	while ((ret = iomap_iter(&iomi, ops)) > 0)
+	while ((ret = iomap_iter(&iomi, ops)) > 0) {
 		iomi.processed = iomap_dio_iter(&iomi, dio);
+
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		iocb->ki_flags &= ~IOCB_HIPRI;
+	}
+
 	blk_finish_plug(&plug);
 
 	/*
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
