Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB3CE7A8E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=; b=fiDz70wOAmZG0MVnPRCioMr1Lw
	AlnmZJHjqTzxX8/vJccrjCRzM2wRbG/n5IQGiGNVskWgug5KOHOBMTJq3QbGahyfGr9+vh5nE+gSI
	NSnF+rxdJ3oIsbDNVFJKzFUmkyRm/qYBkmpO95hKtDh5sDPTnu8h4bXCqW5nbz++jxClhkEIiG9bH
	aHWqza94XHUZUssnm4XlyCaOavaiY11yaMxHbvfifAI/489V1LUTBIzIZUCsmC7FrgA+byTGv8/Sz
	yVhEOP48vXv3x9pqJKCiaWe/874qAV/WKV5I+OUxpm5IkpuKgJ6Wok11jAdix/2VKqBbJbKGJuJ/v
	BcrKPpKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJq0m-0000000Bu9H-2SQg;
	Fri, 14 Nov 2025 09:22:32 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJq0k-0000000Bu8A-3oSD
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:22:32 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2984dfae043so15741155ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 01:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112150; x=1763716950; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=hqVs8WfsQ/XfXVJNWN/tRwYJgRXt9fE6nrWPyQcf32U1qPPsCClf1l92tg7IqIKQaS
         u3xjfPHHv5zcXa6Kjg2HNNJk87ExforWsjS7QP9RhZd4DdJ8elxvEHxzIP+vAF2eMwv3
         RPNpu8gcWifkMWeLsBvYvNsOHb3BmTD8X9KwFLL3tRCsjGUMBAB+Vf/8nHaQ+qwvw1k9
         ceVs7eD31zdmcAlrNSi28eAsTFgoe8do2TnViLAhe1/2gP2KM2jQdx+fDl8QKBwcJGby
         YnwhqRBTJf3e6VjIleycYbBhkAQ7TbnpGvu2pZ0VCYMDUbpaNVRbzs5tH0qPR+Ke9kM7
         0O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112150; x=1763716950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuX17fCzmjSlKD2oTV0BAVWCX3GMVQ03UEsOj2aXO/w=;
        b=dUzYADKiaG/pCcwjtMxm53cd3kduyyEmumly7ZXK9WthDs2KIuorLyodAXrNlPpY5/
         KpzFh6hMXJpf3eKLfLPsHNdXYvIHh0XlRm7M5HLnlWIrh2kmqWmRYgJ86ykTxMpFx5zq
         u7R5FH8LS4DNSVKfWmME1ZPx3DKuT3H/3rp7n99MpJohLA0qxf7LV+LgGTqOm0RN+U5s
         41D51trydlc5I/hX4s54EU8GYfB+Y38Rd5yq7KNZA9gZhevfXqEGJ1A2JKNpWv5pFpAk
         5kZebC8OXSL/94a8KMgZmyDyfo3yhcTRx2ESgGTRecPv+2IDJIC1aVFrEVvYkeAS77ow
         UXNA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ImB37cSw4sT1o8gLqRsphOaG4K5fRP8SZgvKwPe+AbegGHRXU+O3KN5abM5SSJaY1WQAuU/EIfMw@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9CCZ+bVWaBFQEfOL5yTuebtAEnx5pKPECZT2x2ucdpWruy/sj
	S/RKwfA5gpzhrIH4ZysJpLN6la/IsrPPUA3vGE/4vTlLLRKp1J5TFvEA58KZBZnFxXk=
X-Gm-Gg: ASbGnctY2AwWVJ5OGdXAgLYa7nPkI3xZcOPmIGQiqdCB8wXGsqX3jXcdhFTFfzCXafQ
	xXmIznPRQotyuM/hnn/WqmBFUE3nfvSZKCBQ/S+BDotxUYPIeSAG6QSSSbiM4FcpGlx2JFoehqu
	pcqhPPt189DU6GTi5aAv6RA/wZESyIWoXig2DZvVpzYClbqXZSAYUx/NZN4Cuff75HkTrwLAy76
	KoS34W20ZV1I0NZGVfimUfSYtFFWIiBRIkdL7J5GlJHzTyQm1uJqKzIcMoIBV6FGjpEfsg3lPG6
	YwBliyMGndYc4f2qPjoclQPSSHX0vBPwSx2k+YFhnUGv+aCR3/1tZVWswBbWc+OQF9EC5iFsaMr
	ifLFIeDnbp22ZVWALVfLZLLKZcYfqo2WLDa9pGMWfIBohPf2SRH/do+RUGPkLV0cGyQ8MxGd0Us
	Eyk+CflQ83o5pt03Jq3de6eiVLCHPIkqjRLg==
X-Google-Smtp-Source: AGHT+IE5EpOKhzEVc2rBcafP7dwFxgYiV1vDTAUPbL2qqYMIRb4HDnxBwlI0YiLG3+RKWslwz123UA==
X-Received: by 2002:a17:903:380b:b0:297:dd7f:f1e0 with SMTP id d9443c01a7336-2986a751eb6mr23592765ad.43.1763112149863;
        Fri, 14 Nov 2025 01:22:29 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:29 -0800 (PST)
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
Subject: [PATCH v3 2/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:49 +0800
Message-Id: <20251114092149.40116-3-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_012230_957501_31B18FCD 
X-CRM114-Status: GOOD (  17.01  )
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


