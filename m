Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A506AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:38:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6659D2251F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6659D2251F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+EoI86axUvTx7ARGkyJPG11yZV4yNe4GRtcbu6RnzJg=; b=1jyIfJRn5Erd9YZRWNRhOvB97
	BhrH430T4hHPHGK4ZmjAITG1Lz/C0GnNJ+lo1Kj6BgtlvtfEBLduCFaWjblQdKjUCnCKJ+cil7mxE
	8Ev2K28H301GUpFBXIBKHHqvD3ikMBgsJI8isKAHOlNa3iPYM+GUJVuiRRT3FFJMo+leM5c0DzHRU
	OwvyE7EgxoWy0Xqni/+4h+jIT2sb6xA7WPTCPvp/JZDGRTCovwY0qYphBaWS/lrXyOwfF+nONLOcl
	7JVKePwR/VMui3R1O8ZwgIWa3aBq5IuhldKgAu44iwD9Pa4tyVRtMoIsKwvz4NrwcA6o0lpVOtSxz
	4maZKt9YA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4PTb-0004AL-P9; Tue, 26 Jan 2021 14:37:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4PTZ-0004A0-Ri
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 14:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=qlbpHPBSE9cCG3MefejlTgLltST3iJlEyPkRgH8th2I=; b=uVO0bFF9AFcW0iYW9qVgIt1NEs
 NQO7wtP7U7+I3VLtupqYODY5VpSP22wTOv4B8VubukA6rtefpvuwW/BfSG1eObrfC4mNDRk0ZGwM7
 7KDJCqhgk0ex5JZChSQhUuHyUychF2vzMfqHNclLGG4GYbpqP8Vu7XaOmNkOLpNbIFM2P4KNYoaxH
 xjdliuz3nN1AZ9KgNF1r9uoRzaj74Ga3imNCDNfeyspINx6dZNVvGXtXOJ70ISs4TnY5QMBCJlcO3
 0kuYwbflb0XFCI5JCH2CY4WTxfgns81M/XWsEeq5LXlFBFKgS9g3vgY81JH0q21bNujyoifPjdtbl
 ai2xfOjw==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l4PSl-005kVC-34; Tue, 26 Jan 2021 14:37:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: [PATCH 3/3] block: inherit BIO_REMAPPED when cloning bios
Date: Tue, 26 Jan 2021 15:33:08 +0100
Message-Id: <20210126143308.1960860-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126143308.1960860-1-hch@lst.de>
References: <20210126143308.1960860-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cloned bios are can be used to on the same device, in which case we need
to inherit the BIO_REMAPPED flag to avoid a double partition remap.  When
the cloned bios are used on another device, bio_set_dev will clear the flag.

Fixes: 309dca309fc3 ("block: store a block_device pointer in struct bio")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 2 ++
 block/bounce.c              | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 99040a7e6656a1..dfd7740a32300a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -666,6 +666,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
+	if (bio_flagged(bio_src, BIO_REMAPPED))
+		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 8f1e1817673115..50c225398e4d60 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -168,6 +168,8 @@ static struct bio *blk_crypto_clone_bio(struct bio *bio_src)
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
+	if (bio_flagged(bio_src, BIO_REMAPPED))
+		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
diff --git a/block/bounce.c b/block/bounce.c
index a22a8a1942b24f..fc55314aa4269a 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -247,6 +247,8 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
+	if (bio_flagged(bio_src, BIO_REMAPPED))
+		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
