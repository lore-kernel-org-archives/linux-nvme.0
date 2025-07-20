Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C006AC83F22
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeyMdkxr71mHi8iQN2D6FmqIkrzOMSAyTu2jwc1kH6M=; b=fPx2nsRXKZkLgIn7Klt38CQHEv
	GkAokg3ynXAPylUqNohiG4s3WZ2oUscpqCComsjDrEmE/br/u32pfopS3odzLn57Lst4v666UZc1n
	Ystsu3Tbm/vlvnY83Ad2btqxGiwZrfe2NIGD0Lh5daykoMo6iNMZqivn4iHDs9NAp63guJOd/ma9V
	s3zoLpnv3ILVyzyCS0+YaK/bZVYJXVobxu/yQwJ8zCHj/JOrGEa1PRIg1IpuGmgIcqI1AaW67XDB9
	1Y/W2+ZEhPtMzrTRb+MrKj3R+wDAOqT+zAf5ADvS/U3HnnrlCpJkzC85qKzzClCuFW82ytCC2TazC
	jj/C6CoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3R-0000000Fc5Z-39Wz;
	Sun, 20 Jul 2025 18:46:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ11-0000000FbpD-1gkF
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:04 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KEJ3Zm027207
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jeyMdkxr71mHi8iQN2D6FmqIkrzOMSAyTu2jwc1kH6M=; b=BHeboMS/iGej
	biwoCs068ioe0H4ATqU6HRM9Bf8PkDTWD78hOgaKUfXIyEhzw7318AgRlT5iSXpd
	qQoqxHtqvI9YkHlEw6tqQPeHp8sB5aAKo3VnJcKTFlR3okGXjIN3qgFnjfM4YRfV
	tnThVNChgrGQ8oso+zkCmpw0cVs9HxHlCz5Q4AJZw5m8DOgg1yofpFMRc6p3lL5M
	Vnje4WTzpIt3OpVO/kNcJ+5tZNoFoQFt1I8YC96Svpx8jWfj3/lnfLH9pT9fDZdh
	WA0ErbC0UTXKO62R+LgtHUmjMcoiu40jHc9w+wGYNb9GcgjWdRPVimKq5zJOegxW
	h1k2w0DX8A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4808wdwe8x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:02 -0700 (PDT)
Received: from twshared28243.32.prn2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:01 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id A1F08178C78E; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/7] blk-mq-dma: set the bvec being iterated
Date: Sun, 20 Jul 2025 11:40:35 -0700
Message-ID: <20250720184040.2402790-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: usm5ocmHkBF5dg7rb94MzKssXUk2W74B
X-Proofpoint-ORIG-GUID: usm5ocmHkBF5dg7rb94MzKssXUk2W74B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX5w0w818uxiSF BG+cj5aYkP4tRkcCwaI8xfWhrMxjVi3HI2E6I1Oz0ah/PN57JobVAURN72QI4/nzIEmrZT4GxM4 mNn8oe7rSY0bi8NqmKbrHuH16arZPFgprVOt1AhcfLdtKWrXxWH9y4OOeCmbL+TenAroxcbX45W
 Bx5CCvSd+R/53ly3LwIiWgK2lqZ2qHKx27EPlzWyI7nfyyXAiQ37R8e+Pf74yZ0isozJRrerLEe 5CS2/ZXtVjLQ1+oBt/rSAygZVC0XQDe3v1ohoL3gs3eqAqw+YxU1LyAMXMuvpMNfvhnKwDWPtv3 BvuUcdCDQcwgyhiQYOkABqvV4lHEeThHQMjHo8o1hPOzIMlROmrImoNw4rDyhAfSlEvjmR8l1kB
 xYOU5C5evf3o9qzyKDlBY2ivvxBahzy3Kfqg7OfykzfbmmbBM8jZvB6m4VJan50jfOJzqWVy
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=687d38f2 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Ra2a7VNcXYI1eJqiBM4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114403_559146_F1AEAB86 
X-CRM114-Status: GOOD (  16.79  )
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

This will make it easier to add different bvec sources, like for
upcoming integrity support. It also makes iterating "special" payloads
more common with iterating normal data bi_io_vecs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 30 ++++++++++++++++--------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 21da3d8941b23..7f3ad162b8ff2 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -16,23 +16,17 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_dma_iter *iter,
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		vec->paddr =3D bvec_phys(&req->special_vec);
-		vec->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 	vec->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvec, &iter->iter, bv.bv_len);
+
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return true;
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -47,15 +41,16 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_dma_iter *iter,
 				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
+			iter->bvec =3D iter->bio->bi_io_vec;
 		}
=20
-		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
=20
 		bv.bv_len +=3D next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(iter->bvec, &iter->iter, next.bv_len);
 	}
=20
 	vec->len =3D bv.bv_len;
@@ -158,6 +153,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->bvec =3D &req->special_vec;
+	else
+		iter->bvec =3D req->bio->bi_io_vec;
+
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -253,8 +253,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatt=
erlist *sglist,
 	int nsegs =3D 0;
=20
 	/* the internal flush request may not have bio attached */
-	if (iter.bio)
+	if (iter.bio) {
 		iter.iter =3D iter.bio->bi_iter;
+		iter.bvec =3D iter.bio->bi_io_vec;
+	}
=20
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index e1c01ba1e2e58..c2cf74be6a3d6 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -14,6 +14,7 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
+	struct bio_vec			*bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
 	struct pci_p2pdma_map_state	p2pdma;
--=20
2.47.1


