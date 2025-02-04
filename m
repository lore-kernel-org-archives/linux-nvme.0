Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC48C02194
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=re3PSxTV4DNU5pVphE4C5vvtq76V/ASBC4zGcW/yfQQ=; b=kM9pV6yP8l2Hiv6RNPld3x2Z71
	bmdLz9lpxLXVNiZBc17hbm9pIEC3m40Uc+z9VoXoFY8FCO697y5f5VCejTEWzidqx5Vtnw/XzrBoi
	PrzRZcYeQth3flAdmvh5DsT+40v5SL4aXSQymdKqX4YMtb6g8MljGyYXa93KW9Q/6dIPW4CDgUedg
	w7KA0TxmIVSMUHkDxCvsGTDdyuOflMYUSwOrB+kNncHD2P0qVB/2X67JZZz/3L1b1xXoQMpQ7LSkQ
	xSZhpkuRYDmTtdcK5WTodHWCyoCs9CTN+zYhwwChSBQ7r1NpReRGAmh4y3IdqPHKAjz4VcyomELvQ
	iyQWFwgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTV-00000001qPi-0VEr;
	Tue, 04 Feb 2025 23:37:01 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTT-00000001qNX-0Qld
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 23:37:00 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so11629323a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712218; x=1739317018; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=re3PSxTV4DNU5pVphE4C5vvtq76V/ASBC4zGcW/yfQQ=;
        b=H8xj2fRPVzPBEPvbgroauNqPLol2Dpk0C4vVfieTYnDxGVMJIu0o7P1R/7eJjILAON
         7JVMONJ0lJ3t9IQYDlhEff1n8qADjqWliV3a7VESKALkLoKck9gZs4lZgQkEOxpCs3+9
         s7vp2YFLRiY+uXibuq5tFEJFBg23+s+cy0EuO1PQ2XpV8usk2UaYFnCjYeJjhmw3Ugwi
         mD7eWDz/oguP0h4W6vRumKMSvxlGuFU57uj3pJ7QbcO8F0NrDqfD2MpYLflkz+gdBx8Z
         lMvHRFBTlu8sJUOTWANTRooHuvuEfuRZCewwz1OoY1mw0WI5pWjMiFvj2c+f/GG37i3l
         tX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712218; x=1739317018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re3PSxTV4DNU5pVphE4C5vvtq76V/ASBC4zGcW/yfQQ=;
        b=o+dYAMpPI7e+0Ctf/QSyz4DXEp69vw1lf4JNz10aTI3UaOTwQoURxxKsQOvmvm8bOr
         6fsxTH3jqJwdUKLt3RCvFlQkVJ4RpZZGmcb4emp0TXEwckvGVpnWAnxxDSGwegByq3YY
         CyXeDT2Pf2plVgCOvBl3Xq4fzjseFVFOifsNRVdXd2p8njWJmBy5X9agYdkt2/CJGhM2
         D6lmsJlt14R2Er7PBJKS5ZP/DUuoFAW+nkdSYOKjg16gcbkFZXXvu2JP8u17yD9YkLeR
         539TQnhaVg7CCRVkHcfJYGGNEDSgQfo8qgApS4hZNvXnXS+Jf06QgFLoNcpfLO8KFTxH
         HFnA==
X-Forwarded-Encrypted: i=1; AJvYcCVQo0EkJSxqAmZ02ceDdmHJOazH9Hib9xz19b4skp6v22RIncg8Db8fU+8y6qX6e3jnIG3G3PMIf/NN@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf8HdgaNG93xXq0wNjSJssGawa5cR/lO9ul/U7iEMpwC2YgCed
	8aw0R+eUeEL+xSc6ktf4JKHISgRqoD0S1ewui4/SPdLiieFGn7ZP5vXsup60QdRh8udHe/AIHg=
	=
X-Google-Smtp-Source: AGHT+IFjLwbq46SXedWka0QmmBPXIbrzOFu+JuTwezZ4xvg82r8SLnEq4/vkuBjZR0vrrtV6EJI24Y1VSg==
X-Received: from pjbcz6.prod.google.com ([2002:a17:90a:d446:b0:2ea:61ba:b8f7])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f4b:b0:2ee:aed2:c15c
 with SMTP id 98e67ed59e1d1-2f9e083cc9cmr935737a91.28.1738712217752; Tue, 04
 Feb 2025 15:36:57 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:30 +0000
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Mime-Version: 1.0
References: <20250204233630.3407878-1-jxgao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-4-jxgao@google.com>
Subject: [RFC PATCH 3/3] set full_buffer_write for nvme devices.
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_153659_139011_E4A58F02 
X-CRM114-Status: GOOD (  12.80  )
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

NVMe dma operations always overwrite the whole dma buffer passed to
the device. Making use the newly introduced full_buffer_write flag
so in cases swiotlb is used to bounce the buffer, we no longer need
to do the extra copy on preparing the buffer.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 278bed4e35bb..8fb6a0a87202 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3209,6 +3209,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	else
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	dma_set_full_buffer_write(&pdev->dev, true);
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-- 
2.48.1.362.g079036d154-goog


