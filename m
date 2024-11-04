Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23610D132DF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r23oSTZl50mKsH838ytL5lDlNxkmkMYy4oR7U1Ruz2Y=; b=yuZ55UlOD4+GooV4/o8SRaYxgq
	T6IQUiCgPLz+47or+EMCrU8YmlfJyZpaTK5NBC9B62o9s6LnRoAmbx+RnEXFk4C/50sQpJQrVy4SL
	YGZH29C8RyZru868u1h9123xLL92RGKqu6id6vzPlakkze9YR09vGavErl3oAqD1GQ5WimltnbMNG
	zufqtRdn5DrFVcKMEsXsocyJ0P3AzAythiF+AUvkbJMHo0rRtbasSRzHW2uS5iWl87arUvLBsE3CC
	0YE1TAEHw0WrRd7WtiyWnV3gGXsnwebKv3hs6yeyg96gdJNdKvRVaacJoTSN6CDsep4Q5461j9Nw/
	1KI9lqKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zR5-0000000EHGA-3Tf4;
	Mon, 04 Nov 2024 15:56:11 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zR2-0000000EHDI-1B2j
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 15:56:10 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241104155606epoutp0142e74cb6babc53962ffde5c077eaa5a5~EzwJlbNvE2173421734epoutp01H
	for <linux-nvme@lists.infradead.org>; Mon,  4 Nov 2024 15:56:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241104155606epoutp0142e74cb6babc53962ffde5c077eaa5a5~EzwJlbNvE2173421734epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730735766;
	bh=r23oSTZl50mKsH838ytL5lDlNxkmkMYy4oR7U1Ruz2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5UeKt+n9U8j0YcqSPfsgDIcgLqNzlEAGF4Qr8Os9zZYfpOLgT1lgWtDdsFgJtEHR
	 IySa4kd0JVEmslMcLPUpsRgJzhx/wQLJKCc1lfNz4xnwF+Gw/Q7YE1j+/7SQ3hMndj
	 BSIhXKikyHjiyvH/XhSAs4ucf8Wy4wYczOUjmLtk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241104155604epcas5p4c21eaecfaa8f69190416b3fb19f1d91f~EzwIQoJap2760427604epcas5p48;
	Mon,  4 Nov 2024 15:56:04 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xhx026HR4z4x9Pq; Mon,  4 Nov
	2024 15:56:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.00.37975.29EE8276; Tue,  5 Nov 2024 00:56:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141451epcas5p2aef1f93e905c27e34b3e16d89ff39245~EyXv5ExsS3053330533epcas5p2u;
	Mon,  4 Nov 2024 14:14:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241104141451epsmtrp25c9b792302190365df06d7cec0992b5f~EyXv3ptok1987019870epsmtrp21;
	Mon,  4 Nov 2024 14:14:51 +0000 (GMT)
X-AuditID: b6c32a50-085ff70000049457-b3-6728ee92a152
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.DC.18937.AD6D8276; Mon,  4 Nov 2024 23:14:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141448epsmtip2dd27c5d88448694207610d66d3844aea~EyXtZsX3L3011330113epsmtip2j;
	Mon,  4 Nov 2024 14:14:48 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v7 03/10] block: modify bio_integrity_map_user to accept
 iov_iter as argument
