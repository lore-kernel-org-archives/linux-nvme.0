Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C93C47420
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF09521974
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fmlcxnci";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iMeTXtMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF09521974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NpoT8kpr6T4gq4CKTfshm4z1ahk7cyc+NHHqVKmHltw=; b=fmlcxnciCKmgJzVCBxLew2m/Q
	RFFF8dIzxwOWDL8dRRqCCT8OZYt/I1Q0V2ID/v5derDOA7FPp6O3pYTcUyk/mAqexkQuqqtg1Q1UT
	zPEaiLAcCbzE89rBQR9Bvf+TxrMJvjsA/yDKAci7copnX9oTy63q4mkPBqVa07yONJZn3XqvDpjIg
	5X/LfXpqeattKEJatBTv9mnCwoS1+z0n7FX76sajraoVsMNArdSJwbKAIlPIo8xPNqjRonesDD4jC
	Yl7U6OllKBE0BBsP9dtdjTSYA/0vkSPlQl7N6q7WwOMAGpOk2GUixhSmCHx4yu2mW/Gc3I9X7qF1f
	WE4zaWEdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsN4-0002Kb-Jf; Mon, 28 Sep 2020 12:35:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN1-0002Jb-7w
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Bg1aB199Xcrh9A70zWvmAH67ImUyLc9Xz798lZttJbo=; b=iMeTXtMtb+8dZryjDcLNkeK/43
 5krUP+R8jaAKTuoDLX6Iz3+RcflPsQuvFcCAsjkzryPp8ulYpvRhUfYRKQgOlSfx0Ld5VRtTPfrCP
 JrQas1cdRA4cKjNVMbN+fNzHN3ZdJzUGyhlpdWht+vLjzul6osHNWS/K1dZK28pffuYmBbQqiErAL
 ncJSJw4Ie2gEFEn9BguYaV66vkY6KG7rzcqHmBuxNPNcePt7ub380FKEIlW7fYS+/ubX/3/Q6ejzz
 w2YLZMc2/Pj6wzYCdzjh/pDXrJF6SkhEu6TTXxXwXf6VOXWhrFw0lK2zDBSUV3x/8oNvCRT1jgh/m
 joCvuIaA==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN0-0004hj-1y; Mon, 28 Sep 2020 12:35:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
Date: Mon, 28 Sep 2020 14:34:43 +0200
Message-Id: <20200928123502.435373-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Always return BLK_ZONED_NONE if zoned device support is not enabled.
This allows various compiler optimizations including the dead code
elimination that we so like for avoiding ifdefs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8e77f12de52214..1b81b2766858bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -692,7 +692,9 @@ static inline bool queue_is_mq(struct request_queue *q)
 static inline enum blk_zoned_model
 blk_queue_zoned_model(struct request_queue *q)
 {
-	return q->limits.zoned;
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		return q->limits.zoned;
+	return BLK_ZONED_NONE;
 }
 
 static inline bool blk_queue_is_zoned(struct request_queue *q)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
