Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755E1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JY9Q1io734OZEFW32MRcSKv+XA5T+i1JJ70usnOjAgA=; b=mi3DDbgoBGGh0NtNEiXJSnbixv
	rujZ8gGXKrY//tP2aZN/VTyzBpzDLflPVDZPx1YFfKJ+prNjvgMYSEnRuiVSimo6u1YsrILO29BDp
	6tkj6424th51sVilxVmwjCkBBE8k3uIEcDiBvOqnjezwOl5TK3rXvFkDc+2Xn07fmadsDuBUL0i6r
	DCOHYkqcRzrGJlXl5G7e1oI+Psmw6XZX+ph5jTISUwj8UG/ayYzaUQWr2Fy1nRqqEV5kgevCi+uvN
	shhGvl9tvwDpr5/b1DZDOE/r0uaaLDc5roJ5CVGlLv3vtTIxj0+W6HQ9cQpDrVFwl764uzVyRQVAy
	v/6b9i+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmHvn-00Bfoq-NH; Wed, 04 May 2022 16:32:51 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmHvZ-00Bfjl-0z
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:32:39 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 244Dvfou001359
 for <linux-nvme@lists.infradead.org>; Wed, 4 May 2022 09:32:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JY9Q1io734OZEFW32MRcSKv+XA5T+i1JJ70usnOjAgA=;
 b=F6Wa5NodkAKZC86Nb6OsJb7vfmV794/G5+dKXdKrJOZpuC8Ey99AprbTQXH3kUW4nohH
 W0CnoXYMFwc25XDkKEhktIKwCwLDHt2qNWFbvbGbuDXIloKrvaVjim5rWJtp5XB7eaCF
 UhqAVktUk4pimGqviUHdxLkLeMBtOFpzEQU= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0089730.ppops.net (PPS) with ESMTPS id 3fuf22c20r-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 09:32:36 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 09:32:33 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
 id BE9D73939685; Wed,  4 May 2022 09:32:22 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@kernel.vger.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 3/4] block: add bit bucket support
Date: Wed, 4 May 2022 09:32:06 -0700
Message-ID: <20220504163207.891761-4-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504163207.891761-1-kbusch@fb.com>
References: <20220504163207.891761-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9HvTvAfroD1JhpLGhgr9PCsNHbgC7YMW
X-Proofpoint-ORIG-GUID: 9HvTvAfroD1JhpLGhgr9PCsNHbgC7YMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_093237_258551_E033A02A 
X-CRM114-Status: GOOD (  30.93  )
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

Bit buckets allow applications to read partial sectors. Add block
support for partial reads if the request_queue supports it.

This implementation designates a special page for bit buckets. Filling
the holes with this special page should let merging operations continue
as normal. Read data should never be sent to this page, and the driver
should instead recognize this special page and set up their scatter
gather accordingly.

The bit_bucket attribute is exported so applications may know if they
can do partial sector reads.

This implementation only works for direct io on raw block devices, and
does not work with pre-registered buffers due to those already coming in
as a bvec.

Requests with bit buckets need to be flagged specially for this since
NVMe needs to know before walking the segments if it should construct a
bitbucket SGL instead of a PRP.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c          |  5 ++++
 block/blk-merge.c         |  3 +-
 block/blk-mq.c            |  2 ++
 block/blk-sysfs.c         |  3 ++
 block/fops.c              | 58 +++++++++++++++++++++++++++++++++------
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    | 13 +++++++++
 8 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 937bb6b86331..a11931857dd9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -74,6 +74,9 @@ struct kmem_cache *blk_requestq_srcu_cachep;
  */
 static struct workqueue_struct *kblockd_workqueue;
