Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8651FC87FDA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkMrR99d59z6/nHcnOiZ1oYWkISyCmHMhuU85frwhOE=; b=bGqyaUYN5N67Zo5QmS4YJ3ejnK
	n8xEtPlT9Gh8Asxxw7KLNuIhSHOAwoLS+LFfyVIRWyjAtfeC1b7VZr3oefH1jIdT6hPra88+Pw50W
	ScU+GWbKJSYupW3u1souluarNRdvMBsw8BVE1Mfiun5jXPqqy9qgC1LlrbsgCZg4yvFx+ZrZZSQ9T
	SXV4Kz+Vp0qg8eU0vj5rmwupQSiz+BtCb2QKtd50MVtvzkUxMjOnp1OopYwVXSR3ZjKu9VWbnnmid
	nHl1+Olzs+ja92k57xwgmgUdSOw2B5QgzpujO3RXD2XLF7Wm3pxXPCnxoxqia1OVP2TTPVHGypH2A
	MC9vnNKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWd-00000003G7a-0C0D;
	Fri, 08 Aug 2025 16:00:59 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPUL-00000003FdN-1U0x
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 15:58:38 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 578FIuiN020744
	for <linux-nvme@lists.infradead.org>; Fri, 8 Aug 2025 08:58:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FkMrR99d59z6/nHcnOiZ1oYWkISyCmHMhuU85frwhOE=; b=C08uSVwKyNE5
	8GF27Czq2GHNKE3Y48L9c+4rHm1sGfh1iSPK5uESSMybxumIGCiWULLP6LGpGjfI
	y7rpFsaPR65eLMag/8m3MCdQVooEoeDy90dIlTrUScO4M9AF4C/AZYYPPJihyqqP
	jZoX5bCZujQ+FJh8sOHTlVhcDZ15JgtrU6VqBMfJedJZoq2SKOfGuuD+n9Id0tor
	Lrg5w4QmZZsM73dNTexG1Lt3K9L6tg/WeNcokfqROHd3fN61HZ9yHybdhAho5INS
	PxRoAAOblUp6fhH+nvRMYTT6n0h0ubMz2Y6rgCMjvN/0BFi503VjpVrNuuM+RhnL
	Vl+TjRVm2A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 48da6ukf1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Aug 2025 08:58:36 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:35 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 276EC6C76BF; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being iterated
Date: Fri, 8 Aug 2025 08:58:20 -0700
Message-ID: <20250808155826.1864803-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: W3F5cdYSIi6mz3DFAyUfEDgg6MO6L4tY
X-Authority-Analysis: v=2.4 cv=H4nbw/Yi c=1 sm=1 tr=0 ts=68961eac cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=RFQSphkRhlftazc-zEkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX+pqXnebLxGNk SizZeVVDpOKSjf9zGeKA3tI01mTU2RlV19oUJe8LldbaxXdsoD3wrFsg3riP6lqG5bNcW27a+zE VcKhSCLpP12WpGXtZWBssjN3tV5/ZViSbq9YbrUb9kt26GsyjQVML7cmIrSL9BxW8mL/D9lpNz7
 zlduPT1IJ2BkLJ/mmh6KhMTKdTQLdPLN7A7WdXZK9eZPfV6HRVUZ8O2GqpVSWTETc4WC/AL1M1v USmnDwJKFqK9aXO2JITgNOFD6IbGC+tzMhvhMHwttBl2zNAGxezvEZXU+AphXzIIC9ey5kMGdwC eT9PA628khisCRbh86sVEV7PYNd9ZhTkplXAsO32rynqo+N8XRZ7oEnpXeJgDOVOER0e4yrz6+e
 4MHsWJOjaXrFG/8ANqFNAi29sXoGNzx1xKFN1fdnSyiqD83JYL1vRp+I9DmgeCu4QjaxFDmC
X-Proofpoint-GUID: W3F5cdYSIi6mz3DFAyUfEDgg6MO6L4tY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085837_505393_E11988EA 
X-CRM114-Status: GOOD (  19.77  )
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

This will make it easier to add different sources of the bvec table,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 56 ++++++++++++++++++++++----------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ff4c9a7e19d83..4a013703bcba5 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,23 +10,14 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		iter->paddr =3D bvec_phys(&req->special_vec);
-		iter->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 	iter->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, iter->paddr, UINT_MA=
X);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvec, &iter->iter, bv.bv_len);
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -37,19 +28,20 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 		struct bio_vec next;
=20
 		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
+			if (!iter->bio || !iter->bio->bi_next)
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
 	iter->len =3D bv.bv_len;
@@ -119,6 +111,30 @@ static bool blk_rq_dma_map_iova(struct request *req,=
 struct device *dma_dev,
 	return true;
 }
=20
+static struct blk_map_iter blk_rq_map_iter(struct request *rq)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		return (struct blk_map_iter) {
+			.bvec =3D &rq->special_vec,
+			.iter =3D {
+				.bi_size =3D rq->special_vec.bv_len,
+			}
+		};
+       }
+
+	/* the internal flush request may not have bio attached */
+	if (!bio)
+	        return (struct blk_map_iter) {};
+
+	return (struct blk_map_iter) {
+		.bio =3D bio,
+		.bvec =3D bio->bi_io_vec,
+		.iter =3D bio->bi_iter,
+	};
+}
+
 /**
  * blk_rq_dma_map_iter_start - map the first DMA segment for a request
  * @req:	request to map
@@ -146,10 +162,9 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 {
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
+	iter->iter =3D blk_rq_map_iter(req);
=20
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
@@ -237,16 +252,9 @@ blk_next_sg(struct scatterlist **sg, struct scatterl=
ist *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct bio *bio =3D rq->bio;
-	struct blk_map_iter iter =3D {
-		.bio	=3D bio,
-	};
+	struct blk_map_iter iter =3D blk_rq_map_iter(rq);
 	int nsegs =3D 0;
=20
-	/* the internal flush request may not have bio attached */
-	if (bio)
-		iter.iter =3D bio->bi_iter;
-
 	while (blk_map_iter_next(rq, &iter)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(iter.paddr), iter.len,
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 1e5988afdb978..c82f880dee914 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -8,6 +8,7 @@
 struct blk_map_iter {
 	phys_addr_t			paddr;
 	u32				len;
+	struct bio_vec                  *bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
 };
--=20
2.47.3


