Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4999C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:51:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6986661178
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6986661178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3FWyQmGNVVWnna24LbTIufmxV2hODW0chpXPNfPzvwE=; b=d98FCqi5J32Hw809R1Zx844Jgn
	RM1j5tj5OrMZJW7N+ti0Ezzf+UnA2Bm8la2/zlAydg2b3szLrXJAFVr8qNxFNLPpJYdtwcofik5id
	pEDqE8iBlGY1QIqs3X2LDQPrEhFQcQw7yNCO5eG+0njXPAWM6D4668oHurPigy6ukjvs9xs6+pfy1
	lrRZyXIw7xQ3iVRtjGsF2lk51wEPdSeJwLcYiG9Nozf9oy4phdWIc0bjNT2FMuEq1NsAbm8oOugak
	gyka1rQo2RIFsp/O1V/c8IckwsIbIoP+oUt2tIjMzIPwpJli58c+MBndH59zT/czFNQOEmyocB15g
	qoGFlh+w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUnnS-000Jow-Ns; Fri, 09 Apr 2021 09:51:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnnM-000JoO-2f
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 09:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=sopaA0o/Nycia8PbizIwGT4KsDjD1U1jYgKDNZptxK4=; b=rPqG23/6zXE+ABdkoVQ+XyEjZM
 OszFJP910PHhS8NGfJjKTqOqNIr2Awf3B7aPzx2abW0A6Cl1GMVtWOAPM7DyRL12Xzc8A4p8+PA+w
 uIrVijasmhTyezx9Vurr69wRwbd6Ye1j9yqX+BFyjv0rRwItpcBrkgOJkIiiS4p5Bh3o8W0DwcQI9
 pMY5mp2gqVBRH6xepCFWlK9803p2/CXg6oAozdylo//mpvo9uMBfpbJjn7Kmj/BRx/Mce6B+RAFpy
 galceVKyYbgeVycvbJpWCPJud/9Ne0+unB4gu3//WpX0flDeDI49t6krskio6L4C0JQ3AemuQJ29E
 UDiqo2XQ==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnnK-00442z-99; Fri, 09 Apr 2021 09:51:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	Peng Liu <liupeng17@lenovo.com>
Subject: [PATCH] nvme: do not try to reconfigure APST when the controller is
 not live
Date: Fri,  9 Apr 2021 11:49:05 +0200
Message-Id: <20210409094905.1920747-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
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

Do not call nvme_configure_apst when the controller is not live, given
that nvme_configure_apst will fail due the lack of an admin queue when
the controller is being torn down and nvme_set_latency_tolerance is
called from dev_pm_qos_hide_latency_tolerance.

Fixes: 510a405d945b("nvme: fix memory leak for power latency tolerance")
Reported-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 63a1e6cc27acab..f3c7b1cb2c7c8c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2740,7 +2740,8 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 
 	if (ctrl->ps_max_latency_us != latency) {
 		ctrl->ps_max_latency_us = latency;
-		nvme_configure_apst(ctrl);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			nvme_configure_apst(ctrl);
 	}
 }
 
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
