Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E0DC7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L5RtRyeSuYZjNvCCAIrZfZ0wTr6RWPvM785jVZwUc2k=; b=zChpSyYD79KuV9PPtYhQrhEYgO
	AX/v/PVNGocIQXjdkoJyy373YzlVcheMvaGfWJRlMWICOdkB5BNaGmF4JY8ND0K7/JwyFE0VMHVh+
	Ahn+TpHlfhiz6CHoekRXUaKl3Kwtnkv+3XLCkeqP48KhNAUoiDP8mutruH2aUpjFFXes0yhW+U4lY
	rYtZvqxnC5etyp7ov6TZi6Kt7QFwG+2+Ai3CDWsdBlvSKGj39QCgx4puVmw2GWofriY0WHsKCUUV1
	ge/zNZpexZW8o8xo4LjeOGvJVKZIRwZW1r1X7KOy9C6QhaUn1CnDT4qvoWd9Bt8AB5b6Je6iYK/sh
	eWu2mKUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUY4b-0000000A0qO-37JI;
	Wed, 25 Jun 2025 21:54:29 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWzE-00000009uMb-2SsP
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:44:56 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJMHFP016186
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:44:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=L5RtRyeSuYZjNvCCAI
	rZfZ0wTr6RWPvM785jVZwUc2k=; b=AMJXwp0dndU7l0AygcuFkbJbH5C9Ewn/J6
	+qZTWvcAcDdhNmU9WHf7w1g9Cf7GR78eJXnePjq3h+h+HGiLkjWxcTnnAG7jmuar
	hh4TugGLahInCkC7wymL1DII6hIBhPBwKm3xrO1BFWJ9C/re84DiL0Jjot87gR5z
	Vg45+f4niE6Ji9KWX7BULFFeHb5h2zFPYRmhuV0rHx661w2Sv1RuX59ezlVp4Xkt
	KXISUe2Ra+CfJfgiRFQHLJCm66SArjWQjHLueXKppEeeSpZfdCebfY6Tbs/IFfXJ
	aJQob4NOZA7efxN5rL+lRKs2UQH81nkrzj57Ua7reU3Wq+AD50JA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47gevm4es7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:44:50 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 25 Jun 2025 20:44:49 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id C5B538C48C8; Wed, 25 Jun 2025 13:44:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <leon@kernel.org>, <joshi.k@samsung.com>,
        <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Date: Wed, 25 Jun 2025 13:44:44 -0700
Message-ID: <20250625204445.1802483-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE1OSBTYWx0ZWRfX0qRmKv9WG6Cb G5VTuL5a5lgFVrfLv3xuTuqc7mre+wmmD6Xkx5NCcfk5BOw0g7JvHK1xiO8sd+UCpChtfgn7wQn r81tkavL7qGWdsO93r+e68rBC4zaUb1a4aWH5vVEhXqsFxhqdU491XiFYfY/TJWgvfn5A94zQI3
 mGAzlUNJVhSkKZG6Nr8sr9rVnPFAVd1urg1C+vW/BYMqEsFwT7IroUkf077xOhbWGvoFsNFdm1p NF6JWIW/Jx1EsqBmJBdeMiewEGg+BpEBmlT4fkSVYz8b4loNACBg6k9b59jJ6Ar8P2fq4zSxreY jitrFEL27no/dK0boDSOA8gL+wTCviD/ro5eyFth3s28JNmBK5+xGSuHjmmip++slbWnEFvA3Cr
 CVX024iovhanIpEpxsL7beTs6U7ExYRyEKEeQpNPskCFqmEN7nxX+L6qU8VvfNgkvmFr+v79
X-Proofpoint-ORIG-GUID: TRJVYcK99eW55rEZ7-zzDKR3RRPXX-7_
X-Proofpoint-GUID: TRJVYcK99eW55rEZ7-zzDKR3RRPXX-7_
X-Authority-Analysis: v=2.4 cv=Ud9RSLSN c=1 sm=1 tr=0 ts=685c5fc2 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=YbswHzic5SfKCEL6b6MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_07,2025-06-25_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_134452_830610_EEC53138 
X-CRM114-Status: GOOD (  17.36  )
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

