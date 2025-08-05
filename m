Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FC5C87FD1
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e/bMPKidFHHUrC/ur2XiGlaO5yNs6SFOOTrzgvenL+o=; b=pwkUUjdepJnynfZRT/rrp4+rJ5
	xF39jhJEk9QJ9ZHXI5k4AQ5L7zkegz81kCv12Rm6dYKh8yCrrB/nNSgkQxYqgMUCNCyHeCH3rXH5b
	7FYXFpE94EkRfTqWONxXAmN3K44Qp5L16J9Si6ATI+uvqqEQ4Hbp0+L+GjbwO79Dreykhn3PZnCtb
	1iIuZIIZAwe21UwKpjljVldJMfuxRMaRRc6DDuZ3mREH57+TJRMQQkBRr+ckPgeMmXuVsZJSiwNvN
	cFX39iwvDVO6xP1qJx2JNuz4Q2oEiCsopK12oWx030KgqQqeiO/WTtvCgSeEGEvy9UdYFwGS9kg/T
	5THfLn1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNoN-0000000DiXk-1tpw;
	Tue, 05 Aug 2025 19:59:03 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNoG-0000000DiW1-2ZXj
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 19:58:57 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575JnGQN031428
	for <linux-nvme@lists.infradead.org>; Tue, 5 Aug 2025 12:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=e/bMPKidFHHUrC/ur2
	XiGlaO5yNs6SFOOTrzgvenL+o=; b=EHSK0aCtEPAc++D5+35Lu+EPm8ouOQTv1C
	O3ZCQ9a2EUg0NmN42MtZuCjlHv7kAL+8G3aT2mMa26fWzTVxNRxEwv5+ETiCK4m5
	APy3ySkifIP6dvScm1al3RPdwHIKD2KB8FSOKs7Yia+9biqt55vhbOCnqZbAAwgN
	agBtn/ZR9GH+eYeVwYNnNw5DjNuagmA1+HHQ4PDj3FVb4Txny6OXjhouKATwsGP2
	YCD/KM8wtMavjvOiGWt0oKD/QDwprK9HKTrP9/dlSv4gz9eGJJhMpnbeo3OIRuGE
	E/thvBFtfpzJEy+vZYEyBubCMz7w5iRmCWWMpn5b2HA5BJlz1Kkw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bpwh96b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Aug 2025 12:58:55 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 19:58:54 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 25E5D5312FF; Tue,  5 Aug 2025 12:56:09 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] block: accumulate segment page gaps per bio
Date: Tue, 5 Aug 2025 12:56:07 -0700
Message-ID: <20250805195608.2379107-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I4rqbgbV9py80kwYiwZtZs6sRkTKEpfE
X-Proofpoint-ORIG-GUID: I4rqbgbV9py80kwYiwZtZs6sRkTKEpfE
X-Authority-Analysis: v=2.4 cv=bLUWIO+Z c=1 sm=1 tr=0 ts=6892627f cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=d3ekKTwFLshZohFUiHYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE0MSBTYWx0ZWRfX3MSmn0I22ar/ I0m2MoC6iX04JqHbRKVzyVSCRs743cPuMLcwVtZfK6gKKY4xEH18NKqM3riKZFid9WefKqS7Bd3 PXJQM3RQoTvbYaIYOw9wnV8DuIjCW4rKT95MEi5c4N5erRPxqY22XWwsGyOzqb0+qm9uU1ovQ7l
 ym0Ui3ijyCMGI3D1DUeipeJyCx5SEZMIL0OspCH9L8/sosrubFfBAOg+pq135noE0m6yW3IIZaw Mch/COahq96YY3cV9h0kd1c8Bd3axCHeAC+s7sRFs8Gx9Ld6+P4S/yjAj6WesRWaOUUsoo1AMN+ hg858LvwlQ6sPmd8hCCdo0JpeHvidJziauaaQgAOy1yHuGgRo3Uemlqu/54TOMLJWS02uJj6UP6
 ke81NYuPU+ol8AwLoTDAeQCPHQKTQHAKSBKiouXgV9aUwC866NDJlinSDjx0nqMiSnweJW7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_125856_760451_E5D22A0C 
