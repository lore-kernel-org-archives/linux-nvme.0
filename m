Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE50C88E66
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Sep 2026 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eBO6SffKp663hVRNkIfFT8s2g2QggGSwKkRITL4bOqY=; b=mxGZ5HeCLo20oeirF6XfBajsEm
	Iu0ptOAuOQXKGWbjNvqzWFTnA7W5y3wghhD5JNCjHHiBxo9CYZ5hd3nEXItmRFbhNQrWHRJ7wdOkU
	cTcOrkqL885k0OOBbEgvloJe6xdFs44SJwEGJiNJGQlCbeLYnbr64kkQCxjJ0pQiW62Do6HDjDJGp
	AIvpT4lsQI/rNJbuO0KtvpqrmcjJlPy6/hQfT3Tkew1ngjToOuPbU8+LujrRlkqY6zdkAhz00+4qn
	Y8VSlt7p+fRCMklFAtOOJ5hAO1E0RjYvymVfEgijIs6RJOtZt6F3+CPyX9L+2KD0QmDk25S/rKjaj
	wTcn6pZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5jgY-00000001fjn-0xwZ;
	Sun, 13 Sep 2026 12:51:54 +0000
Received: from [101.71.155.101] (helo=mail-m155101.qiye.163.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5jgV-00000001fj7-18YD;
	Sun, 13 Sep 2026 12:51:53 +0000
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3d7;
	Sun, 13 Sep 2026 20:51:34 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: sven@kernel.org,
	j@jannau.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH] nvme: apple: tolerate missing power-domain arrays during cleanup
Date: Sun, 13 Sep 2026 20:51:33 +0800
Message-Id: <20260913125133.109849-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad2b1bc03a1kunm9c0a61b5251170
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEhLVh1JGkkdSx1OQxhMQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=ackSGboRSNuCuZ57sJ91HEbURwSUaVnCkWycMJT+AREczh5LIlb8KI25ixXy76OOTVDw4Gq+f9PKqqWhuhXEozzGvSknBczTyWIgtHekveabGeyQYP11Q/Dn+ymwhj3Uy07l8mxlt30MGhac2Hk4Asvgya0gqUKSwtlh67jUU5g=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=eBO6SffKp663hVRNkIfFT8s2g2QggGSwKkRITL4bOqY=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260913_055151_951608_3B5F0BD3 
X-CRM114-Status: UNSURE (   7.83  )
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

pd_count is set before either backing array is allocated. A failed
array allocation can therefore reach cleanup with a positive count but
a NULL array. Check each array before indexing it.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: eefa72a15ea0 ("apple-nvme: Release power domains when probe fails")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/nvme/host/apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c63e28c75766..b7835e736d82 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1398,9 +1398,9 @@ static void apple_nvme_detach_genpd(struct apple_nvme *anv)
 		return;
 
 	for (i = anv->pd_count - 1; i >= 0; i--) {
-		if (anv->pd_link[i])
+		if (anv->pd_link && anv->pd_link[i])
 			device_link_del(anv->pd_link[i]);
-		if (!IS_ERR_OR_NULL(anv->pd_dev[i]))
+		if (anv->pd_dev && !IS_ERR_OR_NULL(anv->pd_dev[i]))
 			dev_pm_domain_detach(anv->pd_dev[i], true);
 	}
 }

