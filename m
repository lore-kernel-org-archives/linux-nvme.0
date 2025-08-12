Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C99DCA0EDF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CYReooKpTAGn/vR9y2RCTbwRKjsuvRuuurKnIf3s24g=; b=Kj0Fd9b8A2Z3qa+eYwWlrb6usS
	PTi7QUmUUvZ0mPNsiadHBN/E6XLQzOKF9tPSJYjbQx32lBzCfsJ6+/1eTvRCkkea5YI3iSipoXNxd
	w4fl7/ReCaD4bIB37QFt8RfFl+j4ArbohDCqdnT76BBR8YXDG/lfX5Ul8JQ9iqTCAH43CzhJkSko2
	X6RGepCKZbKuP1r9rUhysWnXkgYy7EhXEhgt9C40ntt0Va7+XpJF5oegBM52rVxkL33i7Qh/mXB9p
	O3uaOJgmpSfIIt+i+xsJtgUf4Aj6DIg+KMTN9lR9HLdYxvR0os5m68RT87HaKEMC/A41uU9qeY/PD
	RIPDE4nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulssv-0000000BbU0-1lk8;
	Tue, 12 Aug 2025 17:34:05 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpRg-0000000Aywx-01y7
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:53:45 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDpi5l006825
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CYReooKpTAGn/vR9y2RCTbwRKjsuvRuuurKnIf3s24g=; b=Y8vHyTShu4tC
	0aSpuvNSRtPY8ASd2ZeXq/WGcFNCiL2HWVeOO/ZD74Fi166Ga0UQ0+4mc6IJcQzZ
	mq77Q8v6dXLRtYJYJWko3/U9E/+BE1PCoQvWPiiFaPFyuBRmnt9Bt0Ssg1wdEjW1
	MjpaNxZC4Zv6Nk5k0WhN8f11aIKrysR3Z5U5BFxt7dxvaKopbbB1XqEKP+BsnHu+
	jaT7YYReIZNQNDca2aYDo1meFJLRGM3RDLFpZMgzH9GpfgVY7sYRUAhScqpFYhFe
	ne0fW0rhHsMDGTnKkDFnr/UzjnAXlC/yEcJ07/Z9Njk0bTD42+NsfDTuUIDlJV29
	DGYIetSiVw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g120b0cg-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:43 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 834DF8D4078; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 2/8] blk-mq-dma: provide the bio_vec array being iterated
Date: Tue, 12 Aug 2025 06:52:04 -0700
Message-ID: <20250812135210.4172178-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KJdaDEFo c=1 sm=1 tr=0 ts=689b4767 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lw-f5-AQ3I1Vcfc_tFYA:9
X-Proofpoint-ORIG-GUID: U1vEOTRuB4UiBgzdj2Y2BLgPAL0JOZOI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX2hgQZPjV/Xdu ZoPzkABFqQuDmsqOh/Ue+QDDUJkdcXNo16Ur4sx5iY0d55Y8hgy/Gl0afB13nhGype0lc2B6uwx bZ3KE6LxWFwBAiNRIy68afPBReHQVm+SG9dHYBxBnymL6p3VL5r5cluKUfGCaP8AAOzSz8MlyYr
 8MJevmL9cFvNUgPBGko5szdLJXzE0kyD8+aOq9p+HZOWFMrgE4Z12HgmOrDSgpDBDw+gJX86MW/ CWDt4BNyLstmxOIIhg3o/ooSgXGHFdlpgArH1Ca6GonD0QynPLUwquDWLmQ36jtDwdvrbWxtm3a 79mjcf70WygXh9T4/lM+p+Z8VbjBfqOdrKDu+d/6C/66VWWH2PbzYmNctTvRroiVWLJ4E41Ft+d
 rr4WaFnNPa1XblOLUMFuxT53jfYQXr7m7j8fj4Cuv6NyxFQwVjzbhsH/7mx/jRVQPkVeX0DB
X-Proofpoint-GUID: U1vEOTRuB4UiBgzdj2Y2BLgPAL0JOZOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065344_170951_FAEA3430 
X-CRM114-Status: GOOD (  19.95  )
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

This will make it easier to add different sources of the bvec array,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 56 ++++++++++++++++++++++----------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 51e7a0ff045f9..8f41fe740b465 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -16,23 +16,14 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter,
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
+	bv =3D mp_bvec_iter_bvec(iter->bvecs, iter->iter);
 	vec->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvecs, &iter->iter, bv.bv_len);
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -43,19 +34,20 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter,
 		struct bio_vec next;
=20
 		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
+			if (!iter->bio || !iter->bio->bi_next)
 				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
+			iter->bvecs =3D iter->bio->bi_io_vec;
 		}
=20
-		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next =3D mp_bvec_iter_bvec(iter->bvecs, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
=20
 		bv.bv_len +=3D next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(iter->bvecs, &iter->iter, next.bv_len);
 	}
=20
 	vec->len =3D bv.bv_len;
@@ -125,6 +117,30 @@ static bool blk_rq_dma_map_iova(struct request *req,=
 struct device *dma_dev,
 	return true;
 }
=20
+static inline void blk_rq_map_iter_init(struct request *rq,
+					struct blk_map_iter *iter)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		*iter =3D (struct blk_map_iter) {
+			.bvecs =3D &rq->special_vec,
+			.iter =3D {
+				.bi_size =3D rq->special_vec.bv_len,
+			}
+		};
+       } else if (bio) {
+		*iter =3D (struct blk_map_iter) {
+			.bio =3D bio,
+			.bvecs =3D bio->bi_io_vec,
+			.iter =3D bio->bi_iter,
+		};
+	} else {
+		/* the internal flush request may not have bio attached */
+	        *iter =3D (struct blk_map_iter) {};
+	}
+}
+
 /**
  * blk_rq_dma_map_iter_start - map the first DMA segment for a request
  * @req:	request to map
@@ -153,8 +169,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
 	struct phys_vec vec;
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
+	blk_rq_map_iter_init(req, &iter->iter);
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -246,16 +261,11 @@ blk_next_sg(struct scatterlist **sg, struct scatter=
list *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct blk_map_iter iter =3D {
-		.bio	=3D rq->bio,
-	};
+	struct blk_map_iter iter;
 	struct phys_vec vec;
 	int nsegs =3D 0;
=20
-	/* the internal flush request may not have bio attached */
-	if (iter.bio)
-		iter.iter =3D iter.bio->bi_iter;
-
+	blk_rq_map_iter_init(rq, &iter);
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 6a7e3828673d7..e5cb5e46fc928 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -8,6 +8,7 @@
 struct blk_map_iter {
 	struct bvec_iter		iter;
 	struct bio			*bio;
+	struct bio_vec			*bvecs;
 };
=20
 struct blk_dma_iter {
--=20
2.47.3


