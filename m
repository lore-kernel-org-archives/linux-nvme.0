Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C30AD44D79
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQsh5MEv2xvuMdMfRC5hx+1fVZ+6hqXmEyHQLubiY3A=; b=aJli8NNhVdYCxbwh7UQgpaefMQ
	s1+tIDM79QfY7Kis/tHJ826ysCeM5DpL0c1nxA7eelx996V1pAKDpWDPFKPNbpQOmk2mzJ0hTF1r3
	MPCl91Q3Ykgv/x051HTVFBzK7WXvOfKlASAWzWFJwVSKqVU3soI+x3iPziQP2m72hoco25LA1qXTD
	M0HPUG++EA05XumEjBuEz+ZtCEacS59ezGfO9kg/V0r2nFzVjEvPzMGCpf7sLjOGH7KNkvsmAFb1A
	EaVUC5ZC/koff4m75gBWE0CalofF5+myQTNT7yVEVChjHB3ESMntuzXJUKlMaFU9V8nsCzDSmDoVP
	f3NKjfDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h6L-00000003e0d-3Zw8;
	Wed, 06 Nov 2024 14:33:41 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8h2a-00000003cIV-20jw
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 14:29:50 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241106142946epoutp04bb52a6c83922ff1a496698bac04755ce~FZ3WiVS3Q1059910599epoutp04D
	for <linux-nvme@lists.infradead.org>; Wed,  6 Nov 2024 14:29:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241106142946epoutp04bb52a6c83922ff1a496698bac04755ce~FZ3WiVS3Q1059910599epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730903386;
	bh=wQsh5MEv2xvuMdMfRC5hx+1fVZ+6hqXmEyHQLubiY3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8KgZ9Qsq6feXaF7qxnAd3ZCDRMympaaZ/iZZFZtpNEs1K8irKt4x9kNp7IsiQ164
	 XioTRCJ29pNvcFjOWmkTxiSlXTdaqQaPHmX8pEpKg0nA/DHpBrR58B8dXlb0lUEFLQ
	 9piy2KrNXEgXtidv5Dy62+/m21RKZVOjSey/X6sQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241106142945epcas5p27b22bc354b85cff6c487990cf84f314e~FZ3V1wriO1484514845epcas5p2L;
	Wed,  6 Nov 2024 14:29:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xk6zX2Kfvz4x9Pv; Wed,  6 Nov
	2024 14:29:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.E2.09800.85D7B276; Wed,  6 Nov 2024 23:29:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241106122721epcas5p3849e3582fcb6547be2b1b10b031138d4~FYMdpOSTa1876718767epcas5p3z;
	Wed,  6 Nov 2024 12:27:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241106122721epsmtrp1bdd1f5a15dcf3734ec183b4cc1275f08~FYMdnuyhZ2054020540epsmtrp1T;
	Wed,  6 Nov 2024 12:27:21 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-7e-672b7d58f2f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.01.35203.9A06B276; Wed,  6 Nov 2024 21:27:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241106122718epsmtip1f4f0cccb196ed013747170516d7b45df~FYMbJ800Q0829608296epsmtip1F;
	Wed,  6 Nov 2024 12:27:18 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, Anuj
	Gupta <anuj20.g@samsung.com>