X-CRM114-Status: GOOD (  26.24  )
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
 block/blk-merge.c         | 30 +++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            |  5 +++++
 include/linux/blk-mq.h    |  6 ++++++
 include/linux/blk_types.h |  2 ++
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 81bdad915699a..d63389c063006 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,6 +278,9 @@ static unsigned int bio_split_alignment(struct bio *b=
io,
 	return lim->logical_block_size;
 }
=20
+#define bv_seg_gap(bv, bvprv) \
+	bv.bv_offset | ((bvprv.bv_offset + bvprv.bv_len) & (PAGE_SIZE - 1));
+
 /**
  * bio_split_rw_at - check if and where to split a read/write bio
  * @bio:  [in] bio to be split
@@ -293,9 +296,9 @@ static unsigned int bio_split_alignment(struct bio *b=
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
@@ -305,8 +308,11 @@ int bio_split_rw_at(struct bio *bio, const struct qu=
eue_limits *lim,
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
-			goto split;
+		if (bvprvp) {
+			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
+				goto split;
+			page_gaps |=3D bv_seg_gap(bv, bvprv);
+		}
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
@@ -324,6 +330,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	}
=20
 	*segs =3D nsegs;
+	bio->page_gaps =3D page_gaps;
 	return 0;
 split:
 	if (bio->bi_opf & REQ_ATOMIC)
@@ -353,6 +360,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
+	bio->page_gaps =3D page_gaps;
 	return bytes >> SECTOR_SHIFT;
 }
 EXPORT_SYMBOL_GPL(bio_split_rw_at);
@@ -696,6 +704,8 @@ static bool blk_atomic_write_mergeable_rqs(struct req=
uest *rq,
 static struct request *attempt_merge(struct request_queue *q,
 				     struct request *req, struct request *next)
 {
+	struct bio_vec bv, bvprv;
+
 	if (!rq_mergeable(req) || !rq_mergeable(next))
 		return NULL;
=20
@@ -753,6 +763,10 @@ static struct request *attempt_merge(struct request_=
queue *q,
 	if (next->start_time_ns < req->start_time_ns)
 		req->start_time_ns =3D next->start_time_ns;
=20
+	bv =3D next->bio->bi_io_vec[0];
+	bvprv =3D req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
+	req->__page_gaps |=3D blk_rq_page_gaps(next) | bv_seg_gap(bv, bvprv);
+
 	req->biotail->bi_next =3D next->bio;
 	req->biotail =3D next->biotail;
=20
@@ -861,6 +875,7 @@ enum bio_merge_status bio_attempt_back_merge(struct r=
equest *req,
 		struct bio *bio, unsigned int nr_segs)
 {
 	const blk_opf_t ff =3D bio_failfast(bio);
+	struct bio_vec bv, bvprv;
=20
 	if (!ll_back_merge_fn(req, bio, nr_segs))
 		return BIO_MERGE_FAILED;
@@ -876,6 +891,10 @@ enum bio_merge_status bio_attempt_back_merge(struct =
request *req,
 	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
 		blk_zone_write_plug_bio_merged(bio);
=20
+	bv =3D bio->bi_io_vec[0];
+	bvprv =3D req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
+	req->__page_gaps |=3D bio->page_gaps | bv_seg_gap(bv, bvprv);
+
 	req->biotail->bi_next =3D bio;
 	req->biotail =3D bio;
 	req->__data_len +=3D bio->bi_iter.bi_size;
@@ -890,6 +909,7 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,
 		struct bio *bio, unsigned int nr_segs)
 {
 	const blk_opf_t ff =3D bio_failfast(bio);
+	struct bio_vec bv, bvprv;
=20
 	/*
 	 * A front merge for writes to sequential zones of a zoned block device
@@ -910,6 +930,10 @@ static enum bio_merge_status bio_attempt_front_merge=
(struct request *req,
=20
 	blk_update_mixed_merge(req, bio, true);
=20
+	bv =3D req->bio->bi_io_vec[0];
+	bvprv =3D bio->bi_io_vec[bio->bi_vcnt - 1];
+	req->__page_gaps |=3D bio->page_gaps | bv_seg_gap(bv, bvprv);
+
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
index 2a5a828f19a0b..d8f491867adc0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -115,6 +115,7 @@ struct request {
=20
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
+	unsigned int __page_gaps;	/* a mask of all the segment page gaps */
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


