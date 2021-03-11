Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C33C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 23:34:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1636864F7B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 23:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1636864F7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mVc+uzRmSo1kGkaFvSwEtGNmvV8/JoKU/OZyTuOzec=; b=FblhfplhPVRtQB
	Ct+VQZVqb5SR/YjtX49ockRA1H6YaSwdQ7bbchQFiwvahfpmuIyvClEpR8ekoL2sWdmw7m+Zk3a4a
	R1/TWMSP7a20nZxmQRu28icxDlqjK+NXlna12noVgbK6You7ukl63ulFHgYJcyp5nBqEmI6Sjv/KK
	+bRXKO3d05lNBr1dSsItwfgpMpf4nN4nwJ+lWrqWGd6VQLr1P/RxFJlljbhzZV39O8+I3qB1YPIKq
	fHNhSCMMQfv5WTAUKlKNUPuNcfY2LQADX3W5xTMmsGdtXtIBAuXsQcqA0Pl43Fy5nTv3RT544xrCz
	jfQkuk3FEmih0Nwb+QOA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKUob-00AF0i-Ko; Thu, 11 Mar 2021 23:34:01 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKUmo-00AEfh-Et
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 23:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=KOMMXadwrYwZEB6tWYvcMS2uWikbMkq234oR8x5l6uU=; b=NOigEiKa5QVhqkJx08sL74oozH
 IZ3CiU8+eeNi0GWrmCuxBvytyQml8bVvak4gI55pcE2jXr1VSHIoSsjrWGiFBqneKdlc/tREjEfQK
 vpBhsUQYflR8mj4rh+OgbyUcpWwHvWJro43CV02zDTEMELz51KCyW4YJ1HEQ5aT++Wx4fWd0e2UIz
 1Fdm889jVbolaeVeZCD1GDvmPKyUJzpB3kfWPtbn3sTqKbzNUDsxzF+bTniILfxZ6v1Lj6Izgqeej
 bn38QX113rFGYQkNk83OpSUc66XivY5TKSYhkyr9Yr5OB+kx3ZkOj25E4nbNn9vcglbG8mk4sRFr+
 74XDjSSA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmm-0003ev-8M; Thu, 11 Mar 2021 16:32:09 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lKUmW-00024e-Lc; Thu, 11 Mar 2021 16:31:52 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 11 Mar 2021 16:31:37 -0700
Message-Id: <20210311233142.7900-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_233210_893266_4DF01348 
X-CRM114-Status: GOOD (  13.20  )
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
index 51872e736e7b..481892822104 100644
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
index 2a984cb4d1e0..a6bced004de8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,6 +138,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 bool dma_can_mmap(struct device *dev);
 int dma_supported(struct device *dev, u64 mask);
+int dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
@@ -233,6 +234,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
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
index adc1a83950be..cc1b97deb74d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -540,6 +540,14 @@ int dma_supported(struct device *dev, u64 mask)
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