This is much like the scatter-less DMA helpers for request data, but for
integrity metadata instead. This one only subscribes to the direct
mapping as the virt boundary queue limit used to check for iova
coalescing possibilities doesn't apply to metadata.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c         | 94 +++++++++++++++++++++++++++++++++++
 block/blk-mq-dma.c            |  9 +---
 block/blk.h                   | 10 ++++
 include/linux/blk-integrity.h |  6 +++
 4 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9d..e79df07d1151a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -112,6 +112,100 @@ int blk_rq_map_integrity_sg(struct request *rq, str=
uct scatterlist *sglist)
 }
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
=20
+static void bio_integrity_advance_iter_single(struct bio *bio,
+						struct bvec_iter *iter,
+						struct bio_vec *bvec,
+						unsigned int bytes)
+{
+	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	iter->bi_sector +=3D bytes / bi->tuple_size;
+	bvec_iter_advance(bvec, iter, bytes);
+}
+
+static bool blk_rq_integrity_map_iter_next(struct request *req,
+		struct req_iterator *iter, struct phys_vec *vec)
+{
+	struct bio_integrity_payload *bip =3D bio_integrity(iter->bio);
+	unsigned int max_size;
+	struct bio_vec bv;
+
+	if (!iter->iter.bi_size)
+		return false;
+
+	bv =3D mp_bvec_iter_bvec(bip->bip_vec, iter->iter);
+	vec->paddr =3D bvec_phys(&bv);
+	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
+	bv.bv_len =3D min(bv.bv_len, max_size);
+
+	bio_integrity_advance_iter_single(iter->bio, &iter->iter, &bv, bv.bv_le=
n);
+	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
+		struct bio_vec next;
+
+		if (!iter->iter.bi_size) {
+			if (!iter->bio->bi_next)
+				break;
+			iter->bio =3D iter->bio->bi_next;
+			iter->iter =3D iter->bio->bi_iter;
+		}
+
+		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		if (bv.bv_len + next.bv_len > max_size ||
+		    !biovec_phys_mergeable(req->q, &bv, &next))
+			break;
+
+		bv.bv_len +=3D next.bv_len;
+		bio_integrity_advance_iter_single(iter->bio, &iter->iter, &bv,
+							next.bv_len);
+	}
+
+	vec->len =3D bv.bv_len;
+	return true;
+}
+
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct bio_integrity_payload *bip =3D bio_integrity(req->bio);
+	struct phys_vec vec;
+
+	iter->iter.bio =3D req->bio;
+	iter->iter.iter =3D bip->bip_iter;
+	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
+	iter->status =3D BLK_STS_OK;
+
+	if (!blk_rq_integrity_map_iter_next(req, &iter->iter, &vec))
+		return false;
+
+	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
+				phys_to_page(vec.paddr))) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return blk_dma_map_bus(iter, &vec);
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	default:
+		iter->status =3D BLK_STS_INVAL;
+		return false;
+	}
+
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);
+
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter)
+{
+	struct phys_vec vec;
+
+	if (!blk_rq_integrity_map_iter_next(req, &iter->iter, &vec))
+		return false;
+	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		return blk_dma_map_bus(iter, &vec);
+	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+}
+EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
+
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes)
 {
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..54c25e5e60d78 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -5,11 +5,6 @@
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
-struct phys_vec {
-	phys_addr_t	paddr;
-	u32		len;
-};
-
 static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
 			      struct phys_vec *vec)
 {
@@ -77,14 +72,14 @@ static inline bool blk_can_dma_map_iova(struct reques=
t *req,
 		dma_get_merge_boundary(dma_dev));
 }
=20
-static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
+bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 {
 	iter->addr =3D pci_p2pdma_bus_addr_map(&iter->p2pdma, vec->paddr);
 	iter->len =3D vec->len;
 	return true;
 }
=20
-static bool blk_dma_map_direct(struct request *req, struct device *dma_d=
ev,
+bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
 	iter->addr =3D dma_map_page(dma_dev, phys_to_page(vec->paddr),
diff --git a/block/blk.h b/block/blk.h
index 1141b343d0b5c..755975ddc3046 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
=20
 #include <linux/bio-integrity.h>
 #include <linux/blk-crypto.h>
+#include <linux/blk-mq-dma.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/sched/sysctl.h>
@@ -727,6 +728,15 @@ int bdev_open(struct block_device *bdev, blk_mode_t =
mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
=20
+struct phys_vec {
+	phys_addr_t	paddr;
+	u32		len;
+};
+
+bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec);
+bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter, struct phys_vec *vec);
+
 void blk_integrity_generate(struct bio *bio);
 void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_=
iter);
 void blk_integrity_prepare(struct request *rq);
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index c7eae0bfb013f..8e2aeb5c13864 100644
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
@@ -30,6 +31,11 @@ int blk_rq_count_integrity_sg(struct request_queue *, =
struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
=20
+bool blk_rq_integrity_dma_map_iter_start(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
+bool blk_rq_integrity_dma_map_iter_next(struct request *req,
+		struct device *dma_dev, struct blk_dma_iter *iter);
+
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
 {
--=20
2.47.1


