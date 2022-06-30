Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DF1C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vQ+SPG7rbLReFzJBCjN1ACRC52yjPlRyenY1f8Evls=; b=pzIexY3V3GWPXM0PclLX9Bhdjf
	GsXQTXvFoDb+a6J+bWfDlZDrGWXbUuol1DjcX+Dfyp0//sEVBALoIVqd8Y9IC2SNQJruc9HQjaoHB
	90sl2GhfpyfbMN7sdAkrwldBJ+QXQWeOuTRfe3Je4zoWv1fUI235+pZiHjwqKPBhjqG6Y5wpprLqA
	e7O3noajcNOZ/epT4aQT+aO0xAv7ofnuOVEfDeRFVT6NwDJ7YywVqy7Chu6rK3g7MpDh/9amrzFTd
	Y6R+9DrEAmMmsJBGqp0m1baY4Lg8AwKhCQoStXstiICi1lWvHKLus/HQpejeVe5jJoZxQSDFHhhZT
	uMYNZo+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o710M-001THh-Lu; Thu, 30 Jun 2022 20:43:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o70zu-001SxC-FK
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:47 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25UJL89P004868
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0vQ+SPG7rbLReFzJBCjN1ACRC52yjPlRyenY1f8Evls=;
 b=BwXqJ0IRMhHWVI2XdzdHeXoVR2qu4nIthtzTWuPUslKc79l+2euoanAdUtXj/Ufrrnz0
 E+PXzA2yPKqxIJiWHuOmL9271VX8lgn3H2SJCgPYf58h93h6CSmZV8r+ObwDwDyAd4CE
 1SdoWZWVmTZwR7kamid3ibWolWpcqMPUVxg= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3h195a4pvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:43 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:42 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 34C505932DB8; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 02/12] iomap: save copy of bdev for direct io
Date: Thu, 30 Jun 2022 13:42:02 -0700
Message-ID: <20220630204212.1265638-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: atJQNM4FTVaTvkBihf1GdEEBsXQYKMBN
X-Proofpoint-ORIG-GUID: atJQNM4FTVaTvkBihf1GdEEBsXQYKMBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134246_688785_37F2A9CA 
X-CRM114-Status: GOOD (  15.35  )
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

The block_device is used three times already, so save a copy instead of
following the iomap pointer each time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5d098adba443..5d478a95efdf 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -240,7 +240,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 {
 	const struct iomap *iomap =3D &iter->iomap;
 	struct inode *inode =3D iter->inode;
-	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
+	struct block_device *bdev =3D iomap->bdev;
+	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
@@ -253,7 +254,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t orig_count;
=20
 	if ((pos | length) & ((1 << blkbits) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	    !bdev_iter_is_aligned(bdev, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
@@ -275,7 +276,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 		 * cache flushes on IO completion.
 		 */
 		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_FUA) && bdev_fua(iomap->bdev))
+		    (dio->flags & IOMAP_DIO_WRITE_FUA) && bdev_fua(bdev))
 			use_fua =3D true;
 	}
=20
--=20
2.30.2


