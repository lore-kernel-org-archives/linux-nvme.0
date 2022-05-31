Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF873C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CssFKoJZ3/mGtHyrbWTJBPcP71EgcStDnvvQRHZQLzA=; b=sH9vMX6FL/TZMC/uVnvYNWSFsC
	g1MjlHP9Q1A/j7og+hThdbGw/yDmQvuxVFgK3hTDTaFDeRWor9B6jS4FuWCGeNJqI4UR+2NaFYWrp
	U4yPxgbXqGk0Zfq/mdWYLhOaGRK64irhtbydvqsX8fhUQ+H1pjs1Lw0RnfAbbGe12OKinR7cc+yi3
	kje0Sqvd/LydxZkpboqCOyGH+LMuhZszGYguy+gw/GgVLrxjztvLsroz1nCSlpPnL/ukpEyAMua72
	LQh8+qvXIyaitRCfBNurGWg6s4FQAI6NFK7kgC6+zeNxQ/WPkhdH920ZOakY/sQkMq7ynYXeYKjbE
	2JDAa4zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7dn-00CLRR-Bm; Tue, 31 May 2022 19:34:55 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7dj-00CLR4-JE
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 19:34:54 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiJ6k020555
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=CssFKoJZ3/mGtHyrbWTJBPcP71EgcStDnvvQRHZQLzA=;
 b=prdKASCY5CiXBvcxq+HSwuVpiMBDo3NCrroIFutfThRdLSDLIQoOO1uTNCifTTGJHWro
 m7YeLLmAMRaRXl53D3MQolsVLjagH56OnGMnKl8eFwOkWqjiL2PllCQ8NqbELrH+0CZV
 0JxhO696Nn+hdLO0Mklj8xTyHXLOO4sJthw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbguqr0ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:34:51 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:34:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E56534924B17; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCHv5 07/11] block/bounce: count bytes instead of sectors
Date: Tue, 31 May 2022 12:11:33 -0700
Message-ID: <20220531191137.2291467-8-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IE6TdNsdrKVBQ4cbPTcC9EOq7Dmc-50P
X-Proofpoint-ORIG-GUID: IE6TdNsdrKVBQ4cbPTcC9EOq7Dmc-50P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_123451_682333_C9891C55 
X-CRM114-Status: GOOD (  16.81  )
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

Individual bv_len's may not be a sector size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
v4->v5:

  Updated comment (Christoph)

 block/bounce.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 8f7b6fe3b4db..fbadf179601f 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, st=
ruct bio **bio_orig)
 	int rw =3D bio_data_dir(*bio_orig);
 	struct bio_vec *to, from;
 	struct bvec_iter iter;
-	unsigned i =3D 0;
+	unsigned i =3D 0, bytes =3D 0;
 	bool bounce =3D false;
-	int sectors =3D 0;
+	int sectors;
=20
 	bio_for_each_segment(from, *bio_orig, iter) {
 		if (i++ < BIO_MAX_VECS)
-			sectors +=3D from.bv_len >> 9;
+			bytes +=3D from.bv_len;
 		if (PageHighMem(from.bv_page))
 			bounce =3D true;
 	}
 	if (!bounce)
 		return;
=20
+	/*
+	 * Individual bvecs may not be logical block aligned. Round down
+	 * the split size so that each bio is properly sector size aligned,
+	 * even if we do not use the full hardware limits.
+	 */
+	sectors =3D ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
+			SECTOR_SHIFT;
 	if (sectors < bio_sectors(*bio_orig)) {
 		bio =3D bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
--=20
2.30.2


