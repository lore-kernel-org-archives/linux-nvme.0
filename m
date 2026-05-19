Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE1ACD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvU1xBEA3AMnCAty9ku+e17nT0gNRKHLvZIkc3M8dYo=; b=zL+XFhkqOaRgMhxHsvgQsCxQvv
	GX1gWwoMQ5efzS5yNky/ALfWWaXfbpS+r6FjIkWFSAsJeTjxsQ00uWyAIBxw2L3NcxykOW5QFqnoq
	1c2AChXkWDBgMkjyhWgG/wlsc/Y2JUyZ+IB4UOZKzg4Bi+DG2JhsKFshEq75hmvgjsXAOfrwmT4Gh
	Kvq1nF3yaOkif4QLCH8eRu3+OEMWUI48LQxaonp188rD6a6y6W380hQqRfd0nKe8aNAqygvb3AZMl
	Ai9LASrxlv9ipt/PMcBuPkPUlpaG8aY4ThO0mT60M0YGAUqOrB22b7KOdd1cYYMjeHUDZSERmSvtn
	1THSYOVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAr-00000002Nfk-3HSa;
	Tue, 19 May 2026 17:24:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAq-00000002NeT-2wdu
	for linux-nvme@bombadil.infradead.org;
	Tue, 19 May 2026 17:24:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GvU1xBEA3AMnCAty9ku+e17nT0gNRKHLvZIkc3M8dYo=; b=mLL+Zntop3lWYFUxPFJ9iD+EL1
	OgPQA/vVOwhpXy7iiSpnOisge1k4cFHxGc7WTlm1VMUi3Kli9ae4Y1CgQ9UOS0FQpooRK1dQXWYxl
	EpsQ1shvyj7mJbKKaEK6nVDjODpCM9usRdqR9mynXSofViidBmfclZOf7sIcjM+YOSWCMUCBQSeAh
	yKu7PECOssdVLacZFfNL1y15lA8pw2dTROIbd93GkSDA8OXN0+P7h4/4iogISg2uNuB/EWfaPGks8
	RinyjgNS3t/XtWd4Vuw/hKKmQB3Hw6/59/NS5ooySTb43/ygezGyGFZtKbbzs6/Bd9V6W7kuoDvit
	gvNKRPtw==;
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAm-0000000EvJ4-2I8d
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 17:24:07 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4VXVQ182059
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GvU1xBEA3AMnCAty9ku+e17nT0gNRKHLvZIkc3M8dYo=; b=Re5BAIjHHhgJ
	5JlLcMh35QHev7Cpl9S3/4GpFFTjcbmB5rH5aJhmop9ZAuBYRX5vTgRJRyQFxmv6
	W8fSwydvIqkxwrTSfYpokUxRRiRUmkxfR2SakvwZFD4NmVE7WfsENHEiziSR3tOt
	ad4TzBdiKeNTniDy2TkXp4OxpblCEsrpXYYU6bLJY2rl6MwpmikNTOIsKxq9M2F0
	5UbNP4jKRcjmOckwi2DSNyUC2fJQEuC62f+lGUGEvxG5XK6pVyPIT/KMoNbK1nYF
	lSuUkAZuY+VmPcl/EVtB/ueQSNoerZ9UY51i5Ol6sDbCwOZmox2z/fF99Uaj7eRT
	CShceFVaUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e6p3bskgw-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:03 -0700 (PDT)
Received: from twshared34426.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6254D1A75977C; Tue, 19 May 2026 10:23:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
Date: Tue, 19 May 2026 10:23:22 -0700
Message-ID: <20260519172326.3462354-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX08SyU7I5wz6u
 p8zvOvkCsEF0QsxkwwuNCX2LHoBbLRDCgPhRFJKzSKiJwKsLj+vaouRN2y8ftlsCmM8U0QGCm6q
 8KU8G83fC36duP7IvzJ4YgM4abL6ztkDvhrJtSePFijudIz+qDroUXs1g7lXldrepDGOmQ9QXGH
 8Pa2weApusxkoovDDQcHM+msYvwlVIG9vpKKs5wdMgkC+vkBggqxDA0w4tE/bvqH4VTmZAN9qRk
 Drk6oT1U3fnRNFDZy8WAxdFvlOL7uvZNkFSw6agHDcaLzHTECxgvG9kV6BuY5n+lq6UcekQdjl6
 vepz5AyLhPwQs8jxdGqK0R2EUnhyIyzgcTWVX0eQ+fMsTuacZ99FEcKq6ZXrVH002N7H/KdwVHk
 upp+KnXfeWWjpC8UEBJkE6mhzJHyIvJYQM0KpoG3AeYKZiO3U/AHBe2gwe5KxE9867YqfVppOxe
 PDnQlNfcgxTtEgE62Kg==
X-Proofpoint-GUID: dongWMy3bHFxxYB0t4FCntazWfWb3Xdz
X-Authority-Analysis: v=2.4 cv=K6cS2SWI c=1 sm=1 tr=0 ts=6a0c9cb3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=g6QZ0kzQZARFZKXYqHoA:9
X-Proofpoint-ORIG-GUID: dongWMy3bHFxxYB0t4FCntazWfWb3Xdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_182405_101971_AFCE2C8A 
X-CRM114-Status: GOOD (  12.57  )
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

A bio requesting sectors unaligned to the logical format is invalid
rather than an IO error. Fix up the return code because there are some
device mappers that care about distinguishing these kinds of errors.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f2..881183345a85c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3182,7 +3182,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	 * have to be done with queue usage counter held.
 	 */
 	if (unlikely(bio_unaligned(bio, q))) {
-		bio_io_error(bio);
+		bio->bi_status =3D BLK_STS_INVAL;
+		bio_endio(bio);
 		goto queue_exit;
 	}
=20
--=20
2.53.0-Meta


