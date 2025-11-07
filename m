Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2242ACCFA13
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Nov 2025 02:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=; b=mR1faZi4yjzdPio1CedsoYH/WQ
	PrU4DwT7LSVYjTGePaoP4NpMY2nMukwSt3L5NnVwaGdncgJI0CT7rIA8r4JlZkF5nHxSf+oYKAjqP
	jQYuNvgp4ZasxTP0CcPcwaXfZEeK1imBQRFaXIS4z2neA4p3qAiYaYe1m+SJ4WvK3GWiEVdxdD6JU
	eVEIWBibQjtUi5qgOEpCbFsGQfg0YDIaKlboaxUKSYChggyri9n3G9oiefegxK7iFokcYoyC98KmA
	8d2LAN35xdo47wZ391pmWYBYrw7+RoJLb0QjWQAe8Ss3wLrRXo99hoIiYZM8OxC0M4lfEi0m44hgG
	CTUi0MOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBsy-0000000GYYk-28OU;
	Fri, 07 Nov 2025 02:07:32 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBsv-0000000GYXW-1xkV
	for linux-nvme@lists.infradead.org;
	Fri, 07 Nov 2025 02:07:30 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-29555b384acso2452125ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 18:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481249; x=1763086049; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=dnOMCDNukQ5WjtVwAs0hX7tTuXtEeSBIRRPwGj8s0GyTsiI0VoclsEpjjEsva+Bpi5
         i2W9VcQFyIPKAJHAoilpvEVxIQeNvNOKmceGN+tIJIHUL+Xqqifjpduj8yyJFfCz1MIe
         o6AL6heuDkYrG9/wpmad+PzNaW5HTbd7fxqdmdL1sUM1nZhVXILpaVy+t6Ao7740Dgrh
         zdAbRyJpGrHKrshL0hYKgVczJsfdVePHnn8daZRkpy3gNrhIePaGGOTaE1oWjujuVQgO
         zV+t+yCRoqo4UbIPtGEvLQX9/GfavmFIgJ9T7xwrm4lsII4vmb54ngYP2ouJlxNjx06t
         VN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481249; x=1763086049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=saXOt2zUJJj/QFpBq4Co1pimDknhD98nNAavF+CZA+iaAhdOIj7HzSZGGBOdaizyeB
         5SQZZ4+c+phKY0KWhtfnMZTEg2+yefC1wPb+8iaRSK0RXeu99F4tBlk9j1qJ2uFk84iL
         J42nUmko2lGbmOXQpAz11nHPsnyh5op4UY+wgL/+ChHvxNDtYt26NUJU7FbZ1/TSIs7l
         x61/GC+DK2QSgyD+ypjyR6W9ludYMh850uSEY1Tuwq7esW7FAZtqcufQRiuh/vO8QXep
         EfQ+ZsTzdOmgD58TY84OeD7GYlIpQEuffnIIUf6fwIjQo+kEBVWU0KOAE20zr8rdoBG7
         u2QA==
X-Forwarded-Encrypted: i=1; AJvYcCWBvhrYQdE0d8+hEuAlozk9JQ11ZhS1VCyKUR2bGAnwT2j99TFOvWF5TxpwW/HZiOM82mKxKlW5Ryn+@lists.infradead.org
X-Gm-Message-State: AOJu0YzOwrodDnr5hkIB/VzzK+kp4Q8Rdx5VVg4gzdDwdasLhNvrrpkM
	9hQ6lv+oNmXMgh/DAKSJtwn/6mdFiz6Vpf4gCYRwKJmi+hdOwLZGz4HxLZQO4lAMQjI=
X-Gm-Gg: ASbGnctBZyfD0Jn94VLKeYD/S33WEpjLy73rqumg8QuOkZWwdkVlz+9jHWJCbPoszg9
	GsEIMinCBL4+E+yxOebjoSbDs9vK5ft6gG6Ep6IQHZHF4908/EjWYx7ALDSWhtMXUnqygvUDkpW
	gHah45pT2B4P4KCmToevU7+YkvUaSaiHTU1l/uRYxPIpYDf+aFLnslfqGVwZW3zQvBg6uAQOgMa
	Cl4+S8fAeBqLPIZOO8ytK0tEBDpFmEpygJuvaaNd5/+5MlyTCsSjCQYdhjQ3uzWrh3bpgp0YORy
	MFGnwY9jwyynVzOFg5IpEpnM1oFttpyRy/q44mUHs/EvcDDDXqPy75wsnJJYI2R/sIvADwxwf/g
	H01zDi29V66ksNqbWf6Nj2yxUl70tIbaoA4rudLdKjnTWUqVK1nfv74KclPyaWJH57x3239XGNZ
	DS93bo4gk4tKlDdg8h
