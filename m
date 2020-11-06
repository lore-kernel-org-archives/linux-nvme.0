Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF5C388F2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:04:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93F520720
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R4MBGQb4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Iz1KSxmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cqnCmJyvZZnx2gSb0czZmbs4tMPai/AHCliw39g6H1s=; b=R4MBGQb4palP/Pf4o//awi/zc
	O03tIHeBFTyqUiVYgsFpLa07y1st1gNSV6GfkYnWkr0V4LJ0E5VoxAuyaAaOSaMO0leLr0sxTP7yY
	GSwE0TW97X7LTkqNExHWQQcb7S/nk7dJ1RiWJtKfjAl76NXgbZZMnhPDJIOlq9QICJIy02i9ZNzgi
	lohhBV0dlnKjH69pJsO6/DuhVAOunImjtwslzyDJE7OQcUlfpsfcfHj3N72HVRPKVKPHLyyWhVAFw
	Mzlw7cN6GMA7nGIgBbmhdtVVJ3Wi5kvhylvYaBkwiuDu2Hw3yFb/YBSu6BlxneADgvPXl864rPJiQ
	2wYilLK8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb59r-0002hZ-Bv; Fri, 06 Nov 2020 17:04:15 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56t-00011w-0R
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zPFpNgiugVQ+xdbkGSN+0eJClV8q4n6t0btTMsXElBs=; b=Iz1KSxmqkSDBJvFrjXSKdYsP0w
 JoIPvPZhAvmvTc2lXaxFt1bgKacOe7+FyScP8rRK1wl72/MIYfdhmd4S8VHDuTM2a9RT80bboSZxU
 kInz2blm2LfIetmFOS+pFz2ZDumaZk+B9kKpHPAfHLHHxPop8H/AQU+J+22clDSdPbXw2xOsKL/p6
 JDjN3eygxLT19oFLKyMdyqSp6POAyRPc2QdRw/g2hPAV00HljzjTCSURL1tmZ5epJ/uxTfgIhDucM
 wm5frCa9+aQ85atixSw3Vjo1ZyL2Gdtti8z/+t0xacAhMPtnxcTiXLx33IwyE9VGqxJPdcsJBpRF3
 u5Y8wxiQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56j-0002PW-HZ; Fri, 06 Nov 2020 10:01:06 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004t5-OR; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:27 -0700
Message-Id: <20201106170036.18713-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 06/15] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120111_686593_4DF2FBE6 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a flags member to the dma_map_ops structure with one flag to
indicate support for PCI P2PDMA.

Also, add a helper to check if a device supports PCI P2PDMA.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-map-ops.h | 3 +++
 include/linux/dma-mapping.h | 5 +++++
 kernel/dma/mapping.c        | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..8c12dfa43ce1 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -12,6 +12,9 @@
 struct cma;
 
 struct dma_map_ops {
+	unsigned int flags;
+#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
+
 	void *(*alloc)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, gfp_t gfp,
 			unsigned long attrs);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8d028e15b531..3646c6ba6a00 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -149,6 +149,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 bool dma_can_mmap(struct device *dev);
 int dma_supported(struct device *dev, u64 mask);
+int dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
@@ -244,6 +245,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return 0;
 }
+static inline int dma_pci_p2pdma_supported(struct device *dev)
+{
+	return 0;
+}
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	return -EIO;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 51bb8fa8eb89..192418ef43f8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -567,6 +567,14 @@ int dma_supported(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_supported);
 
+int dma_pci_p2pdma_supported(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
+}
+EXPORT_SYMBOL(dma_pci_p2pdma_supported);
+
 #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
 void arch_dma_set_mask(struct device *dev, u64 mask);
 #else
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