Date: Mon,  4 Nov 2024 19:35:54 +0530
Message-Id: <20241104140601.12239-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104140601.12239-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmuu6kdxrpBrMO6Vh8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSyO/n/LZjHp0DVGi723tC32
	7D3JYjF/2VN2i+7rO9gslh//x2Rx/u9xVovzs+awOwh57Jx1l93j8tlSj02rOtk8Ni+p99h9
	s4HN4+PTWywefVtWMXqcWXCE3ePzJjmPTU/eMgVwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7
	x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gD9pKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
	VUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIznj64jNTwR65it2XPRoYt0l2MXJySAiY
	SPxY3sHexcjFISSwh1Gi+dZWFgjnE6PEvtbDTHDOiX2TGWFaNty+wQRiCwnsZJSYdy4Gougz
	o0TvvcUsIAk2AXWJI89bGUESIiBzexeeBpvLLDCBSaJ94hx2kCphgXiJtiVTwcayCKhKXPnd
	BmRzcPAKWEp8PBMCsU1eYual72DlnAJWEnP+3gVbwCsgKHFy5hMwmxmopnnrbGaQ+RICVzgk
	fq76zgbR7CKxufc6E4QtLPHq+BZ2CFtK4vO7vVA16RI/Lj+FqimQaD62D+pNe4nWU/3MIPcw
	C2hKrN+lDxGWlZh6ah0TxF4+id7fT6BaeSV2zIOxlSTaV86BsiUk9p5rgLI9JCZOWcMGCa1e
	RolTt+6yTmBUmIXkn1lI/pmFsHoBI/MqRqnUguLc9NRk0wJD3bzUcng0J+fnbmIEJ3StgB2M
	qzf81TvEyMTBeIhRgoNZSYR3Xqp6uhBvSmJlVWpRfnxRaU5q8SFGU2CAT2SWEk3OB+aUvJJ4
	QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamGQ1OX9YXepxvX2PRWeT
	c+q/NiceLpeXK3X35B06/nPblaMvqs87bT76c9+hOTeuR5T8Ymza6X/h6N3sGp5EWa3SCSFm
	bx/m5j+6WxdYMmHe37eRbx6/UzcVc2zMPbkm6hRn2buoP9pcYiWRKl/a5Bm555fMiVDYp3n4
	Z/W24OvSFZJdsU9vFL5SDPKx+rA12OjZz8Umpj4Slc+OsAcfeJsZG72+tcUkbsXstzcVy2s2
	Mr2e2/O/5uaOkM4r9xQcEuZyGkY98pGTPLKwdwfDlhV+1Z1y/O4/UosKG2bUTl6x45XTcq2w
	1qt3d5e1KOiELun/wqJXY9388GHGw/Kpil2111iNWNKrjXb1xqj2KrEUZyQaajEXFScCAHbM
	ySlxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXvfWNY10g8t3rSw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBZH/79ls5h06Bqjxd5b2hZ7
	9p5ksZi/7Cm7Rff1HWwWy4//Y7I4//c4q8X5WXPYHYQ8ds66y+5x+Wypx6ZVnWwem5fUe+y+
	2cDm8fHpLRaPvi2rGD3OLDjC7vF5k5zHpidvmQK4orhsUlJzMstSi/TtErgynr74zFSwR65i
	92WPBsZtkl2MnBwSAiYSG27fYOpi5OIQEtjOKHHv+gsWiISExKmXyxghbGGJlf+es0MUfWSU
	WLL7BFiCTUBd4sjzVjBbROAEo8T8iW4gRcwCM5gken6tYANJCAvESlz5+hOsiEVAVeLK7zYg
	m4ODV8BS4uOZEIgF8hIzL31nB7E5Bawk5vy9C3aEEFDJpqZLYDavgKDEyZlPwGxmoPrmrbOZ
	JzAKzEKSmoUktYCRaRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcJxpBe1gXLb+r94hRiYO
	xkOMEhzMSiK881LV04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFk
	mTg4pRqYKj9sufAl1nF2pvSMbRPOCMnm9rn+VEz0fXuweqWf1/tH4j8DVqfM2SHarDrt+G2t
	tokmPH6PVTea7N7780bdvuZNDTKmQTOmKuyZ8cRe9aqYYeI7Fq4PWRGtXcZcIdzbTNQXrH2a
	/573wt1zX+/YbxVfus7IqfCfRNzEb9GpG5ynOZkenad3OvzzOaOGnGjmm/qyO2+4zktf75Rz
	sDzMfdfj+A8VN+z1rniWVjCeFLj3IqY015XJQFL/neT1/VwmCv/KyuXXvtnoc+yzwWavyJXt
	n59KKTzmbJnINfHGVlGOw/XzgpQ3TEie+GHWJ7XL/XXKYTfllwtxHZy5dhKvzYvdvxzl09+d
	+J3s8uH8TSWW4oxEQy3mouJEABdlUiQiAwAA
X-CMS-MailID: 20241104141451epcas5p2aef1f93e905c27e34b3e16d89ff39245
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104141451epcas5p2aef1f93e905c27e34b3e16d89ff39245
References: <20241104140601.12239-1-anuj20.g@samsung.com>
	<CGME20241104141451epcas5p2aef1f93e905c27e34b3e16d89ff39245@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_075608_838801_5435417E 
X-CRM114-Status: GOOD (  21.34  )
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

This patch refactors bio_integrity_map_user to accept iov_iter as
argument. This is a prep patch.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 12 +++++-------
 block/blk-integrity.c         | 10 +++++++++-
 include/linux/bio-integrity.h |  5 ++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4341b0d4efa1..f56d01cec689 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -302,16 +302,15 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 	return nr_bvecs;
 }
 
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes)
+int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	unsigned int align = blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages = stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec = stack_vec;
+	size_t offset, bytes = iter->count;
 	unsigned int direction, nr_bvecs;
-	struct iov_iter iter;
 	int ret, nr_vecs;
-	size_t offset;
 	bool copy;
 
 	if (bio_integrity(bio))
@@ -324,8 +323,7 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes)
 	else
 		direction = ITER_SOURCE;
 
-	iov_iter_ubuf(&iter, direction, ubuf, bytes);
-	nr_vecs = iov_iter_npages(&iter, BIO_MAX_VECS + 1);
+	nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS + 1);
 	if (nr_vecs > BIO_MAX_VECS)
 		return -E2BIG;
 	if (nr_vecs > UIO_FASTIOV) {
@@ -335,8 +333,8 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes)
 		pages = NULL;
 	}
 
-	copy = !iov_iter_is_aligned(&iter, align, align);
-	ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);
+	copy = !iov_iter_is_aligned(iter, align, align);
+	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
 
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index b180cac61a9d..4a29754f1bc2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -115,8 +115,16 @@ EXPORT_SYMBOL(blk_rq_map_integrity_sg);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes)
 {
-	int ret = bio_integrity_map_user(rq->bio, ubuf, bytes);
+	int ret;
+	struct iov_iter iter;
+	unsigned int direction;
 
+	if (op_is_write(req_op(rq)))
+		direction = ITER_DEST;
+	else
+		direction = ITER_SOURCE;
+	iov_iter_ubuf(&iter, direction, ubuf, bytes);
+	ret = bio_integrity_map_user(rq->bio, &iter);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 0f0cf10222e8..58ff9988433a 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -75,7 +75,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 		unsigned int nr);
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 		unsigned int offset);
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len);
+int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter);
 void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
@@ -101,8 +101,7 @@ static inline void bioset_integrity_free(struct bio_set *bs)
 {
 }
 
-static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
-					 ssize_t len)
+static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	return -EINVAL;
 }
-- 
2.25.1


