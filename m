Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B081C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1nZ8QnF0btvr2N223v+ysMCy2G8tPU19RrjuX31LHoQ=; b=WesRwsPm5uYBSiQVoRiQeKFArQ
	XvUVFy6TJn70jsC6lM0Pjhgv/izyp1+XeXaXEpSUublhIsuC9C3CK4sjb619oe47by/B/Wr2RE7nn
	6JKviQlRyZxghWn9PRNJWjg2KUbDSlx0Q14YswVnmbulh7vNntt6KLYpAmTlI4wc5oCSjjP1YPjY5
	28mJnzljN9peNGfctZo2JJCDZJzVW07qvpF1MDW7c4Uvff7xToscuBcu2vjdVWCzJob3SqUIspCnQ
	MOVszDbRKEMr518wURPJXE/2DHDankt3jCzpMyYBR69fq8w64CdvpVxqdDCUozLUpIIVYE0D/T+kL
	dSIYNnGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkxZ-009ekT-OY; Fri, 10 Jun 2022 20:10:21 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkxS-009eiV-5B
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:10:15 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AHKGLY019167
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:10:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1nZ8QnF0btvr2N223v+ysMCy2G8tPU19RrjuX31LHoQ=;
 b=dBhvCbA16YyypczMbjs39+GmZ22y3SMEuGMn9wMiFKrTCAzvv50SZaGiMOOdyE9hJ8G/
 /JeksmD6ILMMuwJCpMdp8kkOnqOYicQJsV68RVodcNRjGKpImUuYJYU082HvBvK1fVyl
 NEOzYpWspwrcgOUlvakg5xYRC2wFbxS5IJg= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gma9316x2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:10:13 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:10:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 0D9C74E9D6A7; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCHv6 07/11] block/bounce: count bytes instead of sectors
Date: Fri, 10 Jun 2022 12:58:26 -0700
Message-ID: <20220610195830.3574005-8-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yAbwwUxLLJtCP4FIMMLfXprsdOijLasg
X-Proofpoint-ORIG-GUID: yAbwwUxLLJtCP4FIMMLfXprsdOijLasg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_131014_244558_C168F826 
X-CRM114-Status: GOOD (  16.67  )
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
+	 * Individual bvecs might not be logical block aligned. Round down
+	 * the split size so that each bio is properly block size aligned,
+	 * even if we do not use the full hardware limits.
+	 */
+	sectors =3D ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
+			SECTOR_SHIFT;
 	if (sectors < bio_sectors(*bio_orig)) {
 		bio =3D bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
 		bio_chain(bio, *bio_orig);
--=20
2.30.2