Subject: [PATCH v8 10/10] block: add support to pass user meta buffer
Date: Wed,  6 Nov 2024 17:48:42 +0530
Message-Id: <20241106121842.5004-11-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106121842.5004-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O+fQ62oORbdvDczuZLoAgbbQ1lPHbRsuJ8FEkv1RtgQLPSmM
	0na9zEE0a0TQ4SoMQbQi1MkUqs7Bym1Q4xBoQC4bbEi97CbIxKEiY+qaylpaNv897/s+z/Pm
	+S4slP8zQ8DK15pog1apIRgcrP1KdHTcjr2xavGls2vJhSUvRu6r9KFknaMdkOduVTDIe1ce
	AdJzuQshm8/1I+T90lGMPFFbgpD9y/MMsqp3EpCu67Fkj2sQIxvOzDDJQ9c6GeRZ9zOEHPO5
	w8gxWx0zjU912W4xqYkRM9Xq+JRBfdP4CdXtsTCohZnrGHXY6QDUsL2PSS22vkK1Ts8jmZys
	gqQ8WqmiDUJam6tT5WvVyUTGu9lvZ8vkYkmcREFuJoRaZSGdTKRvy4x7J1/jz0QIP1JqzP5W
	ptJoJEQpSQad2UQL83RGUzJB61UavVQfb1QWGs1adbyWNm2RiMUJMj9xV0HeQNsvQH9I8fG1
	iWZgAd/HlwM2C+JSeH5wjFkOOCw+3g2gfXYpLFg8AnDCdzE0+RvAG47LyKrEu9+LBAcuACc7
	/gwViwBedU6tsBj467BvthQEBuvwHgCtp65igQLFKxFor3WiAVYEvhVOWuuxAMbwjbDl/rRf
	wWLxcAV8UMIMrtsAj48/XsFsf3tksR0EMA8Ph4PHp1ekqJ9T0nYCDfhD/CYLjtvtKz4QT4dH
	uzODPhFwzu0MeQrg3YqyEFbDJxMzoWh6WDJwCQRxKiwdqkADNigeDS9+Kwq2o2DN0FdIcO1a
	aPVOh6Q82Fm/igl4oLkuhCF0jVpCmIItz6qx4GF9BqDLOoVUAqHtuTi25+LY/l9tB6gDvEzr
	jYVq2ijTJ2rp3f9dc66usBWsPPSYjE7w+68P43sBwgK9ALJQYh1ve1asms9TKYuKaYMu22DW
	0MZeIPMf9+eoYH2uzv9TtKZsiVQhlsrlcqkiUS4hXuLdKz2p4uNqpYkuoGk9bVjVISy2wIK4
	jwi2nvRxl5e3DMjWi7kJOZFzPyCGXJugxdOwOWXhdocNd4saI97fkWtOS22rjEkZlj4pmTdV
	l+0UCedaNsx1NaQn981bR+Tb+qeLtbtq65cuyM6/Ov6dew3bEj5k6XC8UJTYy1aNJvy4pqw6
	h3eq4CHoThXd4C6hvtNRjPf2v9E9eLAtv2g2z/MbV9QklKWmvWmpOPh13Z3wxeap8tP7nOV1
	j61ZNTc3fVBpq/miqW03J4M7jIXtKf7y2B9H0eq7rx3AZ6oEnEhFXIHbt/dFh7yxZ6GJeWfP
	TvbTM3/dbt7kiUro+Ccn3hXpcyZ1XjicVPWgjCv3lvYfeTry01v9sg8JzJinlMSgBqPyX8jA
	fZRxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO7KBO10g40H+Sw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBZH/79ls5h06Bqjxd5b2hZ7
	9p5ksZi/7Cm7Rff1HWwWy4//Y7I4//c4q8X5WXPYHYQ8ds66y+5x+Wypx6ZVnWwem5fUe+y+
	2cDm8fHpLRaPvi2rGD3OLDjC7vF5k5zHpidvmQK4orhsUlJzMstSi/TtErgyjm29z1jQbVlx
	/fJKxgbGC3pdjJwcEgImEr9bfjN1MXJxCAnsZpR43HeaGSIhIXHq5TJGCFtYYuW/5+wgtpDA
	R0aJhwfDQWw2AXWJI89bwWpEBE4wSsyf6AYyiFlgBpPE7z8LWEASwgKuEtd654HZLAKqEhvf
	PQFq4ODgFbCUeN/MDjFfXmLmpe9gNidQ+OznbYwQuywk/izoA7uHV0BQ4uTMJ2BjmIHqm7fO
	Zp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB8aaluYNx+6oP
	eocYmTgYDzFKcDArifD6R2mnC/GmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliSmp2a
	WpBaBJNl4uCUamDKuPD/xKHcKp9tF/xzJjmfbKxJinljlVP7m/1vWeW/CJeHkcXbs+4+fW+4
	4vbtpXsKlk96pBdX8bvE/q2WjrzqwwnVtvujFPvLUnhX/FvW6qQW2PDqE+vNzufvXqRmZe8P
	27U/tz39/nSHL0JMb1/WNss+msr88emTmS3yGlO+rzw4gc/x0KytDAuPrFx25O73aRGT3Dv0
	P52Kdtn0oF/ATaqX5VXHubX/WB+Xc3tGM2rnrDpn+nj+zaoCwayH23hckuc1O6f8ad3r6533
	Mrr5ieL7dX8471sl1LW3T+b3zDmzQluCoecv80HO22tPFspESBsEMEi1uZUuP8L+49Us3X12
	4m2sm39y3wnV3/tDiaU4I9FQi7moOBEAz/uG0iYDAAA=
