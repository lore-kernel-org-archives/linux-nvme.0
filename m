Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E81CD4857
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+//qAOpLt4ftix8+c0vKQWrZh5psXGJmgTeFdUI7xuY=; b=t5kp7BeuqN5ByQzJ9YuzILvuH6
	HrWtbSAYJwBfnOGEZaJ2HKt8HI0h5BFXrwrpECvuDjKnOWhsDP9mnFRdAE7zY3tAt+7b4as6a5weF
	u8poIfzR8K0Km+dtFmlptNElQIdIgqSx8t4XBYTp2wSWLwwY72igQ8hynqGxpyjZZvn3rCYnuFtWx
	My02cwvzcAjZACH941kEuIh5TwqHdwAH0hs98S8taWhiQkOGc09x6QVqbH/c3h7fD7zr6ulaUNvlo
	jlITg9aA2qRueVcitQZg1K+mB6e/tM7lUs8Fv7Qqya9ptiIJibxJazuDTzC9x/pIOZJ7R/fQCM4UZ
	LETeGq8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruS-00000004zlX-1PNF;
	Wed, 04 Sep 2024 15:27:04 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruN-00000004zgV-0OV9
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:27:02 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849UfQF022985
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=+//qAOpLt4ftix8+c0vKQWrZh5psXGJmgTeFdUI7xuY=; b=
	Vvcjkg5AWfp6o2vD/rovTbpYGk1no5V3qyj7A5L6tRi3oOL8Fmto4yigitIhAlXy
	yH0fjMbIOfMBvELMf5v+m8GbFk4n2OBnN+bOgWYnYffmUexkzpdJ/AYx+Qjh3YSN
	+vjpkfx3XeMF5f0ELRkCBXuwBpUv02Lp6sNe8foxDtKzsjm2btVbPPl36GWNYeSi
	K1hv+HOvnlXCvnQ/ggVpZGk9StsjLIAZDwaj+YVDg8nq1osKQjfa0TbW95OA27Xq
	/O6ptYw3MVo26j5fxhvtpXpcqUHMmsj2yIVkbKMjF70C8opk+dVIwKvGFDeVabY+
	r7n810lu/dsy/6HkU1onTg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1wcm-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:58 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E8A6012A036F1; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 08/10] blk-integrity: remove inappropriate limit checks
Date: Wed, 4 Sep 2024 08:26:03 -0700
Message-ID: <20240904152605.4055570-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -gagYi_B0rk4L52yGld4fHStX_FE25b4
X-Proofpoint-ORIG-GUID: -gagYi_B0rk4L52yGld4fHStX_FE25b4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082659_350115_8B08C3F2 
X-CRM114-Status: GOOD (  15.05  )
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

The queue limits for block access are not the same as metadata access.
Delete these.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c |  7 -------
 block/blk-integrity.c |  3 ---
 block/blk-merge.c     |  6 ------
 block/blk.h           | 34 ----------------------------------
 4 files changed, 50 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8d1fb38f745f9..ddd85eb46fbfb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -184,13 +184,6 @@ int bio_integrity_add_page(struct bio *bio, struct p=
age *page,
 		if (bip->bip_vcnt >=3D
 		    min(bip->bip_max_vcnt, queue_max_integrity_segments(q)))
 			return 0;
-
-		/*
-		 * If the queue doesn't support SG gaps and adding this segment
-		 * would create a gap, disallow it.
-		 */
-		if (bvec_gap_to_prev(&q->limits, bv, offset))
-			return 0;
 	}
=20
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index cfb394eff35c8..f9367f3a04208 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -85,9 +85,6 @@ bool blk_integrity_merge_rq(struct request_queue *q, st=
ruct request *req,
 	    q->limits.max_integrity_segments)
 		return false;
=20
-	if (integrity_req_gap_back_merge(req, next->bio))
-		return false;
-
 	return true;
 }
=20
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 56769c4bcd799..43ab1ce09de65 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -650,9 +650,6 @@ int ll_back_merge_fn(struct request *req, struct bio =
*bio, unsigned int nr_segs)
 {
 	if (req_gap_back_merge(req, bio))
 		return 0;
-	if (blk_integrity_rq(req) &&
-	    integrity_req_gap_back_merge(req, bio))
-		return 0;
 	if (!bio_crypt_ctx_back_mergeable(req, bio))
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
@@ -669,9 +666,6 @@ static int ll_front_merge_fn(struct request *req, str=
uct bio *bio,
 {
 	if (req_gap_front_merge(req, bio))
 		return 0;
-	if (blk_integrity_rq(req) &&
-	    integrity_req_gap_front_merge(req, bio))
-		return 0;
 	if (!bio_crypt_ctx_front_mergeable(req, bio))
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
diff --git a/block/blk.h b/block/blk.h
index 32f4e9f630a3a..3f6198824b258 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -224,29 +224,6 @@ bool blk_integrity_merge_rq(struct request_queue *, =
struct request *,
 		struct request *);
 bool blk_integrity_merge_bio(struct request_queue *, struct request *,
 		struct bio *);
-
-static inline bool integrity_req_gap_back_merge(struct request *req,
-		struct bio *next)
-{
-	struct bio_integrity_payload *bip =3D bio_integrity(req->bio);
-	struct bio_integrity_payload *bip_next =3D bio_integrity(next);
-
-	return bvec_gap_to_prev(&req->q->limits,
-				&bip->bip_vec[bip->bip_vcnt - 1],
-				bip_next->bip_vec[0].bv_offset);
-}
-
-static inline bool integrity_req_gap_front_merge(struct request *req,
-		struct bio *bio)
-{
-	struct bio_integrity_payload *bip =3D bio_integrity(bio);
-	struct bio_integrity_payload *bip_next =3D bio_integrity(req->bio);
-
-	return bvec_gap_to_prev(&req->q->limits,
-				&bip->bip_vec[bip->bip_vcnt - 1],
-				bip_next->bip_vec[0].bv_offset);
-}
-
 extern const struct attribute_group blk_integrity_attr_group;
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool blk_integrity_merge_rq(struct request_queue *rq,
@@ -259,17 +236,6 @@ static inline bool blk_integrity_merge_bio(struct re=
quest_queue *rq,
 {
 	return true;
 }
-static inline bool integrity_req_gap_back_merge(struct request *req,
-		struct bio *next)
-{
-	return false;
-}
-static inline bool integrity_req_gap_front_merge(struct request *req,
-		struct bio *bio)
-{
-	return false;
-}
-
 static inline void blk_flush_integrity(void)
 {
 }
--=20
2.43.5


