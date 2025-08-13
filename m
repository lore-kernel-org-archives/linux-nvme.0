Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AD9CA0EE7
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=anjNaWt+3wXdyjyf2pCWgDzvhvam52KzBRAOpcEMVoQ=; b=jwy5x9vhh13AA5WfxjePcQ5WSy
	DFpQVwWZkMr2EBaSWsmI2fAXIBDOtE+m9l2oSqVCZcmvBuwMdFDKRJrMEDOYpPF6N7y3dGuq1Ytte
	GUnnjKEahnPaUGOJ7L3vGOAKJuxQUIrz0RY7Iw4fO4xzu+AgdABISwNAKMECXVaidFl5R8RASw2Nn
	EbNzBNMJFp+HPs9e3MMCWQrScLKXAKjEiFEgBtPZCBROe0SNiC57gDpbRGLDQauqDOhFMz3jkOnVc
	Dmz8ObUfnoqQoAvn7sdTMS9ZcCCzd0egZXnsMWEmEiCsgm8pK5+EEUk7c0+cx8mkzxVmp1pSB7gqg
	5C+UAYuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEOD-0000000EOyb-1Is4;
	Wed, 13 Aug 2025 16:31:49 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDVR-0000000ECpW-1jhz
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:35:14 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBCbc026588
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:35:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=anjNaWt+3wXdyjyf2pCWgDzvhvam52KzBRAOpcEMVoQ=; b=YKynVEGfwp52
	c2sd0DGcln5TmIV8JQT/8bzGXMzWQSng/aDlIu8JYtZCfyTT8lANf1UAEQIvIOA4
	5Wyv9lzj81lSqVlV6sThTurMJcn0ma2JcJ7DWB6rACooDe5Zq1ciay66HtK7Wc2z
	nXpLksy8Iw0etK/fSTuQ2EKtpWky5NbM5DrjjFwR4YeSeoKPfzZ+60HYnyZ8oMxe
	uMtWwZ0s5I2F1QfTSjn8BKCHtNdRvqEgeGOxjs4O6ZtBErn6Xz3FWUZQVAse5ZOd
	/2FceUPXllNyHCAKT5nzP9e9/YEpw9niNxipAneOmvkS6KaHfkVKPbwc9iqkwEuS
	xcDRBMux9A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gw4f87ka-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:35:12 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:35:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8C0BC97CD88; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 7/9] blk-integrity: use iterator for mapping sg
Date: Wed, 13 Aug 2025 08:31:51 -0700
Message-ID: <20250813153153.3260897-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F9nbFsCbQVPtelODuAKltg2lKI9kpygn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX8P6wC7K2bzX4 GfrOC+tFHeizkmw7hUF1qCNqh8GLAS3IY1oT3llUNy53xeJq0Q9xyzTTdW1CCxWhnvHWX051wUW EWaWUWfY18N/5O55DsIGRVw7sEk2KcejYBFpFdI4X/Fz2Qp6fYE5MaPXUU7Nh8aTEZivv41FZ1w
 eS+BJX/y6ulNXAaHcY1TF0fY6FcPvvP9d21EJXwYUtVkTcRCAUwkEELA7Qz/6c0aAu6vD4WJbt/ WTFj8obpdWSSip8LF1PFGTfeeKQOhyxMIwJT3qvhWd7xhnJ0rrFEOgJlJs9aAzHpdOwdpDgcQPX tmhINcTXPPBrMm4DFW+wfLlvmK0920SA4v6bEvy8nDg3N3dtcRddQDzA6omKF/if7U1V8qf09uV
 iB5bHQ1MeYKVy2TzZGZ5XATx669mZRrSVZP4Scpkm/jZ+RqxZU0juZEFceRN/2OhZzdBxaNj
X-Proofpoint-GUID: F9nbFsCbQVPtelODuAKltg2lKI9kpygn
X-Authority-Analysis: v=2.4 cv=M7BNKzws c=1 sm=1 tr=0 ts=689cb0b0 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pchrdSwneEv6fAf9h9MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083513_459448_B4DB5513 
X-CRM114-Status: GOOD (  16.61  )
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

