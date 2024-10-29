Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC52D3A67B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+220GbndM91TZYcbQfyaQ2xjcCIjE+33z1HUaPt3Dds=; b=RshP6pLGdh26zcelYhlLEzjm7S
	jEE+aceAKATNWV12q1nM+E+z2QApyFXCiN2JyPcJ0N6CyUVfbhniL3hQDKbrxodnOnd+Whs5iZF1C
	YZIJYz+BlhBQYf9q1nS55v8j0FsCC5cwiFLATmfhTa9GZaqzMXr+CCfXEp96A+4xFR3UtOtbCO5X0
	kUWvXGeD8G0wLm1c3ix7vEUYdoEZnHyofxwCtArDjnzUql+C0qrjzgSZZ/4I/zjgDQ3QirzRne0O2
	9WYEaQbFMAPOmiJEK9TRWe/9Vj/+z2fjS+HYeojWyqkDmBq0RYGmkt9yLqRvP0h8vLNuuKPRKsGPS
	vUEHD6iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qPt-0000000FOmY-1X2T;
	Tue, 29 Oct 2024 17:54:05 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pwZ-0000000FEro-29wL
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:23:49 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241029172343epoutp04b3c59450af95839c59f2d791ec7b4d58~C-E8wAYJT1007310073epoutp04Q
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 17:23:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241029172343epoutp04b3c59450af95839c59f2d791ec7b4d58~C-E8wAYJT1007310073epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730222623;
	bh=+220GbndM91TZYcbQfyaQ2xjcCIjE+33z1HUaPt3Dds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOs4atmhqd5v382daYzvzieGknR1UAIWX3ZHpwD3EPJja8vOYp4PPSgWgigVIQ0GS
	 igTleh15FUWDaVHt8eIQ3SLMpUxllTC4QPW2gl3bMMMNH9odn7Xlxwrntn0gnhYOCY
	 U3mcdoFI1rPJRtZ63euNgQ+jjLUOG9MN2UCV61F0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241029172343epcas5p1cc4d4e88a21d0042c881a223a4344724~C-E8MSMcJ0899208992epcas5p1E;
	Tue, 29 Oct 2024 17:23:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XdHCx5MVVz4x9Pt; Tue, 29 Oct
	2024 17:23:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.F9.09420.D1A11276; Wed, 30 Oct 2024 02:23:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241029163217epcas5p414d493b7a89c6bd092afd28c4eeea24c~C_YCON41I1629316293epcas5p4x;
	Tue, 29 Oct 2024 16:32:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029163217epsmtrp14680812d561cbd9f9c6bf89fd9b026a5~C_YCNJO9g0723107231epsmtrp1j;
	Tue, 29 Oct 2024 16:32:17 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-5e-67211a1d41d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.4B.07371.11E01276; Wed, 30 Oct 2024 01:32:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163214epsmtip21df614ea02497a6fcd82039dc37de744~C_X-xd3zu0975909759epsmtip2W;
	Tue, 29 Oct 2024 16:32:14 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v5 03/10] block: modify bio_integrity_map_user to accept
 iov_iter as argument
