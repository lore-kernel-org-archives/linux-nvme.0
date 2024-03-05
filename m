Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522EFC54E49
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qz+nVanLpL+n9z9iwjMPgdzjVfAYTSIqRoaTaCVsNO8=; b=XetEOxFU4Vo/xE5JC7iRDXElGn
	FdHNW1tkP7d5ZTo3a1ZSv/V0YMQwRcEZj/4aw1YhCXzFmTedg48lHxwkXsMzjqb+K3zyAIbJQ0sLm
	eiOhlxyDGSZoGxAsInVYNSFGz3g9qbxizAhM/4krK7R7rZM+covToII9sNMJFNV3453Ah3BmMAxAx
	9j3xe3aF1AyR5A+dmhOaKKyVdwdTI7g28M4nYAvlN1sCbVg49nMznfeCGcWe2NZH/vlp7U+yy+TDG
	EltHNwC2ao16rovw+nkO5iKDdHMa0rx5W6qQUnTcTYRPORMa+Gg+qVJzxuNs15x5dOLtzTETqOQLg
	9cyFNO/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVtz-0000000E35o-0vPy;
	Tue, 05 Mar 2024 14:36:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhRqe-0000000Cy2N-32py
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 10:16:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0A9CA61126;
	Tue,  5 Mar 2024 10:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D045C43394;
	Tue,  5 Mar 2024 10:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709633795;
	bh=LoE4Mk2h+x4QygNOYAaQkErlcP1J9OkI1WKvPNtdRq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNEwTJ5cMN9ELwzZS16ppqt8z3E74GD7UClDOZ+K258awlhlHWmthDNESMHRqcqrd
	 FB5rGUzT1HNrfY0k9YRNPH7tpd6eRrBCHBFvW2HuHKRpDRIcieGpESqf5qYSZEu7Ot
	 rJawxgEDFjOWV3aypoQz9qlwzRrIaDARCl71nYqsSh9yKTfAjSlP900AU9rH1yZsqq
	 FSiuklZ0TDjrPQoHx0CLw7CspAdlMh8IJ7b9yEWuOD9m26KZiCU7D2cXRMmTCHbBNI
	 pVkHPjju2ehO/3/QWSJNDh9vuYxqDYLnTUKNJldj71/uHBe1w+Vt8uTvJzHh9hKp99
	 5/3DH4IEH+yWg==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC 15/16] block: add dma_link_range() based API
Date: Tue,  5 Mar 2024 12:15:25 +0200
Message-ID: <1e52aa392b9c434f55203c9d630dd06fcdb75c32.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <a77609c9c9a09214e38b04133e44eee67fe50ab0.1709631413.git.leon@kernel.org>
References: <a77609c9c9a09214e38b04133e44eee67fe50ab0.1709631413.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_021636_951076_B94918F3 
X-CRM114-Status: GOOD (  25.75  )
X-Mailman-Approved-At: Tue, 05 Mar 2024 05:32:59 -0800
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Add two helper functions that are needed to calculate the total DMA
length of the request blk_rq_get_dma_length() and to create DMA
mapping blk_rq_dma_map().

blk_rq_get_dma_length() is used to get the total length of the request,
when driver is allocating IOVA space for this request with the call to
dma_alloc_iova(). This length is then initialized to the iova->size and
passed to allocate iova call chain :-
dma_map_ops->allov_iova()
        iommu_dma_alloc_iova()
                alloc_iova_fast()
                        iova_rcache_get()
                                OR
                        alloc_iova()

blk_rq_dma_map() iterates through bvec list and creates DMA mapping
for each page using iova parameter with the help of dma_link_range().
Note that @iova is allocated & pre-initialized using dma_alloc_iova()
by the caller. After creating a mapping for each page, call into the
callback function @cb provided by the drive with a mapped DMA address
for this page, offset into the iova space (needed at the time of
unlink), length of the mapped page, and page number that is mapped in
this request. Driver is responsible for using this DMA address to
complete the mapping of underlying protocol-specific data structures,
such as NVMe PRPs or NVMe SGLs. This callback approach allows us to
iterate bvec list only once to create bvec to DMA mapping and use that
DMA address in driver to build the protocol-specific data structure,
essentially mapping one bvec page at a time to DMA address and using
that DMA address to create underlying protocol-specific data structures.
Finally, returning the number of linked count.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-merge.c      | 156 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |   9 +++
 2 files changed, 165 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2d470cf2173e..63effc8ac1db 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -583,6 +583,162 @@ int __blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(__blk_rq_map_sg);
 
