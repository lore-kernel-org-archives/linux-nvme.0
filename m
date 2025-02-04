Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7169CC02193
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c1qL4ZnXFfT00K7n5zOtqnft++xXZTvzfh0tC//JmKg=; b=b3GwrWQJTFO/fcTZQqyTuTrVMm
	Ca2BuXwpYpW6g5mKixQwc1Q9cu+15kS4IjKMudR+e9cFvi8QYCFWIkdlvUSs/341wyY1jYfN5hWOa
	RhM/C5y8c7PdYqJmbi03F2neO2RjQWDURNziX3nhkmX5qjm9KcB+ykkhzbI7oB5sIUHHefJqPIaX4
	vENDC2Z2ciUsgp//pNjDZItLITwV27pLSzTQTf9YqJni2rQDTdV6Tz/Rp4z4RJxYkMHMplsgUBwUg
	1syHgMkDQUczDpD42kVRlgdcUONRlHuDxYioKPwnciiaM+BpVKcfX01osrmPRE3ZIEWBX8LCGdJb8
	VR8V9fZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTW-00000001qQx-3IrA;
	Tue, 04 Feb 2025 23:37:02 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfSTT-00000001qMy-43zm
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 23:37:01 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2166e907b5eso113927035ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712216; x=1739317016; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1qL4ZnXFfT00K7n5zOtqnft++xXZTvzfh0tC//JmKg=;
        b=dzMbizBeNje5SzWFHwM3i8eF7wyFZKQjInxeGqBJjabhcepMkzZjLzyo+Ou7ioOQ2E
         xwaGwK0r9yieboky7Gq72WmX8/An7U15GNeIdHL+nTM3Xh3GmhtCIKAdPyzSmMZJ8ZHC
         zog5eAxsxtBp1pHYj5Ho4JWOjfaF2rmxWDg5/ITvXBUxelRgg5pGEekVnl+TfspzFKcG
         8FPF+K92l3bX6ovu4ZGsgRo3uZi5jBUVKvSIgeps+s3G651/1gP0D3VI5uvcvmACMPkF
         kuWT25more695AKy280vYHK/RD0STao9ZeI+4p79ft8hMlykfllPYk2e9j/sBWKpXmPh
         D/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712216; x=1739317016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1qL4ZnXFfT00K7n5zOtqnft++xXZTvzfh0tC//JmKg=;
        b=AJeFxsRfwfSZeugbXRQV8eSG6l0ocdPa0eqT9Rzc8qrWbXYdGD9PExh+fylYp2VzTQ
         Np3jDgqWelWK4vKkbnSNlcnQJVGCFIlnTGQnIHVRdXtTJ51EsmspVvWxrHkFL150m0zK
         FmOvHBzc14vz9dP+2AN2n1pS6Vx/Q+fNOm7t/aegZQOVHV9nIU137duOkiq0KX/bcplb
         LFvrzdEaYC46OwNp6ixiNai3qsvAk3ZXhe5vM52nRb8XTTNKXuHT74lTtCeOsBLSV7JI
         L4I5u6N9MbZKSIer52PqRIB/iv23dl08peVqXzjqeuAVi5xpZFFytUACNAmZvgpkJ8Rv
         LMPA==
X-Forwarded-Encrypted: i=1; AJvYcCUFiOsWGgZiV1AsAZo3Md67CnQ9JPWs084/zwSGrec5MYK13gl99psp0/zt6MX7iNg1QH3GKLXzNFM8@lists.infradead.org
X-Gm-Message-State: AOJu0YxeVMBmUkoYMCGI4CliNTXm9s8pMM1UmZAT/Ul/igt3naZN3U4t
	WqdDnRpFGWuPI30dbw8IreoPVzDF32oeyeOU5WCk0a+SIqr3l79wpOXYpj+89u+4VwRVCYeJaA=
	=
X-Google-Smtp-Source: AGHT+IG1RFAavC3DUQIa1KEGMmHkvtnWsmq5/N2XOmTYW1ZVDvUvfOelUHO4cFQ9z2pdoiyU8JI1A4ubzg==
X-Received: from pfgt33.prod.google.com ([2002:a05:6a00:13a1:b0:725:1e74:6a17])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3296:b0:1e1:aab8:3887
 with SMTP id adf61e73a8af0-1ede88dd04amr934764637.39.1738712216103; Tue, 04
 Feb 2025 15:36:56 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:29 +0000
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Mime-Version: 1.0
References: <20250204233630.3407878-1-jxgao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-3-jxgao@google.com>
Subject: [RFC PATCH 2/3] skip swiotlb pre copy if the device does full buffer write.
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
X-CRM114-CacheID: sfid-20250204_153700_003155_51328B18 
X-CRM114-Status: GOOD (  12.88  )
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

In cases that the device is known to do a full buffer write, we
can skip the pre copy of the swiotlb buffer.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..12124d4fd44f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1436,7 +1436,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
 	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
 	 */
-	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
+	if ((dir == DMA_TO_DEVICE) || !dma_is_full_buffer_write(dev))
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
 	return tlb_addr;
 }
 
-- 
2.48.1.362.g079036d154-goog


