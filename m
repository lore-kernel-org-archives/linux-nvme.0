Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADA3CA0EC1
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0V+V9Pm5R5YbPncpc9ekCr0ozb9G/Bn95kGEnK1V5a0=; b=2u6t6j8r2NgVzBQMh6UxmjWCA8
	U5RyHSTJUAzWvWnm7JSqUhvWu9RFHVrz8d4IXwWNn77DypnkRhb1zlD9QVjnmjC3rCkLeA0/NXERg
	GbO42n+TPgNFu8/JymHr9b0Boqdyh5f0vEcBsHXcgORMX+9iPSkP7X+F/NHNWjQdGM1wKFb85sQJd
	zYEKdeOCr8fqdZr3kshZSJcYAaQfUTV+bJWMaIs5b8CVIjGSf2W9olPzkYFGb37yzGD7Fo1Ld7Mcy
	HyYrmv56rgheSAPVEe92qtWAiuvbY7S8ofanjqLjpldAsnh7mzCCRQrA00aCsVVyTo9waI0io6J0D
	to1MXzOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfYh-0000000FV78-15zA;
	Wed, 06 Aug 2025 14:56:03 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujfUg-0000000FUUB-1m0Y
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 14:51:55 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ECg8o018158
	for <linux-nvme@lists.infradead.org>; Wed, 6 Aug 2025 07:51:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=0V+V9Pm5R5YbPncpc9ekCr0ozb9G/Bn95kGEnK1V5a0=; b=YlcSoFlLKolG
	OVVjN2RkLSWo7V8/vc9IrUrTdbT63fS/8Of8zeOY6BAhveagRmzIoPh125wGjy8C
	5sbNyVbaWiV6nRFtq5FWTvAmuI43aKAd179VX3JAhOYegIoaMU0jISFtUxhA4quY
	GjV4ZqshBM965wWvPTAP03OqLanPNE5oZfZFSrfDR12WAwTXE1dWdze9/03K9kQ3
	RSY8w1ngEXoaK743ITvw7x6gGYiNYGzzYMRSerV0w9Q2hAXL+GYeUORO/v8gGjOA
	ZMk7hxid8m9kwXxyE3dXjZe8ma9uAaL+Je2XOpW08yS1FciCqdoNR+CAdbLyYyim
	894Qw2O5sg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bpwhfrmx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 07:51:53 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 14:51:52 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D809159F45C; Wed,  6 Aug 2025 07:51:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] block: accumulate segment page gaps per bio
Date: Wed, 6 Aug 2025 07:51:35 -0700
Message-ID: <20250806145136.3573196-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806145136.3573196-1-kbusch@meta.com>
References: <20250806145136.3573196-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cF8XzJltJ7JmC6zOzG6cMbrTikXdWb4u
X-Proofpoint-ORIG-GUID: cF8XzJltJ7JmC6zOzG6cMbrTikXdWb4u
X-Authority-Analysis: v=2.4 cv=bLUWIO+Z c=1 sm=1 tr=0 ts=68936c09 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=11tnV2OUVXcqJXJBsJsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MiBTYWx0ZWRfX6Kq+N5c8j+B5 pLvLJ1VuQ2VKtm2asMDZv0J23G5gob45r9C8Z70g4ZJX+rjK53AvchQouiAYyFr8Yok5mTHPw8Q WsAplsy0sGkt6cglUNTaqUlS+UOPo1YGEzkz/nkx0v9UaN+7EknKllfz4Nu40zxeg37n6EY+h/J
 ZpCx2aNSpu2TPeyONj0oMXB7BIPvhIEd8n0M+elGPI5jWZsgozQRu1alQEqS9wC161L3ADKb+Tk BWUyAgsW9yQi9HAxJJWFvLx1CwkMqVFA3ITbM+uGvkALR6ysUI4qWkMqafme28HEuzLpdo75Xd4 WhLyb6zOyreE6H3w7yji3fRETkFz7xNXpvYEXyDG0RcaF1gaWuvQu1XKH4Plof4UcNi7nJHKO8C
 pddIZbXOw5MGifq3QV7mNPNFmCmkUFHPamEejyqmvDLZVqqDsARzwU18oTPU0cWz4o8NYPq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_075154_469484_44BAB534 
X-CRM114-Status: GOOD (  26.18  )
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
device's virtual boundary, but the code had been depending on that queue
limit to know ahead of time if the request aligns to the optimization.

