Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C13860698
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C13860698
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mtRzMKyAauo5A/vuCqv/VJSIG15v1lsipCyG+hNfuNc=; b=cTjgTrGV8IBm7i
	VnMDEIx0DHMUkkL9j+aM/O2jXBl1Nchsy6QcZp/cXhP1EeqaYpzZ9Nks6SLJgGb/+/0DOO8+Xq5qk
	cy6bGW8qvzKF+ZrMAY9atNTZKsg0Mx51Sm1Im5i+A3YAfcEEL5cnYLyXwrdHZDAbazZzQvFBnv2Sy
	bRF9pxYBRHHkBZgtawalNqb/N2WT2yfiZ/snr4socHgmS55dRLjnaCpv6nM/DRx644KIXfUrTyXx/
	OSzTIEFuAXDCZIJeWZyerIKIS/zWOQbnZO+5o27dohfqlh0QSo6nqBl3c1/zVYB53Is/ON3H4KMGA
	9+FLp1mC53BNE6g9NkoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFs1-00CZgW-JY; Tue, 12 Oct 2021 11:22:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFrA-00CZHL-Pq
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2jekzTOKw0yWZJEvYoe5lmOtBAHrUy6faNmK+C8chh4=; b=le20fnhDpl3GUrRDjN4Qvw6cxo
 smssyG/HDe8ZP3W4YQ1O+n3E9BK1T0IcSqUsm7C6s9mpgUnzM55472ZnNn5dyHmJpRvzXoXkqOstG
 Q9aq7CyAyaNPnHY2Wr1t4T96FQ05BmcqGMCNfaLKUBqtOjcgPPcQsX1K8Wpk3GacCCTHg7XTIMHa+
 Q4km5+46KNioVgmNkRQmyEpd7LPBv23vbwALjaI/I7tiFoofKpYr25cHGfnVh4907ru9l4fciVCnl
 wXQBmWm+xT0nztpMMd3q2ZkAiyuZKeWTb7BGhu/llpKq0I4swcxfwYV4oFg088BLXzndoNABVVU9w
 LnJ0U7Gw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFpX-006Rou-IR; Tue, 12 Oct 2021 11:20:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 07/16] blk-mq: remove blk_qc_t_to_tag and blk_qc_t_is_internal
Date: Tue, 12 Oct 2021 13:12:17 +0200
Message-Id: <20211012111226.760968-8-hch@lst.de>
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

Merge both functions into their only caller to keep the blk-mq tag to
blk_qc_t mapping as private as possible in blk-mq.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c            |  8 +++++---
 include/linux/blk_types.h | 10 ----------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 00bc595d8de6d..3d65e79a11db5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -74,9 +74,11 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 static inline struct request *blk_qc_to_rq(struct blk_mq_hw_ctx *hctx,
 		blk_qc_t qc)
 {
-	if (blk_qc_t_is_internal(qc))
-		return blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(qc));
-	return blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(qc));
+	unsigned int tag = qc & ((1U << BLK_QC_T_SHIFT) - 1);
+
+	if (qc & BLK_QC_T_INTERNAL)
+		return blk_mq_tag_to_rq(hctx->sched_tags, tag);
+	return blk_mq_tag_to_rq(hctx->tags, tag);
 }
 
 /*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 000351c5312af..fb7c1477617b8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -505,16 +505,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
 	return cookie != BLK_QC_T_NONE;
 }
 
-static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
-{
-	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
-}
-
-static inline bool blk_qc_t_is_internal(blk_qc_t cookie)
-{
-	return (cookie & BLK_QC_T_INTERNAL) != 0;
-}
-
 struct blk_rq_stat {
 	u64 mean;
 	u64 min;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
