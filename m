Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9433AFC6172
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDsEwI+ao/aPgw7GYpJ4ITMYtFyfxhpYZ0cKsKXdu2I=; b=NyXc4iQDWENpQ6JIC4fzNBrXwZ
	iLgBj5EEZREbH04qSIPu2UmwEsIVJg2uhJSaE6SKdxeEefHSZOH8LyK+9DoZp4L9RdqhyEU9slLYO
	ZY368Ad5mmMoH3VL3ulSdcv+7l6isDJNGV0xBeOPfth5YUoYyDvt+wugfkDIVHm5OCk8t5RmdAaFQ
	+NPtcTZY2+A8CpUmxLWnaBf8zdUGLsRRZYbHcfnaUeQPwA0ewWNrrXKAHIx1iw2os5qu6Ajinjy3m
	31Z1861lJfheGyt5YsmjoC9gspiDjp1DEFi/rdm3wdJhwyYMf/Xq3TsyiM14+fkFHQvjfAOxBXyre
	YyA5WP0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spC0i-0000000Gwdp-0BQs;
	Fri, 13 Sep 2024 19:31:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2x-0000000GoQw-1lVA
	for linux-nvme@bombadil.infradead.org;
	Fri, 13 Sep 2024 18:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dDsEwI+ao/aPgw7GYpJ4ITMYtFyfxhpYZ0cKsKXdu2I=; b=Ka0x9ASvJqejQRjP0OYizRhlLT
	BVmUU+tqeOq1iX+8RKD0A7InlhB//ZK3zsgRgqxfP+SX5AlHZC2HQwd0gsn4Ml7tMsqbeeVniDnQk
	EjjZK7GE9VTdTQb9UU8q+z/P11+3beAPbF/Pz06N3Gu5K4rDlXe17/sZsLTat0S2broJKm1Bvg5ku
	j2MNpXWtIpbFpYj5A5WffCT0RM6RSBRtZ8/zA5WEowmigsAURqVhYfshbB8QLYt/WdZnHC6UPW6dI
	2sy4jOU4ce1oBvIuaT7GWo2nLympQL7/Eas9PRx/Watwid6XxF6Ut822TZ22i/QUxoALndmd62Ynv
	yew+v4Fw==;
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spB2t-00000000h3y-2BLn
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 18:29:29 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DI2Cue032443
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=dDsEwI+ao/aPgw7GYpJ4ITMYtFyfxhpYZ0cKsKXdu2I=; b=
	l9BOmwG0WeCwavTRrsEDifIzDVYyiRmWIh5N1E1kuGr7Jn2A4OYBq7G9ctZXukqh
	hlR88tdODz6m3QdLgkl+Cvem0f1IXHdZRhk8xoP1ExikjXrNAh/XhMRf9BLHnNEB
	LurENNvH3OSx6L9mEm6yG8305I1Q12ifUN7btMSqrn2PY+qLmAb042CmRNgxow3Q
	dAPwvbY8V5wSfI48yyJcn4ChVKEP3E+BUv/gHke6O/OUmCr64tY6BjpVTfYkg/rL
	A4qaGRMDMuFb1d30v7LRxRD+ut7cW6dnedzsjNQL2NCOqeKUrXlXHXkvhaz5CGAf
	BVynHnzfFWdoOkRRQW/0xw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mqb2sp95-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 11:29:21 -0700 (PDT)
Received: from twshared32638.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 13 Sep 2024 18:29:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 60F6E12F91045; Fri, 13 Sep 2024 11:29:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 2/9] blk-mq: set the nr_integrity_segments from bio
Date: Fri, 13 Sep 2024 11:28:47 -0700
Message-ID: <20240913182854.2445457-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913182854.2445457-1-kbusch@meta.com>
References: <20240913182854.2445457-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HgXZM5W0rufsf8EpJ4OzEPI7GQsT3Q2G
X-Proofpoint-ORIG-GUID: HgXZM5W0rufsf8EpJ4OzEPI7GQsT3Q2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_192928_114626_FA6C6E60 
X-CRM114-Status: GOOD (  11.31  )
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
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


