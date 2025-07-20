Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E07C83F3E
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q97T54siiB+AnzZHMhBNhEFizu8K5aTXy2koOH8+ooI=; b=CCXzNFSArdljcD0qM5uxWSHjS5
	tmmQ7Pi3YP+YCtwjA68nLW4DcgzRNtPCuM9SKUIYOrF6OL3z3lnPd9yp5VgUatg4CRin1anmOLKc8
	RfWIt30/cmASuSaznqYAsZFgH6/ycWtpEgIFVKud8xNrxIgRJKbv/wDbK1L69Gk4dfoOkvOIGgeXO
	N02Y6U63xEOixDcAMebO2yA0N/dWtTAAsMxnKZeaOraGaxpnEp8rTYsM1nT/cG5RH6214m/PcJ6VS
	0PPdWN+PRMF36Ko/ZGVdWGTj+ZplClrG6cXJRiGyy25JBtmxJTqJlal2sShedGzH7GSLnLjNUlK4p
	0ZbTk0cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3U-0000000Fc7M-0M1w;
	Sun, 20 Jul 2025 18:46:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ14-0000000Fbqj-3o2O
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:08 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KEJ3Zt027207
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Q97T54siiB+AnzZHMhBNhEFizu8K5aTXy2koOH8+ooI=; b=keZj57qEwkoi
	jz+nofxSCueN8nHWWaTO3dPSsF9t2RNM//llPnSwumZE6JTSDLtZvnUlonobSx5C
	+XgCML+uuy2u3ex0VsveLmSN6ihCyz7K3T+I5fOekLQaLmPFCI40fo/2wrS+/sSf
	GJd+D5m0By6QqaGlosRGvmfUTtNYIg3cRDeQMAKzeqZoYHKz3Mnb4rvJ0S5ykJuR
	8eFQcIiwY/13EpDbypvqGTMCHQrUHLwNnyWOFpmWtrvtp090Sbvql6ArqgiDJ0ZR
	SWiU9LPRf0BBzJEw0tnSs+CjuN4NB98Y6goAVnpdamBuGrowfcqAJB7mxZE4Us6K
	p/zzX+tGjQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4808wdwe8x-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:05 -0700 (PDT)
Received: from twshared78382.04.prn6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:03 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 56BF2178C798; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity metadata
Date: Sun, 20 Jul 2025 11:40:39 -0700
Message-ID: <20250720184040.2402790-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NplAlJEm3hJvoBbiinB7iRv_afz4pMHw
X-Proofpoint-ORIG-GUID: NplAlJEm3hJvoBbiinB7iRv_afz4pMHw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfXzo1vuDJ1KhPQ 7Pcn6a1T2aZ31lBclX/ecIBONpHXTuqCNm6WKvef0/3X6BIRGb4n3CGM4SyHb8WbHtHJ0ZEuxh8 0Sb9QVavB1eegS0HUbv17QaUszIabA70rI3n8m16n+i5tAj39He4loQTjwt+xpQoCnJX+K4HWbt
 8bx6li6smEwsFRmmqhH1+MpDuEa5cKWV4jBjhtl/uJROHeM22cG/YThLFThDQWLft1bkm2XcdHG hCfcbnPNSosubi6uBm6Qi+A7E20zQJT6aK+taBVjDQqA2Zyb/tW7mPaeysFX2WR39JueRL+xGdN ZZ8bD46oUhdHQc40oXfbks0xGvu7FcudN18BQJSHuci1V6issxLPGoMINs/Y8ui82MZEUnz9M4h
 kNOD4BzYwRlUd0L0DuONLUtKOtHE5OC9/RQxmoI2yN4JesPYMVAvKw5rR6WcEE63ZyQ+KmQf
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=687d38f6 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=vMGUKEoAC2i4v1bJTHIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114407_064529_58AA8373 
X-CRM114-Status: GOOD (  17.02  )
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

Provide integrity metadata helpers equivalent to the data payload
helpers for iterating a request for dma setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            | 58 ++++++++++++++++++++++++++++++-----
 include/linux/blk-integrity.h | 17 ++++++++++
 include/linux/blk-mq-dma.h    |  1 +
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 1e2e93c1cf5e2..a4ae043e2cd72 100644
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
+static bool blk_dma_iter_next(struct blk_dma_iter *iter)
+{
+	if (iter->iter.bi_size)
+		return true;
+	if (!iter->bio->bi_next)
+		return false;
+
+	iter->bio =3D iter->bio->bi_next;
+	if (iter->integrity) {
+		iter->iter =3D iter->bio->bi_integrity->bip_iter;
+		iter->bvec =3D iter->bio->bi_integrity->bip_vec;
+	} else {
+		iter->iter =3D iter->bio->bi_iter;
+		iter->bvec =3D iter->bio->bi_io_vec;
+	}
+	return true;
+}
+
 static bool blk_map_iter_next(struct request *req, struct blk_dma_iter *=
iter,
 			      struct phys_vec *vec)
 {
@@ -36,13 +55,8 @@ static bool blk_map_iter_next(struct request *req, str=
uct blk_dma_iter *iter,
 	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
 		struct bio_vec next;
=20
-		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
-				break;
-			iter->bio =3D iter->bio->bi_next;
-			iter->iter =3D iter->bio->bi_iter;
-			iter->bvec =3D iter->bio->bi_io_vec;
-		}
+		if (!blk_dma_iter_next(iter))
+			break;
=20
 		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
@@ -185,6 +199,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	iter->iter =3D req->bio->bi_iter;
+	iter->integrity =3D false;
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
 		iter->bvec =3D &req->special_vec;
 	else
@@ -227,6 +242,35 @@ bool blk_rq_dma_map_iter_next(struct request *req, s=
truct device *dma_dev,
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
=20
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	unsigned len =3D bio_integrity_bytes(&req->q->limits.integrity,
+					   blk_rq_sectors(req));
+	iter->iter =3D req->bio->bi_integrity->bip_iter;
+	iter->bvec =3D req->bio->bi_integrity->bip_vec;
+	iter->integrity =3D true;
+	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
+
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+               struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_map_iter_next(req, iter, &vec))
+		return false;
+
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+#endif
+
 static inline struct scatterlist *
 blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
 {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index c7eae0bfb013f..d66ba850bb2a5 100644
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
@@ -29,6 +30,11 @@ int blk_rq_map_integrity_sg(struct request *, struct s=
catterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter);
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -108,6 +114,17 @@ static inline int blk_rq_integrity_map_user(struct r=
equest *rq,
 {
 	return -EINVAL;
 }
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev,  struct dma_iova_state *state,
+		struct blk_dma_iter *iter)
+{
+	return false;
+}
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	return false;
+}
 static inline struct blk_integrity *bdev_get_integrity(struct block_devi=
ce *b)
 {
 	return NULL;
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index cdbaacc3db065..8b06659bf67dd 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -18,6 +18,7 @@ struct blk_dma_iter {
 	struct bvec_iter		iter;
 	struct bio			*bio;
 	struct pci_p2pdma_map_state	p2pdma;
+	bool				integrity;
 };
=20
 bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_d=
ev,
--=20
2.47.1


