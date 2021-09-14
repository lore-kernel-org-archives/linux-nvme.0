Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD8261163
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DD8261163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IcHpQHkRcSoyix8RtQ0WTAfS33nQPxQWPhN8zlEkHvs=; b=4KCqhTlU7tVrsc
	EkLzeBsNBzjG9xn2fHm4n84LWorZgR2c5Ug6k2td+hK8KUDPyuc/XJy1n3/q15wAWoUqPUXyAXbA8
	k6V/PLUN05M+n8YXwc03vELMMKuIOhwl3Kr0a3pEjWcM+Kk21wFJ9A7LqMaeIRkS3HuzOY1Mezjxb
	1ZKUhXJWjhr00GgxYqHBOGxUf9DyGsK8zFQ5oMo2QqPGMlOb8trg7s+G2gd4nZblw+rlzgb6HmGPy
	ImilM/oCblWE+slqqbeOxvoZBFWLiZr9h4zKyAAnswSnE9SvH8rHoLayJMv9RB/FOb3TvnF4QXrv6
	cDILfoGWp6dOqIyS2eWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2Z9-004ODs-MQ; Tue, 14 Sep 2021 07:09:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2Z7-004ODW-Om
 for linux-nvme@bombadil.infradead.org; Tue, 14 Sep 2021 07:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=KWp8vmMbO3DtgMY56aSxL6xJpVznvKrsjuA6ZN3BFII=; b=jvhcc4Dmh6JGN2s9dUbyLwHkPo
 guM0ns2j0mujP1pPqyVnJjMoTKEikOu0LCMVU2C34ED6HjKo4V+RM/kmH9N2Hgys5pmF7cWU08Wky
 RPpfe5+ZyPlnAw5qyulvOfPRDOEmXB+jJAEF9vUgSnW0TVgQTEQsscllqv3Q2RYA5viMDiDKZgLIP
 /fQrEAfKkCxaKBI8osl0XUGAZspM3E+9g5+VOw1r5VPRangFrZSxD2chuTT/by01Oon5vDvqY8njR
 RYjN/pAykXa/kkYIKYc9C/q3MkCvmsyv5jOxBhNMUZuG/40rBsgT2aaH2aQjHfBLSyw7aN5iKKg60
 stSkZhVA==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2Xx-00EMpg-FX; Tue, 14 Sep 2021 07:08:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com
Cc: Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] block: check if a profile is actually registered in
 blk_integrity_unregister
Date: Tue, 14 Sep 2021 09:06:55 +0200
Message-Id: <20210914070657.87677-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914070657.87677-1-hch@lst.de>
References: <20210914070657.87677-1-hch@lst.de>
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

While clearing the profile itself is harmless, we really should not clear
the stable writes flag if it wasn't set due to a registered integrity
profile.

Reported-by: Lihong Kou <koulihong@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-integrity.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69a12177dfb62..48bfb53aa8571 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -426,8 +426,12 @@ EXPORT_SYMBOL(blk_integrity_register);
  */
 void blk_integrity_unregister(struct gendisk *disk)
 {
+	struct blk_integrity *bi = &disk->queue->integrity;
+
+	if (!bi->profile)
+		return;
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
-	memset(&disk->queue->integrity, 0, sizeof(struct blk_integrity));
+	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