Modify blk_rq_map_integrity_sg to use the blk-mq mapping iterator. This
produces more efficient code and converges the integrity mapping
implementations to reduce future maintenance burdens.

The function implementation moves from blk-integrity.c to blk-mq-dma.c
in order to use the types and functions private to that file.=20

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 58 -------------------------------------------
 block/blk-mq-dma.c    | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 58 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 056b8948369d5..dd97b27366e0e 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -122,64 +122,6 @@ int blk_get_meta_cap(struct block_device *bdev, unsi=
gned int cmd,
 				   NULL);
 }
=20
-/**
- * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
- * @rq:		request to map
- * @sglist:	target scatterlist
- *
- * Description: Map the integrity vectors in request into a
- * scatterlist.  The scatterlist must be big enough to hold all
- * elements.  I.e. sized using blk_rq_count_integrity_sg() or
- * rq->nr_integrity_segments.
- */
-int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sgli=
st)
-{
-	struct bio_vec iv, ivprv =3D { NULL };
-	struct request_queue *q =3D rq->q;
-	struct scatterlist *sg =3D NULL;
-	struct bio *bio =3D rq->bio;
-	unsigned int segments =3D 0;
-	struct bvec_iter iter;
-	int prev =3D 0;
-
-	bio_for_each_integrity_vec(iv, bio, iter) {
-		if (prev) {
-			if (!biovec_phys_mergeable(q, &ivprv, &iv))
-				goto new_segment;
-			if (sg->length + iv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
-
-			sg->length +=3D iv.bv_len;
-		} else {
-new_segment:
-			if (!sg)
-				sg =3D sglist;
-			else {
-				sg_unmark_end(sg);
-				sg =3D sg_next(sg);
-			}
-
-			sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
-			segments++;
-		}
-
-		prev =3D 1;
-		ivprv =3D iv;
-	}
-
-	if (sg)
-		sg_mark_end(sg);
-
-	/*
-	 * Something must have been wrong if the figured number of segment
-	 * is bigger than number of req's physical integrity segments
-	 */
-	BUG_ON(segments > rq->nr_integrity_segments);
-	BUG_ON(segments > queue_max_integrity_segments(q));
-	return segments;
-}
-EXPORT_SYMBOL(blk_rq_map_integrity_sg);
-
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes)
 {
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 60a244a129c3c..660b5e200ccf6 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -379,4 +379,49 @@ bool blk_rq_integrity_dma_map_iter_next(struct reque=
st *req,
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }
 EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+
+/**
+ * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
+ * @rq:		request to map
+ * @sglist:	target scatterlist
+ *
+ * Description: Map the integrity vectors in request into a
+ * scatterlist.  The scatterlist must be big enough to hold all
+ * elements.  I.e. sized using blk_rq_count_integrity_sg() or
+ * rq->nr_integrity_segments.
+ */
+int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sgli=
st)
+{
+	struct request_queue *q =3D rq->q;
+	struct scatterlist *sg =3D NULL;
+	struct bio *bio =3D rq->bio;
+	unsigned int segments =3D 0;
+	struct phys_vec vec;
+
+	struct blk_map_iter iter =3D {
+		.bio =3D bio,
+		.iter =3D bio_integrity(bio)->bip_iter,
+		.bvecs =3D bio_integrity(bio)->bip_vec,
+		.is_integrity =3D true,
+	};
+
+	while (blk_map_iter_next(rq, &iter, &vec)) {
+		sg =3D blk_next_sg(&sg, sglist);
+		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
+				offset_in_page(vec.paddr));
+		segments++;
+	}
+
+	if (sg)
+	        sg_mark_end(sg);
+
+	/*
+	 * Something must have been wrong if the figured number of segment
+	 * is bigger than number of req's physical integrity segments
+	 */
+	BUG_ON(segments > rq->nr_integrity_segments);
+	BUG_ON(segments > queue_max_integrity_segments(q));
+	return segments;
+}
+EXPORT_SYMBOL(blk_rq_map_integrity_sg);
 #endif
--=20
2.47.3


