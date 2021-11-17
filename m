Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3256AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 22:14:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB42261B30
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 22:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB42261B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aR9/NOunbjx2VrbBvqvaOV6WJfKqIrvKUy098YHBKIs=; b=c1OV+OdEiPen0Vi2K1kzouWo2S
	go890O5yGPaj8XIfp1sgJwqtEE1vrEl4e+tf0yg/bWjYqetMjB3R4M0P9l1fLz9DxQlKvLbaBnDQq
	3wCQLjVMGeykKAEIuboNA1zNzMtW6cqWLtP1fj69ryGQWtITbOfWpRX5QawEfznRokUW5aNKrlFoh
	4NvMImtIlY6CERrVoPLkp6oNFV872hg7/lv0NlCdOHwS6X1FiTpg57W5Dx0LzYSgYK+zFvZlnksBZ
	ddNpEQfd44+7VqFDUrNQGo5t6HZ3tjpglRM/2fDevEfUpOai2utsqeX5yhO5tpwagmeTaFcBHgz8v
	HDoN3V3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnTBx-006PYy-Pq; Wed, 17 Nov 2021 22:14:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnSt7-006LcF-1X
 for linux-nvme@bombadil.infradead.org; Wed, 17 Nov 2021 21:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=aR9/NOunbjx2VrbBvqvaOV6WJfKqIrvKUy098YHBKIs=; b=IC9o45L3/psT0rq7LSqXpJdA7u
 NWPWH6eb7O5PWjghInXfz3gHK4TEFb0+6O1aubo9zMl947n4RRlwc5q4XyZi2pQFBGCG2t+xcAgsY
 tSHMAHSNdOQuR/z/2F43UB1+BOqscmYZtje38gOzzFl2YePq8ofK6mghWRVbUztOTxidvAg8uZTbm
 joAtf3SaWVSJfwQdDP2S7DG2uY1/zxamulS/FXBW879uoOB66UVr5VHg3jloK7lCJ5Ab8QugfESxL
 u/vE+oJy9umB4Lfq3FpDoN6ISOMfoPyZM/blIKM/sroFsK+F9jnUcUhlpuXHeKWF/e25wmrT/23NA
 wSrA8Jgg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnSt3-00GZZa-AU
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 21:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=aR9/NOunbjx2VrbBvqvaOV6WJfKqIrvKUy098YHBKIs=; b=lWKQx+YOxtX4F9UOqlW7UFAwyw
 9pKxueuIcLcyyJiQRJ5QeyMRtWaN7EYrGXbYDh6toF6bVWayKR7AZitKrP7zwU1jk1lyKmuiZVMqs
 kbHXQzE5rDsVFKf1Km2CY9x08gk9TX3XSG3wG5uF2BVS1rR3S7k6O17NEjKj0EKBaOmASWD93QNn1
 lPeJNv5mXFIBqZ8OnMiZNfxBs09ttmczPeraV1sj0jL1mQgMVDTjSPvWXDYICJ1s8W2ZyCZxlz4bc
 RVVAEz0Px2vMSL05BmRI619hUNGgWjlBJdyFckOY1GsmvCsbMj6heCEWlCTeCJoybVwLtb8RH2uRJ
 YEB1XA1Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1mnSso-000Zo3-OW; Wed, 17 Nov 2021 14:54:24 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsk-0000zl-BK; Wed, 17 Nov 2021 14:54:18 -0700
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
 Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 17 Nov 2021 14:54:02 -0700
Message-Id: <20211117215410.3695-16-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 15/23] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_215437_467525_F3D16EC8 
X-CRM114-Status: GOOD (  16.65  )
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

Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
allow obtaining P2PDMA pages. If a caller does not set this flag
and tries to map P2PDMA pages it will fail.

This is implemented by checking failing if PCI p2pdma pages are
found when FOLL_PCI_P2PDMA is set. This is only done if pte_devmap()
is set.

FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..65cb27cebbab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2971,6 +2971,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..c31461c3d256 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -527,6 +527,12 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			page = pte_page(pte);
 		else
 			goto no_page;
+
+		if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
+			     is_pci_p2pdma_page(page))) {
+			page = ERR_PTR(-EREMOTEIO);
+			goto out;
+		}
 	} else if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
@@ -980,6 +986,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if ((gup_flags & FOLL_LONGTERM) && (gup_flags & FOLL_PCI_P2PDMA))
+		return -EOPNOTSUPP;
+
 	if (vma_is_secretmem(vma))
 		return -EFAULT;
 
@@ -2297,6 +2306,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
+		if (unlikely(pte_devmap(pte) && !(flags & FOLL_PCI_P2PDMA) &&
+			     is_pci_p2pdma_page(page)))
+			goto pte_unmap;
+
 		head = try_grab_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
@@ -2374,6 +2387,12 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
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
 		if (unlikely(!try_grab_page(page, flags))) {
@@ -2842,7 +2861,8 @@ static int internal_get_user_pages_fast(unsigned long start,
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
-				       FOLL_FAST_ONLY | FOLL_NOFAULT)))
+				       FOLL_FAST_ONLY | FOLL_NOFAULT |
+				       FOLL_PCI_P2PDMA)))
 		return -EINVAL;
 
 	if (gup_flags & FOLL_PIN)
-- 
2.30.2


