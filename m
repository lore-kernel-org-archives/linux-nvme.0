Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F93FC616C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUfSROr0FhSCtvL6UbszCRKrsV9riysj4gJgGG+83JA=; b=mQ9/hrOe6EXqje/uQ9xG4uDw47
	eSwPKNxqmCQdYRoIYFv6BEmFv8xvGhUOEh12RHo/tFNtcR9wdLmvVbQVWce5qDxyssp3zQpPtAKPy
	ay3QuTAdRPT64jgV4INMAMcHRYyGQhxxJLb9aB67QOhw6ypm2EiQeyiADqtvfmUQqdv3q6/iY7aa2
	I4qwEcf1ByarBFybHG9xY+Ll5Tq3zjls44CJz0WlWWFGHE/oai6JK8bu+cZ07MPhmTh+DY6BRkLCD
	xOEri5HzfZR1SrnTcEgiIWFaCedBoUh129xKOUdkCibSZQZDXmMEKWMToVIQdzSMM5GTfMweBhQY5
	LERZBkiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2x-0000000GoRR-44Vx;
	Fri, 13 Sep 2024 18:29:31 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2g-0000000GoLa-1vzV
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:30 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI9uOo016519
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=oUfSROr0FhSCtvL6UbszCRKrsV9riysj4gJgGG+83JA=; b=
	bVysg4A6Z0dHj0+PmhLV8Fv/24JJKgX75zpqBCm4rw1XGrIsmNbHbP899aGx3k/p
	FiR6gcC19dPSqqe2R1E9VSiuYFZrzcfmwKtfZQA4TFKt7oi9PXtq0/tik3rolCri
	boS/0Vnnj0XCkqcL1iFPM0zVPObyQxeTSy+W5yOhUEBJzRldGLGJkEEWpibMPSaC
	+tpN+Wy24Dd3bXtAuRu7mRrgRk0Dm0PsT+zQz8LpqDlSemrRatH3rei457+o0Ytf
	aFC3KgiMMG2IOMwyDIzIJsZ0wmINfxF04AOMrnoXMRtOLynAtkBbVqYB1MLWi2vf
	woLE+om6VClxVlKH2/aChg==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mte705n8-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:14 -0700 (PDT)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:06 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6F30E12F91049; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 4/9] blk-integrity: consider entire bio list for merging
Date: Fri, 13 Sep 2024 11:28:49 -0700
Message-ID: <20240913182854.2445457-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fMySb1YmcbkNuQV9D4RMZZKoNZtr7_tQ
X-Proofpoint-GUID: fMySb1YmcbkNuQV9D4RMZZKoNZtr7_tQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_112914_530603_4A71D449 
X-CRM114-Status: GOOD (  13.42  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


