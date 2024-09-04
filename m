Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AA1CD4853
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJGuAIm2f/+xDgo4fPX/O74jcJilrmqmvJTBA0uhJGc=; b=F+3e8XmxbztPrW+uL61PWPrp7a
	qLnUbeiJdcnjkK+S6l7inc8qqCvwBWFR/pvtQeX3bufJB5mYFym7I/zbDkqROo5SLb8Y9qi4zi4u4
	qWgz9AUCG/ft6RASByrH+WyVNQYYy013YvBmQ/Dem3YkvbmGl7pfLgr+fnYDogPBpIY5NB4GRN2LQ
	DNRP2oJL5MU9Whs0j/tcF3FKoUQf2hkCKtlNRKuxDcZvnXPlOuVoOAocKP4scC/N05gSIK3kEZMZS
	dMdLjymYsTUyEJb5HkDkkTq7KA7ecNR0K8dZvfWZLlcFjJxpGS93TGomnq6CM7SX3ZD9Tt5xHVAKO
	VtDR0bFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruJ-00000004zcl-0jIU;
	Wed, 04 Sep 2024 15:26:55 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruF-00000004zZ7-1dS5
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:53 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 484DJKxX023016
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=NJGuAIm2f/+xDgo4fPX/O74jcJilrmqmvJTBA0uhJGc=; b=
	nyL5oyEaGJWXzULQsfYGJ6uKN6VABTQnRYeh9CmKT0pqmLAP4tmD8ftHZj1FzyPv
	lLStP3qmimHauADdGo8UaU5K0EgMftNJ/tzK8KtGnngdNgoTCDb1jangu38tRBTU
	LpOdGHIVVXpQNZIfDQ9/N513Uxsbj3sH2H3VUN8d1UF40rXyXRg1LcW7Fx4X1/qN
	cAz2b1b+9zlOkfF3vMJebHWrex0uEb5kVHybCJUt1dQktESVlZUa7cFLAir8CpjA
	RMY7h8Ecvq4FSYr/iHXXbAjgAJx5ELK3rcsQ0jM1u3i6csMs31wN3NtZl36tehKB
	yNGh3JJEuzlbwYlr8seE2A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 41e5r4q3vq-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:50 -0700 (PDT)
Received: from twshared17102.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0AD7412A036F7; Wed,  4 Sep 2024 08:26:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 10/10] blk-merge: properly account for integrity segments
Date: Wed, 4 Sep 2024 08:26:05 -0700
Message-ID: <20240904152605.4055570-11-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bSk0SL08Vuhv2sFg8_95BIaE2c-PiT4Q
X-Proofpoint-GUID: bSk0SL08Vuhv2sFg8_95BIaE2c-PiT4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082651_655730_6FDAB596 
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

Merging two requests wasn't accounting for the new segment count, so add
the "next" segement count to the first on a successful merge.

Merging a bio into an existing request was double counting the bio's
segments, even if the merge failed later on. Move the segment accounting
to the end when the merge is successful.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 2 --
 block/blk-merge.c     | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 985de64409cf5..4222c78eab18f 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -107,8 +107,6 @@ bool blk_integrity_merge_bio(struct request_queue *q,=
 struct request *req,
 	    q->limits.max_integrity_segments)
 		return false;
=20
-	req->nr_integrity_segments +=3D nr_integrity_segs;
-
 	return true;
 }
=20
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 43ab1ce09de65..734e6e22a6d22 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -639,6 +639,10 @@ static inline int ll_new_hw_segment(struct request *=
req, struct bio *bio,
 	 * counters.
 	 */
 	req->nr_phys_segments +=3D nr_phys_segs;
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	if (bio->bi_opf & REQ_INTEGRITY)
+		req->nr_integrity_segments +=3D blk_rq_count_integrity_segs(bio);
+#endif
 	return 1;
=20
 no_merge:
@@ -725,6 +729,9 @@ static int ll_merge_requests_fn(struct request_queue =
*q, struct request *req,
=20
 	/* Merge is OK... */
 	req->nr_phys_segments =3D total_phys_segments;
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	req->nr_integrity_segments +=3D next->nr_integrity_segments;
+#endif
 	return 1;
 }
=20
--=20
2.43.5


