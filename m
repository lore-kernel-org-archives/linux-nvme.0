Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F49C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+70oj3ezvDYkGSJCd4zURJxEMv8KpitIy6wxUbfHqM=; b=lY7NkVXs1NRNJPsn/DHOWnfo15
	7K2fwgkK2Rxa2hFeQgzqruYiTxmcz9pRmsDc5p28FFAL7Muad0c4ywV+fMyTOfTqGfRGofJWkSEAL
	7nlfeEJ3ejFnUT42jsJNgG0RuHmKJYbrGBGemlgr4X0Q4TqSkB4UQYN7ET7BkixsKtxVoo9Aav/f0
	5t8w1+v0faMsC7vZ21sqIysE9wab54161bpQoPGCjKQxwL2T2wRap9RnBaAn+u25NC2EoDgDQh4Wr
	EAjlkcKYSa6DIvY6cB12SGTe/s/nhhe3fLiyFlNGgN/i8aPqwciXpZW7dv3cnUSUpa18zuP0BDRUq
	jz/UKvfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7SK-00CJvT-Pf; Tue, 31 May 2022 19:23:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7SF-00CJti-8I
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 19:23:00 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VFiLvu024611
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:22:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=H+70oj3ezvDYkGSJCd4zURJxEMv8KpitIy6wxUbfHqM=;
 b=q+IY0UjXYLJA3O/ZX9ZLRgRz2qObxY89Ww6JUIUZ1TjeGhPxx441zt/IIGzRVh6hdrdC
 wAwuZq42hutwxD6usuPJ5e55GJ+zDvHr0uGRQlIK3SRg0b8KMk+jb+++pUndUU5rTh/V
 7Yi7WR/YhNgKSub1YTREkeDqgZjpjaqq8l8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbhjsfueh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:22:58 -0700
Received: from twshared6696.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:22:57 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CD0454924B15; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 05/11] block: add a helper function for dio alignment
Date: Tue, 31 May 2022 12:11:31 -0700
Message-ID: <20220531191137.2291467-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uULWCTahHOeBXcGWnj54KwnEH_4pPd51
X-Proofpoint-GUID: uULWCTahHOeBXcGWnj54KwnEH_4pPd51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_122259_454431_F8AD9EC2 
X-CRM114-Status: GOOD (  16.23  )
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

This will make it easier to add more complex acceptable alignment
criteria in the future.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v4->v5:

  Return a bool (Damien)

 block/fops.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b9b83030e0df..5aec9a130812 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -42,6 +42,13 @@ static unsigned int dio_bio_write_op(struct kiocb *ioc=
b)
 	return op;
 }
=20
+static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
+			      struct iov_iter *iter)
+{
+	return ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1));
+}
+
 #define DIO_INLINE_BIO_VECS 4
=20
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -54,8 +61,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
@@ -173,8 +179,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
@@ -298,8 +303,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
=20
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
--=20
2.30.2


