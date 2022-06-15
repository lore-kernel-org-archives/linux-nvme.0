Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E0C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NVweqEcjCecZ0bg5dlWjMJWWbRBpQR845+naXv01S1E=; b=3dsmHaaMnHLKHH1lRfQqH8JCca
	ZQHAzyP2L4J3r8oRayDWell1pQRv6IxvAHSWs/pYFfjwiTZ3jOenyIKAOZrBSiNpQcoch5FRPZYYg
	oLjNTaT3hmTwu13uBOtDCzZD9hdiSuTb+XRJiFfXEcFVuE75ltzGaoXzHh7MBBMDhw5WjOiXHDQyQ
	StSywYLM5WiS4olHdb/kKLG2JUKrGFMChDTbSGwPDbEIrEEY8TK6MJp5pQAKxIqxvYsFja2guSK9u
	GrTZQOphy0IQKT1t8F86KLtvV3WAxIqef508H9bg6SJgwARl55i/qzvDsakCm2TbUIyvYlUvsvLKr
	oPtuBBLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1VfA-00FKpF-LV; Wed, 15 Jun 2022 16:14:36 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1VdU-00FJZ8-Kg
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 16:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=NVweqEcjCecZ0bg5dlWjMJWWbRBpQR845+naXv01S1E=; b=mGlJB+Mc6r6QavYLUJHJ2f6Gcf
	4KC3tU5HmwUMDyO6T64JnNBflaA1Oaq/889fD31ncukdVXKstY3aDuLUssracQXrTgPh503f7c3Gm
	9oj+XtAemKDfgOgUrEkOhMLRx7YNuoTdepVnGBAGOZtn7In3FvSV64tzpxAi3mfRaDQNZByACspsC
	XfjfXCXxwzOBwEvK7qOAPCqBKHK80aqj8hMmZYlu9nFhBs4fE1kVcpjRmX6n3I+3TQ0fbrvvOg9Lw
	zNRi3B96PZzbaOrO/k/k6P23XfdlbDDDJPP/i6fydDuKVlrF5ptVyivsSZrkhvrBfWhPjYBHZ1EJC
	Ese8FOBw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o1VdQ-0084iR-Hv; Wed, 15 Jun 2022 10:12:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o1VdI-0004ag-Qo; Wed, 15 Jun 2022 10:12:40 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 15 Jun 2022 10:12:27 -0600
Message-Id: <20220615161233.17527-16-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 15/21] iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_091252_797329_1E235BEB 
X-CRM114-Status: GOOD (  11.54  )
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

Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
which take a flags argument that is passed to get_user_pages_fast().

This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/uio.h |  6 ++++++
 lib/iov_iter.c      | 25 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..ddf9e4cf4a59 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -232,8 +232,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start,
+		unsigned int gup_flags);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start,
+		unsigned int gup_flags);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..9bf6e3af5120 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1515,9 +1515,9 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	return page;
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+		   size_t *start, unsigned int gup_flags)
 {
 	size_t len;
 	int n, res;
@@ -1528,7 +1528,6 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return 0;
 
 	if (likely(iter_is_iovec(i))) {
-		unsigned int gup_flags = 0;
 		unsigned long addr;
 
 		if (iov_iter_rw(i) != WRITE)
@@ -1558,6 +1557,13 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
 	return -EFAULT;
 }
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_flags);
+
+ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
+			   size_t maxsize, unsigned maxpages, size_t *start)
+{
+	return iov_iter_get_pages_flags(i, pages, maxsize, maxpages, start, 0);
+}
 EXPORT_SYMBOL(iov_iter_get_pages);
 
 static struct page **get_pages_array(size_t n)
@@ -1640,9 +1646,9 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	return actual;
 }
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   size_t *start, unsigned int gup_flags)
 {
 	struct page **p;
 	size_t len;
@@ -1654,7 +1660,6 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return 0;
 
 	if (likely(iter_is_iovec(i))) {
-		unsigned int gup_flags = 0;
 		unsigned long addr;
 
 		if (iov_iter_rw(i) != WRITE)
@@ -1667,6 +1672,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
+
 		res = get_user_pages_fast(addr, n, gup_flags, p);
 		if (unlikely(res <= 0)) {
 			kvfree(p);
@@ -1694,6 +1700,13 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
 	return -EFAULT;
 }
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc_flags);
+
+ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
+				 size_t maxsize, size_t *start)
+{
+	return iov_iter_get_pages_alloc_flags(i, pages, maxsize, start, 0);
+}
 EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-- 
2.30.2


