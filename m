Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E0FCCFA13
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 02:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOUCCDcR32WTLhwAJaOBtVC8wRTuafJBLOF7ysVPF/4=; b=WlOZk8fYtLXgh57oEhQBEqpItm
	dRft8gGURjxi3xXakZNbePBIXS9WFTj1UALH76Otk22N8d7bZElM4OM189HjEygtMbB8+gxU/5fiP
	STrbBMBlQnRkAWsC9/uuWcx2uFJBeSbndlecuqDLD9EBxjXFMm/JNnFEru4CG7XwrAhs/rDygU/1p
	XSugPBRxajLUH/t5FNsxJDQCao16HtKDKJPERiOPZ98iA8MsVMtlklbZ+D1nrFyPn0B33D81+zJmO
	C04NZWpdPCFLEkXmAe7ZSUX1IThmSldrYnLPTsFlKJFoz4pQKyGv/63f15F9vRL7p19T/k3Ft5n48
	5lNy5FRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBsj-0000000GYU6-0nBd;
	Fri, 07 Nov 2025 02:07:17 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBsh-0000000GYTF-0Jt3
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 02:07:16 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-290aaff555eso2186275ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 18:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481234; x=1763086034; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOUCCDcR32WTLhwAJaOBtVC8wRTuafJBLOF7ysVPF/4=;
        b=jOfa41NbdFTErsD9d6pQYQlV/4JgJmZp6r43RLeJKSeCFUXCxrqJMoTWxtP/soAU3L
         YiG5o1XmtiIKbl9sfyzu5eKQUqZcnNnkBTeQAuasMSP9zJ5Nwv4xepPIESZ8txBIpfai
         z9mtNO4C1ScBIZASonA/7XCTHSwJHgRww+vaNrvj81tPd/+GiX7KsRrjHroqdyF88eRq
         K31FGpcu1E/iLVt6AFSRsZRGMfB3Wseznc2WeXtlTh9XInqg3y1fIPcMp7HBaKSGV1DE
         kABcGcjuTi85ygCcIKRPOKAso9OKCtGDPuoGceojovf9DfinC1q35HdbiuwyVJc9xtwi
         fxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481234; x=1763086034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOUCCDcR32WTLhwAJaOBtVC8wRTuafJBLOF7ysVPF/4=;
        b=tRl0xxZ0wZGYmPlr/yZgp/WoPCGu7XN2Q67lcvnmiQJV2Y8vNrSZjEiLfKi3Q1OCfK
         EHBnNs6wa+/yJMqBZr2129oRCVPra0jvN3ej10JvM2iidbyzxu5MU2OIBB8RJGwGtJy3
         VS07z29FCxF4dwNUp1xakIjIPxfoaDiVPz61tkdoPgppHIgzwh79PX9EHUJ+u+vynNo6
         J8m5lk8eqjdf7YFFYqJ8d6sf9wuYt0q4L/ZWIcGomSH1qeTAq92n5t3STAVnDtO724Ye
         hwBGMIc/WUJQrOBW9WIRrmq6QrkA74oOrhLL3Fe2QIR8bYZKsEEvvjlDYsIB2D5BWWCl
         SXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGmWuskx3wF0yox/ph1gZQP5wmXq5S+V9Z/v9cvHg63Bbnsk7nUvVturz6MTMHB4gzsiI8Lq5izuC5@lists.infradead.org
X-Gm-Message-State: AOJu0YxxYPKiltbBwImnorEl7JEzIWxreicT2nujQHp0gvMyFHrnwkp7
	wpBgOsc43qxta3mm9enroEouQOMr5aKFoHxdx7YnSa36OIRBRwAk7VHL0IjT6oHMBrE=
