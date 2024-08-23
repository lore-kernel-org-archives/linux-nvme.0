Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B987DC531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90CNtiP/2tt+h1YZtONu5flbGM3VvoqfTKHbF+jJYgc=; b=NmPsZEnQMD2sKZmkSpBZssL+DR
	FjWj9cRgMMt6TvA9X/fhaojB97Nj4zExjB8O/+JbEWRz/n+c3N7nFQyysXvQ05IEWchyGnnAqGBhp
	xP7E+McPkd43uQA/8gd56caKvwZrKMJbfHdsWbOBt0iVs3Rd7mP10+jmv4w+77xqrUsRZbRMRvXgQ
	B8T7k7ncndz1F8saVNRYa+zLT4FQM5wJ4KRiUpaMHUQTBO/YWD7YLQ2HVoYm710WEEhWTpAUQswoa
	qX1WMTT9qMP+X4bpeOUynZVyg52jz0OLZQ52eS1BmRo/KzTNzV7ZvA5RjWWlyrWBjLBLRd07kfSAt
	ZANBytuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqR-0000000GOue-3wMd;
	Fri, 23 Aug 2024 10:48:39 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqG-0000000GOhh-2VUR
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 10:48:31 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240823104822epoutp04cc2451cc51b4bfb0ab0443bcd0b63067~uVdoxGJaG1816918169epoutp04l
	for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 10:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240823104822epoutp04cc2451cc51b4bfb0ab0443bcd0b63067~uVdoxGJaG1816918169epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724410102;
	bh=90CNtiP/2tt+h1YZtONu5flbGM3VvoqfTKHbF+jJYgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo6PoFSBTQcxWeMUKqSz/ehb9QfdNy6kBCgD0ptqViCq9ur3uuT7EQWusaXcAnGH5
	 gubWinIl5e6sa9f0KrnBfGv1PG/Az6LuvFgyIOLXs1dJvscdMQ2KT8rGzXbISl9Ydk
	 hmTo0v+Y7ziPDluijlpJ9yX9kOEdQobn8D2Z2qZM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240823104822epcas5p1262f2e00ced25e2a84c26e18f1596f68~uVdodsH0s2850128501epcas5p1a;
	Fri, 23 Aug 2024 10:48:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wqxch6lndz4x9Q0; Fri, 23 Aug
	2024 10:48:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.8F.09743.4F868C66; Fri, 23 Aug 2024 19:48:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104622epcas5p2e3b29f793eff9857c5712b3d6d327ed5~uVb44JoMx1288512885epcas5p2n;
	Fri, 23 Aug 2024 10:46:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240823104622epsmtrp2e09c20224f926e6655aeccf9907e12da~uVb42v-es0122301223epsmtrp2E;
	Fri, 23 Aug 2024 10:46:22 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-7d-66c868f4185f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.50.19367.E7868C66; Fri, 23 Aug 2024 19:46:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104620epsmtip288908594f49a4e4a562d9e488ce2b8d2~uVb213WlK1442714427epsmtip2a;
	Fri, 23 Aug 2024 10:46:20 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v3 04/10] block: modify bio_integrity_map_user to accept
 iov_iter as argument
