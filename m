Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB95CC87FCF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=avK5vjv2ZBbtTd49zhSzJVhzxXrayaH8NXth9++nfcc=; b=Zlq38iXwc8STCZ+c2CqCBrYLqa
	pzLJdod0HTWojyobVQiXlnsGAbqUnz/g/Wp9OE2ERA1ymbJLtgxVGbW4gBhvuAg1zJqtLeevI7kmd
	Jjh/akZN4t1n9G9FCf0mmWyKjFB/shdRjtJSKvCXY4yhj5iYVwz8AeLdEAzkbFNwOE8Laj9Rd/klI
	wGL8s2HfziLoPm9w0OX3BlxHJG1g5l12Ma3UfVFdqCjTvu1e03zKcKi8P1Dlelk8oKoXzq6A0NIlM
	ome4d8fik3736zoLR97MWWP0fG1j7VY9S3I557iqlmSVeJD3gT/5112hYDTAON4EbvfiAOyeGWW/j
	QocncWfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEO8-0000000EOsz-1PWv;
	Wed, 13 Aug 2025 16:31:44 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDSa-0000000ECMP-3WSK
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:32:18 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57DF1ZMb032629
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=avK5vjv2ZBbtTd49zhSzJVhzxXrayaH8NXth9++nfcc=; b=hFm9TborLj9o
	gLi5HOxV0wDG/fjcuNvgRfV7+OUhcwR3t6W6Fz5CAcAKOSsH+0zwUW5JQQTSr70r
	Eb4qZ1XpHtgmzHiK5mBkddjjF/weIJA6Z4no/kMhTqDfxkou2zO8ayaQSWI9vSWs
	Q3oszof5lvK56naV+/N2LZVkdC86q3W0WHzpmIQjrT8DAAwnAyL3fiiG8Z6fbQss
	vgLYqlM93K/NVvTbceB6WtOuOpGpHEEAQhVQhQYE5j8f2GzxcbQ4RZXdR897CoI9
	VX3ErB+0EGZkuGpH4ZpJwDlO+V05bm45SO/S8WGgUGWXKuskRmBFcFcf7sraIQFY
	ahcD+XGEnw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 48gqmwte1f-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:15 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 88CFC97CD86; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 6/9] blk-mq-dma: add scatter-less integrity data DMA mapping
Date: Wed, 13 Aug 2025 08:31:50 -0700
Message-ID: <20250813153153.3260897-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BaTY0qt2 c=1 sm=1 tr=0 ts=689cafff cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=95mi9lD3wWQj8gX5w1UA:9
X-Proofpoint-GUID: 9mc2RXk0cau5qhNBFHpVzzHXmqHvCojp
X-Proofpoint-ORIG-GUID: 9mc2RXk0cau5qhNBFHpVzzHXmqHvCojp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfXybN25jVkgmqg 879raitCYdZrxO3CcxQQ1zNlMNWQR2d67b/9+ZbkB+t9PqgO1N2KTpj8q+50Fj41RHpHOgKoMbB iXytoMRhm3mGdVU72XqQoQ5vj82LiFpFoogJcAUiw5Tzxh5fMZiy6nuXXc1gIjScTCD9GeZSRg/
 yV9obQWbon3OQgKGGpABLgkFs74fdVQ3HHrg2t0vluAYYmuVJuG4+/deGcDS3l/99ETZz9TB2Se xgX8I08A92ebDpzo5N/KSZNnfXXyGitNC8ciUbxpISsAoHxaCD7TsYij73X7IB8nn7dWcYXlMhL zHRDIfSytj3YltgUg3A6EDofQAUQHBxy61d00WR5O7XMQ+z7yvbv4XIr4PXkZqGrEkr+Ck5EZl9
 +1RXTEeqoEBjoGwJPmUuhUyi39rB0UA5Sw78hNKSWbhYhVhYVQWqK1K2P4WJ1A8hSSx+AIKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083216_998181_4ACBDEB1 
X-CRM114-Status: GOOD (  25.20  )
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

Similar to regular data, introduce more efficient integrity mapping
helpers that does away with the scatterlist structure. This uses the
block mapping iterator to add IOVA segments if IOMMU is enabled, or maps
directly if not. This also supports P2P segements if integrity data ever
wants to allocate that type of memory.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            | 104 +++++++++++++++++++++++++++++++---
 include/linux/blk-integrity.h |  17 ++++++
 include/linux/blk-mq-dma.h    |   1 +
 3 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 31dd8f58f0811..60a244a129c3c 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2025 Christoph Hellwig
  */
+#include <linux/blk-integrity.h>
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
@@ -10,6 +11,24 @@ struct phys_vec {
 	u32		len;
 };
