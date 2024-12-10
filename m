Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B78DE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgFHOgHaE4jw+dGMPOn2vA2NFSP+ToU+o7GNI61mlAU=; b=Y0gDw6fzK62DlKFHZSWMW3SwXH
	NdNmjQNtqKHWtGjPk3uItoCqVm+Yt6UE+XSQdyIEeTZarIUXB81OQzQnyfG0dhcl2uJyY4AyC8pM0
	SvExEV9MR006+6AMfvc+XnH2RA34o/xohyZ0XGXqpQTWGxe7wn7oNcUTPu4wMKteoradUTGYcso4j
	Mv/Edj8PBZN9T+GB99Rz1QABAf5Kt2dmPadNAMvznSbaeVs5UmXaRXRQBzrrmVsbYaOpMCvWIGMsU
	UxBQUhDBYdO3fLEgUjU4ntAJsZIrMbwyi4gIvctKLEmmwtQuAzKsr+bUCW1GgPMFhKW25Mf4mHrI8
	vh2iaGPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6NX-0000000CaeI-1TwT;
	Tue, 10 Dec 2024 19:58:43 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6NV-0000000CadR-0djd
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 19:58:42 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAEatlQ003672
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 11:58:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=mgFHOgHaE4jw+dGMPOn2vA2NFSP+ToU+o7GNI61mlAU=; b=D0xnDSIiPRiW
	j93myHXtOI/RtGihPRVrqLwI8ggzoBlhuvUgZLXh0ypnc28LCZGwNAQ96xtYWUQ3
	cX2Wxozs4noVcHXr5amhDe4YraaTjUBKosroiirT7sg6A+Ke41DigUl6+svn+dG5
	EcESsvySIdKHxPQL4l6WkwIbjBcVZnlUJTx01zgVh/lgHr8WtyqvquSrH7nOJ766
	Yw6DzZnzW4rTDh30o83IilcHzi+4rQxwKTyMux7DWgXlWnBVSp/AY7hkziO17MMa
	9JKPCvC0vm2sgEQNBsG2uMeIJw+dWpdDPs6B62TWWIbZyQs206v+L4Bo9YXOh8Oe
	lI7nygUdEw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43eqja2nhv-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 11:58:39 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 19:58:37 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7D8EC15D5C7C7; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv13 05/11] block: expose write streams for block device nodes
Date: Tue, 10 Dec 2024 11:47:16 -0800
Message-ID: <20241210194722.1905732-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CT_srJ_q25mZXCKMX7hcME8ft53MftLU
X-Proofpoint-GUID: CT_srJ_q25mZXCKMX7hcME8ft53MftLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_115841_378618_B0741218 
X-CRM114-Status: GOOD (  13.57  )
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


