Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1DDEE57D0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMy4GT/2WxENY3dYTa/eDihiGlxScK9w4eG6NktGWso=; b=UBushq2+4X3RXfjxedxUrmPJgy
	szexNF2VmNljw0Tl6KLEUtXq3MyTnNN8sBRFbv5hG1YSxSwCR8UPI9ppTKQ7lk97Ccf9UJJTnUuGV
	7pUHdzLvRSYBUywKLEZRE2FTQHb7xaIe0LAr7gz1ka6lZ+h3A+DM6cLfRbq0VmlQ8oSM3Mor/Bgux
	8EHvRog4JvNXOTX454S8/KqKiPdZiGki2/CY+3h0h6HRvg1BvJXJWuRiLQMgUijwfgF8SbmUut0Dq
	QELIfGUgDJ6r8bJymoqvmwycKyR/XgnmnaRMdr3xrT9MM2RPi6SE6gsGcHHW66k+cuJqTZuesIPUd
	YgCV/GuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTi3-0000000AqrZ-0GJx;
	Wed, 11 Sep 2024 20:13:03 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soTht-0000000Aqk3-2XWw
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 20:12:55 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BHja1S023861
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=MMy4GT/2WxENY3dYTa/eDihiGlxScK9w4eG6NktGWso=; b=
	kagZ2l1MdOU9Sv+j1uT1Ge9kCNygIQUqqV/OCWrnxlPLSDlFNL1k3mN+NCsvba7b
	6ZMga5xh/pgywTZ/H/42SgSOThEpZtaQyIG+08zwe34wNPp9DoSehyOMmORGyJ1p
	4MF9QD/lmudAZXuyNeutIXiKJmS30rYe+NuKLNHllyK18Gp4vGd9bVMDBlLX5Sx9
	RgpNWyC98VPJe2Rxj6l6rRBAVuPWdSXMlf6aqfrxXiVSeN+1x/IsGCB7L4zamqxn
	zqacx6C4iDo55nBb4ufQWzkuQMDxhmw+GoTTXq4gjl7FaMjSLiWbivr4OOB7ZHuh
	fbjwyPeKIrz0GMQUXQnKzA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41k87cmcqt-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2024 13:12:53 -0700 (PDT)
Received: from twshared57535.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id CD5BB12E5EDA7; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 02/10] blk-mq: set the nr_integrity_segments from bio
Date: Wed, 11 Sep 2024 13:12:32 -0700
Message-ID: <20240911201240.3982856-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UjhuPovs3UwoYGODXA162K2msnS16_mO
X-Proofpoint-ORIG-GUID: UjhuPovs3UwoYGODXA162K2msnS16_mO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_131253_891753_5A8D6E52 
X-CRM114-Status: GOOD (  11.97  )
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

This value is used for merging considerations, so it needs to be
accurate.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Removed the "#if defined" condition.

  Replaced the 'bi_opf & REQ_INTEGRITY' check with bio_integrity(). If
  CONFIG_BLK_DEV_INTEGRITY is not set, the stub function will return
  NULL inline, so the compiler will optimize the setting without
  adding runtime overhead.

 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ef3a2ed499563..82219f0e9a256 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2544,6 +2544,9 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->write_hint =3D bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
+	if (bio_integrity(bio))
+		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q,
+								      bio);
=20
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
 	err =3D blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
--=20
2.43.5


