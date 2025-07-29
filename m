Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B82C83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDTpHDyrdZGArIWCxyLrlAqXaszSC3cxOPNvJsnOFUI=; b=xe7sENClU58hgETQv+NhDu/vAV
	yf7stEfgIIkKI1He4pW5Fx5y4NOcxSz34w/EpytQyQiMAB+cMN8JweAoGOL/XDr1W5AAM4jHxG/h3
	uT59yCjuRi42QSBFM70Rtb1vKzkMpkd4kYglT+U0+CqxZzmFO1LxgQp1jM/nV5c07hoVS+8YlTYoj
	5rukt/F1g03gxZJ/+3N2qQnEftcek2SKHv033SqnsuCIpFxfVzEw8iyiTu8vZ5X8tkJ0uHU5BpAYu
	dAxwuFEyHlK+mifZP9aYjjml7KBG9NTCFx9Yqt0YD7FI3sAQ8dbPTXYNGfokgkKGQQbrR3dwG3sQN
	MHuCeEbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglQ4-0000000Gugk-1guc;
	Tue, 29 Jul 2025 14:35:08 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uglQ1-0000000GucO-1ib6
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 14:35:06 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56T7QjNj020371
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uDTpHDyrdZGArIWCxyLrlAqXaszSC3cxOPNvJsnOFUI=; b=aygdIhXjqxJP
	k9gdnMBEVXjgE2D3yDaNxXuaIWzRHihXyxwsM3hRqI6AhDq6tC8kPZnAa4HLi5Xv
	4YlSO9T8VN89lS/ZuLuiefG22VK+zUKQqmHlFTEXJnFCHUP/d/shRy/2rYrZ8lMI
	pdFXWasnjrpKflvC1t/ZERr2S6vQ61o16nMottrIxt97m/C88AEMZ5ksFZjlSTqh
	ZKIeJRhUA0dz+WpCV8LyTbX2Sd68OPne2do77Q8D03emZsiQDCOA+1LRCYKIfuyU
	tjG29loKYPioQjnN4KCyAobaXEgv3xeYNjvs7J2HO9H4DVCkrnXVcVo7foKIf0Hd
	fxp8HnJ7lA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 486sw62a11-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:04 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 94EFF1CC41FE; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being iterated
Date: Tue, 29 Jul 2025 07:34:37 -0700
Message-ID: <20250729143442.2586575-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729143442.2586575-1-kbusch@meta.com>
References: <20250729143442.2586575-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Z2UhdjGy8s5pGI3nnE8ngv2Y5i8-Nynk
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=6888dc18 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=V_F5WBpg3us9ROv35IkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfXxJWm7rHNBpNz eLvThaklsP/TRZOv8W55YHqg7SqE1hHBWKeJCkHXJ3DoPuICVSZaFCl/iIt0jXGmTK1vEd2onI4 gj6lWhz50yj5a9AIzppMWc4s/sTXjZI43/Cn+0rXE2oeESrys0kSEDh6ljVn1ProU2/zpgnLjfH
 BxJmAWtfy/F/V5Mmjvit+qWJZQEWhygSGfLm8jDThBwpXnkARP+uuh7mnwIrbICzn6HdjVIkkRE pCgElPMsLpLDCralgcrwkEY0LwkhhDJE9g4n9d2n+JNHSE02w1bEs79BR2qIciHatN266/sMhxn MAzKzpzL2vGAfLIteVnHmU51G3nZ0zu1+DCtGBjuSb/xeMIV+Gh2GiBmdxYecBR7CH/4BlPe5g+
 w0XWG525UHI8R/uOBg93vED/h70yb5dG4WvrUOm6u0S0kzZj5Z51z+POXYLKkMeOtiae8+1G
X-Proofpoint-ORIG-GUID: Z2UhdjGy8s5pGI3nnE8ngv2Y5i8-Nynk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_073505_616145_10B41ECE 
X-CRM114-Status: GOOD (  17.81  )
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

This will make it easier to add different sources of the bvec table,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 30 ++++++++++++++++--------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 61fbdb715220f..08ce66175a7a3 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,23 +10,17 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		iter->paddr =3D bvec_phys(&req->special_vec);
-		iter->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 	iter->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, iter->paddr, UINT_MA=
X);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvec, &iter->iter, bv.bv_len);
+
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return true;
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -40,15 +34,16 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 		if (!iter->iter.bi_size) {
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
+			iter->bvec =3D iter->bio->bi_io_vec;
 		}
=20
-		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
=20
 		bv.bv_len +=3D next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(iter->bvec, &iter->iter, next.bv_len);
 	}
=20
 	iter->len =3D bv.bv_len;
@@ -151,6 +146,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+		iter->iter.bvec =3D &req->special_vec;
+	else
+		iter->iter.bvec =3D req->bio->bi_io_vec;
+
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
@@ -244,8 +244,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatt=
erlist *sglist,
 	int nsegs =3D 0;
=20
 	/* the internal flush request may not have bio attached */
-	if (bio)
+	if (bio) {
 		iter.iter =3D bio->bi_iter;
+		iter.bvec =3D bio->bi_io_vec;
+	}
=20
 	while (blk_map_iter_next(rq, &iter)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 1e5988afdb978..c82f880dee914 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -8,6 +8,7 @@
 struct blk_map_iter {
 	phys_addr_t			paddr;
 	u32				len;
+	struct bio_vec                  *bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
 };
--=20
2.47.3