X-Gm-Gg: ASbGncv2QxAbO0vvAfpYKage4cl0lTgmzUwbBqANgWKIQHhzCOEpboD9pJAzv82ZW7M
	MZb9TiOGDuEzvNH/vUT0x8Wa3416W2nSWPuSWQL7tetAJOeYHA7Bi7yQpbLizRaDah1HTEL8oBO
	KQRBTc4eowBKJq5CacxRwFJwzIINeQE9phJJtpca+OneLfWXOxdujVtYis0O8AT/KBRADrcSx+T
	OwuWeO4tSKe9AY6kQVKNV0auJAG0bxLfuo2IT4G1NIa38Sh4y7oZsTQ9EuEDhMDmeUl/9XNEnRX
	aG1dY6AnFbZrsreEwS1E5BJwp2r4dQ/jhmPDcFJJIfprSlCuVV6wkjZvIEeYbSDCXYsMr1VIr2y
	Kq4CaW1cjnh2YVPv9R0QS55WTOlUHQU/K4qXT3PvYOM6KNB9I+WvBwuhf20IfTUqUC47baT/bEO
	/8937a20C41tRKAZrQ
X-Google-Smtp-Source: AGHT+IEJti4NiV6U2nPuxp72+m4/jnwAUg2/UAR4b5PLKU43+gH5PrMm/tm0Xa1G5TmaQR5rlzUdcA==
X-Received: by 2002:a17:903:2ac3:b0:290:94ed:184c with SMTP id d9443c01a7336-297c03d5580mr23239875ad.15.1762481234112;
        Thu, 06 Nov 2025 18:07:14 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.07.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:07:13 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 1/2] block: use bio_alloc_bioset for passthru IO by default
Date: Fri,  7 Nov 2025 10:05:56 +0800
Message-Id: <20251107020557.10097-2-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251107020557.10097-1-changfengnan@bytedance.com>
References: <20251107020557.10097-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_180715_123579_B5067CD7 
X-CRM114-Status: GOOD (  17.79  )
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

Use bio_alloc_bioset for passthru IO by default, so that we can enable
bio cache for irq and polled passthru IO in later.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/blk-map.c           | 89 +++++++++++++++------------------------
 drivers/nvme/host/ioctl.c |  2 +-
 2 files changed, 36 insertions(+), 55 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 60faf036fb6e..272a23d8ef8e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -37,6 +37,25 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
 	return bmd;
 }
 
