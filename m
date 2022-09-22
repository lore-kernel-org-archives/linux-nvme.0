Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1DEC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=55w4V1w11q9zjvxXiqXDCItXvw7MgUl3ug3CrLLmnIw=; b=hE0qgbViFn/qUVagQIs2oZBL92
	SUWGtKePzt4n0iqKURKbxIde8sMni7m+1C2T9B+IKbBMyGJBTut+E9Q8MsE+pajG02ZyTXkvILT/7
	PkN7qzqdPmLLqEIF9Sexhw4rDARqLk9kmMAf3D3qAvHKzY1NA6DJ/fEYLUKEQGMQkI2FPFvTTwA5y
	GCRGJWN1xDOEWWEE7Mk6+8VzFnvnVz44eE/LGQ2GrLIbAImdQoMA4So/hgTmD6ma+tn+rUTXOYGeh
	3NbCKOAvtkre2x6164QrhdJW7JTneiQ0PffZcUTmFlcFaG4yvp1VxRof54OXEGp4e+NZphhmu4VtM
	USB02vvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPFh-00Gpmd-0M; Thu, 22 Sep 2022 16:40:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPEk-00Gp5m-Kc
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 16:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=55w4V1w11q9zjvxXiqXDCItXvw7MgUl3ug3CrLLmnIw=; b=OZN/AZUOfIgfOjP6ooObX1mD/z
	0C6aPsUozqfInf00hOtNduDUliCS3P28Y3+gALxitullhCJGm2V3yuSFm/F5CNVrTdv0i+SOzb80R
	AShkraGn1LBqr6dGuFHxp/2RsA3aKj+Rrm2OM05egSqxplGXEPbvgy06OBm93U2eXw2bn1yL7yjv7
	9REh05flbq5LZLN0J2me10EK8R4FTm+m1wh4UX23047qMkC7DrAeGQcTiYNkHxoXfuCz1GBhNif5m
	JJwGas6Cur79OhPuKLfOLiLK6+Ll+tbqsZzcLGHqQ40dvAi4xLr1CpxSeX8u08w+zwfmQ3jBIT7X+
	fXWDB7Cg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEf-00862d-HN; Thu, 22 Sep 2022 10:39:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEb-0001rp-6K; Thu, 22 Sep 2022 10:39:33 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 22 Sep 2022 10:39:21 -0600
Message-Id: <20220922163926.7077-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922163926.7077-1-logang@deltatee.com>
References: <20220922163926.7077-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v10 3/8] block: add check when merging zone device pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_093942_730090_4B887CF9 
X-CRM114-Status: GOOD (  14.41  )
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

Consecutive zone device pages should not be merged into the same sgl
or bvec segment with other types of pages or if they belong to different
pgmaps. Otherwise getting the pgmap of a given segment is not possible
without scanning the entire segment. This helper returns true either if
both pages are not zone device pages or both pages are zone device
pages with the same pgmap.

Add a helper to determine if zone device pages are mergeable and use
this helper in page_is_mergeable().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 block/bio.c            |  2 ++
 include/linux/mmzone.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..969607bc1f4d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -865,6 +865,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
+	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
 	if (*same_page)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e24b40c52468..2c31915b057e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -794,6 +794,25 @@ static inline bool is_zone_device_page(const struct page *page)
 {
 	return page_zonenum(page) == ZONE_DEVICE;
 }
+
+/*
+ * Consecutive zone device pages should not be merged into the same sgl
+ * or bvec segment with other types of pages or if they belong to different
+ * pgmaps. Otherwise getting the pgmap of a given segment is not possible
+ * without scanning the entire segment. This helper returns true either if
+ * both pages are not zone device pages or both pages are zone device pages
+ * with the same pgmap.
+ */
+static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
+						     const struct page *b)
+{
+	if (is_zone_device_page(a) != is_zone_device_page(b))
+		return false;
+	if (!is_zone_device_page(a))
+		return true;
+	return a->pgmap == b->pgmap;
+}
+
 extern void memmap_init_zone_device(struct zone *, unsigned long,
 				    unsigned long, struct dev_pagemap *);
 #else
@@ -801,6 +820,11 @@ static inline bool is_zone_device_page(const struct page *page)
 {
 	return false;
 }
+static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
+						     const struct page *b)
+{
+	return true;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
-- 
2.30.2


