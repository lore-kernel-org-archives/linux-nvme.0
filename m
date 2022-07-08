Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2217C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 03:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PZVxnbJKGIZ/b6lx+jibOHgJAqRgXiux1XWXHznmPRQ=; b=lylMzOeR4y8JtpuiHSqqMVvtEn
	Pe5KgHH+umDfh8RUv//HEO/ym9Ory1IpAF9mRV47AS53p0uYv02Dux+6PLBOggtZmXJ1mdv++/D9j
	GVK6nlDOeVEe7B93cl3h8uBbmug3r010eMzVT0VRByTK0e4MUl2UriW+0M2AcPPfv1/32IQqNsAg+
	BZTh54KWXqTV68tIGv1yxQj9CoRgr8p8mCQAz33f4INK+9J5aWsTCiRzGi//1pKZKIcxgL/VDXP+x
	y3C4lZNOMVqApmdB9jRm/mJ+zcrsHqZiu4w3fjSHxgI9aWxBiAKRbO7yaJ6ktzT+oAa3zG1SUM9jj
	Rh2b2f6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9eK0-001U7M-Jc; Fri, 08 Jul 2022 03:06:24 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9eJp-001U5G-PZ; Fri, 08 Jul 2022 03:06:15 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VIhbwkX_1657249565;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VIhbwkX_1657249565)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 11:06:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-apple: use nvme core helper to cancel requests in tagset
Date: Fri,  8 Jul 2022 11:06:05 +0800
Message-Id: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_200614_042987_9D1150B4 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use nvme core helper nvme_cancel_tagset and nvme_cancel_admin_tagset
instead of same logic code.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/apple.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index d702d7d..7816b5a 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -845,11 +845,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	apple_nvme_handle_cq(&anv->adminq, true);
 	spin_unlock_irqrestore(&anv->lock, flags);
 
-	blk_mq_tagset_busy_iter(&anv->tagset, nvme_cancel_request, &anv->ctrl);
-	blk_mq_tagset_busy_iter(&anv->admin_tagset, nvme_cancel_request,
-				&anv->ctrl);
-	blk_mq_tagset_wait_completed_request(&anv->tagset);
-	blk_mq_tagset_wait_completed_request(&anv->admin_tagset);
+	nvme_cancel_tagset(&anv->ctrl);
+	nvme_cancel_admin_tagset(&anv->ctrl);
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
-- 
1.8.3.1


