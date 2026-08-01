Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7C7C55179
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=; b=PgfGo8Hmg5kO/+dxb3hyKPUaag
	pmRbA8JMHjr/yziAt3gZnpvJy8DKDT2Q+LmvPMn/tPYbmx6Vqnm5YbM4QGsPC/rj0kSdXJZAcsPHo
	rJq8zni/MGKw/py9BbdDJY70JDhEHHK1NbeaFy8TAHIjSS8W6ajzsxhCiYa/qZskDuEri0LYcEXXr
	/z0rqo0SIaoTSROdZ5U1lNl9+oiVaSIT0iBHB8/hucEaxdcxG1W/yXgNZYXqDDM7oLwa73xinjMWx
	fuviOb6W4cDGDb+I67/CkhdgSGoZtpS0BWSD/m4FD0qjMAnTv1mu0TWljCvDmjfU4bgceKk3hidhj
	drZ1SZCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX7-0000000FOMr-1Siy;
	Sun, 02 Aug 2026 06:18:49 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqBy2-0000000Ep7e-0j9f
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:49:43 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2d049069377so14209125ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599381; x=1786204181; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=;
        b=N/2cQ7l8Pvv/jogljiXaEA8GgplNAwXaXVydiH1zMZUWnDPYPFyqx7zftHd9aCZKul
         FM3Axmc4ucfuPNBRw3Jnqb8mTY1SIFGGuImRi4+zXib0P1qkEPxRU9uD4g2IMjiIvjmN
         RjVly00E6yBTRhDre5GwS6IHd3LzLjDlcw5qAtZSJbpFMd7sFSmw4H+wxLEuxRbLOWu5
         p7e5mpRHdg6xCKtdRvT+ieVvS4rmfFmr3HNrSbe6WR3MAoJg5X6YlwU9hECzEwKn0WXh
         woAR2FZ1PRq/hn8r4tPyF+uk+pJU5yXKu/Xwm9FSqf5nFQUe2+WjLkTrkCYVJrxK8bRr
         wb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599381; x=1786204181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=;
        b=CcXy1vlM2dn2qTSo2iIRU2oQIMVfs5GC8Mpetwj4cQ71iqpTr1+D/o59jIb05fCkoV
         PU9E31b3kaK1G0AsbHxfKqzOS3UhXHWCeu3pLxLVyrbfjgS/pzMWBG4H5CZ+FGLtFVXu
         cW1CitKhoY/pvvVSOwD5xETr2VrPYAEHvISQ6I2rQ8fkgg8zg9H+Ghfe1uOJ1rmUuCn3
         d8+SqwD3LW0Rd5voXGHElufoagVZrKFzfHDEeFdUHvY8jajCJWgw/hAkRxnlk0WZf9QY
         aOA5If/5+EgmoWP3oEw9xfLgukeI2PgH5XJBJWksHgERCxaLOjbzwNEGbPnL2xEgYXL7
         qJIw==
X-Forwarded-Encrypted: i=1; AHgh+RpAavFVYYAJeE5CZppiMdkBsUy7uARytNfGsq8pBEZwMK474+4pqLEqaLjt7EG/WXpQDWrpGYwDBY0N@lists.infradead.org
X-Gm-Message-State: AOJu0YyIFpHlhMqe4AtjyZ1FselJ0uQw7bj8i6P6HAi0Q3bOKoMgXNAd
	ZU8cgOGO35TKhbR+Ib3phzNzvHAfWBmzLpVIbBe7F7o69ZPZaNIVFQ93
X-Gm-Gg: AR+sD11+Kjq3VhwuTLWjiw/0g9R1CbhqrekLbU9HXPmhJK9nGEmXrn7iYvfW6LngS1Q
	/+bNtskEvmql7x20/hShO9Y++0C2I12gUQGx2GD/JWX5nR7SE3hS0tQzQZl49plN9mgcYFLahnE
	zYLZnSK9GOLh7TM/pbRqz6JHe209SWO+HcP1d5R7qTo2d4+JrdR1NxaLS0EIBzTaXM2GqiqMnSP
	gD9QsSHVyYqqHr9RzL9ieDzMJPyZaJf+GNbW8eV7wH8ebpE3L30bke2BvqfkGvNTa+klrB90537
	6RkNyGJj8nogJG5vMO+46eLGAdFi1DtEIvUEPyIAE0EGfE1kCp1s/Hz11wo1in//numI9N+xUjc
	9Glepxcgxr+vYPMXEVDQkKejQ4UD5aakJJA/ocihdv6whv8FwHBOFCC99IYIEy8wm9eEDyB7yT1
	jZfWnHNWQCNOkl/v8ajhTocD2RZYLh4XVrJFbN1Tdng492BCL8hSB43vLdamwhF2L+5K6pZdRd8
	FnJ7pA/ic+x6rP+D8+AFuGpo9V/1MmGpXOux08qPPUAsM8=
X-Received: by 2002:a17:903:2450:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d05219f5c9mr36286255ad.10.1785599381195;
        Sat, 01 Aug 2026 08:49:41 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:49:40 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 08/16] block: add dma-buf support for raw bdev
Date: Sat,  1 Aug 2026 16:46:20 +0100
Message-ID: <b32dd786296e1683378c9e037e2b9f26ec24fee8.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_084942_245908_4E9317FA 
X-CRM114-Status: GOOD (  17.77  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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
 block/fops.c           | 19 +++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 56bbacf6e317..3c403afb0f64 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -767,6 +767,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -821,6 +824,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to)))
+		return -EOPNOTSUPP;
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -924,6 +929,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+		return -EINVAL;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -942,6 +960,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..9f4c92e51dc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1682,6 +1682,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0


