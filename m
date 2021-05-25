Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60CEC2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 16:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37F861408
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 16:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37F861408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qp642uYDW0irHjM00XNTaR/O8dZuHIBwhWa2Jrjd9kc=; b=AQ1rFoGjOHAsRW
	teC1ACV7BUSZkjwU0Iedpm6BDjORgiCuZqqw8u+dmBjAQv90gJk875TkMJBVHYRLfHpVm3eecJHpb
	o5zUYUCIKFMgxXmAlg2K8OJNV9cmvQv3/4jgrmr+LGtQV6nLSIPfyygy1MHBTbyRoIVzt+6R1iPWk
	hcxdpbNd39wPD/L36H7vUdY/gF636Gu98OY5WGF9tWfxeIP3WvqRbIfavgGUKgONXAqtDIF5csjwf
	7ptRFgb01cFqy0dIP8F+gjLjxqd6V94Uds5Wn5d0fDOxRpkL5/Qh7bR7tkb52do4QN6k/H29eHm+C
	VGlF3YNMSyiqx3cpvWMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llZoh-006Nov-TM; Tue, 25 May 2021 16:22:04 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llZTB-006DGy-PR
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 15:59:51 +0000
Received: by mail-pl1-f177.google.com with SMTP id u7so8008522plq.4
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 08:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WcCm8z3GYXQMFTEEg55Tg3XehkEIVqYlJHNCXlbMklM=;
 b=rqGUtiW6/6ywSe41jKVbsIMRJNQ8eHMV7DVjbZXc47fPpMVWKCJ1HijTjq3DS3iHjj
 N5rYc6PhfBW+hE5bhSdkj+1tfv/67WLjz0pSU65JfwRPt33Efzda2UKjxNaSQOOCD+8R
 SabDJ8TfsT8F4d+VdjRzMbkFrBqGNKX+odRtjTQaVRR1FbdFBj7K94VYGaLHRvRdA/UI
 JtugRAr48Q6cVA8P93B2Uuub2QyhsRyFZ5iDye/qPnOKbsxQc3OOVSuyrB13Qs149PwJ
 2B8GkK/MbTIyJUtL4pNN/YtxuYSz1a6ceia8tuWDpw4XQQfglN3qyxKnnXK+Iqaj7XOY
 ZDzA==
X-Gm-Message-State: AOAM532MUh4FM04TwV2MVIYA2sAWNyxR2t6X8cTCAvQ6ZUHYrFEVIy39
 KSIs3J3S9RTFU88nEUPCKNwT/TOSJoI=
X-Google-Smtp-Source: ABdhPJy8z+yrdK7PTXeogyWK4iv3zxD2+KFQWRQkoSkPMrDR7s/ewepdrS+u9RcdOQd3s7vPCcM9lA==
X-Received: by 2002:a17:902:c112:b029:f0:d571:8fb0 with SMTP id
 18-20020a170902c112b02900f0d5718fb0mr31410652pli.11.1621958388609; 
 Tue, 25 May 2021 08:59:48 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4f6:7b8c:d4a2:7714])
 by smtp.gmail.com with ESMTPSA id w11sm13721901pfc.79.2021.05.25.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 08:59:48 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: Have NVME_FABRICS select NVME_CORE instead of transport
 drivers
Date: Tue, 25 May 2021 08:59:46 -0700
Message-Id: <20210525155946.2249322-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_085949_858334_E3B3CE4D 
X-CRM114-Status: GOOD (  10.96  )
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

Transport drivers need both core and fabrics modules, instead of
selecting both, have the selection transitive such that NVME_FABRICS
selects NVME_CORE and transport drivers select NVME_FABRICS.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index c0826b3c617c..b6b731db0353 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -33,12 +33,12 @@ config NVME_HWMON
 	  in the system.
 
 config NVME_FABRICS
+	select NVME_CORE
 	tristate
 
 config NVME_RDMA
 	tristate "NVM Express over Fabrics RDMA host driver"
 	depends on INFINIBAND && INFINIBAND_ADDR_TRANS && BLOCK
-	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
 	help
@@ -55,7 +55,6 @@ config NVME_FC
 	tristate "NVM Express over Fabrics FC host driver"
 	depends on BLOCK
 	depends on HAS_DMA
-	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
 	help
@@ -71,7 +70,6 @@ config NVME_FC
 config NVME_TCP
 	tristate "NVM Express over Fabrics TCP host driver"
 	depends on INET
-	select NVME_CORE
 	select NVME_FABRICS
 	select CRYPTO
 	select CRYPTO_CRC32C
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
