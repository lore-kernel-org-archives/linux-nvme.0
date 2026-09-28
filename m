Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97978CA5FB3
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=; b=MLaNpjGoj85cxkmKk66ZAlvxIL
	bLFv6pL6xdlubr8NJHQ72nUmujAikrA5CxJAC4CwmBzsxTJQpoAwQOXa11XhXHhyDqd5xZqYyqsBS
	4eS51rGPScohr93iYerSwwaq2ectrYEHDJtnBgCIN4rXkHkmZxcPnOpl8UYgTQpto/o0b/Ak7562s
	eqqLXo4S8RjRQXgBb6IIN5bCUYG7S4jRHGhRy2rRhj1yyhsHPWQ2I/XeNl8W0k1cnDIoI2c2zc52W
	MPmMZkCtK5WXDmfvok9wN55s9ONls2gIHQOIdIGqY/iVxhsDzBEq9xv0ruUvwrAMNA2FcfpetPvau
	IGSgJfVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7c-00000002jLF-0Rfc;
	Tue, 29 Sep 2026 08:23:32 +0000
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTR-00000000fDh-2etO
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:32:54 +0000
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-4887d06c669so2343461f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602372; x=1791207172; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
        b=FGu1CB4qgaYiu3Ad4y3HEgjcn2JF3JucZrbKUwYP+xzJF5mlzQG0FPeZ6QLF6hlJI2
         wgv9go8sw++VFDmmMI9Ob00kGFzr7veTtsXb3agubnxby9e+OIbZt389qkRtwXyJAp+b
         oZ09HSTh10Gu+uem7JiiFiH6obRrJKWPdIjjGyYWV4hw4bJiTQt0rsxz74lucrs9RnnD
         Y8HRr1FxmPUVo+n58c9Q/7e8BE+EMRQUDuDFqefyJctnWy12xu5TgjgJvD9oM35UolI7
         C7hRWUVwJtGG1zEG462dmfjYuycmEPkeQwaouD1VS5WEbViVXEUaryTBNIBUvKaBBecl
         oBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602372; x=1791207172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
        b=VYQv87CoYf1DXJPiclaolU8GN3VcnI/zfvl1MkkAKgnRShS+KacG0EfQOL08SsAFBa
         ADYe7bkZ2hgfSsda4hGd5i5XZ5XtsdwkzF8SiywC0L/EKOJ8IJSJO88RKvjOhSypbzbD
         EA1hwiZejUU16zJZHeoTZZbO43P5GS20YT9tBDSy6/9MYDYlvJSoTyBPz6ejxs0euntH
         7Q3VIxLc/PrB46ElIRWpJ78Xju1w8LvkgdjQSjvJ/rg4n0Ujz9y0F1Vezy7uyOy4tmvV
         whI55KeBbqZcRRvzIusCSMLiJ1pRVMlejAD4R0X+lLu5zfYZdtH+E0MFl4KU5An7iytP
         jB2w==
X-Forwarded-Encrypted: i=1; AKwUvBxT5Dm0j2LhmKas+uPc5fc43mmgvfsKKGB9/6MftA7O8uhJIlo6G22Pw2QJfzevlvQ+p0Vc0ypvvopY@lists.infradead.org
X-Gm-Message-State: AFq9FYLu0r0vK67QuzCHEqm3BfbwsU7FKin4wdgTk3JbdeK7noOhl1HN
	rFMKh2rzfauReonW9nXIsQzR/7wWhVu7HgOgtG0/xH92jQNuDUjezNps
X-Gm-Gg: AYBFou0c4m7ejK4Er2DPl84vCazF0D3T4aAFNK1dgYTE43E/uyGaW5bdNJC9D2vYAZZ
	e4Eo2AfdwBcFBFnsG4bTzSKCkr/4PwjIAftOHuxQz2OpXS4Pc0MNHkRssc2W40HZfdK/G+hOEgL
	nrog96oO/Mip4ceBZ/LC4EpxBTOu8fWCYl+IpS5ZJCeDbKrA9RESfpFrlB6lZFG6jAzTEDf8tkm
	/q5/Ja6Hb+xD8tY65SX3I/LaMXN7Mzb1P9QxV2NTIPumXZcXzBHnI3BHgM7s13g7UNtO9nmkoh/
	dU8UkoOgZbUB6qRC9SBkqNHwqYeAq1mSv9KXNT19AIxZJZxyIQbBKcfhek0genM4lJtmhv01grq
	ouJzcXNJ/2ulmoxFTFcmwJHLY/nYwLfCjEASwTdMPDRnBBwc2Sor5jzyDDlREa98CmrPaNHT3DT
	CNczz1xMtkNIf+vJzTZe/vAy4Demk6tXzH7YQwOF1Wju1iWrVmA3RheuLqyKGKKR4okng0ZJXQj
	iuTzlQJFAPJ8n3wIpLaKdcAZrxwWUoDgqQW1mYJRp3U1zufEHsYOy79+Ztyaw0yrXC4EPVdW1gI
X-Received: by 2002:a05:6000:4911:b0:486:f99f:8236 with SMTP id ffacd0b85a97d-48872ac74e0mr24072487f8f.44.1790602371877;
        Mon, 28 Sep 2026 06:32:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v7 05/13] block: add dma-buf support for raw bdev
Date: Mon, 28 Sep 2026 14:32:21 +0100
Message-ID: <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063253_702366_49FB25DE 
X-CRM114-Status: GOOD (  21.70  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 25 ++++++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 641621db700f..d05a78d0919a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -783,7 +783,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -796,6 +797,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -851,6 +855,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to))) {
+		if (!ret)
+			ret = -EOPNOTSUPP;
+		goto reexpand;
+	}
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -954,6 +963,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	struct block_device *bdev = file_bdev(file);
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!disk->fops->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -972,6 +994,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..2d5c30823aab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1599,6 +1599,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0