+static dma_addr_t blk_dma_link_page(struct page *page, unsigned int page_offset,
+				    struct dma_iova_attrs *iova,
+				    dma_addr_t dma_offset)
+{
+	dma_addr_t dma_addr;
+	int ret;
+
+	dma_addr = dma_link_range(page, page_offset, iova, dma_offset);
+	ret = dma_mapping_error(iova->dev, dma_addr);
+	if (ret) {
+		pr_err("dma_mapping_err %d dma_addr 0x%llx dma_offset %llu\n",
+			ret, dma_addr, dma_offset);
+		/* better way ? */
+		dma_addr = 0;
+	}
+	return dma_addr;
+}
+
+/**
+ * blk_rq_dma_map: block layer request to DMA mapping helper.
+ *
+ * @req         : [in] request to be mapped
+ * @cb          : [in] callback to be called for each bvec mapped bvec into
+ *                     underlaying driver.
+ * @cb_data     : [in] callback data to be passed, privete to the underlaying
+ *                     driver.
+ * @iova        : [in] iova to be used to create DMA mapping for this request's
+ *                     bvecs.
+ * Description:
+ * Iterates through bvec list and create dma mapping between each bvec page
+ * using @iova with dma_link_range(). Note that @iova needs to be allocated and
+ * pre-initialized using dma_alloc_iova() by the caller. After creating
+ * a mapping for each page, call into the callback function @cb provided by
+ * driver with mapped dma address for this bvec, offset into iova space, length
+ * of the mapped page, and bvec number that is mapped in this requets. Driver is
+ * responsible for using this dma address to complete the mapping of underlaying
+ * protocol specific data structure, such as NVMe PRPs or NVMe SGLs. This
+ * callback approach allows us to iterate bvec list only once to create bvec to
+ * DMA mapping & use that dma address in the driver to build the protocol
+ * specific data structure, essentially mapping one bvec page at a time to DMA
+ * address and use that DMA address to create underlaying protocol specific
+ * data structure.
+ *
+ * Caller needs to ensure @iova is initialized & allovated with using
+ * dma_alloc_iova().
+ */
+int blk_rq_dma_map(struct request *req, driver_map_cb cb, void *cb_data,
+		   struct dma_iova_attrs *iova)
+{
+	dma_addr_t curr_dma_offset = 0;
+	dma_addr_t prev_dma_addr = 0;
+	dma_addr_t dma_addr;
+	size_t prev_dma_len = 0;
+	struct req_iterator iter;
+	struct bio_vec bv;
+	int linked_cnt = 0;
+
+	rq_for_each_bvec(bv, req, iter) {
+		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+			curr_dma_offset = prev_dma_addr + prev_dma_len;
+
+			dma_addr = blk_dma_link_page(bv.bv_page, bv.bv_offset,
+						     iova, curr_dma_offset);
+			if (!dma_addr)
+				break;
+
+			cb(cb_data, linked_cnt, dma_addr, curr_dma_offset,
+			   bv.bv_len);
+
+			prev_dma_len = bv.bv_len;
+			prev_dma_addr = dma_addr;
+			linked_cnt++;
+		} else {
+			unsigned nbytes = bv.bv_len;
+			unsigned total = 0;
+			unsigned offset, len;
+
+			while (nbytes > 0) {
+				struct page *page = bv.bv_page;
+
+				offset = bv.bv_offset + total;
+				len = min(get_max_segment_size(&req->q->limits,
+							       page, offset),
+							       nbytes);
+
+				page += (offset >> PAGE_SHIFT);
+				offset &= ~PAGE_MASK;
+
+				curr_dma_offset = prev_dma_addr + prev_dma_len;
+
+				dma_addr = blk_dma_link_page(page, offset,
+							     iova,
+							     curr_dma_offset);
+				if (!dma_addr)
+					break;
+
+				cb(cb_data, linked_cnt, dma_addr,
+				   curr_dma_offset, len);
+
+				total += len;
+				nbytes -= len;
+
+				prev_dma_len = len;
+				prev_dma_addr = dma_addr;
+				linked_cnt++;
+			}
+		}
+	}
+	return linked_cnt;
+}
+EXPORT_SYMBOL_GPL(blk_rq_dma_map);
+
+/*
+ * Calculate total DMA length needed to satisfy this request.
+ */
+size_t blk_rq_get_dma_length(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct bio *bio = rq->bio;
+	unsigned int offset, len;
+	struct bvec_iter iter;
+	size_t dma_length = 0;
+	struct bio_vec bvec;
+
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return rq->special_vec.bv_len;
+
+	if (!rq->bio)
+		return 0;
+
+	for_each_bio(bio) {
+		bio_for_each_bvec(bvec, bio, iter) {
+			unsigned int nbytes = bvec.bv_len;
+			unsigned int total = 0;
+
+			if (bvec.bv_offset + bvec.bv_len <= PAGE_SIZE) {
+				dma_length += bvec.bv_len;
+				continue;
+			}
+
+			while (nbytes > 0) {
+				offset = bvec.bv_offset + total;
+				len = min(get_max_segment_size(&q->limits,
+							       bvec.bv_page,
+							       offset), nbytes);
+				total += len;
+				nbytes -= len;
+				dma_length += len;
+			}
+		}
+	}
+
+	return dma_length;
+}
+EXPORT_SYMBOL(blk_rq_get_dma_length);
+
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 						  sector_t offset)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7a8150a5f051..80b9c7f2c3a0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -8,6 +8,7 @@
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
+#include <linux/dma-mapping.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -1144,7 +1145,15 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 
 	return __blk_rq_map_sg(q, rq, sglist, &last_sg);
 }
+
+typedef void (*driver_map_cb)(void *cb_data, u32 cnt, dma_addr_t dma_addr,
+			      dma_addr_t offset, u32 len);
+
+int blk_rq_dma_map(struct request *req, driver_map_cb cb, void *cb_data,
+		   struct dma_iova_attrs *iova);
+
 void blk_dump_rq_flags(struct request *, char *);
+size_t blk_rq_get_dma_length(struct request *rq);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int blk_rq_zone_no(struct request *rq)
-- 
2.44.0


