Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABECECD4F20
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1UwveGw9W/6ottXJOf2+aM2Smjb0TJhMxeWYP59wn24=; b=EyiGwCLjWjjOr9sOVB1yiDFjbm
	T8ajgbEEloCAs1LyMR0CWF8Ivf4CtHmN1n9vUFR0hZ7m0S2t8c1r1anvPVzmn78oTQXaQ/q4FcuD+
	QklwEBKUzV7dbT5JLWSbUTF1LGco8TubseUzH1UplrwU9sPiYfCH6fyfx3RgSTiB4wcQJQfrojt8s
	QZXIqNR7RJXgmf0jlPwmeTC8HP335caJ6keRJSXUUOO6lGZwpIbY50q0svQaq/kqz0GKIUnV++KKn
	yf8rYNpw96FMtN5BYkj3RyQ0VtarWRsjQPNFPfYDdJEFuQTV4paMlpgLFu2vMYS9uCvPHGkC7zgw/
	qO3zEiRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruO-00000004zhr-1Kds;
	Wed, 04 Sep 2024 15:27:00 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruK-00000004zeI-2rW5
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:58 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849UfQA022985
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=1UwveGw9W/6ottXJOf2+aM2Smjb0TJhMxeWYP59wn24=; b=
	LDHAoo1XSGB2sWIJSk9qzaebmYZIgrIiR1Vs+iYRRE62yw6zWWXvFonOJZ5zpy8j
	nqw2awN3EWkK8+25A4dhgDDvyiQAjhLM28CbcmIp4wl0Ulk83YvsU05H6E5nGgsR
	ze/PQuonu+jIalBJCSoq7W8bKUa6creFJ7NCbAN3ZUqgyxdODBj7WA/4FxJtr6A+
	krWG3spX8FhVtf2dgwGqqn9wkM9GEc5flZgHcWqQf3hf6e0bIZ4G0ziKvpSvArkp
	nSGJrAKBE3sYuAZOuB+5pS0ff3bcA+QxtQgegHcU6UG3wpSYUYWmKFgTHZ0KSBJu
	cfnbDgfxtkXVAJsSkwflOw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1wcm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:56 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 02BA112A036F5; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 09/10] blk-integrity: consider entire bio list for merging
Date: Wed, 4 Sep 2024 08:26:04 -0700
Message-ID: <20240904152605.4055570-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: A4AIL9tZrL-YcPii9aZK2QFnH9rjYzZA
X-Proofpoint-ORIG-GUID: A4AIL9tZrL-YcPii9aZK2QFnH9rjYzZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082656_825762_6F04EE77 
X-CRM114-Status: GOOD (  12.25  )
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

If a bio is merged to a req, the entire bio list is merged, so don't
temporarily unchain it when counting segments for consideration.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index f9367f3a04208..985de64409cf5 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -92,7 +92,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, s=
truct request *req,
 			     struct bio *bio)
 {
 	int nr_integrity_segs;
-	struct bio *next =3D bio->bi_next;
=20
 	if (blk_integrity_rq(req) =3D=3D 0 && bio_integrity(bio) =3D=3D NULL)
 		return true;
@@ -103,10 +102,7 @@ bool blk_integrity_merge_bio(struct request_queue *q=
, struct request *req,
 	if (bio_integrity(req->bio)->bip_flags !=3D bio_integrity(bio)->bip_fla=
gs)
 		return false;
=20
-	bio->bi_next =3D NULL;
 	nr_integrity_segs =3D blk_rq_count_integrity_segs(bio);
-	bio->bi_next =3D next;
-
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
 		return false;
--=20
2.43.5