Date: Tue, 29 Oct 2024 21:53:55 +0530
Message-Id: <20241029162402.21400-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029162402.21400-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmhq6slGK6wYpnKhYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJouj/9+yWUw6dI3RYu8tbYs9
	e0+yWMxf9pTdovv6DjaL5cf/MVmc/3uc1eL8rDnsDkIeO2fdZfe4fLbUY9OqTjaPzUvqPXbf
	bGDz+Pj0FotH35ZVjB5nFhxh9/i8Sc5j05O3TAFcUdk2GamJKalFCql5yfkpmXnptkrewfHO
	8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA/KSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
	lVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM35enMhY0CdXcfmcaANjr2QXIyeHhICJ
	RMf6l0xdjFwcQgK7GSU+7/nCDOF8YpTYva2dHcL5xihx5+UrRpiW7/dfMkIk9jJK3Hs/jQ3C
	+cwoMWneI1aQKjYBdYkjz1vBqkQE9jBK9C48zQLiMAtMYJJonziHHaRKWCBeoml9A1A7BweL
	gKrE5heeIGFeAUuJKf23odbJS8y89B2snFPASuLY0T1MEDWCEidnPmEBsZmBapq3zgY7XELg
	CofE7Je3mUFmSgi4SNzaJQcxR1ji1fEt7BC2lMTL/jYoO13ix+WnTBB2gUTzsX1Qe+0lWk/1
	g41hFtCUWL9LHyIsKzH11DomiLV8Er2/n0C18krsmAdjK0m0r5wDZUtI7D3XAGV7SBzavI4F
	Eli9jBI//p5jnsCoMAvJO7OQvDMLYfUCRuZVjJKpBcW56anFpgWGeanl8FhOzs/dxAhO51qe
	OxjvPvigd4iRiYPxEKMEB7OSCO/qWNl0Id6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwlmpwPzCh5
	JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwqc8UK9sj0/Ip9uOJ
	jZOacyvvPrmYesr4lOteh3T7Ka/Wvvt/7bl2yIN/kg+d+dY6OLC3azYcvvhL5GBVvFutgN7m
	lDNP9zYcZn/Gvm3ph+g3oTyhz/fHnVuVeOqTifndfZN+rfO5orKh8Yv2vpkdiz6lqD352+X5
	ev5167DsiZxlCYvLc1ilN35mCe11D0g4xdPAJRq++cV9Ho6ep+GzVGvOzZI6G+ZS+fPEdif7
	7JSMJdy9PpO2iDZ+Cd8n8+RYXNnV8icNX30W+0XZ8KWF8d6UP6mxq3BS2Ndj6YGaB+zN9OP6
	j1y7/mvZGuNF7//YfDi88lWzL/urM1YL30auLFWPfLC++U71udN+z9Z+P6XEUpyRaKjFXFSc
	CACxVfElcAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK4gn2K6QWuzgMXHr79ZLJom/GW2
	mLNqG6PF6rv9bBavD39itLh5YCeTxcrVR5ks3rWeY7GYPb2ZyeLo/7dsFpMOXWO02HtL22LP
	3pMsFvOXPWW36L6+g81i+fF/TBbn/x5ntTg/aw67g5DHzll32T0uny312LSqk81j85J6j903
	G9g8Pj69xeLRt2UVo8eZBUfYPT5vkvPY9OQtUwBXFJdNSmpOZllqkb5dAlfGz4sTGQv65Cou
	nxNtYOyV7GLk5JAQMJH4fv8lYxcjF4eQwG5Gia4D61kgEhISp14uY4SwhSVW/nvODlH0kVHi
	z5JVYEVsAuoSR563ghWJCJxglJg/0Q2kiFlgBpNEz68VbCAJYYFYibsb24FsDg4WAVWJzS88
	QcK8ApYSU/pvQy2Ql5h56Ts7iM0pYCVx7OgeJpByIaCak5PcIMoFJU7OfAK2lhmovHnrbOYJ
	jAKzkKRmIUktYGRaxSiZWlCcm56bbFhgmJdarlecmFtcmpeul5yfu4kRHG1aGjsY783/p3eI
	kYmD8RCjBAezkgjv6ljZdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hjNmpwgJpCeWpGanphak
	FsFkmTg4pRqYqqvSOyyPrjTl4lffb2z2y2wGS15phOfsSefF9Yt4/5e4tXPEyUvfscmx+r5J
	q6MytYWxIkUsXWXJ9VO7nkjfi5rd/EHVszcpo1JrX/TE1E0SYRMXSxx5VfUt9v5qmdfH2d03
	7WB0bIx+fCmwpjz0l3v672WBGl7zF/H8qpyTcjV25cyWm7e80lW2Fs652vz8RYilUM58CYcG
	3/bXd3OOi1w9J3Xwfkbe7fdcfy7KaOWkF5SLqSglG+9UV/F/N02Bt7kvZV+CjtWPcwtefeH7
	untTq0iVW+PsCsUveTOdvyUqyOQvTuLQ76vlVfhelblxA8cZ/afXOTkYzR9a9GpuPqvY3280
	uer3xKue2UosxRmJhlrMRcWJAPnP/wIlAwAA
X-CMS-MailID: 20241029163217epcas5p414d493b7a89c6bd092afd28c4eeea24c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163217epcas5p414d493b7a89c6bd092afd28c4eeea24c
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163217epcas5p414d493b7a89c6bd092afd28c4eeea24c@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_102347_926611_1D8F90BB 
X-CRM114-Status: GOOD (  18.21  )
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


