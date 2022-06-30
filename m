Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0469FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2PcbPL+ScYos2ta7RiNm7JAwTYF5Vc2xnm+uNmvoKA=; b=gRbOLKQrcq9i+wH97zB0BNIBQf
	bokTZV/NKYnPAtn8QtxXzeKnAeh9cVwNxuuoPGx5L0pUi8rvHgypnb11/tCSIENQe0R7m6uzmMZLL
	n+dhU+OFfAbeEL5pGsXpAa5FBfmb+w9tMIYdLm2PXSqFYWuYD+bncYRIJ9C9XIgB2oPXqP1AhBeKA
	zwq+37wnGRhhcddayfvnnObznTToJ8vHQdE7GmpkTvfBOLNN9e8y3v5AWmePQo5JyPeRpFA60BfSh
	vDWsXwcT/aOuvXlsnHEP/2Hx1xBWfl883yHnJUmDiU0KtLcoaGDyiseQAOxAf5jKL5NEr5rQLs1gD
	U0cM6R2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o710b-001TPe-4C; Thu, 30 Jun 2022 20:43:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o70zy-001T1e-Cm
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:42:52 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UFmZrF032527
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e2PcbPL+ScYos2ta7RiNm7JAwTYF5Vc2xnm+uNmvoKA=;
 b=ocJB/Ql6LAyn7MZlfcT8E5dV2GqgETXN3h9mR6e27lkW7eyyRF4CUEtune2UfV5Us3Ca
 pOIwAx+5Vj/Cy43zSQYfBydfJYJ4LoFgTjZQjwsEVWrJIEtVRh4M251gRb+KJCsF9OCE
 41T9ygtLMFqOAHra6L+FAiyTx/wFmxjhTVA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h12ug6g03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:42:49 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:49 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:49 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C33B15932DBD; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 05/12] block: add bit bucket capabilities
Date: Thu, 30 Jun 2022 13:42:05 -0700
Message-ID: <20220630204212.1265638-6-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: brOxunAFnCYP9SbxwUxPPOCjktF9vKtU
X-Proofpoint-ORIG-GUID: brOxunAFnCYP9SbxwUxPPOCjktF9vKtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134250_524723_277879A8 
X-CRM114-Status: GOOD (  35.28  )
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

Recent storage protocol enhancements allow devices to support partial
sector read access. When used by a host, this can provide link bandwidth
savings and reduce memory utilization. Provide a way for drivers to
indicate support for this capability, and implement the framework to
submit bit-bucket read bio's.

The implementation indicates the unwanted data by using a special page.
The page can be used multiple times within the same bio to designate one
or more unwanted data gaps within the requested sector(s). Drivers that
subscribe to the capability must check for this page and set up their
protocol specific scatter-gather accordingly.

Requests with bit buckets need to be flagged specially for this since
NVMe needs to know before walking the segments if it should construct a
bit bucket SGL instead of a PRP.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               | 29 +++++++++++++++++++++++++++--
 block/blk-core.c          |  5 +++++
 block/blk-merge.c         |  3 ++-
 block/blk-mq.c            |  2 ++
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    | 13 +++++++++++++
 7 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 933ea3210954..b0c85778257a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1208,6 +1208,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
+	unsigned int lbas =3D bdev_logical_block_size(bio->bi_bdev);
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -1226,10 +1227,32 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
 	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
+	 *
+	 * Partial sector reads can break the iov length expecations by
+	 * allowing dma_alignement granularities. The code enforces only 1
+	 * segment in that case, which simplifies the following logic. We don't
+	 * need to consider individual segment lengths since the skip and
+	 * truncate bytes are guaranteed to align the total length to the block
+	 * size.
 	 */
 	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
