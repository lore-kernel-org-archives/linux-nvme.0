Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87182C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7uKXzg/OPyXABdABOidNCjnrvjXhXTUMSABSngag/3w=; b=shdh1mctOXgtZgldKYojjMTeK+
	cqsRFkZgZK5W8XnwVaJNHFAPx+O3hhTuP/NF3L/okhxaat/zxsh3SXvZCAJ87RTfxeJJytTqNGDFU
	BZSkxnZL+6pDf51PYmxQwu2px6Vcsh5g8GBa6LG9L3AEtMqtQ7de4bRlJ7VtYvTIPHENzF6ntqHJj
	cvyGXxWuDYHaVWsjKVnAD4iPiBvQRDyrpAHWymDEhkDV4UFEho6xsqXVyxs9UPSF2nJ584JQVDqXa
	Q6GlIBYt0hrQQWEglDTqYwUEWu6C6GLn1hnHMhnayVR3689FfUv41Wo1fLzgNNAWIB1Ac1ZCZ7iCx
	X0Ac0RCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkri-009dPh-KT; Fri, 10 Jun 2022 20:04:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzkrf-009dOW-DD
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:04:16 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AHiAgg023617
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:04:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7uKXzg/OPyXABdABOidNCjnrvjXhXTUMSABSngag/3w=;
 b=SFVIqev8kpSEzX+JXUynTupOi/zwkrLNaKrcB9F30a3AYKQzM/Ds++cj4AS3OrpQg3Hp
 /ACIj9D+NMmAz4ZyyMJoEHIDgHs/yI4KAs2YsCltn9asi+dm8F2YNbOpUnyzfcbO32eS
 z7oVTKbTuXcxyhC9kdnfW4fQ0eW9sC4ClkE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmam8rwd3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:04:13 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:04:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 364FA4E9D6AB; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 10/11] block: relax direct io memory alignment
Date: Fri, 10 Jun 2022 12:58:29 -0700
Message-ID: <20220610195830.3574005-11-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TftZWsbd7PvJ7tG1J01DfU63OHQOQRe-
X-Proofpoint-ORIG-GUID: TftZWsbd7PvJ7tG1J01DfU63OHQOQRe-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_130415_601852_59ED3D65 
X-CRM114-Status: GOOD (  21.53  )
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

Use the address alignment requirements from the block_device for direct
io instead of requiring addresses be aligned to the block size. User
space can discover the alignment requirements from the dma_alignment
queue attribute.

User space can specify any hardware compatible DMA offset for each
segment, but every segment length is still required to be a multiple of
the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c            | 9 +++++++++
 block/fops.c           | 4 ++--
 include/linux/blkdev.h | 5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5618c6a4b3a3..551f1d12208b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1220,7 +1220,16 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
=20
+	/*
+	 * Each segment in the iov is required to be a block size multiple.
+	 * However, we may not be able to get the entire segment if it spans
+	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
+	 * result to ensure the bio's total size is correct. The remainder of
+	 * the iov data will be picked up in the next bio iteration.
+	 */
 	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (size > 0)
+		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
diff --git a/block/fops.c b/block/fops.c
index 9d32df6fc315..86d3cab9bf93 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -45,8 +45,8 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb=
)
 static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 			      struct iov_iter *iter)
 {
-	return ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1));
+	return pos & (bdev_logical_block_size(bdev) - 1) ||
+		!bdev_iter_is_aligned(bdev, iter);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fb5c177708d5..914c613d81da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -425,6 +425,11 @@ struct request_queue {
 	unsigned long		nr_requests;	/* Max # of requests */
=20
 	unsigned int		dma_pad_mask;
+	/*
+	 * Drivers that set dma_alignment to less than 511 must be prepared to
+	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
+	 * due to possible offsets.
+	 */
 	unsigned int		dma_alignment;
=20
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
--=20
2.30.2


