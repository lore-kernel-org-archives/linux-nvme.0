Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FEC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:08:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B1164ECE
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B1164ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=coJeqFGvjsZTqDxXInsUc25ni+pCSgZRyLdpewcpNv4=; b=Qikl/sd0qbqdiDkZ2YWlfWJ53u
	PNrwzt6WtP+MwndsJCd2p8u6fQaz9eAhKyzMH1x8XPsbaODtgsWxJItX8eaUckbEYj6rYoPUBjWwC
	j1/eokJWzY6xSogSaDiZOaAB8kSRJKQNvZZpDYU8DDtb+I9mEg2KMWB6esgyQvjSnSJxDOPMgU1Ld
	z6bHrjukAmzMYOb9GtvgSnRpIegC/d6aSsMhNNZAypmQ/3Td0kXKtMrCDshBbWO8dMcIosCCrOFuM
	njfgb1dHxuNReRPsHyUU3lEAqXat+8XFpMkkLvML+IEL6/kRljVnhwauZwefdHJkvWywE9ina6TmP
	VfOEsrIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6gRI-00026w-Vi; Mon, 01 Feb 2021 21:08:53 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6gRG-00025f-Lx
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 21:08:51 +0000
Received: by mail-lf1-x129.google.com with SMTP id a12so24836353lfb.1
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 13:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=w4xw7p1Zqxhp9EJUU/TzfN5yh7Qdrt0nLCbnKbIp9fE=;
 b=rLUugkAhgD6L2nsGFHFaOvNFiWi4R3D1yhuFhsxSUOuu7lvabvkkyRzdXbGGG3KWH0
 zB7PsivQxvFzOkNfXXfngiUsLWWj2FY+/6L/Gzzu6JsACROS8yD1/1lpbkx+7j6Bpeop
 P+SikBRBou5U/Ea3DQsqIDwhyo4P0ASjWKGkozQMtZYAWQsOfXFdZIY6KYWtzy9HatFe
 LtwED+LmCyFHcMW37bRbfvfIZu6mnQ9+j6QSNQQAOs6SeLbFUYdXtWM8T7w2m4vTQiqA
 Hx9IhnWjG169RH1Z0gUVv00BjIv/9jkLqXYYSitbHed46w6wzUP/ETjm4DdGw+qIh9j6
 /Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=w4xw7p1Zqxhp9EJUU/TzfN5yh7Qdrt0nLCbnKbIp9fE=;
 b=CGnMwh0RVtScUiz8bIxCqN289WT6XmR8OuAXxP7fDjaMH57pu9jDbIqqR4ERI0hWyL
 jkGFs5RWwGqY2kKRiBTnANlUSSybjlsQ/kumBmrNcHeoa9T7pzNPQKwH/TH1rlEeEX18
 sekc1IiT8ZxoZphAjKn6FQlzPs4qJgAovRzqxKEPuYtQPOIyLR2AX3/xmw7cKN9T/skN
 in7dN7ibR9Whc21lnhEoDtY0gqZplgnqGA0C+LTNspkMo9SP7L2XXGXhZHaRRmWHNjMJ
 bGP4BJ/0qedHGcI1QADeO8gFlpIFISXfxVQd5NqFSr2TT0Pyq4T0kznDHHvjor+pC8zP
 g3sg==
X-Gm-Message-State: AOAM532UJgIi9mqfntaZ/Mi3m5hw7465KK9OoHJhAyzRaTrVfvPu6XJD
 G8rs183sooaKRIDBX/pTngV/nqDPq6hItnhs
X-Google-Smtp-Source: ABdhPJyoAoXS3JmKTU/9HjAxhgSfVQ51gvRa/Lxtxe8gz5ZSYhQ37sPyXA82/X1DDQyDEepiPe1jBQ==
X-Received: by 2002:a19:ac49:: with SMTP id r9mr9856190lfc.602.1612213725358; 
 Mon, 01 Feb 2021 13:08:45 -0800 (PST)
Received: from nova.home (2-108-107-206-static.dk.customer.tdc.net.
 [2.108.107.206])
 by smtp.gmail.com with ESMTPSA id v14sm3142227lfo.210.2021.02.01.13.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 13:08:44 -0800 (PST)
From: Claus Stovgaard <claus.stovgaard@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: Mark Phison E16 (Corsair MP600) as IGNORE_DEV_SUBNQN
Date: Mon,  1 Feb 2021 22:08:22 +0100
Message-Id: <20210201210822.6501-1-claus.stovgaard@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_160850_759428_82076BC9 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Claus Stovgaard <claus.stovgaard@gmail.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Tested both with Corsairs firmware 11.3 and 13.0 for the MP600 and both
have the issue as reported by the kernel.

nvme nvme0: missing or invalid SUBNQN field.

Signed-off-by: Claus Stovgaard <claus.stovgaard@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..41b1b0731cbd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3242,6 +3242,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 (Corsair MP600) */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
