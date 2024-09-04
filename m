Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E13CD4853
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJP9fbquyO89MaTiOtDLqqeht8rmftU7NWjYzfHDelI=; b=ODqXqmodi3kubGobIR266QNRcR
	wn2ldBkXMT5NibXBt2jME0L2sypcH2+DJyGPekfAQYCuVJRE1GUCPXC8eFpBbmrcRN4Sk+CK3ws13
	E3A72GrB2wW5uMT+t5Plx4/8fdWVIW8GWcrbw5zdnB0AwymAt09RWJzIJ6m1C1i1qSS7HWcGTUgKh
	0GqCEx+eDFdsQSUWOUl+DMf6GWeQ80kwVFRlmd4SeOMlLIXLJt8DFjXRPI4AiZdCeD2aMYlvW60Qp
	ZsfH5H/tWTXMSnz8FLglOHd65IviYZI8jovE4kR9Pkz0mkqqW/jgzxQsspfWO5PI/RbsAVhuignjV
	w/XCoWWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slru9-00000004zW0-3VSA;
	Wed, 04 Sep 2024 15:26:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slru7-00000004zVD-1w3T
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:44 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849U2Nj022336
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=HJP9fbquyO89MaTiOtDLqqeht8rmftU7NWjYzfHDelI=; b=
	MKZxzqTw9ZehoIqgfEiCZ7e55mbnZP46oroZbom7rS5p6j47x9bf4cYzarRVEc8b
	iUzWv9pXWp0siB9/bLu4iA+0yvZu8vuteL18Gi4P2WxBRqx8mfEqK3nfUd467Bdz
	fMLazFlbnYBEgawdjLGeKP+h/dAI6yExAZQtkMljo1gfzs0qiMn1ggIAk1/O5obq
	aB8P6YB8ZPuTVUByAvC0nWSJ0Ae+ATF4ePGNkkFS6YIdpbqaqX/n3odS9TsRWPks
	eVPDfB/3vvSekFmnP0eEqhQPi3T29m1PSILB60IOXJEOs9ZOmzBb6lO9H8aaEHQL
	nuNUmSlD9wuhS4BvtdPKCA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1w8k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:42 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D030A12A036ED; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 06/10] blk-integrity: simplify counting segments
Date: Wed, 4 Sep 2024 08:26:01 -0700
Message-ID: <20240904152605.4055570-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TKIDUF2Fj3QfXPX-K8vtO_MEWJebLoDY
X-Proofpoint-ORIG-GUID: TKIDUF2Fj3QfXPX-K8vtO_MEWJebLoDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082643_511734_8F092B2C 
X-CRM114-Status: GOOD (  16.73  )
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

The segments are already packed to the queue limits when adding them to
the bio, so each vector is already its own segment. No need to attempt
compacting them even more. And give the function a more appropriate
name, since we're counting segments, not scatter-gather elements.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c         | 33 ++++++---------------------------
 block/blk-mq.c                |  2 +-
 include/linux/blk-integrity.h |  5 ++---
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 4365960153b91..c180141b7871c 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -17,39 +17,18 @@
 #include "blk.h"
=20
 /**
- * blk_rq_count_integrity_sg - Count number of integrity scatterlist ele=
ments
- * @q:		request queue
+ * blk_rq_count_integrity_segs - Count number of integrity segments
  * @bio:	bio with integrity metadata attached
  *
  * Description: Returns the number of elements required in a
  * scatterlist corresponding to the integrity metadata in a bio.
  */
-int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
+int blk_rq_count_integrity_segs(struct bio *bio)
 {
-	struct bio_vec iv, ivprv =3D { NULL };
 	unsigned int segments =3D 0;
-	unsigned int seg_size =3D 0;
-	struct bvec_iter iter;
-	int prev =3D 0;
-
-	bio_for_each_integrity_vec(iv, bio, iter) {
=20
-		if (prev) {
-			if (!biovec_phys_mergeable(q, &ivprv, &iv))
-				goto new_segment;
-			if (seg_size + iv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-
-			seg_size +=3D iv.bv_len;
-		} else {
-new_segment:
-			segments++;
-			seg_size =3D iv.bv_len;
-		}
-
-		prev =3D 1;
-		ivprv =3D iv;
-	}
+	for_each_bio(bio)
+		segments +=3D bio->bi_integrity->bip_vcnt;
=20
 	return segments;
 }
@@ -62,7 +41,7 @@ int blk_rq_count_integrity_sg(struct request_queue *q, =
struct bio *bio)
  *
  * Description: Map the integrity vectors in request into a
  * scatterlist.  The scatterlist must be big enough to hold all
- * elements.  I.e. sized using blk_rq_count_integrity_sg().
+ * elements.  I.e. sized using blk_rq_count_integrity_segs().
  */
 int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
 			    struct scatterlist *sglist)
@@ -145,7 +124,7 @@ bool blk_integrity_merge_bio(struct request_queue *q,=
 struct request *req,
 		return false;
=20
 	bio->bi_next =3D NULL;
-	nr_integrity_segs =3D blk_rq_count_integrity_sg(q, bio);
+	nr_integrity_segs =3D blk_rq_count_integrity_segs(bio);
 	bio->bi_next =3D next;
=20
 	if (req->nr_integrity_segments + nr_integrity_segs >
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ed5181c75610..79cc66275f1cd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2548,7 +2548,7 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
 	blk_rq_bio_prep(rq, bio, nr_segs);
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	if (bio->bi_opf & REQ_INTEGRITY)
-		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q, bio);
+		rq->nr_integrity_segments =3D blk_rq_count_integrity_segs(bio);
 #endif
=20
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index de98049b7ded9..0de05278ac824 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -27,7 +27,7 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 int blk_rq_map_integrity_sg(struct request_queue *, struct bio *,
 				   struct scatterlist *);
-int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
+int blk_rq_count_integrity_segs(struct bio *);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -91,8 +91,7 @@ static inline struct bio_vec rq_integrity_vec(struct re=
quest *rq)
 				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
-static inline int blk_rq_count_integrity_sg(struct request_queue *q,
-					    struct bio *b)
+static inline int blk_rq_count_integrity_segs(struct bio *b)
 {
 	return 0;
 }
--=20
2.43.5