X-Google-Smtp-Source: AGHT+IHXmZOcta8jUuxDACQrWTlF7AFvsAayeKJwmvo20B5+lL1aR+s8qHZVmeDX1E1ADNkEK+YkjQ==
X-Received: by 2002:a17:903:1a85:b0:295:94e1:91da with SMTP id d9443c01a7336-297c04601efmr20299015ad.33.1762481248360;
        Thu, 06 Nov 2025 18:07:28 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.07.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:07:28 -0800 (PST)
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
Subject: [PATCH v2 2/2] block: enable per-cpu bio cache by default
Date: Fri,  7 Nov 2025 10:05:57 +0800
Message-Id: <20251107020557.10097-3-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251107020557.10097-1-changfengnan@bytedance.com>
References: <20251107020557.10097-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_180729_511963_3A53AD25 
X-CRM114-Status: GOOD (  16.73  )
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

Since after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for
IRQ rw"), bio_put is safe for task and irq context, bio_alloc_bioset is
safe for task context and no one calls in irq context, so we can enable
per cpu bio cache by default.

Benchmarked with t/io_uring and ext4+nvme:
taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
-X1 -n1 -P1  /mnt/testfile
base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_bioset
decrease from 1.42% to 1.22%.

The worst case is allocate bio in CPU A but free in CPU B, still use
t/io_uring and ext4+nvme:
base IOPS is 648K, patch IOPS is 647K.

Also use fio test ext4/xfs with libaio/sync/io_uring on null_blk and
nvme, no obvious performance regression.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/bio.c        | 26 ++++++++++++--------------
 block/fops.c       |  4 ----
 include/linux/fs.h |  3 ---
 io_uring/rw.c      |  1 -
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..64a1599a5930 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -516,20 +516,18 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
-	if (opf & REQ_ALLOC_CACHE) {
-		if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
-			bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
-						     gfp_mask, bs);
-			if (bio)
-				return bio;
-			/*
-			 * No cached bio available, bio returned below marked with
-			 * REQ_ALLOC_CACHE to particpate in per-cpu alloc cache.
-			 */
-		} else {
-			opf &= ~REQ_ALLOC_CACHE;
-		}
-	}
+	if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
+		opf |= REQ_ALLOC_CACHE;
+		bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
+					     gfp_mask, bs);
+		if (bio)
+			return bio;
+		/*
+		 * No cached bio available, bio returned below marked with
+		 * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
+		 */
+	} else
+		opf &= ~REQ_ALLOC_CACHE;
 
 	/*
 	 * submit_bio_noacct() converts recursion to iteration; this means if
diff --git a/block/fops.c b/block/fops.c
index 5e3db9fead77..7ef2848244b1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -184,8 +184,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
@@ -333,8 +331,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
-		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
 			       &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..1be899ac8b5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -365,8 +365,6 @@ struct readahead_control;
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
-/* can use bio alloc cache */
-#define IOCB_ALLOC_CACHE	(1 << 21)
 /*
  * IOCB_DIO_CALLER_COMP can be set by the iocb owner, to indicate that the
  * iocb completion can be passed back to the owner for execution from a safe
@@ -399,7 +397,6 @@ struct readahead_control;
 	{ IOCB_WRITE,		"WRITE" }, \
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
-	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
 	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }, \
 	{ IOCB_AIO_RW,		"AIO_RW" }, \
 	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 5b2241a5813c..c0c59eb358a8 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -862,7 +862,6 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode, int rw_type)
 	ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
 	if (unlikely(ret))
 		return ret;
-	kiocb->ki_flags |= IOCB_ALLOC_CACHE;
 
 	/*
 	 * If the file is marked O_NONBLOCK, still allow retry for it if it
-- 
2.39.5 (Apple Git-154)