=20
+static bool __blk_map_iter_next(struct blk_map_iter *iter)
+{
+	if (iter->iter.bi_size)
+		return true;
+	if (!iter->bio || !iter->bio->bi_next)
+		return false;
+
+	iter->bio =3D iter->bio->bi_next;
+	if (iter->is_integrity) {
+		iter->iter =3D bio_integrity(iter->bio)->bip_iter;
+		iter->bvecs =3D bio_integrity(iter->bio)->bip_vec;
+	} else {
+		iter->iter =3D iter->bio->bi_iter;
+		iter->bvecs =3D iter->bio->bi_io_vec;
+	}
+	return true;
+}
+
 static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter,
 			      struct phys_vec *vec)
 {
@@ -33,13 +52,8 @@ static bool blk_map_iter_next(struct request *req, str=
uct blk_map_iter *iter,
 	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
 		struct bio_vec next;
=20
-		if (!iter->iter.bi_size) {
-			if (!iter->bio || !iter->bio->bi_next)
-				break;
-			iter->bio =3D iter->bio->bi_next;
-			iter->iter =3D iter->bio->bi_iter;
-			iter->bvecs =3D iter->bio->bi_io_vec;
-		}
+		if (!__blk_map_iter_next(iter))
+			break;
=20
 		next =3D mp_bvec_iter_bvec(iter->bvecs, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
@@ -290,3 +304,79 @@ int __blk_rq_map_sg(struct request *rq, struct scatt=
erlist *sglist,
 	return nsegs;
 }
 EXPORT_SYMBOL(__blk_rq_map_sg);
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+/**
+ * blk_rq_integrity_dma_map_iter_start - map the first integrity DMA seg=
ment
+ * 					 for a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Start DMA mapping @req integrity data to @dma_dev.  @state and @iter =
are
+ * provided by the caller and don't need to be initialized.  @state need=
s to be
+ * stored for use at unmap time, @iter is only needed at map time.
+ *
+ * Returns %false if there is no segment to map, including due to an err=
or, or
+ * %true if it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.=
addr
+ * and the length in @iter.len.  If no segment was mapped the status cod=
e is
+ * returned in @iter.status.
+ *
+ * The caller can call blk_rq_dma_map_coalesce() to check if further seg=
ments
+ * need to be mapped after this, or go straight to blk_rq_dma_map_iter_n=
ext()
+ * to try to map the following segments.
+ */
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	unsigned len =3D bio_integrity_bytes(&req->q->limits.integrity,
+					   blk_rq_sectors(req));
+	struct bio *bio =3D req->bio;
+
+	iter->iter =3D (struct blk_map_iter) {
+		.bio =3D bio,
+		.iter =3D bio_integrity(bio)->bip_iter,
+		.bvecs =3D bio_integrity(bio)->bip_vec,
+		.is_integrity =3D true,
+	};
+	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
+
+/**
+ * blk_rq_integrity_dma_map_iter_start - map the next integrity DMA segm=
ent for
+ * 					 a request
+ * @req:	request to map
+ * @dma_dev:	device to map to
+ * @state:	DMA IOVA state
+ * @iter:	block layer DMA iterator
+ *
+ * Iterate to the next integrity mapping after a previous call to
+ * blk_rq_integrity_dma_map_iter_start().  See there for a detailed desc=
ription
+ * of the arguments.
+ *
+ * Returns %false if there is no segment to map, including due to an err=
or, or
+ * %true if it did map a segment.
+ *
+ * If a segment was mapped, the DMA address for it is returned in @iter.=
addr and
+ * the length in @iter.len.  If no segment was mapped the status code is
+ * returned in @iter.status.
+ */
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+               struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+#endif
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index e67a2b6e8f111..78fe2459e6612 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -4,6 +4,7 @@
=20
 #include <linux/blk-mq.h>
 #include <linux/bio-integrity.h>
+#include <linux/blk-mq-dma.h>
=20
 struct request;
=20
@@ -31,6 +32,11 @@ int blk_rq_integrity_map_user(struct request *rq, void=
 __user *ubuf,
 			      ssize_t bytes);
 int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 		     struct logical_block_metadata_cap __user *argp);
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter);
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -115,6 +121,17 @@ static inline int blk_rq_integrity_map_user(struct r=
equest *rq,
 {
 	return -EINVAL;
 }
+static inline bool blk_rq_integrity_dma_map_iter_start(struct request *r=
eq,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	return false;
+}
+static inline bool blk_rq_integrity_dma_map_iter_next(struct request *re=
q,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	return false;
+}
 static inline struct blk_integrity *bdev_get_integrity(struct block_devi=
ce *b)
 {
 	return NULL;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 881880095e0da..0f45ea110ca12 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -9,6 +9,7 @@ struct blk_map_iter {
 	struct bvec_iter		iter;
 	struct bio			*bio;
 	struct bio_vec			*bvecs;
+	bool				is_integrity;
 };
=20
 struct blk_dma_iter {
--=20
2.47.3