=20
+struct page *blk_bb_page;
+EXPORT_SYMBOL_GPL(blk_bb_page);
+
 /**
  * blk_queue_flag_set - atomically set a queue flag
  * @flag: flag to be set
@@ -1309,5 +1312,7 @@ int __init blk_dev_init(void)
=20
 	blk_debugfs_root =3D debugfs_create_dir("block", NULL);
=20
+	blk_bb_page =3D ZERO_PAGE(0);
+
 	return 0;
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..3fde24bf97f3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -278,7 +278,8 @@ static struct bio *blk_bio_segment_split(struct reque=
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
index c4370d276170..80309d243a09 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2411,6 +2411,8 @@ static void blk_mq_bio_to_request(struct request *r=
q, struct bio *bio,
=20
 	if (bio->bi_opf & REQ_RAHEAD)
 		rq->cmd_flags |=3D REQ_FAILFAST_MASK;
+	if (bio_flagged(bio, BIO_BIT_BUCKET))
+		rq->rq_flags |=3D RQF_BIT_BUCKET;
=20
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	blk_rq_bio_prep(rq, bio, nr_segs);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 14607565d781..19c385084aea 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -309,6 +309,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+QUEUE_SYSFS_BIT_FNS(bit_bucket, BIT_BUCKET, 0);
 #undef QUEUE_SYSFS_BIT_FNS
=20
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -627,6 +628,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_ENTRY(queue_bit_bucket, "bit_bucket");
=20
 static struct attribute *queue_attrs[] =3D {
 	&queue_requests_entry.attr,
@@ -653,6 +655,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
+	&queue_bit_bucket_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
 	&queue_max_open_zones_entry.attr,
diff --git a/block/fops.c b/block/fops.c
index a6583bce1e7d..36ccd52ece03 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -57,13 +57,21 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb=
 *iocb,
 {
 	struct block_device *bdev =3D iocb->ki_filp->private_data;
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	loff_t pos =3D iocb->ki_pos;
 	bool should_dirty =3D false;
+	u16 skip =3D 0, trunc =3D 0;
 	struct bio bio;
 	ssize_t ret;
=20
-	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	if ((pos | iov_iter_count(iter)) & (blksz - 1)) {
+		if (iov_iter_rw(iter) !=3D READ || iov_iter_is_bvec(iter) ||
+		    !blk_queue_bb(bdev_get_queue(bdev)))
+			return -EINVAL;
+		skip =3D pos & (blksz - 1);
+		trunc =3D blksz - ((pos + iov_iter_count(iter)) & (blksz - 1));
+		nr_pages +=3D !!skip + !!trunc;
+	}
 	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
@@ -80,6 +88,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (iter_is_iovec(iter))
 			should_dirty =3D true;
+		if (skip)
+			blk_add_bb_page(&bio, skip);
 	} else {
 		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
 	}
@@ -91,7 +101,10 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb=
 *iocb,
 	ret =3D bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
-	ret =3D bio.bi_iter.bi_size;
+
+	if (trunc)
+		blk_add_bb_page(&bio, trunc);
+	ret =3D bio.bi_iter.bi_size - trunc - skip;
=20
 	if (iov_iter_rw(iter) =3D=3D WRITE)
 		task_io_account_write(ret);
@@ -186,16 +199,25 @@ static ssize_t __blkdev_direct_IO(struct kiocb *ioc=
b, struct iov_iter *iter,
 		unsigned int nr_pages)
 {
 	struct block_device *bdev =3D iocb->ki_filp->private_data;
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read =3D (iov_iter_rw(iter) =3D=3D READ), is_sync;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos =3D iocb->ki_pos;
+	u16 skip =3D 0, trunc =3D 0, bucket_bytes =3D 0;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	if ((pos | iov_iter_count(iter)) & (blksz - 1)) {
+		if (iov_iter_rw(iter) !=3D READ || iov_iter_is_bvec(iter) ||
+		    !blk_queue_bb(bdev_get_queue(bdev)))
+			return -EINVAL;
+		skip =3D pos & (blksz - 1);
+		trunc =3D blksz - ((pos + iov_iter_count(iter)) & (blksz - 1));
+		bucket_bytes =3D skip + trunc;
+		nr_pages +=3D !!skip + !!trunc;
+	}
 	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
@@ -240,6 +262,10 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb=
, struct iov_iter *iter,
 		if (is_read) {
 			if (dio->flags & DIO_SHOULD_DIRTY)
 				bio_set_pages_dirty(bio);
+			if (skip) {
+				blk_add_bb_page(bio, skip);
+				skip =3D 0;
+			}
 		} else {
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
@@ -251,6 +277,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
=20
 		nr_pages =3D bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
+			if (trunc)
+				blk_add_bb_page(bio, trunc);
 			submit_bio(bio);
 			break;
 		}
@@ -275,7 +303,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 	if (!ret)
 		ret =3D blk_status_to_errno(dio->bio.bi_status);
 	if (likely(!ret))
-		ret =3D dio->size;
+		ret =3D dio->size - bucket_bytes;
=20
 	bio_put(&dio->bio);
 	return ret;
@@ -311,15 +339,23 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
b *iocb,
 					unsigned int nr_pages)
 {
 	struct block_device *bdev =3D iocb->ki_filp->private_data;
+	unsigned int blksz =3D bdev_logical_block_size(bdev);
 	bool is_read =3D iov_iter_rw(iter) =3D=3D READ;
 	unsigned int opf =3D is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos =3D iocb->ki_pos;
+	u16 skip =3D 0, trunc =3D 0;
 	int ret =3D 0;
=20
-	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
+	if ((pos | iov_iter_count(iter)) & (blksz - 1)) {
+		if (iov_iter_rw(iter) !=3D READ || iov_iter_is_bvec(iter) ||
+		    !blk_queue_bb(bdev_get_queue(bdev)))
+			return -EINVAL;
+		skip =3D pos & (blksz - 1);
+		trunc =3D blksz - ((pos + iov_iter_count(iter)) & (blksz - 1));
+		nr_pages +=3D !!skip + !!trunc;
+	}
 	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
 		return -EINVAL;
=20
@@ -340,13 +376,17 @@ static ssize_t __blkdev_direct_IO_async(struct kioc=
b *iocb,
 		 */
 		bio_iov_bvec_set(bio, iter);
 	} else {
+		if (skip)
+			blk_add_bb_page(bio, skip);
 		ret =3D bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
 			bio_put(bio);
 			return ret;
 		}
+		if (trunc)
+			blk_add_bb_page(bio, trunc);
 	}
-	dio->size =3D bio->bi_iter.bi_size;
+	dio->size =3D bio->bi_iter.bi_size - trunc - skip;
=20
 	if (is_read) {
 		if (iter_is_iovec(iter)) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7aa5c54901a9..1a3902c2440f 100644
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
index 1973ef9bd40f..f55e194b72a0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -330,6 +330,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_PERCPU_CACHE,	/* can participate in per-cpu alloc cache */
+	BIO_BIT_BUCKET,		/* contains one or more bit bucket pages */
 	BIO_FLAG_LAST
 };
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dba6d411fc1e..5feaa5e7810e 100644
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
@@ -560,6 +561,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active =
*/
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_BIT_BUCKET   30	/* device supports read bit buckets *=
/
=20
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -605,6 +607,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->qu=
eue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flag=
s)
+#define blk_queue_bb(q)		test_bit(QUEUE_FLAG_BIT_BUCKET, &(q)->queue_fla=
gs)
=20
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
@@ -1588,4 +1591,14 @@ struct io_comp_batch {
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


