Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5EC43600
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:16:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8335D6112D
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8335D6112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=brtU1PZ7GZjNH7WRVZBtmnVqOTJnY2EkOkfXqZv4yHg=; b=HmhCCfps+3J5GrN0AEP/Vqxrj
	sQCMaGZpGCvenZLakMb42eZsPUCZpS1eTF/3Axhg3Srw+KsLnB1LuM+6Hqi7k2kG0oY2p96Can+F5
	oMX9WVrYLr7kcElWPTlVz9x2VXfjVGe6gC3KBDNbxtplBeflgRL5mewkOd8gl/iJkRon+tbuBGm+h
	v1fwCcGJEPa1xHJ8FkUIlmnP1cYuCtGPxRSR9o+PjBdCOf0xsvq1Gjz3pppBtNNMhWVX1XaRskzm9
	6r5SzvtlAEWeJXNmUFkviUCBT+/xFk4y/eOBMDiSSwumxfhQrHcIznV6VUDh0rQDizyo1bK0XxBb1
	/w0B5ztpA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgoj6-002rgV-7f; Wed, 12 May 2021 13:16:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiW-002rb8-6p
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=3NRasvAJk/2IumrVSjqvjwNMNfQe7gR4L2NNKEmN28E=; b=xiciGPBB0X7upEVxij2f/rLkt5
 vpMtOoB3CBp9qamjDy9frNy+A7oMOlDS2nFc2BGcbCIwgn+CfpM+qR04B5fQ8/QM7svg3cU2bka2S
 jR2vY67Z9EV3wGBSxsoQo0dd7yw/B0Ql5V7WbOLxmcE107uQT/Th5zC1acb3Aw9XmCqeTCgA1S1SZ
 va3kFqgHNjsU0wZtdNLIur055hFHpqQZ341yX8QBAMGucq+j8fuROVowwAPmzqW1dvRH1kK5kxkYw
 /wtuEPdjP0BjwPo5oYGwpOo/BIbv/uxTF9KO1yorV6mVhaCrHgtxXhBVlkueZNPdXCI02iC6EpYA9
 IR43fo5A==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoiU-00AO2J-A1; Wed, 12 May 2021 13:15:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 04/15] blk-mq: factor out a blk_qc_to_hctx helper
Date: Wed, 12 May 2021 15:15:34 +0200
Message-Id: <20210512131545.495160-5-hch@lst.de>
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

Add a helper to get the hctx from a request_queue and cookie, and fold
the blk_qc_t_to_queue_num helper into it as no other callers are left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c            | 8 +++++++-
 include/linux/blk_types.h | 5 -----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 466676bc2f0b..04e17d50fb02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,6 +63,12 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
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
@@ -3892,7 +3898,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	hctx = blk_qc_to_hctx(q, cookie);
 
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..ed71a8d968f2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -515,11 +515,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
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
