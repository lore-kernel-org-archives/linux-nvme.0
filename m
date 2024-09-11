Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70A5EE57CF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vK7qovxoMZszHB6W/2udkY9+/U6Fab7VLQCU0PsTo08=; b=n8kU7YFSEAEfu2lqRxQI1vXNqm
	XBrQ81lhsOUrdtNCCHggq/vNW56Dc5Ax/5XzMWTS7HHqQYbAP0lvB3VGu3P8Ekig0MwAKegPgDYuT
	QUNIje/da4oM8ZmM1i+DS1TVlhn/6APaH4tH8TR0lrAWY78o4OJJy9NItfkcs76LxVutFADjtkpNz
	5w6U7YX2SaJf0z3cysRb2ilIU7e6AcG04BoDRE6fJC3xL4NCSEuW+TRydrITgOqZyv5EiGuE/YHjn
	9n3RRYDCFrjknLG59RTr561K1PLfuAYITCQtRSs85dZ+5qe96mbsdtLAZd8Wsu188heIIqkp7cHaX
	1hkW3EKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTiC-0000000Ar11-1F10;
	Wed, 11 Sep 2024 20:13:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soThy-0000000Aqna-2Jzi
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:13:00 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHjdxh019460
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=vK7qovxoMZszHB6W/2udkY9+/U6Fab7VLQCU0PsTo08=; b=
	MLJOpA0EQF3BNWDwY6W/0omrS8KKiE7SoujZvNEnq+YxGy+pVaLzVMKSgjOj3J4X
	6bKeN9j95lQ6YjYx7P8OrvHzWNo35yBn0q4dv00/c/OeAlG+hlUW7UXLy7mwt5pF
	xjbdbqL6NgYZkN76vUChu0ZU4imCWzyDBJoJyOZgTdun1lhXCINEC18aQxDJHk39
	ZUZjFcCd0fzwi2dFy7NxJIHQsEOyy1r6jd1ipzyajdHxGLyVhPPfwe38VwB7i2oY
	KAODWJjmMsfCn8ZwxeQMoZKuWzxSBtl7dd7rjX1J2d4H8s/OGQcrC2HxA0e2fqpY
	GkI63qj9GW5CE39NqWYA+g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kbpe38qg-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:58 -0700 (PDT)
Received: from twshared4354.35.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:55 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id EAB7812E5EDAC; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 04/10] blk-integrity: consider entire bio list for merging
Date: Wed, 11 Sep 2024 13:12:34 -0700
Message-ID: <20240911201240.3982856-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CM70I1eBLDuO38cfGnRezzm03SRDsi1M
X-Proofpoint-GUID: CM70I1eBLDuO38cfGnRezzm03SRDsi1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131258_622696_9E57CD1E 
X-CRM114-Status: GOOD (  13.44  )
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

If a bio is merged to a request, the entire bio list is merged, so don't
temporarily detach it from its list when counting segments. In most
cases, bi_next will already be NULL, so detaching is usually a no-op.
But if the bio does have a list, the current code is miscounting the
segments for the resulting merge.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index afd101555d3cb..84065691aaed0 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -134,7 +134,6 @@ bool blk_integrity_merge_bio(struct request_queue *q,=
 struct request *req,
 			     struct bio *bio)
 {
 	int nr_integrity_segs;
-	struct bio *next =3D bio->bi_next;
=20
 	if (blk_integrity_rq(req) =3D=3D 0 && bio_integrity(bio) =3D=3D NULL)
 		return true;
@@ -145,10 +144,7 @@ bool blk_integrity_merge_bio(struct request_queue *q=
, struct request *req,
 	if (bio_integrity(req->bio)->bip_flags !=3D bio_integrity(bio)->bip_fla=
gs)
 		return false;
=20
-	bio->bi_next =3D NULL;
 	nr_integrity_segs =3D blk_rq_count_integrity_sg(q, bio);
-	bio->bi_next =3D next;
-
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
 		return false;
--=20
2.43.5


