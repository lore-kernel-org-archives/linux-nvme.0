Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E181E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IaesBJajvy2XJvCSejkRh5S+DvrgGK6zlymIWSzBoyc=; b=qMgEmPTXhIjGS+i5dtfeRX6tFh
	uo5MY97f8rxU9yOt9sonr62vS70dLs8T2wKwx/xGjLPSQp+IOJjGRhdaFxnMuAW0BYqqQ/E0qmarN
	2hA+47jviVJ8NhArKW47tOSwRvbtP3zl1d1I5n5wmOF818jYWV4bAUKLk11YqlNz1+zaCrAoZCEhD
	pwjPfkFKMfE3aU5hCY+E0w2njPaNp3PjIOCtzCymhxMFYBKnQEUtlYukKVSsS4stjfFX1LRpCHeX9
	O+tL227y49qLrzGs+cIkKq7U34EqMQYFcKnguHcVdGuSLWkFj7MuktbFLp+OKcGm3KOK3eQS770ZX
	K8jJW+MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNXE-00000000FMZ-2eIi;
	Fri, 06 Dec 2024 01:53:36 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNX8-00000000FEq-0sVb
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:53:32 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B603K9N013801
	for <linux-nvme@lists.infradead.org>; Thu, 5 Dec 2024 17:53:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=IaesBJajvy2XJvCSejkRh5S+DvrgGK6zlymIWSzBoyc=; b=is3SY7wB49cy
	EB3OemMXg+FNcvfC0dgf5GMZTFf6pnI99KR76zYftHDeQ7bGB3NqAP4UY71yz0dG
	S9zrdssa03GK8kQ2590zIsilbxmzWL2sKBJAbbBvCASlQmyxmwsMdxjzDnuFKL7Z
	MuZMI9nvgtOQOkJ+B0GJ9Dp8Fg+Pr1btASr8L1inX3muUIiFpvImqNpo5a3mAeUC
	XMXE3U93+E5VkvhZ66GUFov4hYAJpIYQFmDshZ5em28MTf/udZR+Atkh84s6c7nS
	KjWdwOrRCdpgxpA0jH9Hu0NhVvKn3C4GKluIPk7A5bLEcekI/lZpnaiBYlM44uRx
	3gZn68x22Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bnx9rpvh-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Dec 2024 17:53:29 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1ADCA15B21151; Thu,  5 Dec 2024 17:53:09 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 04/10] block: add a bi_write_stream field
Date: Thu, 5 Dec 2024 17:53:02 -0800
Message-ID: <20241206015308.3342386-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uPZVTtnGsrCvfY_N2qrxfV1LgCm5gX6K
X-Proofpoint-GUID: uPZVTtnGsrCvfY_N2qrxfV1LgCm5gX6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_175330_281084_373824A3 
X-CRM114-Status: GOOD (  12.22  )
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


