Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A693AC0219C
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pO2wFrYwZ1zMwPRV8fZHC1bSnFIVgje5V9k5lwpDmgQ=; b=D3EnEk1N+AMOgvIeCeC8dqpvGI
	Z+3LQo0JBFc8iRwpu4DsFmP6zjlvjEAUm0vIIie3M82PZ8az9srV9v8jIje/q++1gZAC2qc86+2tw
	3PVnCMXl5otPluOqMH5f3p5GvfyGGR7sMIg+UnqumCEmcsJW0OamGi2MP85x7rtcvNbFEQdQrVmKO
	3ZXm+d/qlaQCS2s38JSeE4DnHscWWvVQu+tQJxD6OTR8ADzwqG8ztoga/4paO8WOO4B96+DNCr0ku
	x/P7aOVykLASMexfBO04Mf/wyWlfvIkteGOQr178DVdBcR9Pb8aIDgWE3/3t3c0cHTMyiUgvhucbZ
	XLecPFyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1gB-0000000GMcS-4C3t;
	Mon, 03 Feb 2025 19:00:20 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1QL-0000000GJ1v-3n4u
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 18:43:59 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IHpko029078
	for <linux-nvme@lists.infradead.org>; Mon, 3 Feb 2025 10:43:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=pO2wFrYwZ1zMwPRV8fZHC1bSnFIVgje5V9k5lwpDmgQ=; b=FL1I7nbq8zUI
	x09RdKqnbC/7CLd7946khYWmBUe/GrTcMfDJX9nP8ssOhKFBkDlp4u09SU3rWIIb
	g6nmbhJGL1he9WMc18+pFrNcLuBkuO3vWPxNaA9jEsTcQ9x+Kbpz6JHU+gKRQ0VT
	fPqLpYPxOXuSg1DyFdoyxrOrAgjdo2lHhFzyB6mOpSw1+/LIlO+2jaIvBkugKeIP
	s5l6GlWC1r1rrv0oUr6CALbMRpm3pGQCRBaEH2qGnoONXr0PWQfVATQjr453wa45
	LkiKHIbL6TbsI7giGmBiLxTdU+YTa+umhxyX9Nbl426I+tAVIiUODwrfAiF+HJDp
	0BUS9fwgYQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k2e9ghex-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 10:43:57 -0800 (PST)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:43:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 16B30179C2623; Mon,  3 Feb 2025 10:41:33 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 02/11] block: add a bi_write_stream field
Date: Mon, 3 Feb 2025 10:41:20 -0800
Message-ID: <20250203184129.1829324-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203184129.1829324-1-kbusch@meta.com>
References: <20250203184129.1829324-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QUZAUqDcw5y_XotEtSdLJvR54dwHIf9E
X-Proofpoint-GUID: QUZAUqDcw5y_XotEtSdLJvR54dwHIf9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_104358_061240_0014412F 
X-CRM114-Status: GOOD (  13.54  )
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
The new field fits in an existing hole, so does not change the size of
the struct.

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
index f0c416e5931d9..f7c2b3b1a55dd 100644
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
index 15cd231d560cb..85642ead0d805 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -829,6 +829,8 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
=20
 	if (req->bio->bi_write_hint !=3D next->bio->bi_write_hint)
 		return NULL;
+	if (req->bio->bi_write_stream !=3D next->bio->bi_write_stream)
+		return NULL;
 	if (req->bio->bi_ioprio !=3D next->bio->bi_ioprio)
 		return NULL;
 	if (!blk_atomic_write_mergeable_rqs(req, next))
@@ -950,6 +952,8 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *=
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


