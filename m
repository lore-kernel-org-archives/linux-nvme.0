Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B63CA0EFC
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Aug 2025 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGdL0884uDAWKmbhibPsPLhCp7gAcDZEMnc4JQscSE4=; b=LkixZ6DXhF8C7trYMMnVVRfUtS
	4dpqXS3NXdf70g0wwPrPDKNSr1mnQ0PId9Yq1CfIng9z2DKEd39OVYExfOhoqBBUWSTvTWt4dGiCz
	6cl31Dm0iDw8RT8eM50qr2/CSR9ENDb2pj4qdoU19hg93E6tdO1E3v2FkSPsGBtUT+ZEfkslfHnVA
	qcpY6J/v7gztQisADJV6FVxHzVs6FvgsJpKYR2Hxi+ShfvgFHa5Jy/EGloL+ZffPoBZLZSMNOgrgC
	4RfPd4ALB0KRSUUSQUZLeg9R3qsXFXSIxfuEg+c7mf0T5o9Z/1Y1RRnlh+G6qiASKIYLXfmQzFqM5
	MhW+/Vew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upHI6-00000001FE6-1Hxl;
	Fri, 22 Aug 2025 02:14:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upC9B-00000000Wj6-14tF
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 20:44:34 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 57LKUEvb1168264
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 13:44:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WGdL0884uDAWKmbhibPsPLhCp7gAcDZEMnc4JQscSE4=; b=CqPplp4DAaAD
	nEL5GpQlqdS7FKr0LogmCJYWsH31TgDId4m0wrj7DonYIVFRMT1QsJ1fPwN46A+t
	28YTaEnpcwS8SwS2YlJZ/bxNxkG9j1l05y/Pgho17QyDHo7vjSWoX1llwWSaqlCT
	b7JKlH6jPttOmyS+grXZKhLktBrCOG6FgRvBXen6VTDjrxOPajNorJRWmN0r9jRs
	oJHs94rDA5k2n28a9+ODL/nevU229VB64zeaXwh30lpr6iyAhCkTKXNoIHUYXTrn
	ATv6oqB5DSvXx9qEW/2yPlYrkUXrLrMGla2NhDau7Ra6b7ck3Ulb/ADJQ5mfAt6f
	I/tKBDtLBg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48pagm046j-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 21 Aug 2025 13:44:30 -0700 (PDT)
Received: from twshared10560.01.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 21 Aug 2025 20:44:24 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1AEB9DAAF4F; Thu, 21 Aug 2025 13:44:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Date: Thu, 21 Aug 2025 13:44:19 -0700
Message-ID: <20250821204420.2267923-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821204420.2267923-1-kbusch@meta.com>
References: <20250821204420.2267923-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=L6VEg+T8 c=1 sm=1 tr=0 ts=68a7852e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pC_r94qpXYv0nIwI4BQA:9
X-Proofpoint-ORIG-GUID: -Al9Uvr1aqsXth3Hb3C-4J91quehUXal
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE3NyBTYWx0ZWRfXzE0teeoJd/2O
 H4DjcD4vxvn1j70QiVGY5kQ7eVoNWSd/ggidF1kf/5TK3BOhWgKRMMggD00yH53edglvXmJbgkp
 SaLRcrP2Q9kXFZuwLBr8+70hblBdEzKovIkwxXKHUQkyp3cyy0mVy0rBLv2j6O5LCj8FhjkrjA+
 lOfmKxP5tNZYvPnIlK4haEWME4lPOPagfeq8JnCkOnryhL1kZYx8IDZOQfXZN5Sa5HgHZ4cyeTd
 7hRDHOsw01O9NK+KGsIfqPOKYae2oTfWnt0AJYnnN5VdiCZswaHXV2UkdZ+NorSWHP9iTEcwcEB
 YoU/y8cBtWzn2LCKN31grXECeRwj9qq5pbZoa8W/J4pHI1vkeFwFQ8vlcmysKOw7vuEuIgWjrLk
 lctoaqywnAqI5V+PQ4+1LnzzwdOBBHCTBqNmjY4P0HF2TOlL0c6nJpFihmHl/wSvTrKbikG0
