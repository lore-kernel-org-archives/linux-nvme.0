Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F7FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:19:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EF960698
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89EF960698
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pU2JfStSYfPGR9+cwTzhZIBkPvErqwjbPs+QB8eGe2Q=; b=jwvaahLhbVLc3W
	Et6lNx0JGeXyECBFuNLuP8moXhDkc6eRBXhs4yg0CRFoKZXdgnYuWCC+a5kZsnwj3RmVTPieERoCi
	Xf2RROU4QrvnVtgJ0W0AQ9zgMMZ1pk8PNVtxnTrFhx8c6Sbr47kFePzpG5RMvMK5taUYJG6zO2Mul
	VaY78IfdtKQAZ62e85ygxVIqAt+tNL1MFRgOXcD1ZAKTd2wXvJKQfzdkHfZTq4GndZ+EeZBd7I7Kd
	Qw51hbXUu319VZ0vNku+9NKWypWqJutD1WOFbKYXbGOTNUZomGYsbpjUvQ6da4ti55gFfBpfKH18I
	8APKh+agMqn26GxpNeng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFo9-00CXzD-JE; Tue, 12 Oct 2021 11:18:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFo8-00CXyk-Re
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=RZ9DL6WdB9ouJLGc8dUCkAIJ+6pdeleI7sPP0w5I3VY=; b=k0ZkTGLM8JrlIVeEEgWTH7zpA+
 xSFZVHrj1/jupB9NLoqRbouoXKr/yOJu3j0mL4IOPJNvrwVhwxWD1DNCc+WA2gIM2Sjz6YuRiPI7O
 9nmYQcTjVuxsvlG+L7xl5dN4QY4mi7220WGF5DZLbv8dOaKcZev+H8Cf6GV08NzPYv0qgDLRYEjE5
 2dB9TYsvu2NYPuFazLtQdjulUJ7WA1PFb4Lomcm3n0pczJB4J3YI4vhqQim6Y18pand8/yvU+T66+
 PhYoPyNKBnIhWkTvRcn4ksEi1Osy+ioSa5AFXk4qA2ISLvBKvPHL1ipca5XdmpGH/peN3l0lbi7b6
 6GC5H14g==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFn5-006RdR-OB; Tue, 12 Oct 2021 11:18:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 05/16] blk-mq: factor out a blk_qc_to_hctx helper
Date: Tue, 12 Oct 2021 13:12:15 +0200
Message-Id: <20211012111226.760968-6-hch@lst.de>
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

Add a helper to get the hctx from a request_queue and cookie, and fold
the blk_qc_t_to_queue_num helper into it as no other callers are left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c            | 8 +++++++-
 include/linux/blk_types.h | 5 -----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 38e6651d8b94c..e1d1f2109bbed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -65,6 +65,12 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
+		blk_qc_t qc)
+{
+	return q->queue_hw_ctx[(qc & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT];
+}
+
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -4040,7 +4046,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	hctx = blk_qc_to_hctx(q, cookie);
 
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3b967053e9f5a..000351c5312af 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -505,11 +505,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
 	return cookie != BLK_QC_T_NONE;
 }
 
-static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
-{
-	return (cookie & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT;
-}
-
 static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
 {
 	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
