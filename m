Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C67CC6B3D
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=; b=MbvW82JX8TP2zWgO/O+Cwurk0J
	dgyfnWkqhFPzxHYkoNaYhjzPJDuUzcQ7e/Z0Prh31ZU0BbN0hkJ0xFksrAsy7jTNPGu/b3F6nIqhg
	wt8qr+MGeTNZ6cEaqC7ByBEITOrnPgk7m26QS96+8lJ/vi/bSgxga4NqVexb30rbBxy3YvKGUCPJu
	1xborfIYPu4LdMlT2N9ONDPhb/eWOCHOeziRoPFCFqLh7ge5BHjRqLbNkX++jLHFKFrYnV2O/n+d8
	fLHvBBbZsmcimsnBmeZuRF9eEz3CkVBkMwmYQUizFHeTvEHihs8pukw2hCNmD7Kozrx2y3mVD4yDO
	IpzMsY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxi-00000000TM0-2bI6;
	Thu, 15 Oct 2026 15:01:42 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjWy-0000000E3H4-2zGC
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:30 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-48b042c0728so782185f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924927; x=1792529727; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=UUFB1rTNwQl6HwCoe3pzbgLHT0zwxsq05YPO8Z9dzPJaFMelv4bvOGBBZiW439zaok
         VpKzwQwKchEwUTC4zZ9wlc8iMFIgZka1a9kcyDlzTnDP2lqupaS8jzbSBI5/yYWyNXEl
         c933XTdlG/XRRy86tEMe6rYvpsvCzOSOFUb+BKBgwmZxblsDlEP6IWAV/HJZanBZh1EB
         4uHIBLrQy7M+wRDfcEAnNUw1oOkXK1uJu9BgEZLUwU9VBsbWwstYBP6vLqhCLPr0oHbg
         FPi1p7t+YjQ1UVdE+MzWkTJ0xji+Z47ggMzfPyyEj4jnCs3sZHyzfZMWiWAG0IfIAQza
         2/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924927; x=1792529727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=LdrsAFuxxiHsEHBKB5mHcbi3T5UxeqY9o3jO2IymkRluTZLX9Ad1R8QOb2CM0yfJv2
         GLdv72ImCD9JPSf9so8DJJ6VJz8pqweUt2vkynDzn1pHrMdlYruBv4KHOlRbbI5XZeNY
         3SoMLpU3S7xn2a8mUQsdUtyCp04Dr23SV78wPCe+o0gIudZ8rnlVS9MXoJctw6g6Kkss
         r/+P5WKf3Yrbtc1ohx8yEagjarN2sxTYMVr/Zi9hdzYxnmDBtBgxSfFzXSDmgqLEGvVJ
         C0ipD1tUuHC2hOs3PfAP9oi+M2L2w8AWH7rNCorOwMGe9fqOvNi660NPqOPAWWkg4ul4
         IhXw==
X-Forwarded-Encrypted: i=1; AKwUvBzKV4p7YyFd/0zr4UYrwpZippap5VGYIb+PCJQvBKxT9O0uXJqGGs/afI+n9JRlLVtFd3gj9eYSju6q@lists.infradead.org
X-Gm-Message-State: AFq9FYLmJol909EHAmNskv6vrRwmbZ11lMs7VgeLKIADmlXL9Ii8htGs
	0MKpImd6/d+P8IbvwxJ8jl+nFc7UPsd5A1QKDyvY1Mwblhm0ZfNMXUbL
X-Gm-Gg: AYBFou14O51xtPDR6xzc7AjRVRtB6kh2v+mgynjO/r0CskLWYu3fZbII6b/F/v76x4V
	MJfXKKryAFeWk2/3MkCW2h/qSGIZfduRSgo880GunQBvf5qSGF2DNlFBu4uaImYNH98SSQjPruh
	pDxMhGd0LSxEUONQiaBrs+ZF4T4/aatMJAozdRKtKU6VVXzy/d9lU1biBPgTcBq8FoDmdHnM4o0
	Crg370++nbDx1QZ+Ao0vm/JxprdWO9biy0iAKj8fHpUk4usa4mN/xyKrZK25pFTazcLG4f8I/VN
	qWxk/7wTn9521VH9/udTtVzVmf9KNR0hHsw9jRKwuK6K28XHgdqBHvsPqNdUFKmzeCDYTYtAwq7
	0tIQmfuN/PtSs+IK7ZEHnNev//mllh9sevlxvSMfkSWLB/Gu6KfowODD4Yjnwvks6y12eAqJ+A2
	MKbg6miV+NF2A8Xhe19iWfju++J57rfO1d6svH1eG0TBwOEuKwBq1BWpQrNzESWiwOM4E15PG1N
	1dZT9h+DEaYJ2rc6zspwHrAFcMUCyZJjbnrgMQa/eZk1YYx1unWmKwu1OZBOYnGPfawFAVBIbmv
X-Received: by 2002:a5d:5d09:0:b0:482:fd9c:3740 with SMTP id ffacd0b85a97d-48dbaae8af0mr23656771f8f.22.1791924926558;
        Tue, 13 Oct 2026 13:55:26 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:24 -0700 (PDT)
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
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v10 05/13] block: add dma-buf support for raw bdev
Date: Tue, 13 Oct 2026 21:54:49 +0100
Message-ID: <78b3f2bb6e3ce576ee99252b88f0af8602b436d1.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135529_697157_BA345868 
X-CRM114-Status: GOOD (  19.06  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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
 block/fops.c           | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..6c6700df943c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -730,6 +730,9 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	if (unlikely(iov_iter_is_dmabuf_map(from)))
+		return -EOPNOTSUPP;
+
 	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
 			NULL);
 }
@@ -855,6 +858,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -958,6 +966,21 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+	if (bdev_has_integrity_csum(bdev))
+		return -EOPNOTSUPP;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -976,6 +999,7 @@ const struct file_operations def_blk_fops = {
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


