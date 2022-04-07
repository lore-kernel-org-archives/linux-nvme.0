Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081A9C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NhYwwPYUOPNVkjQIdyegnu/TVIl/nr3VeJZ7F4Q1rQY=; b=H0Ixt9JhtQ5MxwG2BMgfDUBs5R
	zUEwb85whh64PnYYPcwI8+5p2n0/pqoj/CutUhkQhKunWz3sx35dC1lul6y8G6mUexMYMC40GetdF
	njIqhrLwtCus+5JLSP3RllX1Ze9qeE6yM3l6DXNA1q94J3yungzETUu4/3Au1J1T5wqx6gj7Kgt+u
	NN9uVnh4tuQRXnDdDdy8vs5GPLdLfaQvBh9jS7i9Ist8bT1D1fVxKR5s788Lt/8fyQZmHG2WomfrJ
	SjI8hqzWIm5SaBaOdxeX2lUFKyjh6VQ+9H77mz1U8sENwKQ8CJdaD3yUcXTalsgbB3H9qOChInF4b
	dmRMA2LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUfh-00CwnF-RA; Thu, 07 Apr 2022 16:07:46 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUMN-00Cnvj-6v
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=NhYwwPYUOPNVkjQIdyegnu/TVIl/nr3VeJZ7F4Q1rQY=; b=kW115vO/lD5rTsxYR5wDs4inqe
 b62XLPVR1SKPBKhjIMGvH8/MnKPRwidsE+zcAlS8tHsYa6gYUO/lWQKAiq0fskHTB4DfCzP9KwEt2
 awuANPVzBGDxwiLlGKvFZcVBO0iijF1vKPmrj95MhayJpJlrS46NDTFfC+t7KI8DNk4ry1m5/8d1J
 +7oK34SQ8cIiJnBx3+JJHIyr3dMLRP4mSXQh6eF23EX5U4e3yvWW2GUbw6AGAk7S7lbdREAiI4Faf
 /F4ASkipN0tLk9wxIMmSs5rh/01GZKqdFrmMo+fMt2J66f3X0zQZYZqeS8UlYt9kYOkl7xUEiidL6
 7kOVCESQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMJ-002BBi-Mr; Thu, 07 Apr 2022 09:47:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUME-00022A-Fc; Thu, 07 Apr 2022 09:47:38 -0600
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
 Ralph Campbell <rcampbell@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  7 Apr 2022 09:47:12 -0600
Message-Id: <20220407154717.7695-17-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
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
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 16/21] block: add check when merging zone device pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_084747_354111_B356E2E8 
X-CRM114-Status: GOOD (  13.11  )
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
---
 block/bio.c        |  2 ++
 include/linux/mm.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index cdd7b2915c53..3406c0450db3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -834,6 +834,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
+	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
 	if (*same_page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14ef41af8b77..fb2264a17e4a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1108,6 +1108,24 @@ static inline bool is_zone_device_page(const struct page *page)
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
 extern void memmap_init_zone_device(struct zone *, unsigned long,
 				    unsigned long, struct dev_pagemap *);
 #else
@@ -1115,6 +1133,11 @@ static inline bool is_zone_device_page(const struct page *page)
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


