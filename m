Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FCDC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 15:03:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E26020829
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nogci8M8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QudsO20Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E26020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nCVsH9o782S0BZITE0soTmXQ9yrgyDP0nTPGMOEAwmE=; b=Nogci8M8ENbdjFYsTwH1aZELTh
	3iuTCQOFm8pogD+wcBPI5PNKXLWU4+Wa8D4SSPjfLlgqtvaQ0QVkiLX5P10Pg38o2L0zfB+ohy3oi
	QYjJOYXHcNvMxYsflmoXJsSxWv4tDQ/MFhL8hoOc11lueHbAOxGLx3VAkYY2nhD643U1C9mUzHpT9
	u0p3rWaUhKKQCzZoIQh+XNrvFbZ0CFcX0k1V44pLMPtdkgJIlNTBNrLAhURfSU/r+2woZ+cgDVXN6
	Fka/skD2yuJQBt+BmwP+vl+azmH/JpSRamd1zvDEeYp7yaQui0Q8eGXJULOWmuwhWK3WfO5w4zTkv
	bUj7pDrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHq10-0007rV-6K; Mon, 14 Sep 2020 15:03:34 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHq0w-0007py-Mp
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 15:03:32 +0000
Received: by mail-wm1-x343.google.com with SMTP id x23so354075wmi.3
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oguichTI2JiRh+M6kipMP5TlmvO7QX2E553rfXFO7+0=;
 b=QudsO20Qexc+Ktbp/b4Y3K2E/SCCF3kkzMqHXzNZxpkDra+1CpbXH6bVdbVkjqtZvO
 YbW2MHrCwGzrFdyJh+a6GizWnmcyf8XsQ7ChNgl5d+rCWl5Y/1yhMXl6/hnlE337b0ty
 1zOyYIktjFAR+dOjoSbTBUM+KBG/GRG7QpqL/30sdQtwCM81j2U2NhMgimfeU0J1Fgz8
 ILBSBKK/dfekaXnYV7A3Mktf76hMSGggZ1HfWUqF6YsGmiP666Hy9UwdxabO4FoNQwNP
 bT8Z36ehbnaqgxdpvqBUstw+Y3ciGIS3OLPOY4ypJ2GvGqRgXPU75oZqQ8yCcPnH1evJ
 q97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oguichTI2JiRh+M6kipMP5TlmvO7QX2E553rfXFO7+0=;
 b=Z2XtZHlFRGKSpdC1UhB2ClXsU6dGSsizMfeNrr0sQMrDmf9R3qGNhElCFHl+xwCU4n
 /kxXasp1KqNjFBWaQEjrcd8e/uavYck4D5Fb8oXwoDI7rWxKFN/U4k5Jq4ErjHtgWaAx
 ZzPES+OMBdUubFZ+pfYXHyPS3FNi+7IZWEyTDJqrBHYeLpIre/ebuS0mWl3dAJcM9NEG
 7XlBQbJyyzABP/BwQXODdCl+Pp0Xt6rjtIUVkEbpe9bV3dUmqUU1Gm0FLeP8PvMKjwfw
 hISvx6+2LsOCyC+p5wanR+A1izNhRppfFcSXorvsEMsrnzhEnyYXSWipyMS2GgrXKTDM
 lhNg==
X-Gm-Message-State: AOAM532PxgNzG+BGnpV/KpKpseor3h68LAkqP2f1erhJWSAMToGJa9gq
 AaDn1ITcRQhMgX6TFCqLC0w=
X-Google-Smtp-Source: ABdhPJx2lY+MrWtjvr56gCqfupiUyXAQUpFI19jVo/Fv8wbpLoFlzdQNfLBEDFwiZtW3z+bY7XLMAA==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr7043189wmc.21.1600095809707; 
 Mon, 14 Sep 2020 08:03:29 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
 by smtp.gmail.com with ESMTPSA id i3sm21214910wrs.4.2020.09.14.08.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:03:28 -0700 (PDT)
From: Necip Fazil Yildiran <fazilyildiran@gmail.com>
To: sagi@grimberg.me
Subject: [PATCH] nvme: tcp: fix kconfig dependency warning when !CRYPTO
Date: Mon, 14 Sep 2020 18:01:21 +0300
Message-Id: <20200914150120.449602-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_110330_779359_56569806 
X-CRM114-Status: GOOD (  12.78  )
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
Cc: paul@pgazz.com, Necip Fazil Yildiran <fazilyildiran@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 minwoo.im.dev@gmail.com, kbusch@kernel.org, jeho@cs.utexas.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When NVME_TCP is enabled and CRYPTO is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_CRC32C
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - NVME_TCP [=y] && INET [=y] && BLK_DEV_NVME [=y]

The reason is that NVME_TCP selects CRYPTO_CRC32C without depending on or
selecting CRYPTO while CRYPTO_CRC32C is subordinate to CRYPTO.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: 79fd751d61aa ("nvme: tcp: selects CRYPTO_CRC32C for nvme-tcp")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 3ed9786b88d8..a44d49d63968 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -73,6 +73,7 @@ config NVME_TCP
 	depends on INET
 	depends on BLK_DEV_NVME
 	select NVME_FABRICS
+	select CRYPTO
 	select CRYPTO_CRC32C
 	help
 	  This provides support for the NVMe over Fabrics protocol using
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