Rather than rely on that queue limit, which many devices may not even
have, store the virtual boundary gaps of each segment into the bio as a
mask while checking the segments and merging. We can then quickly check
per io if the request can use the optimization or not.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  1 +
 block/blk-merge.c         | 32 +++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            |  5 +++++
 include/linux/blk-mq.h    |  6 ++++++
 include/linux/blk_types.h |  2 ++
 6 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b7636a2662f7d..8ed71c284b408 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -275,6 +275,7 @@ void bio_init(struct bio *bio, struct block_device *b=
dev, struct bio_vec *table,
 	bio->bi_integrity =3D NULL;
 #endif
 	bio->bi_vcnt =3D 0;
+	bio->page_gaps =3D 0;
=20
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 81bdad915699a..a09749f9ee3cb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,6 +278,11 @@ static unsigned int bio_split_alignment(struct bio *=
bio,
 	return lim->logical_block_size;
 }
=20
+static inline unsigned int bvec_seg_gap(struct bio_vec bv, struct bio_ve=
c bp)
+{
+	return bv.bv_offset | ((bp.bv_offset + bp.bv_len) & (PAGE_SIZE - 1));
+}
+
 /**
  * bio_split_rw_at - check if and where to split a read/write bio
  * @bio:  [in] bio to be split
@@ -293,9 +298,9 @@ static unsigned int bio_split_alignment(struct bio *b=
io,
 int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes)
 {
+	unsigned nsegs =3D 0, bytes =3D 0, page_gaps =3D 0;
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
-	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
 		if (bv.bv_offset & lim->dma_alignment)
@@ -305,8 +310,11 @@ int bio_split_rw_at(struct bio *bio, const struct qu=
eue_limits *lim,
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
-			goto split;
+		if (bvprvp) {
+			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
+				goto split;
+			page_gaps |=3D bvec_seg_gap(bv, bvprv);
+		}
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
@@ -324,6 +332,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	}
=20
 	*segs =3D nsegs;
+	bio->page_gaps =3D page_gaps;
 	return 0;
 split:
 	if (bio->bi_opf & REQ_ATOMIC)
@@ -353,6 +362,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
+	bio->page_gaps =3D page_gaps;
 	return bytes >> SECTOR_SHIFT;
 }
 EXPORT_SYMBOL_GPL(bio_split_rw_at);
@@ -689,6 +699,19 @@ static bool blk_atomic_write_mergeable_rqs(struct re=
quest *rq,
 	return (rq->cmd_flags & REQ_ATOMIC) =3D=3D (next->cmd_flags & REQ_ATOMI=
C);
 }
=20
+static inline unsigned int bio_seg_gap(struct request_queue *q,
+				struct bio *next, struct bio *prev)
+{
+	struct bio_vec pb, nb;
+
+	bio_get_last_bvec(prev, &pb);
+	bio_get_first_bvec(next, &nb);
+	if (biovec_phys_mergeable(q, &pb, &nb))
+		return 0;
+
+	return next->page_gaps | bvec_seg_gap(nb, pb);
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be hel=
d.
@@ -753,6 +776,7 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
 	if (next->start_time_ns < req->start_time_ns)
 		req->start_time_ns =3D next->start_time_ns;
=20
+	req->__page_gaps |=3D bio_seg_gap(req->q, next->bio, req->biotail);
 	req->biotail->bi_next =3D next->bio;
 	req->biotail =3D next->biotail;
=20
@@ -876,6 +900,7 @@ enum bio_merge_status bio_attempt_back_merge(struct r=
equest *req,
 	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
 		blk_zone_write_plug_bio_merged(bio);
=20
+	req->__page_gaps |=3D bio_seg_gap(req->q, bio, req->biotail);
 	req->biotail->bi_next =3D bio;
 	req->biotail =3D bio;
 	req->__data_len +=3D bio->bi_iter.bi_size;
@@ -910,6 +935,7 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,
=20
 	blk_update_mixed_merge(req, bio, true);
=20
+	req->__page_gaps |=3D bio_seg_gap(req->q, req->bio, bio);
 	bio->bi_next =3D req->bio;
 	req->bio =3D bio;
=20
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index faa36ff6465ee..a03067c4a268f 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -73,8 +73,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct blk_map_iter *iter)
 static inline bool blk_can_dma_map_iova(struct request *req,
 		struct device *dma_dev)
 {
-	return !((queue_virt_boundary(req->q) + 1) &
-		dma_get_merge_boundary(dma_dev));
+	return !(blk_rq_page_gaps(req) & dma_get_merge_boundary(dma_dev));
 }
=20
 static bool blk_dma_map_bus(struct blk_dma_iter *iter)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02ecebd..09134a66c5666 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
 	INIT_LIST_HEAD(&rq->queuelist);
 	rq->q =3D q;
 	rq->__sector =3D (sector_t) -1;
+	rq->__page_gaps =3D 0;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag =3D BLK_MQ_NO_TAG;
@@ -659,6 +660,7 @@ struct request *blk_mq_alloc_request(struct request_q=
ueue *q, blk_opf_t opf,
 			goto out_queue_exit;
 	}
 	rq->__data_len =3D 0;
+	rq->__page_gaps =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -739,6 +741,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len =3D 0;
+	rq->__page_gaps =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -2665,6 +2668,7 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
 	rq->bio =3D rq->biotail =3D bio;
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->__data_len =3D bio->bi_iter.bi_size;
+	rq->__page_gaps =3D bio->page_gaps;
 	rq->nr_phys_segments =3D nr_segs;
 	if (bio_integrity(bio))
 		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q,
@@ -3363,6 +3367,7 @@ int blk_rq_prep_clone(struct request *rq, struct re=
quest *rq_src,
=20
 	/* Copy attributes of the original request to the clone request. */
 	rq->__sector =3D blk_rq_pos(rq_src);
+	rq->__page_gaps =3D blk_rq_page_gaps(rq_src);
 	rq->__data_len =3D blk_rq_bytes(rq_src);
 	if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a5a828f19a0b..093f6c5cd7b74 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -115,6 +115,7 @@ struct request {
=20
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
+	unsigned int __page_gaps;	/* a mask of all the segment gaps */
 	sector_t __sector;		/* sector cursor */
=20
 	struct bio *bio;
@@ -1080,6 +1081,11 @@ static inline sector_t blk_rq_pos(const struct req=
uest *rq)
 	return rq->__sector;
 }
=20
+static inline unsigned int blk_rq_page_gaps(const struct request *rq)
+{
+	return rq->__page_gaps;
+}
+
 static inline unsigned int blk_rq_bytes(const struct request *rq)
 {
 	return rq->__data_len;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0a29b20939d17..d0ed28d40fe02 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -264,6 +264,8 @@ struct bio {
=20
 	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
=20
+	unsigned int		page_gaps;	/* a mask of all the vector gaps */
+
 	atomic_t		__bi_cnt;	/* pin count */
=20
 	struct bio_vec		*bi_io_vec;	/* the actual vec list */
--=20
2.47.3


