Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF563CE7A8E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pVqJ5zZ0HtfmnlapRSluaL8hZ3jxVD5iRJrMHsVwK6A=; b=Qn7kSu8WPAohsK5dvVM6MXVkkm
	rwG8Qp5mkmiVEZsZiK+Bjxh/7FLxVrAXaS+8QmuvPgFFS4472BbLJhxDxJonA9qVN4DothdOI3cJj
	W4cCHWyzxZUfptx1+FjlNC4QDJsH49lIK6DLQLjiCWPaaqBjSJ0H6u70+tNBf2//qw/uStrJLBkFX
	trxVuUHCXp6dhBnH44HC16hjuzN1bHyXl6BQG7jgG0MfBTORloYXRGj15cwaVPMonkcU/x4Ark75F
	/lMOc345Wdy0nP2CyeRfaZLxwVY81bpzPrnC0eYJ0MWbA3WBZAzd0YSxZAKq1AlltNepPy5h8YQBb
	Ant8AuCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJq0e-0000000Bu5k-19BD;
	Fri, 14 Nov 2025 09:22:24 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJq0b-0000000Bu4t-409u
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:22:23 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-29808a9a96aso17147395ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112141; x=1763716941; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVqJ5zZ0HtfmnlapRSluaL8hZ3jxVD5iRJrMHsVwK6A=;
        b=PGFqQT4HTo/yLOCTRdwY14oh5bMgVjs0TciBV4/vNEPOHlw2+DF+Vh7S8IjFMvEoqW
         AaKO2HvioTm1pa6WRr2xMT5kWpHgwbeXPMTNjIa6GmNDaZSlAtpLmBHoS+J6SgniC3ce
         +KS8cXa6DFXmEKwGq+ooEji2JaN1f7NR7jjIJm5GDq6xrnREikU6nND6SAsB8d/F13L5
         IMbh3zHWLUEoa3wslMvncO6D3ojYKrz4z8b9XiDlEPBj97/dklpsMHT0VbdN10NZT9ZY
         9vGe/TpPe4txf+EZ4GkNvaYtK3haTjtD/FbwRfHa/JRxjiQSZFzJaHYZLfFBmiv9oQd9
         exVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112141; x=1763716941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pVqJ5zZ0HtfmnlapRSluaL8hZ3jxVD5iRJrMHsVwK6A=;
        b=sinDIT00oxm81JlyrNcmyLzz4WDtm+0UuR9uhZ6mvnR2aMGZzKGBClomXC2sliCBfs
         4AXeJT0TSMBS5ZezaUTGOCpVmzKPpZ5nZdweB+UCoI98nH8GjOuWCEvzJNi98HqQQKTI
         gApQjHlIaMHC1ziSASkgupQ1XDkQffSfdr6ZUrSpt6bcjC7w+yOW+C2xGSmbfPq899ku
         YBttVWjWE4HtRUqs8GW5f/6+Lyhb631QvmBKEGRg+Vtchr8WwpzuZTgs7hKLWiTDLytE
         aWsux7OcP9dFB4ClOXZKuHQv48iSTJYFrIfmsgyqM5m3qx8cQgw61IONZ+3mrw3jQ0ZN
         6CDA==
X-Forwarded-Encrypted: i=1; AJvYcCVIpaZeoKdBGw6f5NOxG33k1fyl+CY70++hnjc3WrIMIQQiiMjjC5/PY2ZMPNF0+CTVoSe2yyUUnSl4@lists.infradead.org
X-Gm-Message-State: AOJu0Yyn/jkBOv0Sch9+5ktLdXoAvj+xp0eVfyXEOYMa/RAWdsE5L+Eb
	bpl8xadJ/bl0WfXHC4tIBlhnzsiVdNd2nIS/n8dwzz2E6RjAD8bJcdXgbvf6MUFHEYk=
X-Gm-Gg: ASbGncvWR1U+r/NP3uKGFreiI1T/sFBC/LDCMJt+HPzmw6C70POh0RksRhS9Ts4BEbA
	Rd664cciZmAAJuhQgI5T/IxkKSzSpyTE0x+np7B0M8suGn6FMPb7jvwvYHw3gBMfnD3RKgR0qbK
	D8Q8J3s5r0cCvkvRxgaHdvTXi75YHjs56uvOa33GlxqqzHj9aP+mouNVDOKeB2eOUqbpjQ0tHbi
	th09wTCZprzckWiOlWNzZKe92ZkeGovElZFzjodlwFKEu4mjsOEs/N9aFK/kFG4RPMKz3Zznt9T
	TKnZjY2VD+4kl85rpM7y7UaimWSmmamiqUbtNrtRWp3h+MPua+HsXSighjAufRkK/A9g8ixg68a
	e1FvAFGGtcIDKAQwp0Bcr2EoC+fdj17wNM8wEMF4oTxxWBYiZIRjs9HnjC0tSG/Y7su0DUrBNUh
	75vZPeYP/1sma5ngzcPkKv+Pvtueghh4Od62dReR454N53
X-Google-Smtp-Source: AGHT+IG8akVzn6mgTzVS8eSbF8fdiM3Aj0sp4LOsT1smP8qpTtrhqG7ZlkpNWC+Kazn0Hs5a6+hQ3A==
X-Received: by 2002:a17:903:2c07:b0:293:e12:1bec with SMTP id d9443c01a7336-2986a6d57ebmr28935835ad.20.1763112141041;
        Fri, 14 Nov 2025 01:22:21 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:20 -0800 (PST)
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
Subject: [PATCH v3 1/2] block: use bio_alloc_bioset for passthru IO by default
Date: Fri, 14 Nov 2025 17:21:48 +0800
Message-Id: <20251114092149.40116-2-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_012222_022533_7F242036 
X-CRM114-Status: GOOD (  18.52  )
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
 block/blk-map.c           | 90 ++++++++++++++++-----------------------
 drivers/nvme/host/ioctl.c |  2 +-
 2 files changed, 37 insertions(+), 55 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 60faf036fb6e..9e45cb142d85 100644
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
@@ -369,6 +353,7 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 
 /**
  *	bio_copy_kern	-	copy kernel address into bio
+ *	@rq: request to fill
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
  *	@op: bio/request operation
@@ -377,9 +362,10 @@ static void bio_copy_kern_endio_read(struct bio *bio)
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
@@ -394,10 +380,9 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
 		return ERR_PTR(-EINVAL);
 
 	nr_pages = end - start;
-	bio = bio_kmalloc(nr_pages, gfp_mask);
+	bio = blk_rq_map_bio_alloc(rq, nr_pages, gfp_mask);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
-	bio_init_inline(bio, NULL, nr_pages, op);
 
 	while (len) {
 		struct page *page;
@@ -431,8 +416,7 @@ static struct bio *bio_copy_kern(void *data, unsigned int len, enum req_op op,
 
 cleanup:
 	bio_free_pages(bio);
-	bio_uninit(bio);
-	kfree(bio);
+	blk_mq_map_bio_put(bio);
 	return ERR_PTR(-ENOMEM);
 }
 
@@ -676,18 +660,16 @@ int blk_rq_map_kern(struct request *rq, void *kbuf, unsigned int len,
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
index c212fa952c0f..9c0d7b1618ce 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -446,7 +446,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct iov_iter iter;
 	struct iov_iter *map_iter = NULL;
 	struct request *req;
-	blk_opf_t rq_flags = REQ_ALLOC_CACHE;
+	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	int ret;
 
-- 
2.39.5 (Apple Git-154)


