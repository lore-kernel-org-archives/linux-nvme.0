Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3CBC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a1ESS9FvEbxK8WmdGc+88RFDsifxDVAiztMf4TMM3sc=; b=Ju9f30xMfNgS1nIb0+FqN1GDlA
	lsy5XLSUb25H9jFC8AaEsFXG34/QiUVa0RyWmRfIaRm4xCDQ4lj6IgJHIV4VDYtDP9Zp+Kc+5WSyn
	FpzMJehvXzR0eu7UTYn66Ib8+KWiwRIHvUnC9aKFfdgjdsgRlyx2EoZd5z7tlilO4FLJ3AB8RNr74
	DSy7yDs6WHq8XH9zNvMzjdnVNrXV/952H6vh4h6psRquULm9LjCg3fFVqep6FhZr9qT8IJpjBDqve
	L19QJgTQh4WqbrIejwffaMymkMWlsh6e1dWPjMbjjWPqaKU+N6z7Cwfy6Hmc+mNmnUmz/xjAw/pMy
	eSuuTqbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl92-009hYD-VG; Fri, 10 Jun 2022 20:22:13 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl90-009hXb-BI
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:22:11 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AHHeX3032012
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:22:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a1ESS9FvEbxK8WmdGc+88RFDsifxDVAiztMf4TMM3sc=;
 b=c7PBurL3cb+9y3immdgkxzdwXC4jNCxcRquUyKEukaB0z/B/jog+pUCdiB+gwbvyjJ75
 kGc9rtPv9pRFBe07yF+sXxiFzh10TMUqnlnOsbnjmnuaxsLP75jgEY+WvrvDdBZH+JPf
 uzfJVlgyxUONKyr4O2izm6FXL0/JsK0ylxM= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gma7n1a86-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:22:09 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:22:09 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C0A084E9D6A1; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv6 05/11] block: add a helper function for dio alignment
Date: Fri, 10 Jun 2022 12:58:24 -0700
Message-ID: <20220610195830.3574005-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TMlnXl3dBSTCdcOGzz0tp9OxVI8PhbaT
X-Proofpoint-GUID: TMlnXl3dBSTCdcOGzz0tp9OxVI8PhbaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_132210_436101_CB036E0B 
X-CRM114-Status: GOOD (  16.44  )
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d6b3276a6c68..9d32df6fc315 100644
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


