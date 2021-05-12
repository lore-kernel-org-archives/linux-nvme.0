Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4EBC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:16:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A56613EB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A56613EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9q8jdsaAqdxpW0NrkhmfeuZFy6Hzlr9KEjqBGLNhCgA=; b=CQ+gat91AdXALgj9flrkSkyzl
	+H0lWYL97YaoRvRsEWoYLIl3X0C3b0oV+PK5xrM2wCurxRotlHtlLDrWAttykJ3LHr2eyMKpViK1D
	GCCSR2UhZ8FaZuCBO3qmdrUeYuLOBe3lZiQeqkqYxlylKeGwGOZXRxRaColhBd/2sTyC9pi4cyUU3
	4L2nY4YX0hQwTg5Dsokr2LfJr/17KVHiGCDUGx7fjdp3nYY8C17Sq4ZcXtUoxMbpFBqiqItkew2qS
	5kkn11uMdqRUmwIeKvP8AmuNJkM0hfmhURkYQZXMTIfq+vI2YrM9hXRZE5eTNyTIwv3wlD4fSRQWy
	/yW9P+Sgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgoij-002rcx-Ak; Wed, 12 May 2021 13:16:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiU-002rao-3e
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=QV8H2JiB9CJxNbpu7PfrVC25LYjNfXKcBsDwiceEXG4=; b=vNnu39MxIFh6qMDlw8iUkG7nhj
 695SgCuuvvD6ERwCv/EV4PGHfop1hj7bSzU7+nEFaILxV/CH5tNTuCaldGGNTrcim3ibY+vk3ZSPF
 w3v1zIhyPGypvvyx4Yu+7k4KX6hwcLGpsAmErIbTuoIC8WQbyVLu2W+l/TXUOwJqvBmbG1Bom9qGr
 2sC2fkSfDmtPwynoYAN2ItbITkJwVLrfwpXXVCnuavEr4ZdHv5+manUk5GoDzH5Ll1ql6gMeLE3cz
 tHITGyBUw126Jh01JnpKjyKGz4bQS/e9y4xSFc/HQ0aut11k43+OdOoDahMh7X6emjOYR+SFsB8Tv
 NBwqWWJQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiR-00AO1x-Ik; Wed, 12 May 2021 13:15:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 03/15] iomap: don't try to poll multi-bio I/Os in
 __iomap_dio_rw
Date: Wed, 12 May 2021 15:15:33 +0200
Message-Id: <20210512131545.495160-4-hch@lst.de>
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
 fs/iomap/direct-io.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..d5637f467109 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -282,6 +282,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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
@@ -339,6 +346,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
 						 BIO_MAX_VECS);
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		if (nr_pages)
+			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
@@ -579,6 +591,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iov_iter_revert(iter, pos - dio->i_size);
 			break;
 		}
+
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		iocb->ki_flags &= ~IOCB_HIPRI;
 	} while ((count = iov_iter_count(iter)) > 0);
 	blk_finish_plug(&plug);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
