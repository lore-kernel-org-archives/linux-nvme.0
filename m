Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F1FA373E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OC676xm4n+4quUWve6+HSNFg0hwcXHADJsbuIB5KOEM=; b=nmIwN4TnwvjO/6MOwdrBPXkjwX
	i5PaLTuMoq0GQHHl23RZpqqmkbEeFLCgNKbTJRCoic/w9IQ81n1B0W38Bvs+9M3uhXrwZ0+OJ3Y7v
	yXeatG+V+e0Qhu7c7S4IVV9xkvlahQmXbk7dXGcf6jxmw4mhfp12X0zty1rFlYhZeKM4EcB5geltF
	CVeBesPnSr+v71av5ZNxDFPLDVNTCa8Ywjb02vuhA8n8nbmoNOKrhlUxwHD1ZopNYsVCvUpTz71pN
	Bl4LKqwCoQ21/7sX57UlMf8olWqdJiPbRojmaP+oDNfDa2yeI5oetA9h7iN2gjyT4nyFN/znHErQu
	uiOjqegw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olw1f-009EiT-58; Fri, 21 Oct 2022 17:41:43 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olw1P-009EQU-Mo
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 17:41:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=OC676xm4n+4quUWve6+HSNFg0hwcXHADJsbuIB5KOEM=; b=Wsxq4q38mUEjvwfxvFF14IWzOU
	5VlOWiPn8393f1dAxy8toKeXn6XeHrR/IUTe8OpAg2VL4FONatGB0R5rvYnwFWE1BTojlUpH2WfJW
	8Z6THGFo+tIqoM5h4LswsjbKqa5dblgAGUcLcNNggZITwNoKaKq9alo493IKjoWM+/9ZiXHbXPtJY
	LAA7yWQZpTmCk1DJ2q0L2uYXuCNRSifxnQTC8AFv5l/wsP3k9oTTSC9OAUUZPtZWy3uAjMtFP1FCF
	tQWboeFYCJfBd8htw5d0X8tTLHSMTbe/6E3W00wy5pRWsT/5+JCkf47fjtvYawICHeGbAdpz+t893
	wKG7s7/g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1olw1I-00DoHz-T8; Fri, 21 Oct 2022 11:41:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1olw1F-0001t9-OW; Fri, 21 Oct 2022 11:41:17 -0600
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
Date: Fri, 21 Oct 2022 11:41:09 -0600
Message-Id: <20221021174116.7200-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021174116.7200-1-logang@deltatee.com>
References: <20221021174116.7200-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 2/9] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_104127_851914_C04537A7 
X-CRM114-Status: GOOD (  20.70  )
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

GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
allow obtaining P2PDMA pages. If GUP is called without the flag and a
P2PDMA page is found, it will return an error in try_grab_page() or
try_grab_folio().

The check is safe to do before taking the reference to the page in both
cases seeing the page should be protected by either the appropriate
ptl or mmap_lock; or the gup fast guarantees preventing TLB flushes.

try_grab_folio() has one call site that WARNs on failure and cannot
actually deal with the failure of this function (it seems it will
get into an infinite loop). Expand the comment there to document a
couple more conditions on why it will not fail.

FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set. This is to copy
fsdax until pgmap refcounts are fixed (see the link below for more
information).

Link: https://lkml.kernel.org/r/Yy4Ot5MoOhsgYLTQ@ziepe.ca
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 19 ++++++++++++++++++-
 mm/hugetlb.c       |  6 ++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 62a91dc1272b..6b081a8dcf88 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2958,6 +2958,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/gup.c b/mm/gup.c
index e2f447446384..29e28f020f0b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -123,6 +123,9 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+		return NULL;
+
 	if (flags & FOLL_GET)
 		return try_get_folio(page, refs);
 	else if (flags & FOLL_PIN) {
@@ -216,6 +219,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
 
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+		return -EREMOTEIO;
+
 	if (flags & FOLL_GET)
 		folio_ref_inc(folio);
 	else if (flags & FOLL_PIN) {
@@ -631,6 +637,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		page = ERR_PTR(ret);
 		goto out;
 	}
+
 	/*
 	 * We need to make the page accessible if and only if we are going
 	 * to access its content (the FOLL_PIN case).  Please see
@@ -1060,6 +1067,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if ((gup_flags & FOLL_LONGTERM) && (gup_flags & FOLL_PCI_P2PDMA))
+		return -EOPNOTSUPP;
+
 	if (vma_is_secretmem(vma))
 		return -EFAULT;
 
@@ -2536,6 +2546,12 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
+
+		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
+			undo_dev_pagemap(nr, nr_start, flags, pages);
+			break;
+		}
+
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(try_grab_page(page, flags))) {
@@ -3020,7 +3036,8 @@ static int internal_get_user_pages_fast(unsigned long start,
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
-				       FOLL_FAST_ONLY | FOLL_NOFAULT)))
+				       FOLL_FAST_ONLY | FOLL_NOFAULT |
+				       FOLL_PCI_P2PDMA)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e8d01a19ce46..a55adfbacedb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6342,8 +6342,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * tables. If the huge page is present, then the tail
 			 * pages must also be present. The ptl prevents the
 			 * head page and tail pages from being rearranged in
-			 * any way. So this page must be available at this
-			 * point, unless the page refcount overflowed:
+			 * any way. As this is hugetlb, the pages will never
+			 * be p2pdma or not longterm pinable. So this page
+			 * must be available at this point, unless the page
+			 * refcount overflowed:
 			 */
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
-- 
2.30.2


