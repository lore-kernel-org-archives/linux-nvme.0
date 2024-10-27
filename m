Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4A2D13570
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tALG9wpKBtQB3tqH+0SVvlMPUAnleSl370kVmfpw6cg=; b=iBNbB1r0mncgu75tW++iotaULc
	g57H1UlieEdrRzIgxKQhI2JgI6Ic3s6JUAd9dfKmydywvpUY9z9TG7GJjP5VTxmbOh+tdz6LRhXRc
	I6ed8QhnihJMsQKNowQP2pJsfQ454N13Qi3q6P8AW+V4M50d6m62rj5Y6ZD2s6GM13TvHO4YX1ly6
	585vTcLnaz5edKb/3urE+lf2Gw/cDL8VyFnMouv0EMql/LQ4piXs7bDeguHdy1WfL1csk74C7Pbui
	7OzE5pjyye3igb638tFo29yvjnD8MIF6vS1qyvdraXnF1g9FUwrDYD0llPqcVpnwhD1TJ5Kb/ANf8
	PtNdMQuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t55Dd-00000008TRt-2cnI;
	Sun, 27 Oct 2024 15:30:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t54AQ-00000008Kpj-10eO
	for linux-nvme@bombadil.infradead.org;
	Sun, 27 Oct 2024 14:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tALG9wpKBtQB3tqH+0SVvlMPUAnleSl370kVmfpw6cg=; b=SfR3zMG3aLzfr/06yN887rLukh
	5T7OSjAQju8WA295l0T/qTqCCcpqoG8vq6YIoTdxsSfhtuDNMRC33yXbzCx6tuE6jxZyJHZfWd23z
	h7wvF6ds1TiReNdESwuQX1WfeXIEdUzg13LgQvzGMuSMpcoBOmLSFR5K/UuVwBvJTi1HXjnvxGQsr
	o45dToJZxIRTtmS0LHoCtFfuWrXGshotHbdnW8vZxP40R4Xw275KBPCbCD/TdinrBRRA5wmpIbNlQ
	VVALJ2QTa/tnjIU4juSItN8/yulwSb0NluuOBdYgQLPAG7eOI7OF24BnFyrN1aOxvtKeyXdnnNYa3
	Qxbx1QrQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t54AM-00000009QSr-2qFu
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 14:22:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 237F95C5830;
	Sun, 27 Oct 2024 14:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270F5C4CEC3;
	Sun, 27 Oct 2024 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730038968;
	bh=Ig+DtUOzk0wRj0C/EWVGPiHozm6V2fkXLKm30AePHJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+zfRmfgUjBdKG0sjFH7EFWB14iiJjvEXA1eTMDEC2NPGsxgK3GK1ozAFere43Kk3
	 Olw8VnLKVDFHXG1xCYeSjKw7t2cyNGOGv1SB0qzIaO7Hjg9oYHlDJVIAPTr9/UTSPh
	 iBN4VQUVqSBI7htWJrXD6Vj/LvGOfrORvquuGrGjQyhyT4sD/QndXQDzjQPGyamfu0
	 9FwwvLYJyeH8muOh/ZbuS9SltR1FQiEn/M9pPcFgU0ARzo04FYi2f55G1NgIoF90fU
	 gugpxORRZ1GMtHC/dWj350ZIJ+YXqS8sneoRix0wJR8tDnk8guw7Mz4U+sUsPYyPVa
	 1pQyQWXPE7NcA==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/7] block: share more code for bio addition helpers
Date: Sun, 27 Oct 2024 16:21:54 +0200
Message-ID: <e6be9d87a3ca1a2f9c27bce73fbab559c21c765f.1730037261.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730037261.git.leon@kernel.org>
References: <cover.1730037261.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_142251_158653_8F3C4C90 
X-CRM114-Status: GOOD (  22.06  )
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
which duplicates a lot of code from bio_add_page and
bio_add_zone_append_page.  Add bio_add_page_int and
bio_add_zone_append_page_int helpers that pass down the same_page
output argument so that __bio_iov_iter_get_pages can reuse the main
add bio to page helpers.

Note that I'd normally call these helpers __bio_add_page and
__bio_add_zone_append_page, but the former is already taken for an
exported API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/bio.c | 114 +++++++++++++++++++++++-----------------------------
 1 file changed, 51 insertions(+), 63 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ac4d77c88932..2d3bc8bfb071 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1064,6 +1064,19 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
+static int bio_add_zone_append_page_int(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int offset, bool *same_page)
+{
+	struct block_device *bdev = bio->bi_bdev;
+
+	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
+		return 0;
+	if (WARN_ON_ONCE(!bdev_is_zoned(bdev)))
+		return 0;
+	return bio_add_hw_page(bdev_get_queue(bdev), bio, page, len, offset,
+			bdev_max_zone_append_sectors(bdev), same_page);
+}
+
 /**
  * bio_add_zone_append_page - attempt to add page to zone-append bio
  * @bio: destination bio
@@ -1083,17 +1096,9 @@ EXPORT_SYMBOL(bio_add_pc_page);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset)
 {
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	bool same_page = false;
 
-	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
-		return 0;
-
-	if (WARN_ON_ONCE(!bdev_is_zoned(bio->bi_bdev)))
-		return 0;
-
-	return bio_add_hw_page(q, bio, page, len, offset,
-			       queue_max_zone_append_sectors(q), &same_page);
+	return bio_add_zone_append_page_int(bio, page, len, offset, &same_page);
 }
 EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 
@@ -1119,20 +1124,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
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
@@ -1141,7 +1135,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				page, len, offset, same_page)) {
 		bio->bi_iter.bi_size += len;
 		return len;
 	}
@@ -1151,6 +1145,24 @@ int bio_add_page(struct bio *bio, struct page *page,
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
@@ -1224,41 +1236,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
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
-static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
-					 size_t len, size_t offset)
-{
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	bool same_page = false;
-
-	if (bio_add_hw_folio(q, bio, folio, len, offset,
-			queue_max_zone_append_sectors(q), &same_page) != len)
-		return -EINVAL;
-	if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
-		unpin_user_folio(folio, 1);
-	return 0;
-}
-
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
@@ -1353,6 +1330,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
 		struct page *page = pages[i];
 		struct folio *folio = page_folio(page);
+		struct page *first_page = folio_page(folio, 0);
+		bool same_page = false;
 
 		folio_offset = ((size_t)folio_page_idx(folio, page) <<
 			       PAGE_SHIFT) + offset;
@@ -1366,12 +1345,21 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 						   folio, left, offset);
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			ret = bio_iov_add_zone_append_folio(bio, folio, len,
-					folio_offset);
-			if (ret)
+			if (bio_add_zone_append_page_int(bio, first_page, len,
+					folio_offset, &same_page) != len) {
+				ret = -EINVAL;
+				break;
+			}
+		} else {
+			if (bio_add_page_int(bio, folio_page(folio, 0), len,
+					folio_offset, &same_page) != len) {
+				ret = -EINVAL;
 				break;
-		} else
-			bio_iov_add_folio(bio, folio, len, folio_offset);
+			}
+		}
+
+		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
+			unpin_user_folio(folio, 1);
 
 		offset = 0;
 	}
-- 
2.46.2


