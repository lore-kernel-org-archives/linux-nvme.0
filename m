Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900E6CD4F22
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rd7a/k5fb4q3A2ywz24VKgaB3Pwg9YzXlvjTsg1C6HY=; b=XXv9SfSuB4T9MEqgaSDZPaAPc+
	l+tbC8Y976OSCyeCJjXxDI4avHAbDWiY2CH05KoO+1+UOx0R4HPLsZsCG88Cgz92zEgUyGA2/pERZ
	JqM8rjsbwTNAZNASRbOx36biZwE8wFnbH62yqRna8VMlxopFkuw+u1/ZnFEz0lhHP/7cZ5A/i/wBE
	m8rmipPGu9J+ZwVW9tTey3eCOIfAdsXu/F8jySC9B2gEPyEG66waY4I9IZ/lc2A24ItdPsaGs4Ty9
	T+OHvpBMsS6wRXT4QbIS4nytIUnpLnFRodkjaWmmtrJ7cZ16JcZRtMUODeZXp+fKa5XuMWtJfVJlP
	GZFBaVQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruE-00000004zYP-0pJS;
	Wed, 04 Sep 2024 15:26:50 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruA-00000004zWO-0nH5
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:47 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849U2Nr022336
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=rd7a/k5fb4q3A2ywz24VKgaB3Pwg9YzXlvjTsg1C6HY=; b=
	Hi8kP2nYf0wRpYjozES0Sosfu/EGIo6kVR9uDPeUa5Xt+sWTKXii+m1+4myIO4TM
	OZQDic7hNdeGNzd3dFBEsaCMq2hOmN4RG9bQtWju7JTHWhe1REUMMbtgP859sCam
	WxjlCernoQTGslwKD2RwQqHkjlqS6zdT3oNhwQSf4VzYIEHafhmR7GoAzU2GRNQ5
	T5NAUygpwUs82YEhJVOZfeQjRJI2Ap8cO+CBe55ZX04Gcd0KBAZiQnf5Or8ATkJp
	eMYvriATFnxqP41EWtvYbyv2VlxdY6ymsOArUVSoqBbCxOe1A5OWiR6yCfNUiyJN
	cOHoyyDnxm3Sdk4XqryLsA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp1w8k-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:45 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A784612A036E3; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 01/10] blk-mq: set the nr_integrity_segments from bio
Date: Wed, 4 Sep 2024 08:25:56 -0700
Message-ID: <20240904152605.4055570-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OvEHrNlJz9Anb28nLaRwby6w6zg4qmyF
X-Proofpoint-ORIG-GUID: OvEHrNlJz9Anb28nLaRwby6w6zg4qmyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082646_344841_D78562F4 
X-CRM114-Status: GOOD (  11.22  )
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

This value is used for potential merging later.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 36abbaefe3874..3ed5181c75610 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2546,6 +2546,10 @@ static void blk_mq_bio_to_request(struct request *=
rq, struct bio *bio,
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->write_hint =3D bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	if (bio->bi_opf & REQ_INTEGRITY)
+		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q, bio);
+#endif
=20
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
 	err =3D blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
--=20
2.43.5


