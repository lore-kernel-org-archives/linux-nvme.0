Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF0C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 05:14:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B2C20679
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 05:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAvRpzgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B2C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mBvH/qJ4XaAL380NQ8cckHXvetxG9TKmk7clmIxIgtA=; b=bAvRpzgwIzzCAq
	QSjc4V8CGh1FyMOh3olapI1f307+svTMgcGPgrX4zOuZ1YeAZF2TPWT0cZQsgkPoW8uvEbQxzuuMT
	fnzxypgI7fY5lQ79sIrnPsV3WZKMsjKj3hUfaKNXjx78kyrzGZPPHDLGr3XtU4B/vT1zCyocrPeVD
	IzlQnKHmM+6qI+XI+59IbrK9arGkXhD4vS8JDQNe4w6eOJeZh3mrCW2jUmmvCHSoB6OpuhYB2nhT+
	3TqdBgrGDFoJmQse/ToFoqzKu7f3uhzWFgz8rktLCERZWvnZDJm1ea1nZbvN/AoGhywafINV1CM4p
	HXaKr+DtfrzePO81Xz5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgLjl-0004Ah-3K; Wed, 03 Jun 2020 05:14:49 +0000
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jgLji-0004AN-40; Wed, 03 Jun 2020 05:14:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: [PATCH] block: remove the error argument to the block_bio_complete
 tracepoint
Date: Wed,  3 Jun 2020 07:14:43 +0200
Message-Id: <20200603051443.579748-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, hare@suse.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The status can be trivially derived from the bio itself.  That also avoid
callers like NVMe to incorrectly pass a blk_status_t instead of the errno,
and the overhead of translating the blk_status_t to the errno in the I/O
completion fast path when no tracing is enabled.

Fixes: 35fe0d12c8a3 ("nvme: trace bio completion")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                  | 3 +--
 drivers/nvme/host/nvme.h     | 3 +--
 include/trace/events/block.h | 6 +++---
 kernel/trace/blktrace.c      | 6 +++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5235da6434aab..a7366c02c9b57 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1434,8 +1434,7 @@ void bio_endio(struct bio *bio)
 	}
 
 	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_complete(bio->bi_disk->queue, bio,
-					 blk_status_to_errno(bio->bi_status));
+		trace_block_bio_complete(bio->bi_disk->queue, bio);
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fa5c75501049d..c0f4226d32992 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -599,8 +599,7 @@ static inline void nvme_trace_bio_complete(struct request *req,
 	struct nvme_ns *ns = req->q->queuedata;
 
 	if (req->cmd_flags & REQ_NVME_MPATH)
-		trace_block_bio_complete(ns->head->disk->queue,
-					 req->bio, status);
+		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
 extern struct device_attribute dev_attr_ana_grpid;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf237..1257f26bb887b 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -261,9 +261,9 @@ TRACE_EVENT(block_bio_bounce,
  */
 TRACE_EVENT(block_bio_complete,
 
-	TP_PROTO(struct request_queue *q, struct bio *bio, int error),
+	TP_PROTO(struct request_queue *q, struct bio *bio),
 
-	TP_ARGS(q, bio, error),
+	TP_ARGS(q, bio),
 
 	TP_STRUCT__entry(
 		__field( dev_t,		dev		)
@@ -277,7 +277,7 @@ TRACE_EVENT(block_bio_complete,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		__entry->error		= error;
+		__entry->error		= blk_status_to_errno(bio->bi_status);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 	),
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f20840870..1e5499414cdf1 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -885,10 +885,10 @@ static void blk_add_trace_bio_bounce(void *ignore,
 }
 
 static void blk_add_trace_bio_complete(void *ignore,
-				       struct request_queue *q, struct bio *bio,
-				       int error)
+				       struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE, error);
+	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE,
+			  blk_status_to_errno(bio->bi_status));
 }
 
 static void blk_add_trace_bio_backmerge(void *ignore,
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
