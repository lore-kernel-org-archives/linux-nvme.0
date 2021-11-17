Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 23:00:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BAF61B44
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 23:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50BAF61B44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTDwkIdh5VVB1A6kvJWI8S8U3pygCOVAXIxj1iLgIvE=; b=CVA5x+8VwFYbioOPOaZjCdeqOF
	zZKOMNYrF5tAnCXCe83uparavCCg81JXLLsOPWknl1sGO7ZcFI3TWN1fxlpJekjoRO+JS+CMIRyvd
	zjN4TcxFJRu4aPXsDGTr+Sm2rDzpM07j1ppxyBfZ5WcOuPKzp5CvjuS+r9igo1aDvZTzKUBy3LMhA
	XE33/7d8J32We9BiLcqpKyIkCeAVW/3Y9q7aiBtnzcWNGmG8vXD9O9cRFQIs3yYAoJ2wRiD8BgQPh
	4dNFGkOzGSKGWtbKfwtmp58PkJn58VyN5/UN+1j04cVzRPmyFp9e05Dqkd27q+Wv0QSVQnUGCFKpI
	L5EE5R7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnTv5-006XT3-9u; Wed, 17 Nov 2021 23:00:47 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnSst-006LSb-8a
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 21:54:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=eTDwkIdh5VVB1A6kvJWI8S8U3pygCOVAXIxj1iLgIvE=; b=SQppbxuiwygLRJ7DQxog7ZaSod
 0RRBTWAKJOw8Ex6wR262KavH+Sz3+W3gwMLbzGhuJjKb8TIX9XyAV4Siaq0AqFBEH7RrGWVJ4GXcA
 5TuBux3E/JXhT4m1N/mC0TpVjFCtMbYExyKx3R2mzgxOJkGEosdVBf7WtrBrwqvzW+aVsftmuewbY
 I30+UP5IXAJSIsF8Oflm3I1t0acYWm9XvXJMljxucAU6vqDU6fDZy8hF/jA0Cp4c5pSQ9UGRsOObi
 GxifhDD07oL9ZxpIfJsKPpDcPZlLr9bcRh8gHUbqdjhDZ9b/b54L5oLjNfC8cK/lpvWdoZliu63np
 7oERExbQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsi-000Zo4-TD; Wed, 17 Nov 2021 14:54:18 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsd-0000yo-Oo; Wed, 17 Nov 2021 14:54:11 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@nvidia.com>
Date: Wed, 17 Nov 2021 14:53:48 -0700
Message-Id: <20211117215410.3695-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static inline
 functions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_135427_381519_DF5B6091 
X-CRM114-Status: GOOD (  12.35  )
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

Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
into static inline functions. There's no reason for these to be macros
and static inline are generally preferred these days.

Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
adding another bit to this mask, can do so more easily.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/scatterlist.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 266754a55327..7ff9d6386c12 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -69,10 +69,27 @@ struct sg_append_table {
  * a valid sg entry, or whether it points to the start of a new scatterlist.
  * Those low bits are there for everyone! (thanks mason :-)
  */
-#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
-#define sg_is_last(sg)		((sg)->page_link & SG_END)
-#define sg_chain_ptr(sg)	\
-	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
+#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END)
+
+static inline unsigned int __sg_flags(struct scatterlist *sg)
+{
+	return sg->page_link & SG_PAGE_LINK_MASK;
+}
+
+static inline struct scatterlist *sg_chain_ptr(struct scatterlist *sg)
+{
+	return (struct scatterlist *)(sg->page_link & ~SG_PAGE_LINK_MASK);
+}
+
+static inline bool sg_is_chain(struct scatterlist *sg)
+{
+	return __sg_flags(sg) & SG_CHAIN;
+}
+
+static inline bool sg_is_last(struct scatterlist *sg)
+{
+	return __sg_flags(sg) & SG_END;
+}
 
 /**
  * sg_assign_page - Assign a given page to an SG entry
@@ -92,7 +109,7 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 	 * In order for the low bit stealing approach to work, pages
 	 * must be aligned at a 32-bit boundary as a minimum.
 	 */
-	BUG_ON((unsigned long) page & (SG_CHAIN | SG_END));
+	BUG_ON((unsigned long)page & SG_PAGE_LINK_MASK);
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
@@ -126,7 +143,7 @@ static inline struct page *sg_page(struct scatterlist *sg)
 #ifdef CONFIG_DEBUG_SG
 	BUG_ON(sg_is_chain(sg));
 #endif
-	return (struct page *)((sg)->page_link & ~(SG_CHAIN | SG_END));
+	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
 }
 
 /**
-- 
2.30.2


