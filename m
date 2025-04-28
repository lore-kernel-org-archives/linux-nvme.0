Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B68EC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3z0T+ZgkMIUWqLcWm2tKeR9BajP2OyD9df/TDQ/JBM=; b=h2midw3xbcPP7Y+O1fVtIcpad2
	kTzu8o8U6Qgn0RlDT898043HWgqAfHFP/M41V95xIcX41l4jYgsllHX2LGhCzItbn2YDe/hNn3wrw
	lcWVJ65sIIRdFu5piha0Fpfe8U516+iu40e4ztBYnI6A3mLvIPltsOwk0izhH+6u7tjDqw9AYhLuY
	E252W/+jcnk5NldUztdsdyC7LprYFZpFd7T9HSXdfAl7rs6MDdqX0OKksoJS8nWMw89QdIiuG3vmY
	JkTxpYDLDIC7dE94ApPlcLlYBRIIIJtB04+28NhuD5gqZ2rrvF3NrM+LN+564fcDXlrFj9xetkjN3
	ok4wHkxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9OA2-00000006K77-2RA4;
	Mon, 28 Apr 2025 13:04:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9KiX-00000005apd-2jYZ
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:24:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 57EC761162;
	Mon, 28 Apr 2025 09:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CAFC4CEEE;
	Mon, 28 Apr 2025 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832240;
	bh=cn4ZAo5vXix5AGqKt4IWuh2vUXjY6lms9OP/AMjOBBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oo6f8LitBAP+zsGFjpfl+0mKIJC5Ky3ldfas2CEBRMfKaB8MBnnjLgNzm9zM6tZmT
	 gFqE6/2vvpVC3VBAQvhHlTGEYrSHDsE1l5GlwZAkFZ61myGlxGalP4JwuRBNe5Xlms
	 0LasKT819i+2DFexVc3tcm6U24G3gzB7SPTdpUOmZ0/AxBENdqtZKvrWiW/XO5sPNm
	 kg3YYe08XQScGeBLTSqR5fK19dmrijYQZUR1wb+msSqBR2zHb8K53hQh1vE3wec+WB
	 v8fzSVgfYh4rO84M4uuhfM4r7TSXXi2mlVErAce+d2QxOulbFGJ5HrsUWjnM4mRpF7
	 d145U3IkIKPog==
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
Subject: [PATCH v10 19/24] block: don't merge different kinds of P2P transfers in a single bio
Date: Mon, 28 Apr 2025 12:22:25 +0300
Message-ID: <e31df76edb282f648d22c3c9040320cf18b1652f.1745831017.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

To get out of the dma mapping helpers having to check every segment for
it's P2P status, ensure that bios either contain P2P transfers or non-P2P
transfers, and that a P2P bio only contains ranges from a single device.

This means we do the page zone access in the bio add path where it should
be still page hot, and will only have do the fairly expensive P2P topology
lookup once per bio down in the dma mapping path, and only for already
marked bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/bio.c               | 17 ++++++++++-------
 block/blk-merge.c         | 17 +++++++++++------
 include/linux/blk_types.h |  2 ++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3047fa3f4b32..279eac2396bf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -928,8 +928,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
-	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
-		return false;
 
 	*same_page = ((vec_end_addr & PAGE_MASK) == ((page_addr + off) &
 		     PAGE_MASK));
@@ -998,11 +996,16 @@ static int bio_add_page_int(struct bio *bio, struct page *page,
 	if (bio->bi_iter.bi_size > UINT_MAX - len)
 		return 0;
 
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, same_page)) {
-		bio->bi_iter.bi_size += len;
-		return len;
+	if (bio->bi_vcnt > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (bvec_try_merge_page(bv, page, len, offset, same_page)) {
+			bio->bi_iter.bi_size += len;
+			return len;
+		}
+	} else {
+		if (is_pci_p2pdma_page(page))
+			bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
 	}
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fdd4efb54c6c..d9691e900cc6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -320,12 +320,17 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 	unsigned nsegs = 0, bytes = 0;
 
 	bio_for_each_bvec(bv, bio, iter) {
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, disallow it.
-		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
-			goto split;
+		if (bvprvp) {
+			/*
+			 * If the queue doesn't support SG gaps and adding this
+			 * offset would create a gap, disallow it.
+			 */
+			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
+				goto split;
+		} else {
+			if (is_pci_p2pdma_page(bv.bv_page))
+				bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
+		}
 
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7..94cf146e8ce6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -378,6 +378,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -410,6 +411,7 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
+#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 
-- 
2.49.0