X-Proofpoint-GUID: -Al9Uvr1aqsXth3Hb3C-4J91quehUXal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_134433_452344_EFB1D9B2 
X-CRM114-Status: GOOD (  25.59  )
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

From: Keith Busch <kbusch@kernel.org>

The blk-mq dma iteration has an optimization for requests that align to
the device's iommu merge boundary. This boundary may be larger than the
device's virtual boundary (if any), but the code had been depending on
that queue limit to know ahead of time if the request is guaranteed to
align to that optimization.

Rather than rely on that queue limit, which many devices may not report,
store the lowest set bit of any page boundary gap between each segment
into the bio while checking the segments. The request turns this into a
mask for merging and quickly checking per io if the request can use the
iova optimization.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  1 +
 block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            | 10 ++++++++++
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  8 ++++++++
 6 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f185119b8b40b..8bbb9236c2567 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -253,6 +253,7 @@ void bio_init(struct bio *bio, struct block_device *b=
dev, struct bio_vec *table,
 	bio->bi_write_hint =3D 0;
 	bio->bi_write_stream =3D 0;
 	bio->bi_status =3D 0;
+	bio->bi_pg_bit =3D 0;
 	bio->bi_iter.bi_sector =3D 0;
 	bio->bi_iter.bi_size =3D 0;
 	bio->bi_iter.bi_idx =3D 0;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 35e99dd1c5fd8..7e81a729d5067 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,6 +278,12 @@ static unsigned int bio_split_alignment(struct bio *=
bio,
 	return lim->logical_block_size;
 }
=20
+static inline unsigned int bvec_seg_gap(struct bio_vec *bv, struct bio_v=
ec *bvprv)
+{
+	return ((bvprv->bv_offset + bvprv->bv_len) & (PAGE_SIZE - 1)) |
+			bv->bv_offset;
+}
+
 /**
  * bio_split_io_at - check if and where to split a bio
  * @bio:  [in] bio to be split
@@ -294,9 +300,9 @@ static unsigned int bio_split_alignment(struct bio *b=
io,
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
 {
+	unsigned nsegs =3D 0, bytes =3D 0, page_gaps =3D 0;
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
-	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
 		if (bv.bv_offset & lim->dma_alignment ||
@@ -307,8 +313,11 @@ int bio_split_io_at(struct bio *bio, const struct qu=
eue_limits *lim,
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
-			goto split;
+		if (bvprvp) {
+			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
+				goto split;
+			page_gaps |=3D bvec_seg_gap(&bv, &bvprv);
+		}
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
@@ -326,6 +335,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 	}
=20
 	*segs =3D nsegs;
+	bio->bi_pg_bit =3D ffs(page_gaps);
 	return 0;
 split:
 	if (bio->bi_opf & REQ_ATOMIC)
@@ -361,6 +371,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
+	bio->bi_pg_bit =3D ffs(page_gaps);
 	return bytes >> SECTOR_SHIFT;
 }
 EXPORT_SYMBOL_GPL(bio_split_io_at);
@@ -697,6 +708,24 @@ static bool blk_atomic_write_mergeable_rqs(struct re=
quest *rq,
 	return (rq->cmd_flags & REQ_ATOMIC) =3D=3D (next->cmd_flags & REQ_ATOMI=
C);
 }
=20
+static inline unsigned int bio_seg_gap(struct request_queue *q,
+				struct bio *next, struct bio *prev)
+{
+	unsigned int page_gaps =3D 0;
+	struct bio_vec pb, nb;
+
+	if (prev->bi_pg_bit)
+		page_gaps |=3D 1 << (prev->bi_pg_bit - 1);
+	if (next->bi_pg_bit)
+		page_gaps |=3D 1 << (next->bi_pg_bit - 1);
+
+	bio_get_last_bvec(prev, &pb);
+	bio_get_first_bvec(next, &nb);
+	if (!biovec_phys_mergeable(q, &pb, &nb))
+		page_gaps |=3D bvec_seg_gap(&nb, &pb);
+	return page_gaps;
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be hel=
d.
@@ -761,6 +790,8 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
 	if (next->start_time_ns < req->start_time_ns)
 		req->start_time_ns =3D next->start_time_ns;
=20
+	req->page_gap |=3D bio_seg_gap(req->q, next->bio, req->biotail) |
+			   next->page_gap;
 	req->biotail->bi_next =3D next->bio;
 	req->biotail =3D next->biotail;
=20
@@ -884,6 +915,7 @@ enum bio_merge_status bio_attempt_back_merge(struct r=
equest *req,
 	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
 		blk_zone_write_plug_bio_merged(bio);
=20
+	req->page_gap |=3D bio_seg_gap(req->q, bio, req->biotail);
 	req->biotail->bi_next =3D bio;
 	req->biotail =3D bio;
 	req->__data_len +=3D bio->bi_iter.bi_size;
@@ -918,6 +950,7 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,
=20
 	blk_update_mixed_merge(req, bio, true);
=20
+	req->page_gap |=3D bio_seg_gap(req->q, req->bio, bio);
 	bio->bi_next =3D req->bio;
 	req->bio =3D bio;
=20
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 660b5e200ccf6..ee542ef28de0c 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct blk_map_iter *iter,
 static inline bool blk_can_dma_map_iova(struct request *req,
 		struct device *dma_dev)
 {
-	return !((queue_virt_boundary(req->q) + 1) &
-		dma_get_merge_boundary(dma_dev));
+	return !(req->page_gap & dma_get_merge_boundary(dma_dev));
 }
=20
 static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02ecebd..8d1cde13742d4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
 	INIT_LIST_HEAD(&rq->queuelist);
 	rq->q =3D q;
 	rq->__sector =3D (sector_t) -1;
+	rq->page_gap =3D 0;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag =3D BLK_MQ_NO_TAG;
@@ -659,6 +660,7 @@ struct request *blk_mq_alloc_request(struct request_q=
ueue *q, blk_opf_t opf,
 			goto out_queue_exit;
 	}
 	rq->__data_len =3D 0;
+	rq->page_gap =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -739,6 +741,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len =3D 0;
+	rq->page_gap =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -2665,6 +2668,12 @@ static void blk_mq_bio_to_request(struct request *=
rq, struct bio *bio,
 	rq->bio =3D rq->biotail =3D bio;
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->__data_len =3D bio->bi_iter.bi_size;
+
+	if (bio->bi_pg_bit)
+		rq->page_gap =3D 1 << (bio->bi_pg_bit - 1);
+	else
+		rq->page_gap  =3D 0;
+
 	rq->nr_phys_segments =3D nr_segs;
 	if (bio_integrity(bio))
 		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q,
@@ -3370,6 +3379,7 @@ int blk_rq_prep_clone(struct request *rq, struct re=
quest *rq_src,
 	}
 	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
 	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
+	rq->page_gap =3D rq_src->page_gap;
=20
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a5a828f19a0b..5ef0cef8823be 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -152,6 +152,8 @@ struct request {
 	unsigned short nr_phys_segments;
 	unsigned short nr_integrity_segments;
=20
+	unsigned int page_gap;
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct bio_crypt_ctx *crypt_ctx;
 	struct blk_crypto_keyslot *crypt_keyslot;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 930daff207df2..0bfea2d4cd03a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -222,6 +222,14 @@ struct bio {
 	enum rw_hint		bi_write_hint;
 	u8			bi_write_stream;
 	blk_status_t		bi_status;
+
+	/*
+	 * The page gap bit indicates the lowest set bit in any page address
+	 * offset between all bi_io_vecs. This field is initialized only after
+	 * splitting to the hardware limits.
+	 */
+	u8			bi_pg_bit;
+
 	atomic_t		__bi_remaining;
=20
 	struct bvec_iter	bi_iter;
--=20
2.47.3


