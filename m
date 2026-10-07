Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555AACA601D
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=; b=V1tLekbF6zVViZsV19Lxumvb3Z
	mCK6XVgYROUbSDbvQmOrIy2rP8bR54r/iPRwa6muRvDGmnZTaGb6YH8cEWW+gBUwt6z9EHzrO3eFi
	kpECearKRci/4Rtl33xf3Sriwbx1hdECY0h3GR/Xl61YeZYbmoiJSS6fiCGqgfs+jL+g6JTvafleU
	atlz79hHIl3Ih0EhNTVLZoLGX758dCvg7lvOBErORAFkO3F6rvTXS9eIjGi9fAFAOMHwSMofAh7tA
	CsA50qR5N8AYsWomepSp0PS2pUGaHbkx0rPZaYDZh3W0Z/vmZ0bUgPatTQe8s8wUVSIcTegqLDt/A
	FoqzpJtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtc-00000006hW6-2jYV;
	Fri, 09 Oct 2026 16:56:36 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGW3-00000001atO-1h50
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:20 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so9155055e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336737; x=1791941537; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=lOvnKFTj4Yr9WLdNk/9ufCgjhPZEwpm1Phu6zaxP3KK8QvLOAQVHdNmKW9Z6e60aOO
         +t03IcCjdP236RO+UrwsSsHFWhap1EVJz9VRdrYQ11vdWcOMcu3FHZJSgc/8ovxRrZS3
         dvuRoWe/APUGe1il2DoXTxWCsdVpY30EwTAKsicpqOqXcUPJqz9K8F5f/8XzFqxssG6G
         gJMETAGgREGRWuOxkO0tsjKatvOdmQJcZuZLy5uBz9plF1XnfDwfUUMoH0zVHeNT8hHw
         qZ5K5DtAjX/i/HHaD1SILdebyuuBQKk8fRSzbTe+RUHs+NZsFRb6mYd1lagyvJ7MUbsB
         kEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336737; x=1791941537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
        b=XiPBal+rLWxV2vw0Kc5YDi2XT8UKdO8t9Xy3Zuttxxi58rvuD6XA4Mswec7biIfjZC
         qbYDN2PeEJiagbZ1ivyL2pclS7D7AKQZN4bl8qPr/4bK0pb7MVjev1jHh4GMWPYv7w6Z
         Y3VwkUBx9SRIEtIUMsdgQpRxVgEdgethcxHRMsMc9IhiLkLBw9/577d2veWEu4qR9pue
         JXN4uDClE0+v3PNltiWn6GoKQ2ypytsjMspXCKS0FKTPF1FH4KnbeVftmYLPi77A+0BG
         IOm0ex/4aq5rdHOT3MOR+qNIJMh5383oIu+cTuyLTFGCJrDHbAWEN+4V20rWriECx14B
         HABQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEAGscJeusaOU2l2BDreEMd6ygtpMvj7BDSvHp6S5NU2vE1vb+qALSSVbZ3qh9NYZJ4ph4bth2Ssr5@lists.infradead.org
X-Gm-Message-State: AFuF++lmumAOapzci3zgJNst9Qh2vee/uYGtkB+AMwsTnDtjyD7/JkDV
	2JEklBiE/sKW2xbg+e2ADPNMutV6rvFsXPHpLoVm6YVZOwBJkbDGJfWUVuO03w==
X-Gm-Gg: AYBFou0A6Tj8KK4IKISLmHgkvOpiSDynf7xvk8opJz3SdBVp1u3hjujC1X02hrUs2XD
	y7WWeMS7PQACa16Z42fi+sQcIlmUrCW2EzHFfuuiYm7mhUop7I1zuy/A8cX9ehost7uMRzMNTiL
	ax7a1gWgnX3znym677c3Y9nUORbZZT6Tmib2lK4wU2Pz0XlwIPDD7DUXoy9f9lHMWsX0qvXlpBW
	Nddi1BYCVCZfidcc979Bua0V5vyieHcWxqoPOsCnIv1PnS+MvmTH/Snfj7ORVcwUXg9pv3OZgBR
	XMkTTqNTYrFxCEXgFe9HzPpaQ/3n2fgOwslH32jAOj5HaIjNYOzo5CR4JSIpI2T2l2emdnSid+O
	EADjrcFlmUwTITCFlYsL80d3RfKq5D5/9jTa+XUJPaeyh1QOQyOzUQdB6TDix3DSECpFnlnCQ4q
	StR+YlouRBCmdYn58nc28xH01kTW6DuVCh31PpCjinebGTGR5Bg8K7kTUdWA9u5VgJwXos3Oe+W
	D80RICSPfpZ8Vd3GGx476KMgn7pT9HgaZx8y7V4dZ18c6u4CwBWmPF17+r1NInbqAStZ9gHZj+D
X-Received: by 2002:a05:600c:820a:b0:49f:f9d1:e618 with SMTP id 5b1f17b1804b1-4a180311281mr8069355e9.17.1791336737511;
        Tue, 06 Oct 2026 18:32:17 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:16 -0700 (PDT)
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
Subject: [PATCH v8 03/13] block: add dma-buf support for raw bdev
Date: Wed,  7 Oct 2026 02:31:46 +0100
Message-ID: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183219_463571_EA3520AC 
X-CRM114-Status: GOOD (  19.29  )
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


