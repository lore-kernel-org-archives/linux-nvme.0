Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E53BE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yixUJQ8ooJk0u2bR1ISmda8XJCYdYkQYBeTAq+JHgas=; b=bfqVINooKJzmfnL7OweiVBppEn
	i7txqgdzCE4pMlAvugAtbzrCo0LAJb8RxnnhLCu7PGpGMTs16q7He5feDBHxopr2VW0Xm6ePYleuV
	3TwXNDiCYf/TIiqT8G5LMh51vkE91EHL17hcdZcdM0WAO/I8KLw/RMOtepZo1dSPdADBlVegluiq8
	KlGTEHCpwZNwVqL5mAArZhtGybpSdbQA9p1UmoEZrOEBsHRqF0X/yvdXZhfKlr5/xmmBM7j8QACtR
	H1Szj/sM0Ov6ZdLAHYnLF1B1kWzcce9FRlwRZryrpZNipZ3geanRIjGfVQWyLs8TCsc8lrR/2dhRh
	vusoGNIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6dH-0000000Cddy-1iwr;
	Tue, 10 Dec 2024 20:14:59 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6cz-0000000CdaU-1Z5D
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 20:14:42 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BAHXnQw018505
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:14:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=yixUJQ8ooJk0u2bR1ISmda8XJCYdYkQYBeTAq+JHgas=; b=H4tNtCaR43ZA
	lJ2xjaP0fZCP0poPVMUojY2sSXjK6X4O8tgNjHLhi2eq3iXy4KtBWEZKDy+VNjPi
	IdV0eQaoOFIjlxQyspbNRn1G7Nov40PbmQTA68t7crFEggpCxGKuEPg4jMr+oYrM
	OTLOAHHVJS2pe1SEwmr1TcOjMqtuyebXeIu1EvNs42uPxiGAsM24mK+sbp5KuC5j
	2vQwCZcS5caNMvPfdArj5NxPNVN8qPaaZbGeObzI6skgHnLF6WFFyY1kQQ7sSVVp
	fAkoNsMjy3ew2zE6Yrh4+/QzWJ8cUX2b9hFhtQeHLJMcCp5Cve5mtkcYEJLy3grw
	GIkVUnruCQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43et5dhane-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:14:40 -0800 (PST)
Received: from twshared60378.16.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:14:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4AD4615D5C7BD; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty
	<nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv13 02/11] block: add a bi_write_stream field
Date: Tue, 10 Dec 2024 11:47:13 -0800
Message-ID: <20241210194722.1905732-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LPasVnSevTxXnuZWJRHoW81SphR9IkPc
X-Proofpoint-ORIG-GUID: LPasVnSevTxXnuZWJRHoW81SphR9IkPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_121441_528041_34867785 
X-CRM114-Status: GOOD (  12.15  )
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

From: Christoph Hellwig <hch@lst.de>

Add the ability to pass a write stream for placement control in the bio.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 1 +
 block/blk-merge.c           | 4 ++++
 block/bounce.c              | 1 +
 include/linux/blk_types.h   | 1 +
 5 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 699a78c85c756..2aa86edc7cd6f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *b=
dev, struct bio_vec *table,
 	bio->bi_flags =3D 0;
 	bio->bi_ioprio =3D 0;
 	bio->bi_write_hint =3D 0;
+	bio->bi_write_stream =3D 0;
 	bio->bi_status =3D 0;
 	bio->bi_iter.bi_sector =3D 0;
 	bio->bi_iter.bi_size =3D 0;
@@ -827,6 +828,7 @@ static int __bio_clone(struct bio *bio, struct bio *b=
io_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio =3D bio_src->bi_ioprio;
 	bio->bi_write_hint =3D bio_src->bi_write_hint;
+	bio->bi_write_stream =3D bio_src->bi_write_stream;
 	bio->bi_iter =3D bio_src->bi_iter;
=20
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 29a205482617c..66762243a886b 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -173,6 +173,7 @@ static struct bio *blk_crypto_fallback_clone_bio(stru=
ct bio *bio_src)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		=3D bio_src->bi_ioprio;
 	bio->bi_write_hint	=3D bio_src->bi_write_hint;
+	bio->bi_write_stream	=3D bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	=3D bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
=20
diff --git a/block/blk-merge.c b/block/blk-merge.c
index e01383c6e534b..1e5327fb6c45b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -866,6 +866,8 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
=20
 	if (req->bio->bi_write_hint !=3D next->bio->bi_write_hint)
 		return NULL;
+	if (req->bio->bi_write_stream !=3D next->bio->bi_write_stream)
+		return NULL;
 	if (req->bio->bi_ioprio !=3D next->bio->bi_ioprio)
 		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
@@ -987,6 +989,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *=
bio)
 		return false;
 	if (rq->bio->bi_write_hint !=3D bio->bi_write_hint)
 		return false;
+	if (rq->bio->bi_write_stream !=3D bio->bi_write_stream)
+		return false;
 	if (rq->bio->bi_ioprio !=3D bio->bi_ioprio)
 		return false;
 	if (blk_atomic_write_mergeable_rq_bio(rq, bio) =3D=3D false)
diff --git a/block/bounce.c b/block/bounce.c
index 0d898cd5ec497..fb8f60f114d7d 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -170,6 +170,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_s=
rc)
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		=3D bio_src->bi_ioprio;
 	bio->bi_write_hint	=3D bio_src->bi_write_hint;
+	bio->bi_write_stream	=3D bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	=3D bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
=20
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7e..4ca3449ce9c95 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -220,6 +220,7 @@ struct bio {
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
 	enum rw_hint		bi_write_hint;
+	u8			bi_write_stream;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
=20
--=20
2.43.5


