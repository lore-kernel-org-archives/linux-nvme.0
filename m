Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FEACCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3uIIFUGZUhTny+l29Npf3dXTLcPutMotnjp9XCSWr9U=; b=p1lsCxBR36lk/zejXuz6bdxF68
	WiKcXJrJrsRwUuiT0VIlEMJn4Uo6ojivuxh5Gf63dvLSsxzsY7wIwNNjixFl1Vdcu0KGsRytH746m
	H14S3lIhBbSMGoRQp5VSgCTmrejhxpK7TXH4BRmm0LEdrfommAfqqq82wHN6JG64KqAZw7ohiDqFU
	Q7pVT3h7l4vAU0LkKQ/ZJtdE1lFbxyme6ChgZiK64NNYmudqqg2MVQ0CNCdUOuMb+sJaZTeIe5R2Y
	mdhTxOitherr4NiZBXAZ9djObsxBQLAiO+YfWCBCJeU+XhtLDCm2pUbWD37cKOnCzYFjajnkFdy03
	Kkn3aM3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gau-0000000GjaQ-13Ht;
	Tue, 14 Oct 2025 15:05:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gak-0000000GjS4-25Vf
	for linux-nvme@bombadil.infradead.org;
	Tue, 14 Oct 2025 15:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3uIIFUGZUhTny+l29Npf3dXTLcPutMotnjp9XCSWr9U=; b=dC+SScFDY7BFC+dOPfZV7xPq9y
	oDR3lBs/I1SJmUDhVKqMqDkt4gTGkvnlmvZ7FOGaVmZsVk9U04rN3DWGFlMPkJoqqeJ1uTIHr6lKW
	sN7huWx+95+yOHa/BnLm17z2nXBmZccy35z+KhAWPYy7VoZElCugHwu3+lnxdxB/g5vplhQ4UB17a
	hW+Eq7Erw+zmX/PI5KStpHhEze9+4zJIUzvFgL8YBYCN+jtcTiXolx5uGkHULLfza7XQAP4+9lUve
	iS96OBza2xtJol9z6ytCEH3bjrv/1+rS98pWi9pT9phmUVAq4R9aMKbCCPvHWtq4R5cFFyjjXWTRJ
	73CPKghw==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gaX-00000005GVs-046k
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 15:05:30 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E9movO2010951
	for <linux-nvme@lists.infradead.org>; Tue, 14 Oct 2025 08:05:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=3uIIFUGZUhTny+l29Npf3dXTLcPutMotnjp9XCSWr9U=; b=Ud2RB+pe0W3Y
	jkkiChRTYTWjFQw6qxfjGaUNCfWnjb9lRuc8/sUceeQm/5tadQBZ11zR4vl8tSz7
	6wMsudoB9Z76WCgn09Orrn9hst9IXKRcjPxUzUkoOF++4yUJpfMNP9sjJDZ1Pjeq
	h0Av1opX41AOdeOEZGF4xZx2UnoTHLkOmOzh9ooY4+hYb3Xd1I29WkJwm7cykvIy
	41EL743IyR1tW7d2VYbWHylaSqmwzSXNHhAQ4Iu2iy4HmEEzw3BAotx1TwT+1jTu
	6IAzSq3SxBMFOaOCGsaQiLw4vagASXPfABg9CDx+F/D12UBAX+92SQV3Uqnxf41L
	5p/bDLpPaQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49sm7f2032-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 14 Oct 2025 08:05:13 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 14 Oct 2025 15:05:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4FB862B305DC; Tue, 14 Oct 2025 08:05:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Date: Tue, 14 Oct 2025 08:04:55 -0700
Message-ID: <20251014150456.2219261-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014150456.2219261-1-kbusch@meta.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNCBTYWx0ZWRfXw3VrrvPV1lwY
 yf1eLQ9SpYN5nGeHhADPgt23zwiSk2sjGMGVs/qJ8Ebl+4ndY9ZYnR1nobwk9bXY/3fjHCziQsO
 I1UcyGfdn+r9hZpE+sfFVlwQjF+472RVTQ+Bh/5VlovCdEJXRK0WXoRuVv41VpspZFxKBaQhPQM
 bWuKjjyXN5AQ6MQBkYQuxCFeVS5gdxE/HkhDoJjtnFqxRZH+mIRsRGuTcOaB4MYW293nWIk/CHN
 +AMjwmlk5f6dv6tMycwa3ZfeNS8nATqpyvIJddTJ2daOgznsxZHrXlqk9IJjomkOV3tzhQbvPc6
 XXGIDT5f9eruVSa/QLfGLn3XxUNlVcK0azYHQfIq0rs63KxyWbaoxRZqWRE7JEkiOnuJLgUx3lJ
 tUptXAMRVP/DvFwMHzkIsmr3+dTlSw==