X-CMS-MailID: 20241106122721epcas5p3849e3582fcb6547be2b1b10b031138d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106122721epcas5p3849e3582fcb6547be2b1b10b031138d4
References: <20241106121842.5004-1-anuj20.g@samsung.com>
	<CGME20241106122721epcas5p3849e3582fcb6547be2b1b10b031138d4@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_062948_932917_34D7BC63 
X-CRM114-Status: GOOD (  24.71  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

If an iocb contains metadata, extract that and prepare the bip.
Based on flags specified by the user, set corresponding guard/app/ref
tags to be checked in bip.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 50 +++++++++++++++++++++++++++++++++++
 block/fops.c                  | 45 ++++++++++++++++++++++++-------
 include/linux/bio-integrity.h |  7 +++++
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3bee43b87001..5d81ad9a3d20 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -364,6 +364,55 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	return ret;
 }
 
+static void bio_uio_meta_to_bip(struct bio *bio, struct uio_meta *meta)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	if (meta->flags & IO_INTEGRITY_CHK_GUARD)
+		bip->bip_flags |= BIP_CHECK_GUARD;
+	if (meta->flags & IO_INTEGRITY_CHK_APPTAG)
+		bip->bip_flags |= BIP_CHECK_APPTAG;
+	if (meta->flags & IO_INTEGRITY_CHK_REFTAG)
+		bip->bip_flags |= BIP_CHECK_REFTAG;
+
+	bip->app_tag = meta->app_tag;
+}
+
+int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	unsigned int integrity_bytes;
+	int ret;
+	struct iov_iter it;
+
+	if (!bi)
+		return -EINVAL;
+	/*
+	 * original meta iterator can be bigger.
+	 * process integrity info corresponding to current data buffer only.
+	 */
+	it = meta->iter;
+	integrity_bytes = bio_integrity_bytes(bi, bio_sectors(bio));
+	if (it.count < integrity_bytes)
+		return -EINVAL;
+
+	/* should fit into two bytes */
+	BUILD_BUG_ON(IO_INTEGRITY_VALID_FLAGS >= (1 << 16));
+
+	if (meta->flags && (meta->flags & ~IO_INTEGRITY_VALID_FLAGS))
+		return -EINVAL;
+
+	it.count = integrity_bytes;
+	ret = bio_integrity_map_user(bio, &it);
+	if (!ret) {
+		bio_uio_meta_to_bip(bio, meta);
+		bip_set_seed(bio_integrity(bio), meta->seed);
+		iov_iter_advance(&meta->iter, integrity_bytes);
+		meta->seed += bio_integrity_intervals(bi, bio_sectors(bio));
+	}
+	return ret;
+}
+
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
  * @bio:	bio to prepare
@@ -564,6 +613,7 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 	bip->bip_vec = bip_src->bip_vec;
 	bip->bip_iter = bip_src->bip_iter;
 	bip->bip_flags = bip_src->bip_flags & BIP_CLONE_FLAGS;
