Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F83C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ngx1M3+a4EOhn7oa2wX9HNTxKy75b3x4RgFOhBsXFKI=; b=vvEnwUjqKQ5ceTxIMXRC3cc7QK
	mVjm8qo7Gthutd2+fqcbMhKbYlzgo6qvYbTSdrXveU3ga5st4RwtOIerDE2HXisKfZRd/Qj/5jh3x
	U0fXiB+2mHsMPv+H+f2W9UPATdpfgWHCyNSsh+ln7iulvDGmgDapNm/wKyaiToYWnetShGxrOAiqU
	n44UYMUdnWewPSO3Lwmn1zvWW9xv66cqsh7gtG+IQkTDhZbH83gNHt69hu5SNmu8HJvBwwDErjKEq
	v8pu9/vFoxxaQoiy2wRZSQQPDxTI+0pSrFfuxVwuqB7RjB6GtHwuvcmUgf1L1g7SnSvLA0cjRhR+t
	I44D+mlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmHvc-00BflG-O0; Wed, 04 May 2022 16:32:40 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmHvS-00Bfhp-UX
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:32:33 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244DvdJl013039
 for <linux-nvme@lists.infradead.org>; Wed, 4 May 2022 09:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Ngx1M3+a4EOhn7oa2wX9HNTxKy75b3x4RgFOhBsXFKI=;
 b=h5o545w39z+s7bMvAeonLMWwrn7Dbd6Jg3l+FDe+hZ5oOqYDcE9GmqrUmlaGmUYUT2X2
 jp61isFTyiiGCVwKKIKtBxx4IgWsjqUUlKkznXGEN28UoKFg8ishJ90jDThPZ6IKc/2w
 kzc1q1eQGwHoXoFF3xAvkje/wHhAzcuMKyE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fuf2mm3wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 09:32:30 -0700
Received: from twshared41237.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 09:32:29 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
 id B269E3939683; Wed,  4 May 2022 09:32:22 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@kernel.vger.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 2/4] block: relax direct io memory alignment
Date: Wed, 4 May 2022 09:32:05 -0700
Message-ID: <20220504163207.891761-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504163207.891761-1-kbusch@fb.com>
References: <20220504163207.891761-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MHb9KwsN231oPr6Z1iXtxG-LH6nUduog
X-Proofpoint-ORIG-GUID: MHb9KwsN231oPr6Z1iXtxG-LH6nUduog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_093231_144387_12C11901 
X-CRM114-Status: GOOD (  20.25  )
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

Use the address alignment requirements from the hardware for direct io
instead of requiring addresses be aligned to the block size. User space
can discover the alignment requirements from the dma_alignment queue
attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c           | 15 +++++++++------
 fs/direct-io.c         | 11 +++++++----
 fs/iomap/direct-io.c   |  3 ++-
 include/linux/blkdev.h |  5 +++++
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..a6583bce1e7d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -62,8 +62,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	if (nr_pages <=3D DIO_INLINE_BIO_VECS)
@@ -193,8 +194,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	bio =3D bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
@@ -316,8 +318,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	loff_t pos =3D iocb->ki_pos;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
+	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
 	bio =3D bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index aef06e607b40..b3d249d7d91d 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1132,7 +1132,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct in=
ode *inode,
 	struct dio_submit sdio =3D { 0, };
 	struct buffer_head map_bh =3D { 0, };
 	struct blk_plug plug;
-	unsigned long align =3D offset | iov_iter_alignment(iter);
+	unsigned long align =3D iov_iter_alignment(iter);
=20
 	/*
 	 * Avoid references to bdev if not absolutely needed to give
@@ -1166,11 +1166,14 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct =
inode *inode,
 		goto fail_dio;
 	}
=20
-	if (align & blocksize_mask) {
-		if (bdev)
+	if ((offset | align) & blocksize_mask) {
+		if (bdev) {
 			blkbits =3D blksize_bits(bdev_logical_block_size(bdev));
+			if (align & bdev_dma_alignment(bdev))
+				goto fail_dio;
+		}
 		blocksize_mask =3D (1 << blkbits) - 1;
-		if (align & blocksize_mask)
+		if ((offset | count) & blocksize_mask)
 			goto fail_dio;
 	}
=20
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b08f5dc31780..c73b050b7026 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -243,7 +243,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length | align) & ((1 << blkbits) - 1))
+	if ((pos | length) & ((1 << blkbits) - 1) ||
+	    align & bdev_dma_alignment(iomap->bdev))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60d016138997..dba6d411fc1e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1378,6 +1378,11 @@ static inline int queue_dma_alignment(const struct=
 request_queue *q)
 	return q ? q->dma_alignment : 511;
 }
=20
+static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
+{
+	return queue_dma_alignment(bdev_get_queue(bdev));
+}
+
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long =
addr,
 				 unsigned int len)
 {
--=20
2.30.2


