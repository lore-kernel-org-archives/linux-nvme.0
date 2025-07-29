Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C992DC87FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5vT2iVAErtjJat8Ks7am4DzUZeGC35xV/9B3wNywCHk=; b=ndlvBY+1FZ8sbg4/n8R+sMKBBk
	GC0SZBUrB4mAxrmFHdgP6owBysh6qaYq090w/sj+HPoztX5h0XiJEXPhzWAAmppQljyCSCwrkG9TS
	VHhbELiDxMMMqfQrqjk3GTDWGoYIKVZJD3wum57xBVKDyEqcdF2wMTJO/ZPugT+53o7y1lB8x0XQr
	fAh8goz2BXjGyTwYrrrhl8W5uVlzx9sJClCTkn4+a6pOzyFU+xNb3FCcdQP5XeXC8mfHlCTqLqEqg
	1hTY6vEmsD8Wak8bGf3BK8P+XDjRSsWyaS5weLRWcmbf+2jtKCxKacWmV/4SMiKjetVQp/SAweu5u
	7JZlrHUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglQA-0000000Gum4-0ElJ;
	Tue, 29 Jul 2025 14:35:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglQ6-0000000Guih-2MQB
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 14:35:12 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7R5Ha018946
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5vT2iVAErtjJat8Ks7am4DzUZeGC35xV/9B3wNywCHk=; b=vjT0OajhH4Gm
	IfJjJT8UrK/iyOiCjLMD/aKxcaRXHpMKshMCRcAp6pyVEbFJa8JcBL9l441/Zlg7
	2UkGUjqiFaoVkIbCRLUnBW5ha99vicCmqSnagBGvhUdiR41AdI3El3XLdghcjTyT
	qGjugdiOo6zyV86LNKbCObtD+4PjS4RxGqaer5++hDwnhWxDllpsZ7TJKVUBve+w
	70iCz25/GyNZDI1SjJRAnneCAxoFK+rIUhVQnX+uFXrbB5SsiJd0txynC1Yh4PWA
	yes+PylH+ovX7NC3+kbgbp59e46RggSxntKMFQQ0kJGy5Py4wd1gW/xplHa5IiRk
	mLiHFPj50w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486swmja4t-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:09 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 7463E1CC41FC; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
Date: Tue, 29 Jul 2025 07:34:36 -0700
Message-ID: <20250729143442.2586575-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729143442.2586575-1-kbusch@meta.com>
References: <20250729143442.2586575-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KZHSsRYD c=1 sm=1 tr=0 ts=6888dc1d cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=vJZztQhXiBMcT6r6zj8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfXziiK2J2lDs5Q kv02zuEG/74W3BuCDro5XDgR9RZ/oHhmrFi1bw7EjOHJEf7EKkP2h2nlfSqjYmTW/jAGnpYjdcw WvgWB+0c2o14Vgn4CSGAY2rqSGTZvnMeTOl//4IZADAvtDtXgacM+wK85l7qoF73QYkyNZTejIt
 tIDvlzbBt5+/KtaQV3PMgFl9qw5twbUZ94Q+VdNRi8RYEcVMcM7RCsWlPJB7Fk4U7H+4Bu8nUAd 6tSc6ed449r/i7ofEF6rERTUcRkEPW3jYZuuHnWLTaujiJfQZVO51Q8EJ/hohG23HbUSMpt5kkQ vgEUTls9yRrGyOoF7bddOxeEhaEKIfCGlsoqYAZvqCqPoXR/JpAnpoMcfYAzfNIUfoA7Yi0L+/Y
 ReuqEtFENhh+rRDcJdvV7yxatVQ+mPZwdWrwiurUs3wtA2+EeL+evVZXLn2oxC3SPFWKaZaN
X-Proofpoint-ORIG-GUID: 2kfCvSfJ2Q8Hc-VBsU5qamYgooAmmC50
X-Proofpoint-GUID: 2kfCvSfJ2Q8Hc-VBsU5qamYgooAmmC50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_073510_725493_0B2F0442 
X-CRM114-Status: GOOD (  18.98  )
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

Create a type that fully captures the lower level physical address
iteration.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 93 +++++++++++++++++---------------------
 include/linux/blk-mq-dma.h |  9 +++-
 2 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..61fbdb715220f 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -5,13 +5,7 @@
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
-struct phys_vec {
-	phys_addr_t	paddr;
-	u32		len;
-};
-
-static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
-			      struct phys_vec *vec)
+static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter)
 {
 	unsigned int max_size;
 	struct bio_vec bv;
@@ -19,8 +13,8 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		if (!iter->bio)
 			return false;
-		vec->paddr =3D bvec_phys(&req->special_vec);
-		vec->len =3D req->special_vec.bv_len;
+		iter->paddr =3D bvec_phys(&req->special_vec);
+		iter->len =3D req->special_vec.bv_len;
 		iter->bio =3D NULL;
 		return true;
 	}
@@ -29,8 +23,8 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 		return false;
=20
 	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
-	vec->paddr =3D bvec_phys(&bv);
-	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
+	iter->paddr =3D bvec_phys(&bv);
+	max_size =3D get_max_segment_size(&req->q->limits, iter->paddr, UINT_MA=
X);
 	bv.bv_len =3D min(bv.bv_len, max_size);
 	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
=20
@@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, st=
ruct req_iterator *iter,
 	 * one could be merged into it.  This typically happens when moving to
 	 * the next bio, but some callers also don't pack bvecs tight.
 	 */