+	bip->app_tag = bip_src->app_tag;
 
 	return 0;
 }
diff --git a/block/fops.c b/block/fops.c
index 2d01c9007681..412ae74032ad 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -54,6 +54,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	struct bio bio;
 	ssize_t ret;
 
+	WARN_ON_ONCE(iocb->ki_flags & IOCB_HAS_METADATA);
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
@@ -124,12 +125,16 @@ static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
 	bool should_dirty = dio->flags & DIO_SHOULD_DIRTY;
+	bool is_sync = dio->flags & DIO_IS_SYNC;
 
 	if (bio->bi_status && !dio->bio.bi_status)
 		dio->bio.bi_status = bio->bi_status;
 
+	if (!is_sync && (dio->iocb->ki_flags & IOCB_HAS_METADATA))
+		bio_integrity_unmap_user(bio);
+
 	if (atomic_dec_and_test(&dio->ref)) {
-		if (!(dio->flags & DIO_IS_SYNC)) {
+		if (!is_sync) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
@@ -221,14 +226,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			 * a retry of this from blocking context.
 			 */
 			if (unlikely(iov_iter_count(iter))) {
-				bio_release_pages(bio, false);
-				bio_clear_flag(bio, BIO_REFFED);
-				bio_put(bio);
-				blk_finish_plug(&plug);
-				return -EAGAIN;
+				ret = -EAGAIN;
+				goto fail;
 			}
 			bio->bi_opf |= REQ_NOWAIT;
 		}
+		if (!is_sync && (iocb->ki_flags & IOCB_HAS_METADATA)) {
+			ret = bio_integrity_map_iter(bio, iocb->private);
+			if (unlikely(ret))
+				goto fail;
+		}
 
 		if (is_read) {
 			if (dio->flags & DIO_SHOULD_DIRTY)
@@ -269,6 +276,12 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	bio_put(&dio->bio);
 	return ret;
+fail:
+	bio_release_pages(bio, false);
+	bio_clear_flag(bio, BIO_REFFED);
+	bio_put(bio);
+	blk_finish_plug(&plug);
+	return ret;
 }
 
 static void blkdev_bio_end_io_async(struct bio *bio)
@@ -286,6 +299,9 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
+	if (iocb->ki_flags & IOCB_HAS_METADATA)
+		bio_integrity_unmap_user(bio);
+
 	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
@@ -330,10 +346,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		bio_iov_bvec_set(bio, iter);
 	} else {
 		ret = bio_iov_iter_get_pages(bio, iter);
-		if (unlikely(ret)) {
-			bio_put(bio);
-			return ret;
-		}
+		if (unlikely(ret))
+			goto out_bio_put;
 	}
 	dio->size = bio->bi_iter.bi_size;
 
@@ -346,6 +360,13 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
+	if (iocb->ki_flags & IOCB_HAS_METADATA) {
+		ret = bio_integrity_map_iter(bio, iocb->private);
+		WRITE_ONCE(iocb->private, NULL);
+		if (unlikely(ret))
+			goto out_bio_put;
+	}
+
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio->bi_opf |= REQ_ATOMIC;
 
@@ -360,6 +381,10 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		submit_bio(bio);
 	}
 	return -EIOCBQUEUED;
+
+out_bio_put:
+	bio_put(bio);
+	return ret;
 }
 
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 2195bc06dcde..de0a6c9de4d1 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -23,6 +23,7 @@ struct bio_integrity_payload {
 	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
 	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
 	unsigned short		bip_flags;	/* control flags */
+	u16			app_tag;	/* application tag value */
 
 	struct bvec_iter	bio_iter;	/* for rewinding parent bio */
 
@@ -78,6 +79,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 		unsigned int offset);
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter);
+int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta);
 void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
@@ -108,6 +110,11 @@ static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	return -EINVAL;
 }
 
+static inline int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
+{
+	return -EINVAL;
+}
+
 static inline void bio_integrity_unmap_user(struct bio *bio)
 {
 }
-- 
2.25.1


