Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B40AC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=; b=tj3uzUdM1nmFKaSt/hu8EiUcoc
	vft40k5qcxllD2WVsZnsEUzFg0fmunv+l2DoVAJc88s6TKlKQMmzhxKZNCkGkycdShNIERkBT6uX/
	PW/IcdshUI6DoRCI6Lfld1Hejvkpw/xWhH3BfKsgw2MeL16edfgV7SWmjzAb6papIZ/RFLR7EZYJL
	n1XpnbaIPabuCIDuAdy1sQ9iMLtWd0Aq8DtDlV9h/tAuGehaZFDZvFBmg0Z5C/NPWH/VAQw6GvlaO
	s91xCUQGnItTnBlGIC7likh3nkhRbMeG/cUdIpjUeHb4pgzRgj+ttcDT1w2NIm8QzZdO943v6J64r
	M+azxL5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCh1-0000000DyAs-2t4P;
	Thu, 22 Aug 2024 18:37:55 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgw-0000000Dy6F-23el
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:51 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-201ed196debso10601985ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351869; x=1724956669; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=;
        b=DheCcCw+8bGpveDb5EXE/LRlpUGlG+XYhhI7R6KofXSnRX6Bb//8UfyuaZmdFw0p7P
         eYF4yfRHJyoX1tAHOQq/dnrSM9kxDXDGq2c3igSqfwDttzvbTCGzYcGbCkReF2DvS8N6
         XA8yAax9Ts52+fVJgw/Os4teJPXFgTCn11oVVFg9ZpV7nb1Hv3xa3h7sWqqs+q4izwjR
         lDwHm9LaBy96FCzBXbz6kt9sl6Qspa100ik3ogNScVwULNvdNCl5lC3cqFW8N/LoDXou
         THLf8bwjHCrYS6AlW7mD6zTbGij/wlgmhWgwRtrBZN3Kw60IBG0J8ZRknd61bPjhbi2m
         0COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351869; x=1724956669;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=;
        b=KF6pXL0O+N3XQsrQapS9Qo7cyx1s2EH3v/jHLQm2Vhs3EW4qhs+C6jewrSQ932nvrN
         OfFVYtTDjechvNvWMP/REfy7Rs0IM5GD3OGzN9SZV7Zf9aGVtq+NeWwfDH0yJlykIJvW
         R+Bjq69EurZbS+x7DEfFyEVPKTnkl2DtaCdSk90l56PhVhf8Oxe+o0wAFCntpVBXYeUC
         P5e2CRBsbJSiJ8lc4vQFwd1TARVfEGXNO9oVE8Lkd/YpARMRx8X1WKJO+rnUGLZa2Efo
         E9ZNy2n+F85Y/gpnouZkE+2SqXpeIrJvCSOCf+jm7pCqF1YFR7KhrCHUxWQHAqLbnN2j
         Vufg==
X-Forwarded-Encrypted: i=1; AJvYcCV9M9tG/L1XEcwFzeJ4VMLOs7MCp/007lpg2I4xXOMozObxQI6siR2XHnCSGcARCBJJZuXSubh4P7x7@lists.infradead.org
X-Gm-Message-State: AOJu0Yx01gu7fsNBDLnYLkac5xOSa7Eb5f1z22KrYtXddmalYGZuRXL0
	I8ghvUMYa7qJrseONOdK7W/qEYl173zjcLDXd+Zfyswz4JMZmQRKsFE70Iae
X-Google-Smtp-Source: AGHT+IH8+45q6oXd8x8II3Jds1dxAoYSz31lmfPW/kQ0FnzP0cCsfuNQ8sVNo0lwZUKJpv9rCx8MxQ==
X-Received: by 2002:a17:903:228d:b0:1fc:f65:cd8a with SMTP id d9443c01a7336-20367d1394dmr75819225ad.18.1724351869298;
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 3/7] dma: Add function for drivers to know if allowing blocking is useful
Date: Thu, 22 Aug 2024 11:37:14 -0700
Message-Id: <20240822183718.1234-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113750_556294_8E020626 
X-CRM114-Status: GOOD (  15.82  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

With the addition of swiotlb throttling functionality, storage
device drivers may want to know whether using the DMA_ATTR_MAY_BLOCK
attribute is useful. In a CoCo VM or environment where swiotlb=force
is used, the MAY_BLOCK attribute enables swiotlb throttling. But if
throttling is not enable or useful, storage device drivers probably
do not want to set BLK_MQ_F_BLOCKING at the blk-mq request queue level.

Add function dma_recommend_may_block() that indicates whether
the underlying implementation of the DMA map calls would benefit
from allowing blocking. If the kernel was built with
CONFIG_SWIOTLB_THROTTLE, and swiotlb=force is set (on the kernel
command line or due to being a CoCo VM), this function returns
true. Otherwise it returns false.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/direct.c         |  6 ++++++
 kernel/dma/direct.h         |  1 +
 kernel/dma/mapping.c        | 10 ++++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7b78294813be..ec2edf068218 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -145,6 +145,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
+bool dma_recommend_may_block(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
 unsigned long dma_get_merge_boundary(struct device *dev);
@@ -252,6 +253,10 @@ static inline bool dma_addressing_limited(struct device *dev)
 {
 	return false;
 }
+static inline bool dma_recommend_may_block(struct device *dev)
+{
+	return false;
+}
 static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 80e03c0838d4..34d14e4ace64 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -649,6 +649,12 @@ bool dma_direct_all_ram_mapped(struct device *dev)
 				      check_ram_in_range_map);
 }
 
+bool dma_direct_recommend_may_block(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) &&
+			is_swiotlb_force_bounce(dev);
+}
+
 size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index d2c0b7e632fc..63516a540276 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -21,6 +21,7 @@ bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 bool dma_direct_all_ram_mapped(struct device *dev);
+bool dma_direct_recommend_may_block(struct device *dev);
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b1c18058d55f..832982bafd5a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -858,6 +858,16 @@ bool dma_addressing_limited(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
+bool dma_recommend_may_block(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops))
+		return dma_direct_recommend_may_block(dev);
+	return false;
+}
+EXPORT_SYMBOL_GPL(dma_recommend_may_block);
+
 size_t dma_max_mapping_size(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.25.1