-	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
+	while (!iter->iter.bi_size ||
+	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
 		struct bio_vec next;
=20
 		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
-				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
 		}
@@ -58,7 +51,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
 	}
=20
-	vec->len =3D bv.bv_len;
+	iter->len =3D bv.bv_len;
 	return true;
 }
=20
@@ -77,29 +70,29 @@ static inline bool blk_can_dma_map_iova(struct reques=
t *req,
 		dma_get_merge_boundary(dma_dev));
 }
=20
-static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
+static bool blk_dma_map_bus(struct blk_dma_iter *iter)
 {
-	iter->addr =3D pci_p2pdma_bus_addr_map(&iter->p2pdma, vec->paddr);
-	iter->len =3D vec->len;
+	iter->addr =3D pci_p2pdma_bus_addr_map(&iter->p2pdma, iter->iter.paddr)=
;
+	iter->len =3D iter->iter.len;
 	return true;
 }
=20
 static bool blk_dma_map_direct(struct request *req, struct device *dma_d=
ev,
-		struct blk_dma_iter *iter, struct phys_vec *vec)
+		struct blk_dma_iter *iter)
 {
-	iter->addr =3D dma_map_page(dma_dev, phys_to_page(vec->paddr),
-			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
-	if (dma_mapping_error(dma_dev, iter->addr)) {
+	iter->addr =3D dma_map_page(dma_dev, phys_to_page(iter->iter.paddr),
+			offset_in_page(iter->iter.paddr), iter->iter.len,
+			rq_dma_dir(req));
+	if (dma_mapping_error(dma_dev, iter->iter.paddr)) {
 		iter->status =3D BLK_STS_RESOURCE;
 		return false;
 	}
-	iter->len =3D vec->len;
+	iter->len =3D iter->iter.len;
 	return true;
 }
=20
 static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_=
dev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter,
-		struct phys_vec *vec)
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	enum dma_data_direction dir =3D rq_dma_dir(req);
 	unsigned int mapped =3D 0;
@@ -109,12 +102,12 @@ static bool blk_rq_dma_map_iova(struct request *req=
, struct device *dma_dev,
 	iter->len =3D dma_iova_size(state);
=20
 	do {
-		error =3D dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+		error =3D dma_iova_link(dma_dev, state, iter->iter.paddr, mapped,
+				iter->iter.len, dir, 0);
 		if (error)
 			break;
-		mapped +=3D vec->len;
-	} while (blk_map_iter_next(req, &iter->iter, vec));
+		mapped +=3D iter->iter.len;
+	} while (blk_map_iter_next(req, &iter->iter));
=20
 	error =3D dma_iova_sync(dma_dev, state, 0, mapped);
 	if (error) {
@@ -151,10 +144,10 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
-	struct phys_vec vec;
+	struct blk_map_iter *map_iter =3D &iter->iter;
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
+	map_iter->bio =3D req->bio;
+	map_iter->iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -162,14 +155,14 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
 	 */
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, map_iter))
 		return false;
=20
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
 		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(vec.paddr))) {
+					 phys_to_page(map_iter->paddr))) {
 		case PCI_P2PDMA_MAP_BUS_ADDR:
-			return blk_dma_map_bus(iter, &vec);
+			return blk_dma_map_bus(iter);
 		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 			/*
 			 * P2P transfers through the host bridge are treated the
@@ -184,9 +177,9 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 	}
=20
 	if (blk_can_dma_map_iova(req, dma_dev) &&
-	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
-		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
-	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+	    dma_iova_try_alloc(dma_dev, state, map_iter->paddr, total_len))
+		return blk_rq_dma_map_iova(req, dma_dev, state, iter);
+	return blk_dma_map_direct(req, dma_dev, iter);
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
@@ -211,14 +204,12 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_de=
v,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
-	struct phys_vec vec;
-
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, &iter->iter))
 		return false;
=20
 	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
-		return blk_dma_map_bus(iter, &vec);
-	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+		return blk_dma_map_bus(iter);
+	return blk_dma_map_direct(req, dma_dev, iter);
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
=20
@@ -246,20 +237,20 @@ blk_next_sg(struct scatterlist **sg, struct scatter=
list *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct req_iterator iter =3D {
-		.bio	=3D rq->bio,
+	struct bio *bio =3D rq->bio;
+	struct blk_map_iter iter =3D {
+		.bio	=3D bio,
 	};
-	struct phys_vec vec;
 	int nsegs =3D 0;
=20
 	/* the internal flush request may not have bio attached */
-	if (iter.bio)
-		iter.iter =3D iter.bio->bi_iter;
+	if (bio)
+		iter.iter =3D bio->bi_iter;
=20
-	while (blk_map_iter_next(rq, &iter, &vec)) {
+	while (blk_map_iter_next(rq, &iter)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
-		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
-				offset_in_page(vec.paddr));
+		sg_set_page(*last_sg, phys_to_page(iter.paddr), iter.len,
+				offset_in_page(iter.paddr));
 		nsegs++;
 	}
=20
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c26a01aeae006..1e5988afdb978 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -5,6 +5,13 @@
 #include <linux/blk-mq.h>
 #include <linux/pci-p2pdma.h>
=20
+struct blk_map_iter {
+	phys_addr_t			paddr;
+	u32				len;
+	struct bvec_iter		iter;
+	struct bio			*bio;
+};
+
 struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
@@ -14,7 +21,7 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
-	struct req_iterator		iter;
+	struct blk_map_iter		iter;
 	struct pci_p2pdma_map_state	p2pdma;
 };
=20
--=20
2.47.3


