Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C24C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:18:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877EE61008
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877EE61008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7JSjpNfaB/2Dzku1iQKtYtLkN0nY1Ze9Ed77XWRS9IU=; b=JjudyXKta9m/6b
	8LYtk8yZuP2vTiwu9nFYO+rXYgu719RwNerGLPAih56u5KOH4ri9Zh0M3eh0eVc918vkdwY4C7wlW
	8X8XTtpmejhsQs7WrIwKlLPIjssL+xmTK5/Yg7WERXpgGbuuJVBG5rq8K0MGIAKQX1eDMvIj+JbrL
	Sq04hex2IHpZL1QEeJl+fRIlOJNPul9OLCM8tlK4KTVJUYEBIt4Kuhopr2vwzE6atx7IHHhq8Iblw
	75qwOFphYBViMenIxIy0NPhb17Dc76ATHIDjSKdaGngLHJIAXCRTa6l7WdZ8Xh4GhGSVS67olshZW
	jx2eP9EY5HnYce9JYvuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqZks-007wzh-4l; Tue, 08 Jun 2021 11:18:46 +0000
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqZPC-007ot6-Aj
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 10:56:24 +0000
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c184:ea65:c3d6:a616])
 by albert.telenet-ops.be with bizsmtp
 id EawC250031G4u2S06awCew; Tue, 08 Jun 2021 12:56:17 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1lqZP1-00EOq1-D6; Tue, 08 Jun 2021 12:56:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1lqZP0-008IPP-RD; Tue, 08 Jun 2021 12:56:10 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "David S . Miller" <davem@davemloft.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Omkar Kulkarni <okulkarni@marvell.com>,
 Hannes Reinecke <hare@suse.de>, Dean Balandin <dbalandin@marvell.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shai Malin <smalin@marvell.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] nvme: NVME_TCP_OFFLOAD should not default to m
Date: Tue,  8 Jun 2021 12:56:09 +0200
Message-Id: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_035622_548626_B61BC5BF 
X-CRM114-Status: GOOD (  10.21  )
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

The help text for the symbol controlling support for the NVM Express
over Fabrics TCP offload common layer suggests to not enable this
support when unsure.

Hence drop the "default m", which actually means "default y" if
CONFIG_MODULES is not enabled.

Fixes: f0e8cb6106da2703 ("nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/nvme/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 9c6f4d776daf14cf..f76cc4690bfc37bc 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -88,7 +88,6 @@ config NVME_TCP
 
 config NVME_TCP_OFFLOAD
 	tristate "NVM Express over Fabrics TCP offload common layer"
-	default m
 	depends on BLOCK
 	depends on INET
 	select NVME_CORE
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
