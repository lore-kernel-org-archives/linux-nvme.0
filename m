Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E73DCD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zy1ofmOP6PSRwOaZNgivE8Y4y6QkgY6sla0k7S7E7Cg=; b=oGiHaKf61x3gjHzIbphIb06myR
	QYQh8IioIViOrztGglgLqisl4PMQgOuM6FX/QXWTfIxfZ1GvYuOLmza1+FQzJXGqki7Mb++PE4f8X
	hTInXE3IeN2H6YMizfxiYv/kk8pIhgy//9kHITuBIODoQJL6mY9jZlV+frudMS16qPkCFwu0DUPIe
	FfrMnrTM73W3cb/0R7OIpiwU27FCcLWY+rPUGK4P4Nrf7Vd2w7RSjiURvbuvV5MSphHMNt3+pV46y
	8uZKEMiS2glJxUjY3I8Dc35JlTZYYUnDB6cwh3Yc/d80jyn9pzOP0WYMIvvBJxvjkCaU4j0BfeAEw
	m6gqvydg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAo-00000002NdX-2r8W;
	Tue, 19 May 2026 17:24:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPOAl-00000002NcE-3zAx
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 17:24:05 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JE2lWS1645037
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zy1ofmOP6PSRwOaZNgivE8Y4y6QkgY6sla0k7S7E7Cg=; b=de+0quj5V62B
	kOO1nbP2jsBQY055/rN1A9xHIDKh4RxevoK+crjDDdK/rw0QjVr14bH7YehoNaMX
	V/FrCs1p1PkxADqJLBLzGFworXaJH5ZbCm4yllzxoZ53xuyrGYjoUF5DOfVRvPJ3
	My6o0W0U4MnyE2hvkRlQ1PZ5FWusyx5SUZQgtKeu2todQk3I2epgRTUmrsbqP+tg
	w7hN5wj2jvJXJtDvF6bL4HguMQPBoEIQYu5EEo2SUB0fQu6lnTGNcmSdxabo2i4j
	jki8AR37KivD8pRRfTc9b14kIU2+1DSXOSIX4UtEvwYxRci6cUK03j9eN3xJRsOT
	hb+uSs0uOQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8s9e9drw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 10:24:03 -0700 (PDT)
Received: from twshared23877.03.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:56 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 637E31A75978D; Tue, 19 May 2026 10:23:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 2/5] block: fix invalid zone append status
Date: Tue, 19 May 2026 10:23:23 -0700
Message-ID: <20260519172326.3462354-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfXwxnueA/AnTes
 cXm+w2UKGB49tXsGLwAOK1XpDzV8SpbWJV4/VLdF9+EIshQlvfZWKToBgO9P8j2FEJ+/Dbdj94X
 UTJPJ8zIC9pQJ67H+/OFXxFzAHsLT8a6BodTe+Y4WKvMsx/pkSQBJSuNMs2BiK0CEcjOkk82b9t
 bYPkAhQAh0WQg974MAYeuIIWBoDcgycuEzQvsozWRk4rQgiu6pmtySAzpIDHUlnZG11OZ+ccYyF
 A/IfZXivjNb2HNG+RDnyJfrfjFmUOF6fWPW0NTY5tnmzqMB34kIx9UxBvm8B5BgPuoeDVhDc0Mf
 Z2FbezbPrviiWM5cBKF7IPaeKYJMSvsTTQ1XjRTW8k7cJ+x328KxIZSgS4XT5BcAq9mRuaL3gU5
 puzHbQVRYBcDgnZy7EyXfd7bu7As1FKp+cRAM7enzIqSkvvhqmGJH7eiPzFNgBDOcIw+LDOiRwL
 b1ZfUi78gez2i7kbHXw==
X-Proofpoint-ORIG-GUID: aqKUfTsVjDFz6v-jZLj733iEIoqvyUwt
X-Proofpoint-GUID: aqKUfTsVjDFz6v-jZLj733iEIoqvyUwt
X-Authority-Analysis: v=2.4 cv=XpLK/1F9 c=1 sm=1 tr=0 ts=6a0c9cb3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=xkUBQ34vpCiLUNs1zEsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_102404_567236_0539CEF2 
X-CRM114-Status: GOOD (  14.06  )
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

A bio submitted to a zone block device that breaks the limits is invalid
rather than an IO error. Fix up the return code to report it that way,
as the previously used IOERR is considered a path failure.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 22af5dec112b5..92a802dc8042c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -604,7 +604,7 @@ static inline blk_status_t blk_check_zone_append(stru=
ct request_queue *q,
=20
 	/* The bio sector must point to the start of a sequential zone */
 	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector))
-		return BLK_STS_IOERR;
+		return BLK_STS_INVAL;
=20
 	/*
 	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
@@ -612,11 +612,11 @@ static inline blk_status_t blk_check_zone_append(st=
ruct request_queue *q,
 	 * different zones.
 	 */
 	if (nr_sectors > q->limits.chunk_sectors)
-		return BLK_STS_IOERR;
+		return BLK_STS_INVAL;
=20
 	/* Make sure the BIO is small enough and will not get split */
 	if (nr_sectors > q->limits.max_zone_append_sectors)
-		return BLK_STS_IOERR;
+		return BLK_STS_INVAL;
=20
 	bio->bi_opf |=3D REQ_NOMERGE;
=20
--=20
2.53.0-Meta


