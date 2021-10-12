Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:24:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9950F60F11
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9950F60F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5UFrDf4zrkv+OYVQW9OtNP5c8vamEjnu+1wtc+C2TG0=; b=g7CBBghqIzdBQq
	s5IgJuDRfuXoEU9CpsYPMhDN5Ve864rG06MnJLg7m6m4HA7wUHh6HkGbBY4i764uaeeB2AXoE783J
	PTeTqhH3p+HI8l5x9i4QWJRULzT4DQ4gD6/2GJZjicI2JHDff8vvuN9RNoNQFCCfDcO7nu+z8JYbC
	GyHXE14NVOLjqDlihYmMVYLzTP/goeFtikcc5EeHvn3HyJumhOQshAbITm9SqaIsa/hs0BPKcWDmE
	g6VXV4OBkBfnB1ROdGKKP2CZS5imoTGJVBBaHu3/x5HdTXFzQ2RRrpSLSPLMnz4i9XWnGvs3nzBOA
	nxiFFNAjVjXWGLA/2Nkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFsp-00Ca37-10; Tue, 12 Oct 2021 11:23:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFsK-00CZpG-5V
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=kir2JiMTS1q2pXQcBcW1ulBEweYc8IXY5W5Zz7iGMOE=; b=uQyMkkOyShNoTyub1objPQjJWt
 +Tm5DoD8zbcuhgzZurJEz0lHKb2KplcyconKRewwBbuNgISfT+saGeFvxuJg3FmQB+gamZMRLlhS5
 hFFFB8JwbfJMziU4M6U0oOdHLnd8gjH6+mZfQUQcx06pAdNciGceUH9SVbNyKRboiSlyp9q3ccdAY
 LiO4W2qkfCmtMwNzIS2GA5LQbsgKDZmSK0GXcWiP6f/a53B3yrDG3Qa8gGlVrmEwvuECTw0aqFNnH
 8GBsK6EzuEdSH2TbvACcK0v9Rw6aa7eggZBO6zueUKQimKjSxP020E+0EogSv/ShgK6hdXyo088oO
 NaAcOTVw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFrA-006RuN-4v; Tue, 12 Oct 2021 11:22:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 08/16] blk-mq: remove blk_qc_t_valid
Date: Tue, 12 Oct 2021 13:12:18 +0200
Message-Id: <20211012111226.760968-9-hch@lst.de>
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

Move the trivial check into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c            | 2 +-
 include/linux/blk_types.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3d65e79a11db5..ec2bee3d19f2d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4067,7 +4067,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
  */
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
-	if (!blk_qc_t_valid(cookie) ||
+	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fb7c1477617b8..5017ba8fc5392 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -500,11 +500,6 @@ typedef unsigned int blk_qc_t;
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 
-static inline bool blk_qc_t_valid(blk_qc_t cookie)
-{
-	return cookie != BLK_QC_T_NONE;
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
