Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC48E77180
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEtG5pIJIABxdhq/OuyTkBbzsVLRyyzv+L3EKrkNogE=; b=Q49GggMuTEAyqyMFeP+rRlr5yR
	zPOJ5kgE4qIJOl6bq1IpoEDf3khF6/CInSB9RH5Ds3t7nh7hxYaHTRYRNdMrx/Euf314PINFDVxnq
	+7OfVTHxIDMJaS+xqe8i9WQ58rSqhuqHsE3sCxYYfeU72SFkG3773CTTVk+GffY74WKpy25XnK0ux
	dvDF7r9uRojdmtHd0XskwwaHg3r7wqF7q8iNOnF+9Ky0SvDrFapmOpgQkh4rf7esrK+7RR3mWjXjD
	fjp0NSjVXeZMPBCUZWGl4iM928o6FbUtO6lgybKj988dnXJhxOnkNhVSJDbBdLqBYWGCFwkzNDxfS
	EV+mzM4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLRuV-0000000FoOU-0fcW;
	Wed, 11 Dec 2024 18:58:11 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLRt6-0000000Fnqq-0cMU
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 18:56:46 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFI1B9022537
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 10:56:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=FEtG5pIJIABxdhq/OuyTkBbzsVLRyyzv+L3EKrkNogE=; b=Ilfsle7/F3ee
	+E3Fgwib06UMqpPk4mqCEnA2aPPEpLHkll89HxGJCII+Nb1Rn4+NHFTV8qGKc7qk
	36LZM2LsBOV65PBuZyfTqJCELSQyGzhqVMN9Ln+j0+bEDJ1ZPax9pNGmG+ABLtZl
	uI9V1bwkRCSGribuFHpV+n2PeYOtWhvWNn/dWN+0MGQup03etm8Jv7U8BWDNQAJN
	W4DuOAbgD+9j8lthgmo/+FWozuhrCrKho+qHnJAuv2Zz2i6EV/Gjq5PTrS9iY1Gp
	BNuQl7eIcyRWVb8RGjkyeCZNm+jU1BtPC68VE+i3MEz5Jfbz/4Kls+3CWQrl8ypy
	hjKuU5+7OA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43fcs9j2cf-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 10:56:43 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 18:56:41 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 71FF215DE395B; Wed, 11 Dec 2024 10:35:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty
	<nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv14 05/11] block: expose write streams for block device nodes
Date: Wed, 11 Dec 2024 10:35:08 -0800
Message-ID: <20241211183514.64070-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211183514.64070-1-kbusch@meta.com>
References: <20241211183514.64070-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yveS3oI6VPGz7VizZgzNEqr9hvU6_PVm
X-Proofpoint-ORIG-GUID: yveS3oI6VPGz7VizZgzNEqr9hvU6_PVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_105644_192075_E45DD59B 
X-CRM114-Status: GOOD (  13.68  )
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

From: Christoph Hellwig <hch@lst.de>

Use the per-kiocb write stream if provided, or map temperature hints to
write streams (which is a bit questionable, but this shows how it is
done).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[kbusch: removed statx reporting]
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 6d5c4fc5a2168..f16aa39bf5bad 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	}
 	bio.bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 	bio.bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+	bio.bi_write_stream =3D iocb->ki_write_stream;
 	bio.bi_ioprio =3D iocb->ki_ioprio;
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |=3D REQ_ATOMIC;
@@ -206,6 +207,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	for (;;) {
 		bio->bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 		bio->bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+		bio->bi_write_stream =3D iocb->ki_write_stream;
 		bio->bi_private =3D dio;
 		bio->bi_end_io =3D blkdev_bio_end_io;
 		bio->bi_ioprio =3D iocb->ki_ioprio;
@@ -333,6 +335,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 	dio->iocb =3D iocb;
 	bio->bi_iter.bi_sector =3D pos >> SECTOR_SHIFT;
 	bio->bi_write_hint =3D file_inode(iocb->ki_filp)->i_write_hint;
+	bio->bi_write_stream =3D iocb->ki_write_stream;
 	bio->bi_end_io =3D blkdev_bio_end_io_async;
 	bio->bi_ioprio =3D iocb->ki_ioprio;
=20
@@ -398,6 +401,26 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, =
struct iov_iter *iter)
 	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
=20
+	if (iov_iter_rw(iter) =3D=3D WRITE) {
+		u16 max_write_streams =3D bdev_max_write_streams(bdev);
+
+		if (iocb->ki_write_stream) {
+			if (iocb->ki_write_stream > max_write_streams)
+				return -EINVAL;
+		} else if (max_write_streams) {
+			enum rw_hint write_hint =3D
+				file_inode(iocb->ki_filp)->i_write_hint;
+
+			/*
+			 * Just use the write hint as write stream for block
+			 * device writes.  This assumes no file system is
+			 * mounted that would use the streams differently.
+			 */
+			if (write_hint <=3D max_write_streams)
+				iocb->ki_write_stream =3D write_hint;
+		}
+	}
+
 	nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <=3D BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
--=20
2.43.5