+static inline void blk_mq_map_bio_put(struct bio *bio)
+{
+	bio_put(bio);
+}
+
+static struct bio *blk_rq_map_bio_alloc(struct request *rq,
+		unsigned int nr_vecs, gfp_t gfp_mask)
+{
+	struct block_device *bdev = rq->q->disk ? rq->q->disk->part0 : NULL;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask,
+				&fs_bio_set);
+	if (!bio)
+		return NULL;
+
+	return bio;
+}
+
 /**
  * bio_copy_from_iter - copy all pages from iov_iter to bio
  * @bio: The &struct bio which describes the I/O as destination
@@ -154,10 +173,9 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	nr_pages = bio_max_segs(DIV_ROUND_UP(offset + len, PAGE_SIZE));
 
 	ret = -ENOMEM;
-	bio = bio_kmalloc(nr_pages, gfp_mask);
+	bio = blk_rq_map_bio_alloc(rq, nr_pages, gfp_mask);
 	if (!bio)
 		goto out_bmd;
-	bio_init_inline(bio, NULL, nr_pages, req_op(rq));
 
 	if (map_data) {
 		nr_pages = 1U << map_data->page_order;
@@ -233,43 +251,12 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 cleanup:
 	if (!map_data)
 		bio_free_pages(bio);
-	bio_uninit(bio);
-	kfree(bio);
+	blk_mq_map_bio_put(bio);
 out_bmd:
 	kfree(bmd);
 	return ret;
 }
 
-static void blk_mq_map_bio_put(struct bio *bio)
-{
-	if (bio->bi_opf & REQ_ALLOC_CACHE) {
-		bio_put(bio);
-	} else {
-		bio_uninit(bio);
-		kfree(bio);
-	}
-}
-
-static struct bio *blk_rq_map_bio_alloc(struct request *rq,
-		unsigned int nr_vecs, gfp_t gfp_mask)
-{
-	struct block_device *bdev = rq->q->disk ? rq->q->disk->part0 : NULL;
-	struct bio *bio;
-
-	if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <= BIO_INLINE_VECS)) {
-		bio = bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask,
-					&fs_bio_set);
-		if (!bio)
-			return NULL;
-	} else {
-		bio = bio_kmalloc(nr_vecs, gfp_mask);
-		if (!bio)
-			return NULL;
-		bio_init_inline(bio, bdev, nr_vecs, req_op(rq));
-	}
-	return bio;
-}
-
 static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		gfp_t gfp_mask)
 {
@@ -318,25 +305,23 @@ static void bio_invalidate_vmalloc_pages(struct bio *bio)
 static void bio_map_kern_endio(struct bio *bio)
 {
 	bio_invalidate_vmalloc_pages(bio);
-	bio_uninit(bio);
-	kfree(bio);
+	blk_mq_map_bio_put(bio);
 }
 
-static struct bio *bio_map_kern(void *data, unsigned int len, enum req_op op,
+static struct bio *bio_map_kern(struct request *rq, void *data, unsigned int len,
 		gfp_t gfp_mask)
 {
 	unsigned int nr_vecs = bio_add_max_vecs(data, len);
 	struct bio *bio;
 
-	bio = bio_kmalloc(nr_vecs, gfp_mask);
+	bio = blk_rq_map_bio_alloc(rq, nr_vecs, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init_inline(bio, NULL, nr_vecs, op);
+
 	if (is_vmalloc_addr(data)) {
 		bio->bi_private = data;
 		if (!bio_add_vmalloc(bio, data, len)) {
-			bio_uninit(bio);
-			kfree(bio);
+			blk_mq_map_bio_put(bio);
 			return ERR_PTR(-EINVAL);
 		}
 	} else {
@@ -349,8 +334,7 @@ static struct bio *bio_map_kern(void *data, unsigned int len, enum req_op op,
 static void bio_copy_kern_endio(struct bio *bio)
 {
 	bio_free_pages(bio);
-	bio_uninit(bio);
-	kfree(bio);
+	blk_mq_map_bio_put(bio);
 }
 
 static void bio_copy_kern_endio_read(struct bio *bio)
@@ -377,9 +361,10 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	copy the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
+static struct bio *bio_copy_kern(struct request *rq, void *data, unsigned int len,
 		gfp_t gfp_mask)
 {
+	enum req_op op = req_op(rq);
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
@@ -394,10 +379,9 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
 		return ERR_PTR(-EINVAL);
 
 	nr_pages = end - start;
-	bio = bio_kmalloc(nr_pages, gfp_mask);
+	bio = blk_rq_map_bio_alloc(rq, nr_pages, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init_inline(bio, NULL, nr_pages, op);
 
 	while (len) {
 		struct page *page;
@@ -431,8 +415,7 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
 
 cleanup:
 	bio_free_pages(bio);
-	bio_uninit(bio);
-	kfree(bio);
+	blk_mq_map_bio_put(bio);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -676,18 +659,16 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
 		return -EINVAL;
 
 	if (!blk_rq_aligned(rq->q, addr, len) || object_is_on_stack(kbuf))
-		bio = bio_copy_kern(kbuf, len, req_op(rq), gfp_mask);
+		bio = bio_copy_kern(rq, kbuf, len, gfp_mask);
 	else
-		bio = bio_map_kern(kbuf, len, req_op(rq), gfp_mask);
+		bio = bio_map_kern(rq, kbuf, len, gfp_mask);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
 	ret = blk_rq_append_bio(rq, bio);
-	if (unlikely(ret)) {
-		bio_uninit(bio);
-		kfree(bio);
-	}
+	if (unlikely(ret))
+		blk_mq_map_bio_put(bio);
 	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_kern);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c212fa952c0f..cd6bca8a5233 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -446,7 +446,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct iov_iter iter;
 	struct iov_iter *map_iter = NULL;
 	struct request *req;
-	blk_opf_t rq_flags = REQ_ALLOC_CACHE;
+	blk_opf_t rq_flags;
 	blk_mq_req_flags_t blk_flags = 0;
 	int ret;
 
-- 
2.39.5 (Apple Git-154)


