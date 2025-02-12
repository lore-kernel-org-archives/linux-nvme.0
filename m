Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625F6C021A0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szz5q8OAuo67lw+94E1dN9/NQa54+wbklwNt3LY2h8k=; b=tExfsFFxYELcRMYHTNoLcsLZnF
	i2upcnl0op7bDaVzKdJFwTdXCl2orJiYN+N+OnfPnP0MM2Xkezen/q9nu0t/ePU0XCAc/KsadhaNE
	JgRPBlwuLSG7BjjhIrPvnv+KYfRQjXtbL9/l9QbpjvsmXCDwngaxYJxMP2nesx0I97CqB6YQBWpQu
	bGxnrrR6ATFlVNyHcaH0aZwuLD5pTK0d80ei7d8w6aQ5H3QzWOAZZr2n+3uzMSrDiqji4bnL9x7G3
	Fe0+rpkmdqQwg+2rnRKbHEaMuJrTqbfNwU1FAAVCI306UkehNOc7ubZMLRU9R9lTZ1V1fP/LK0cnF
	ZnEpPHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGKH-00000008H5T-2zzL;
	Wed, 12 Feb 2025 17:15:05 +0000
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGB2-00000008DOk-1GBP
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 17:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1739379929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b+zKe0hVzTzQ+s0ZD/DkQ4+MPYOf0gUwkcT+EMa8cUdy9CLIk5CjrIzaiPBeZNwAO8O/79ADR+aM1Cf28jzxmdIaJchMRBpoNmgUsz9lNS8jbwreYu9qD7182YMYWp+EW4JJ5pY4yUPHIM2epDXDyo7JqirEi3qVaSv0YcHKh0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739379929; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=szz5q8OAuo67lw+94E1dN9/NQa54+wbklwNt3LY2h8k=; 
	b=WgHE7QrSM//8pKvvyzg6qDLDojXVzDt0Nu7pe4hnPavE1eEXf/rpA+M60tWmygmKmZux7cgj1u7aXAXP2b+o0jnpzOT/6wPY3JYWTtoS5jkw3WHC1/a1EaEHCC/gARPotfXQGymbAMhRGLMIbw1st7XK+aMmldFoMJDA46PJ6hU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739379929;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=szz5q8OAuo67lw+94E1dN9/NQa54+wbklwNt3LY2h8k=;
	b=kQHLMSUuinqM7OLB8gmtM2syo0JuKWEA3hezCUKkmYaWr7fnm48R8ATycr/GqhGg
	6LKSlTBsfbB1r82RiVkKyEm0/2GdVivlLWIUowmyQqrp9bUGfqAWQxms2cH6D/nflPx
	6TCucciJ0Lv77B6YoyssaB8pGwtLHcbzYuNyMt8N7C3Ao8mwWX85t/uIf/ASGcWf4SF
	4KBbDrDATynKLR6W24aqdNH7fRphUgkkc09zPvKXNM6YOjNXplac6/n24xrWbbW45Kf
	6MjgaFeDsOBC0KdhT+ecnrT2LZ6otHMKAEyQDdxmbsoF3yyCJ65jBgQFSqFkWmKk0Hs
	zMauaDdM1g==
Received: by mx.zohomail.com with SMTPS id 1739379926466930.6067351141463;
	Wed, 12 Feb 2025 09:05:26 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] nvme-pci: clean up CMBMSC when registering CMB fails
Date: Thu, 13 Feb 2025 01:04:43 +0800
Message-ID: <20250212170444.16138-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>
References: <20250212170444.16138-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_090532_395744_116B57BE 
X-CRM114-Status: GOOD (  11.38  )
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

CMB decoding should get disabled when the CMB block isn't successfully
registered to P2P DMA subsystem.

Clean up the CMBMSC register in this error handling codepath to disable
CMB decoding (and CMBLOC/CMBSZ registers).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9197a5b173fdf..659ba85795a91 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2003,6 +2003,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
+		hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
 		return;
 	}
 
-- 
2.48.1


