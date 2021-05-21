Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8828FC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 21:51:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E46606A5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 21:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E46606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cDHXdLminJvgJsLY70lP93ay7r8MezlBoA0xZv9jGnk=; b=NNR9xsviS503cp
	kmcpscP5OzE+x3D4+d/kC8ntsljGM4ADS6vcyjBhp/haO6lK/LOrOA6vQgKbFW4ObGVJcMAWY/yRI
	2L3Q6pwlGL/ebOPw92q+Qh2smQfs5oq4Za/c7jMQfTwAgq4fxpNWb07yCIihsJIbvc1wOsGrIUiss
	V5GXCrpI21GTsHIIYCOuYr63tVLuc5F/zAzQv+3Vs/7GqyOcyaRND8D30mN8PaanTeT6iRljKzHzT
	xwEt1UvlwaJ7jqYpUxeayblSiW8hfZqpsIuD6LsIOoQfdlibCbiam3uBJttoxf4gpRHWsv7RxqsdS
	oXKtd893O9pc2UGYWJQA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkD3N-001BDx-Bn; Fri, 21 May 2021 21:51:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkD3I-001BDf-M6
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 21:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=HOEzk02XsGfSPLrlXuJ9f7hWmEEROWp8/2e5lB734ho=; b=x8pwkYyfqfcymt2FvVK/YLLU7F
 18YReD0zOL3Q8cvp2Z+sAVBqT74/93NQnRz9Uhq9+0y8LJvysfv7QT4pqVtriCF7APHiH67ZnAIle
 +FMM35mJ94TIqtpAGmA/MCEbkAlhBvcf0BK2fyeag1pdVxRAaR1Ibtnn6NZ94TGoYtmTJ1qtkWLTG
 +sDts1grHfC5kYizrrp/1vPnR+kPieHZxlc8KSnnLRXfxvp4eSjROJWbLu6vlqQXy0U0l10ZQsWdg
 DNA0xfzcFq6iXM05ywyj6V9KtgqX2iJI1H6O8VzHVEAwolh1Uz5aBu9bhp/ugVI93XCgAfVINmDws
 0muQ/3xg==;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkD3C-00HRbo-KO
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 21:51:23 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso8152836wmm.3
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 14:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HOEzk02XsGfSPLrlXuJ9f7hWmEEROWp8/2e5lB734ho=;
 b=d2uXtKhIKLc0JRPptWiz0NN40Knm3zQIb0iF+fgoBFr+xd7X0rfmEEAvOSgHvshUHh
 MYyqBoMSXuhlKZW6zC+0OA6R3OTZ0wo+h51ClJP4HFN3WQQZCH3UPerBDVR+yiAU7QvJ
 numtcd2yv6ar62zijjEKhe9O5UrNGg0wBIXGHNfTSQW8GDSlIzQ5gynjqwPgQ8/v5AFD
 SgQFuHJprI1qUWQBg2i3HuBUxr2cILxJoE0Tg98dUt2g7vcCY23g9bK2Q6s6iB8CzAcB
 2imk4X3OjXge6MgfSieInrnMUhAkfCxoSoj5lsPd6DRKFNgeYBnO2bvqwT1KiSx/HHSU
 xG+g==
X-Gm-Message-State: AOAM530+UKGImrnwo55lD1x5i/L3YL9E8s1wMSF57NUnTpbPS4wgxMtl
 MjSBvtCuoQ1JzABCCjo2zIIdiFtL+C4=
X-Google-Smtp-Source: ABdhPJz8Ga2XkCXCV1OHYXDN4QVpSMfNiSsG6PkH7lfdlP1AWUV8bSYurekpxndC8Wq3pJ8n8fwVMw==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr11329539wmi.45.1621633880863; 
 Fri, 21 May 2021 14:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id v15sm742823wmj.39.2021.05.21.14.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 14:51:20 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
Date: Fri, 21 May 2021 14:51:15 -0700
Message-Id: <20210521215115.1901970-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_145122_685109_1615A8C8 
X-CRM114-Status: GOOD (  11.13  )
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

We need to select NVME_CORE.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index a44d49d63968..c0826b3c617c 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -71,7 +71,7 @@ config NVME_FC
 config NVME_TCP
 	tristate "NVM Express over Fabrics TCP host driver"
 	depends on INET
-	depends on BLK_DEV_NVME
+	select NVME_CORE
 	select NVME_FABRICS
 	select CRYPTO
 	select CRYPTO_CRC32C
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
