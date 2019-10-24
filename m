Return-Path: <SRS0=/YZe=YR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7992CA9EAF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 15:24:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895FE205C9
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHPKVl0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895FE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4l5zRQEb/Pn4gOfGxvkMV0aLxFJvyGghB6Yml8y9l3A=; b=fHP
	KVl0x9OVuf/h7/IT/ohY9vAaWNscWDz40VObxB8YsYAN836kCmb/k6NLFn+F2eLP8OzMml7Ytu1jQ
	+NEPmnJYfznc2yXq+JD+3iU7sO1IU0wSZG84nYS7T6qopnIPWIOBrwMbuSdzIvlc/SCOiXS4oyOIV
	vN0tg3Pl+xDdHxH3KFTZPtyBLuYVdUctX3H0f0AAJHrcpwHlkfKyx912wCH3h1TvcDwNQAnlUeJm+
	E52vc94/1cEpH2kN55GIJNHXgThjMH4ii3nCcdD9dFKPU2/W8ljMSSq9KVx3j/lp+D7mPwY+q1eqJ
	ePIH1gMnPuLaYYE0v/uJoJhO46hFsSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNey8-0006Mg-6i; Thu, 24 Oct 2019 15:24:08 +0000
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNey5-0006Lm-7y
 for linux-nvme@lists.infradead.org; Thu, 24 Oct 2019 15:24:06 +0000
Received: from ramsan ([84.195.182.253]) by andre.telenet-ops.be with bizsmtp
 id HTQ12100F5USYZQ01TQ1aA; Thu, 24 Oct 2019 17:24:01 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iNey1-00076Q-Bs; Thu, 24 Oct 2019 17:24:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iNey1-0007px-9B; Thu, 24 Oct 2019 17:24:01 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial] nvme-pci: Spelling s/resdicovered/rediscovered/
Date: Thu, 24 Oct 2019 17:24:00 +0200
Message-Id: <20191024152400.30082-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_082405_446633_4EF71265 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix misspelling of "rediscovered".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 869f462e6b6ea01c..dd4a2ce85e872cd0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2982,7 +2982,7 @@ static int nvme_suspend(struct device *dev)
 
 		/*
 		 * Clearing npss forces a controller reset on resume. The
-		 * correct value will be resdicovered then.
+		 * correct value will be rediscovered then.
 		 */
 		ret = nvme_disable_prepare_reset(ndev, true);
 		ctrl->npss = 0;
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