-	if (size > 0)
-		size =3D ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
+	if (size > 0) {
+		/*
+		 * If size doesn't reach the end with bit buckets, align the
+		 * total size down to the block size to avoid a bit-bucket
+		 * truncation overlapping with the desired read data.
+		 */
+		if (bio_flagged(bio, BIO_BIT_BUCKET)) {
+			if (size !=3D iov_iter_count(iter)) {
+				size_t total_size =3D size + bio->bi_iter.bi_size;
+
+				total_size =3D ALIGN_DOWN(total_size, lbas);
+				size =3D total_size - bio->bi_iter.bi_size;
+			}
+		} else {
+			size =3D ALIGN_DOWN(size, lbas);
+		}
+	}
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
=20
@@ -1602,6 +1625,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
=20
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
+	if (bio_flagged(bio, BIO_BIT_BUCKET))
+		bio_set_flag(split, BIO_BIT_BUCKET);
=20
 	return split;
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index 5ad7bd93077c..d2e9fd42b732 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -73,6 +73,9 @@ struct kmem_cache *blk_requestq_srcu_cachep;
  */
 static struct workqueue_struct *kblockd_workqueue;
=20
+struct page *blk_bb_page;
+EXPORT_SYMBOL_GPL(blk_bb_page);
+
 /**
  * blk_queue_flag_set - atomically set a queue flag
  * @flag: flag to be set
@@ -1228,5 +1231,7 @@ int __init blk_dev_init(void)
=20
 	blk_debugfs_root =3D debugfs_create_dir("block", NULL);
=20
+	blk_bb_page =3D ZERO_PAGE(0);
+
 	return 0;
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0f5f42ebd0bb..65b71114633f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -281,7 +281,8 @@ static struct bio *blk_bio_segment_split(struct reque=
st_queue *q,
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
+		if (!bio_flagged(bio, BIO_BIT_BUCKET) && bvprvp &&
+		    bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
 			goto split;
=20
 		if (nsegs < max_segs &&
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 15c7c5c4ad22..efbe308d7ae5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2425,6 +2425,8 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
=20
 	if (bio->bi_opf & REQ_RAHEAD)
 		rq->cmd_flags |=3D REQ_FAILFAST_MASK;
+	if (bio_flagged(bio, BIO_BIT_BUCKET))
+		rq->rq_flags |=3D RQF_BIT_BUCKET;
=20
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	blk_rq_bio_prep(rq, bio, nr_segs);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 43aad0da3305..05fa0b292223 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -22,6 +22,8 @@ typedef __u32 __bitwise req_flags_t;
=20
 /* drive already may have started this one */
 #define RQF_STARTED		((__force req_flags_t)(1 << 1))
+/* request has bit bucket payload */
+#define RQF_BIT_BUCKET         ((__force req_flags_t)(1 << 2))
 /* may not be passed by ioscheduler */
 #define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
 /* request for flush sequence */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a24d4078fb21..dc981d0232d1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -332,6 +332,7 @@ enum {
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
+	BIO_BIT_BUCKET,		/* contains one or more bit bucket pages */
 	BIO_FLAG_LAST
 };
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9d676adfaaa1..4396fcf04bb8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -44,6 +44,7 @@ struct blk_crypto_profile;
 extern const struct device_type disk_type;
 extern struct device_type part_type;
 extern struct class block_class;
+extern struct page *blk_bb_page;
=20
 /* Must be consistent with blk_mq_poll_stats_bkt() */
 #define BLK_MQ_POLL_STATS_BKTS 16
@@ -580,6 +581,7 @@ struct request_queue {
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active =
*/
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_BIT_BUCKET   31	/* device supports read bit buckets *=
/
=20
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -621,6 +623,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->qu=
eue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flag=
s)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_=
flags)
+#define blk_queue_bb(q)		test_bit(QUEUE_FLAG_BIT_BUCKET, &(q)->queue_fla=
gs)
=20
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
@@ -1566,4 +1569,14 @@ struct io_comp_batch {
=20
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name =3D { }
=20
+static inline void blk_add_bb_page(struct bio *bio, int len)
+{
+	bio_set_flag(bio, BIO_BIT_BUCKET);
+	get_page(blk_bb_page);
+	bio_add_page(bio, blk_bb_page, len, 0);
+}
+static inline bool blk_is_bit_bucket(struct page *page)
+{
+	return page =3D=3D blk_bb_page;
+}
 #endif /* _LINUX_BLKDEV_H */
--=20
2.30.2


