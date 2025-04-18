Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7DCC369D0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8cLIyacvLhTreh8gF/Aa6K4pXr5Yx0Q0wjZ2YLBnFvw=; b=oWJ7XaXU2YJmO3VADa9Hmbjoip
	Aj5kQMaWOAKd8U9xdP2plaWKJ8d5T7sPvmD0q/nsTBgfkr95hJpn1IYfbdV0GiNSedH39RC0DSBY1
	sF5Eqxrvzr8b4cQN3yWjFJmEH+AqMwfouuuXVZcgW9j0jxChqpm+w1GNcl+NAc9pBMsSFceyEOTEI
	CWoG477Q4QHCvJK36aA0bo/FQ1oi3GuOGZGy6pesLrQDkHGn3APyxVbfrv/ElNlHYarWrntBVIxPY
	U1NXGmywutY1chPSbUsHb4NPFZxNKZf3xyWrPHwLMW5hPRFzDVAFugVAeHupdqkFef9HGuYM+wdUO
	zWL9DWyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5onr-0000000H0Lj-1CEc;
	Fri, 18 Apr 2025 16:42:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5fX9-0000000FJmQ-3iQi
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 06:49:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE1BA68480;
	Fri, 18 Apr 2025 06:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B367C4CEE7;
	Fri, 18 Apr 2025 06:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744958946;
	bh=FGXDsNA0sR7G/5v+LnwSm5/sUMLhEeMj7l+/Osc6L2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8xsLgZWIx/US9R6pj3eRnpqPtX+d8I55kJMo6U7/IDuuX/AwydFE+tN8fIDWjOc9
	 Dn8YJI4xhLUzIwm4/jrvXHxnREOauqrN77cGM+D6lLNrik5e+pWaW9422xm1PN5a92
	 x4i7bARpGCzIWHO5ftNP5UUMQYq5y3ulySQeGmD1qdncWWC4KQMUR7pme/1Kp2YqRv
	 pROXVYAzPeSUUbddwd5uuRoY8QX+1ASGEgfB0jZL/K0F0itHqPMAAl+356idT0cdWF
	 sEBLLpbayG4diDeAAyf3NCNHSxdfVNqMn/DkttF2SHa9pZVtwnBoTacdQ9+sd1SHQe
	 ENtJZuoTsdpVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v8 18/24] block: share more code for bio addition helper
Date: Fri, 18 Apr 2025 09:47:48 +0300
Message-ID: <753430b79ac788786ea065dac648fa662d4666b9.1744825142.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
References: <cover.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

From: Christoph Hellwig <hch@lst.de>

__bio_iov_iter_get_pages currently open codes adding pages to the bio,
which duplicates a lot of code from bio_add_page. Add bio_add_page_int
helper that pass down the same_page output argument so that
__bio_iov_iter_get_pages can reuse the main add bio to page helpers.

Note that I'd normally call these helper __bio_add_page, but the former
is already taken for an exported API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/bio.c | 68 +++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4e6c85a33d74..3047fa3f4b32 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -989,20 +989,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
-/**
- *	bio_add_page	-	attempt to add page(s) to bio
- *	@bio: destination bio
- *	@page: start page to add
- *	@len: vec entry length, may cross pages
- *	@offset: vec entry offset relative to @page, may cross pages
- *
- *	Attempt to add page(s) to the bio_vec maplist. This will only fail
- *	if either bio->bi_vcnt == bio->bi_max_vecs or it's a cloned bio.
- */
-int bio_add_page(struct bio *bio, struct page *page,
-		 unsigned int len, unsigned int offset)
+static int bio_add_page_int(struct bio *bio, struct page *page,
+		 unsigned int len, unsigned int offset, bool *same_page)
 {
-	bool same_page = false;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
@@ -1011,7 +1000,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				page, len, offset, same_page)) {
 		bio->bi_iter.bi_size += len;
 		return len;
 	}
@@ -1021,6 +1010,24 @@ int bio_add_page(struct bio *bio, struct page *page,
 	__bio_add_page(bio, page, len, offset);
 	return len;
 }
+
+/**
+ * bio_add_page	- attempt to add page(s) to bio
+ * @bio: destination bio
+ * @page: start page to add
+ * @len: vec entry length, may cross pages
+ * @offset: vec entry offset relative to @page, may cross pages
+ *
+ * Attempt to add page(s) to the bio_vec maplist.  Will only fail if the
+ * bio is full, or it is incorrectly used on a cloned bio.
+ */
+int bio_add_page(struct bio *bio, struct page *page,
+		 unsigned int len, unsigned int offset)
+{
+	bool same_page = false;
+
+	return bio_add_page_int(bio, page, len, offset, &same_page);
+}
 EXPORT_SYMBOL(bio_add_page);
 
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
@@ -1088,27 +1095,6 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
-			     size_t offset)
-{
-	bool same_page = false;
-
-	if (WARN_ON_ONCE(bio->bi_iter.bi_size > UINT_MAX - len))
-		return -EIO;
-
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				folio_page(folio, 0), len, offset,
-				&same_page)) {
-		bio->bi_iter.bi_size += len;
-		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_folio(folio, 1);
-		return 0;
-	}
-	bio_add_folio_nofail(bio, folio, len, offset);
-	return 0;
-}
-
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
@@ -1203,6 +1189,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
 		struct page *page = pages[i];
 		struct folio *folio = page_folio(page);
+		struct page *first_page = folio_page(folio, 0);
+		bool same_page = false;
 
 		folio_offset = ((size_t)folio_page_idx(folio, page) <<
 			       PAGE_SHIFT) + offset;
@@ -1215,7 +1203,15 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			len = get_contig_folio_len(&num_pages, pages, i,
 						   folio, left, offset);
 
-		bio_iov_add_folio(bio, folio, len, folio_offset);
+		if (bio_add_page_int(bio, first_page, len, folio_offset,
+				     &same_page) != len) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
+			unpin_user_folio(folio, 1);
+
 		offset = 0;
 	}
 
-- 
2.49.0