Date: Fri, 23 Aug 2024 16:08:04 +0530
Message-Id: <20240823103811.2421-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823103811.2421-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmlu6XjBNpBktn61k0TfjLbDFn1TZG
	i9V3+9ksbh7YyWSxcvVRJot3redYLI7+f8tmMenQNUaL7WeWMlvsvaVtMX/ZU3aL7us72CyW
	H//H5MDrsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1Zxeix+XS1x+dNcgGcUdk2
	GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKymUJeaU
	AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMzad
	esFUcEq+YsPlFywNjL1SXYycHBICJhIz+qeydzFycQgJ7GaUWLJ6CROE84lRYs27BWwgVWDO
	jauOMB0//7SzQBTtZJS4Pm8bVPtnRommjkksIFVsAuoSR563MoLYIgKVEs93/QDrYBa4yShx
	aO8zZpCEsEC8xPXuZWBFLAKqEhMvbwdr5hWwkNj6sJMNYp28xMxL39lBbE4BS4mm2Q1QNYIS
	J2c+AbOZgWqat85mBlkgIbCUQ+Jk8xxWiGYXiYW/NjNC2MISr45vYYewpSQ+v9sLtSBd4sfl
	p0wQdoFE87F9UPX2Eq2n+oGGcgAt0JRYv0sfIiwrMfXUOiaIvXwSvb+fQLXySuyYB2MrSbSv
	nANlS0jsPdfABDJGQsBD4v6yIkiI9jBKHDuQPYFRYRaSb2Yh+WYWwuIFjMyrGCVTC4pz01OL
	TQuM8lLL4ZGcnJ+7iRGcjrW8djA+fPBB7xAjEwfjIUYJDmYlEd6ke0fThHhTEiurUovy44tK
	c1KLDzGaAoN7IrOUaHI+MCPklcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTT
	x8TBKdXAZM7Z8UtfP6wtck+XXnf9xh2f3VOaLhjHSjRv1Fvkd7CpecL01LSutNu3Fxppzy5Y
	q3Zj5t5JW2yu/BYUiFVbF8si07SOk+OD+NS/056+kjj1U7v0cN8Hkd07BBNS9614srjdSz2U
	/7nS1n+GG1pXflj2cYXZq+wcw/2qnd2T8r///nesfXG2OLdhk5T0JgcewTWpZQW3otZt+H7e
	jklAbyN7wtxKz/Lf63av3FK7MEGhpdQhzFS5fOYtlvWl6rx+v42+VMf/kF286vPae2KeGpmO
	hzMuPvgd0Hv678zNtgKxe83r57u+iAiS+V/faxBXPGXVk46MWYfl1llcvjBx/0Wp/sUpz0O2
	iNbsLzv3V4mlOCPRUIu5qDgRAPCSqotQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvG5dxok0g/mnNC2aJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jcuD12DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx8ent1g8+rasYvTYfLra4/MmuQDOKC6b
	lNSczLLUIn27BK6MTadeMBWckq/YcPkFSwNjr1QXIyeHhICJxM8/7SxdjFwcQgLbGSUebupg
	gUhISJx6uYwRwhaWWPnvOTtE0UdGiRud59lAEmwC6hJHnrcygiREBBoZJbY0fwHrZha4zyix
	oDsExBYWiJX40tgE1sAioCox8fJ2sBpeAQuJrQ872SA2yEvMvPSdHcTmFLCUaJrdAFYjBFSz
	bPkZRoh6QYmTM59AzZeXaN46m3kCo8AsJKlZSFILGJlWMYqmFhTnpucmFxjqFSfmFpfmpesl
	5+duYgRHi1bQDsZl6//qHWJk4mA8xCjBwawkwpt072iaEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA9M0I/66B5oq26w79mceEJGwXFpX80HfxG1D/5LT
	Ti9XiE+ztA/v7nhw+45Sg/X8fTMkd+z7xG3j3Cqq8PXYx6tP3F88mRwU79Gu48XIniC5jNfv
	nPLjR9KVaYcnzdE/Fhv2ofSy1MN+Xc4FjhnNIZtjuxfIvFwxl7HHZVl33elM/9kN6wPOvkr6
	XGc2SeVU3X2Zc6rlC9Jzt8gueXq+2zn+/Zr+WQfXspev2sDEtPjXSvcY3pOPVdbqvmQ9c2jn
	nG13YywqDzJyfF8nPIlHj/3VNaXCrMIX7k18F51O/e7adtXb4li6sGxIXS/n/cRz7dF3PpRz
	u5vxMVXvmdO0dFnEjU3SVXW7cpjOi0s7+CmxFGckGmoxFxUnAgC0jE+0BQMAAA==
X-CMS-MailID: 20240823104622epcas5p2e3b29f793eff9857c5712b3d6d327ed5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823104622epcas5p2e3b29f793eff9857c5712b3d6d327ed5
References: <20240823103811.2421-1-anuj20.g@samsung.com>
	<CGME20240823104622epcas5p2e3b29f793eff9857c5712b3d6d327ed5@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_034829_028563_A0507772 
X-CRM114-Status: GOOD (  18.33  )
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
 drivers/nvme/host/ioctl.c     | 11 +++++++++--
 include/linux/bio-integrity.h |  6 +++---
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index d8b810a2b4bf..aaf67eb427ab 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -310,17 +310,16 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
 	return nr_bvecs;
 }
 
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes,
+int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter,
 			   u32 seed)
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
@@ -333,8 +332,7 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes,
 	else
 		direction = ITER_SOURCE;
 
-	iov_iter_ubuf(&iter, direction, ubuf, bytes);
-	nr_vecs = iov_iter_npages(&iter, BIO_MAX_VECS + 1);
+	nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS + 1);
 	if (nr_vecs > BIO_MAX_VECS)
 		return -E2BIG;
 	if (nr_vecs > UIO_FASTIOV) {
@@ -344,8 +342,8 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes,
 		pages = NULL;
 	}
 
-	copy = !iov_iter_is_aligned(&iter, align, align);
-	ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);
+	copy = !iov_iter_is_aligned(iter, align, align);
+	ret = iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..d8628e7071cb 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -146,8 +146,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	if (bdev) {
 		bio_set_dev(bio, bdev);
 		if (meta_buffer && meta_len) {
-			ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
-						     meta_seed);
+			struct iov_iter iter;
+			unsigned int direction;
+
+			if (bio_data_dir(bio) == READ)
+				direction = ITER_DEST;
+			else
+				direction = ITER_SOURCE;
+			iov_iter_ubuf(&iter, direction, meta_buffer, meta_len);
+			ret = bio_integrity_map_user(bio, &iter, meta_seed);
 			if (ret)
 				goto out_unmap;
 			req->cmd_flags |= REQ_INTEGRITY;
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 485d8a43017a..5313811dc1ce 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -75,7 +75,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 		unsigned int nr);
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 		unsigned int offset);
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
+int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter, u32 seed);
 void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
@@ -101,8 +101,8 @@ static inline void bioset_integrity_free(struct bio_set *bs)
 {
 }
 
-static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
-					 ssize_t len, u32 seed)
+static inline int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter,
+					u32 seed)
 {
 	return -EINVAL;
 }
-- 
2.25.1