X-Proofpoint-ORIG-GUID: ESl7WvAUpvvHAWdmFRgmrQvCCJZOKZoo
X-Proofpoint-GUID: ESl7WvAUpvvHAWdmFRgmrQvCCJZOKZoo
X-Authority-Analysis: v=2.4 cv=MMJtWcZl c=1 sm=1 tr=0 ts=68ee66aa cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=p6Wd7jY5hks2xNYZl-IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_160527_547892_9FE4ACF3 
X-CRM114-Status: GOOD (  28.29  )
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

The blk-mq dma iterator has an optimization for requests that align to
the device's iommu merge boundary. This boundary may be larger than the
device's virtual boundary, but the code had been depending on that queue
limit to know ahead of time if the request is guaranteed to align to
that optimization.

Rather than rely on that queue limit, which many devices may not report,
save the lowest set bit of any boundary gap between each segment in the
bio while checking the segments. The request stores the value for
merging and quickly checking per io if the request can use iova
optimizations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  1 +
 block/blk-map.c           |  3 +++
 block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            |  6 ++++++
 include/linux/bio.h       |  2 ++
 include/linux/blk-mq.h    | 16 ++++++++++++++++
 include/linux/blk_types.h | 12 ++++++++++++
 8 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278d..7b13bdf72de09 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -253,6 +253,7 @@ void bio_init(struct bio *bio, struct block_device *b=
dev, struct bio_vec *table,
 	bio->bi_write_hint =3D 0;
 	bio->bi_write_stream =3D 0;
 	bio->bi_status =3D 0;
+	bio->bi_bvec_gap_bit =3D 0;
 	bio->bi_iter.bi_sector =3D 0;
 	bio->bi_iter.bi_size =3D 0;
 	bio->bi_iter.bi_idx =3D 0;
diff --git a/block/blk-map.c b/block/blk-map.c
index 60faf036fb6e4..17a1dc2886786 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,6 +459,8 @@ int blk_rq_append_bio(struct request *rq, struct bio =
*bio)
 	if (rq->bio) {
 		if (!ll_back_merge_fn(rq, bio, nr_segs))
 			return -EINVAL;
+		rq->phys_gap_bit =3D bio_seg_gap(rq->q, rq->biotail, bio,
+					       rq->phys_gap_bit);
 		rq->biotail->bi_next =3D bio;
 		rq->biotail =3D bio;
 		rq->__data_len +=3D bio->bi_iter.bi_size;
@@ -469,6 +471,7 @@ int blk_rq_append_bio(struct request *rq, struct bio =
*bio)
 	rq->nr_phys_segments =3D nr_segs;
 	rq->bio =3D rq->biotail =3D bio;
 	rq->__data_len =3D bio->bi_iter.bi_size;
+	rq->phys_gap_bit =3D bio->bi_bvec_gap_bit;
 	return 0;
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 002c594798242..2a1da435462de 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -302,6 +302,12 @@ static unsigned int bio_split_alignment(struct bio *=
bio,
 	return lim->logical_block_size;
 }
=20
+static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
+					struct bio_vec *bv)
+{
+	return bv->bv_offset | (bvprv->bv_offset + bvprv->bv_len);
+}
+
 /**
  * bio_split_io_at - check if and where to split a bio
  * @bio:  [in] bio to be split
@@ -319,8 +325,8 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
 {
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
+	unsigned nsegs =3D 0, bytes =3D 0, gaps =3D 0;
 	struct bvec_iter iter;
-	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
 		if (bv.bv_offset & lim->dma_alignment ||
@@ -331,8 +337,11 @@ int bio_split_io_at(struct bio *bio, const struct qu=
eue_limits *lim,
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
-			goto split;
+		if (bvprvp) {
+			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
+				goto split;
+			gaps |=3D bvec_seg_gap(bvprvp, &bv);
+		}
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
@@ -350,6 +359,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 	}
=20
 	*segs =3D nsegs;
+	bio->bi_bvec_gap_bit =3D ffs(gaps);
 	return 0;
 split:
 	if (bio->bi_opf & REQ_ATOMIC)
@@ -385,6 +395,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
+	bio->bi_bvec_gap_bit =3D ffs(gaps);
 	return bytes >> SECTOR_SHIFT;
 }
 EXPORT_SYMBOL_GPL(bio_split_io_at);
@@ -721,6 +732,21 @@ static bool blk_atomic_write_mergeable_rqs(struct re=
quest *rq,
 	return (rq->cmd_flags & REQ_ATOMIC) =3D=3D (next->cmd_flags & REQ_ATOMI=
C);
 }
=20
+u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *ne=
xt,
+	       u8 gaps_bit)
+{
+	struct bio_vec pb, nb;
+
+	gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
+	gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
+
+	bio_get_last_bvec(prev, &pb);
+	bio_get_first_bvec(next, &nb);
+	if (!biovec_phys_mergeable(q, &pb, &nb))
+		gaps_bit =3D min_not_zero(gaps_bit, ffs(bvec_seg_gap(&pb, &nb)));
+	return gaps_bit;
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be hel=
d.
@@ -785,6 +811,9 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
 	if (next->start_time_ns < req->start_time_ns)
 		req->start_time_ns =3D next->start_time_ns;
=20
+	req->phys_gap_bit =3D bio_seg_gap(req->q, req->biotail, next->bio,
+					min_not_zero(next->phys_gap_bit,
+						     req->phys_gap_bit));
 	req->biotail->bi_next =3D next->bio;
 	req->biotail =3D next->biotail;
=20
@@ -908,6 +937,8 @@ enum bio_merge_status bio_attempt_back_merge(struct r=
equest *req,
 	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
 		blk_zone_write_plug_bio_merged(bio);
=20
+	req->phys_gap_bit =3D bio_seg_gap(req->q, req->biotail, bio,
+					req->phys_gap_bit);
 	req->biotail->bi_next =3D bio;
 	req->biotail =3D bio;
 	req->__data_len +=3D bio->bi_iter.bi_size;
@@ -942,6 +973,8 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,
=20
 	blk_update_mixed_merge(req, bio, true);
=20
+	req->phys_gap_bit =3D bio_seg_gap(req->q, bio, req->bio,
+					req->phys_gap_bit);
 	bio->bi_next =3D req->bio;
 	req->bio =3D bio;
=20
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 449950029872a..94d3461b5bc8e 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct blk_map_iter *iter,
 static inline bool blk_can_dma_map_iova(struct request *req,
 		struct device *dma_dev)
 {
-	return !((queue_virt_boundary(req->q) + 1) &
-		dma_get_merge_boundary(dma_dev));
+	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));
 }
=20
 static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09f5794141615..c12e5ee315fce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
 	INIT_LIST_HEAD(&rq->queuelist);
 	rq->q =3D q;
 	rq->__sector =3D (sector_t) -1;
+	rq->phys_gap_bit =3D 0;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag =3D BLK_MQ_NO_TAG;
@@ -668,6 +669,7 @@ struct request *blk_mq_alloc_request(struct request_q=
ueue *q, blk_opf_t opf,
 			goto out_queue_exit;
 	}
 	rq->__data_len =3D 0;
+	rq->phys_gap_bit =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -748,6 +750,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len =3D 0;
+	rq->phys_gap_bit =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -2674,6 +2677,8 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
 	rq->bio =3D rq->biotail =3D bio;
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->__data_len =3D bio->bi_iter.bi_size;
+	rq->phys_gap_bit =3D bio->bi_bvec_gap_bit;
+
 	rq->nr_phys_segments =3D nr_segs;
 	if (bio_integrity(bio))
 		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q,
@@ -3380,6 +3385,7 @@ int blk_rq_prep_clone(struct request *rq, struct re=
quest *rq_src,
 	}
 	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
 	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
+	rq->phys_gap_bit =3D rq_src->phys_gap_bit;
=20
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 16c1c85613b76..ad2d57908c1c0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,6 +324,8 @@ extern struct bio *bio_split(struct bio *bio, int sec=
tors,
 			     gfp_t gfp, struct bio_set *bs);
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes, unsigned len_align);
+u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *ne=
xt,
+		u8 gaps_bit);
=20
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b25d12545f46d..ddda00f07fae4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -152,6 +152,14 @@ struct request {
 	unsigned short nr_phys_segments;
 	unsigned short nr_integrity_segments;
=20
+	/*
+	 * The lowest set bit for address gaps between physical segments. This
+	 * provides information necessary for dma optimization opprotunities,
+	 * like for testing if the segments can be coalesced against the
+	 * device's iommu granule.
+	 */
+	unsigned char phys_gap_bit;
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct bio_crypt_ctx *crypt_ctx;
 	struct blk_crypto_keyslot *crypt_keyslot;
@@ -208,6 +216,14 @@ struct request {
 	void *end_io_data;
 };
=20
+/*
+ * Returns a mask with all bits starting at req->phys_gap_bit set to 1.
+ */
+static inline unsigned long req_phys_gap_mask(const struct request *req)
+{
+	return ~(((1 << req->phys_gap_bit) >> 1) - 1);
+}
+
 static inline enum req_op req_op(const struct request *req)
 {
 	return req->cmd_flags & REQ_OP_MASK;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8e8d1cc8b06c4..53501ebb0623e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -218,6 +218,18 @@ struct bio {
 	enum rw_hint		bi_write_hint;
 	u8			bi_write_stream;
 	blk_status_t		bi_status;
+
+	/*
+	 * The bvec gap bit indicates the lowest set bit in any address offset
+	 * between all bi_io_vecs. This field is initialized only after the bio
+	 * is split to the hardware limits (see bio_split_io_at()). The value
+	 * may be used to consider DMA optimization when performing that
+	 * mapping. The value is compared to a power of two mask where the
+	 * result depends on any bit set within the mask, so saving the lowest
+	 * bit is sufficient to know if any segment gap collides with the mask.
+	 */
+	u8			bi_bvec_gap_bit;
+
 	atomic_t		__bi_remaining;
=20
 	struct bvec_iter	bi_iter;
--=20
2.47.3


