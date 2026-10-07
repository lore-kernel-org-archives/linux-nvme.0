Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA68CCA9EC3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=; b=E0tUxNzPRuomdeHBsTekB+wD6Q
	w9YuuLtnP7GInifgpWRACxMiXc0lZkkArvvgXf3TuMVIFDJrl4Hl2u/ZIR8weatkQh3rkBNVT6eV5
	sSYWdAHAlZ4PnGKxEsjuHt/n9S79/BK4O4GQsZN38YvDPVyXeuqNVwslLJqsmSviAhxmrBLzbyQgb
	6c8XQOjkmX3aTPGKHvcJI5rHhRmMpz9caGkzqRHvLZ8ODeYMsM5Y/M2pQntOc3g05RQlqCoQD3g1g
	EKbagFzu4xapIXyuFUPXtBiH0bB7LJ7zilWaLKTkfyBIxuonfOwcemOWXp1sEQfskKd5zcf95OxC3
	CLpS4j7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtq-00000006hsa-1eC5;
	Fri, 09 Oct 2026 16:56:50 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgi-00000001cE4-0fqH
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:25 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a02718da81so10913195e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337398; x=1791942198; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=A4RzTGzpVJmeV06EZ8usc+YXKBJ3Vr9S7RDsWr7fo/WNkTRYUWtJSnPBdxmLh2Wvlc
         qkY7O+K3tlGWLAx1SjziBZJGt+c4QdfWBAylo8CBxkCVGmZLSCJIO61LwPQAPxC9evLe
         Ke9bRsAsOaqhnzS0Zep9uck2Z2XV7OFKHBde8W7HUVFRk1RmPBU3jkqXZOjPS0H2J7+l
         av0GSYvbc6mSq+om58rFwxY50DtPht182KtIWdU+0CWeQUig9hMOnC8tzIc9LLY4omGC
         88q4Eprau34/3ihV7VIocy5quAB0D6xEM7Kv/7tBDQhGB380aHbNQdwhJ5RIHOeahy67
         gu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337398; x=1791942198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=Mj1YNIxFgFxApTiTj6780l8wu/oNnBvC0GUpbh6xQ/l7evDisv4O+r+E8JZO8kjmMk
         TMfK2AUjvglVd6wxGCgKjKHgMkyuBPNMYqX67EsszYDaWpN53b0fB0kB+0WinJjA/VTi
         BmPLnXJl0IqYUVsJWPpGQJmCsDWUFiR36jP/IDL6rGRm/8fHy2QCe0uVF5pMs2nBFOXN
         PkDgZHqLFhlh2HgAPi+BFAeykU2Kx3GoNYVhuVfaBgZOkfblhw2qUwHNfY8Rfz4dezkt
         rgtOHWUufeNCcU/OPAotoSmxDmWqehxyOr+TXFounHSMSpbZL1/gFHwZK73IFGC7GAu2
         P6dQ==
X-Forwarded-Encrypted: i=1; AKwUvBy59i/l82D/8W+eVDuBTjnzB61rhpt2oq0oYDBPy0o2APk7XNePlGR7qbbxyu5mKyKiKwrPJuUoyaBr@lists.infradead.org
X-Gm-Message-State: AFuF++l6YTLuEPrHvn4B+L7OXbQRZjLM8XtBJ/ZlaIwedhB6iqejbadw
	WndJKJw0rX6IjFiik6EDQHcj1O+ljopVl8Uw36CzKT+/P2+XgbI/C+7P
X-Gm-Gg: AYBFou1CY7+rbnSrQeTiuDz78/qwdqkVmMZC9ISi727ycX08AeeTG+CCdhfaQpqQ9gt
	ImQp09XlBKxwyl2xoqRqe3Uc3pE8eCEWIObGYEgvE1swEIr3k753ZAMecSAiM+7S1ySTT4NN6gD
	SKNcFvf+QiEvdieCsmFj2DslJZVdGdq0Nt6KQX8dsmaks2oLcQKUcomRg6MAeOwMcNmy71sxiQ7
	8pBwXhoZ8WSaJ+cDBnQjZ33ChzGgT7vYFq3HbqZU3wp5IhJR54kf0IfJPFo1TVQkVwedw9Mll2U
	1wxPfDwywsgfEI6N0vAvbtK23IwuefVgerb2GRAVnSXCvKx+y2IGh43zq5Oc8pEMKTCaenCBHIH
	F02yAHfS86jYOt1E6qnSu0LPMAwwNEjUYdsnxEBZY5t/05l2dnKWvxiVo5YFedXNqthoV5J/Pak
	9HAyJiK05g2ny2BV7uJRqjbgrLrCibF8GpOnDN3uC/gniKNHcm4Uzv+Du3VheimxvcgC0PMhkH9
	mJ3McgIT3/GOXIbilEGP9wp4AjSPh5HVx8YroPFWkTgMgUJVhye7o/cKns4oCYxRScxkNNz5Gt+
X-Received: by 2002:a05:600c:c16f:b0:4a0:2484:2800 with SMTP id 5b1f17b1804b1-4a1800ca1c3mr7313145e9.3.1791337398229;
        Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:16 -0700 (PDT)
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
Subject: [PATCH v9 05/13] block: add dma-buf support for raw bdev
Date: Wed,  7 Oct 2026 02:42:48 +0100
Message-ID: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184323_404528_1F852DE1 
X-CRM114-Status: GOOD (  19.19  )
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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
 block/fops.c           | 22 ++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..e9da48ab73be 100644
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
@@ -958,6 +966,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -976,6 +997,7 @@ const struct file_operations def_blk_fops = {
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


