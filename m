Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B137C54F5E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=; b=4N3sy5dmO8GHwAl6tYDkNUuCaS
	VnEqC4HLtq+NOKs9kkV60OcosbrCysVYOrYLqkVvdO13cIBTT8GDVX+xlh+3EZYLm9+ksuaV6MyEa
	lT7apUVI2t5DjE00EWPB65pJ9MNv9I6P53Y6k+Vh7kHk90Y/278hwt8gWEFrDrX+5wFBZYZRNm7rJ
	6FYOOXrRLR2VUlULtYMSGR7vJoZLoSnfZ0Z+8ZmkEeVf5TsCX07RRwrsKM+DdtRe/8UNb+eghWFOU
	WVwMQaggEir0K4z5zC78Ew2g3j9h2KfEwKXNy9n1zRyV3YPhQL5VjCGgTVOXch5b2P7feVAE1u01F
	Faiqvc3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqI-00000006fSc-2Xis;
	Wed, 29 Jul 2026 02:16:22 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopN8-00000006KN0-0cJG
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:29:59 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so240989f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274196; x=1785878996; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
        b=rkYIreMA38Ty2GP49chBKknTxeiLEj8czFisJAXf+P8jBlR/hYKSgtfcExGn+Te/wX
         OsKUmyk24sP7kyvwCIx4TC/E/e+QR0m1Q99+vU6i1CRey186FHoNahOfwCV9oNK+cu0U
         z3m0ghbwOiJJXpMxlnSi6YrEfW8V8hLn4AWH+I5Lej4V+huOSSQzSdvqwOj02E0n3lKr
         9bAKDQ9kMEcf6jRjIqJ3FAwia0FJojs81p3KAcgThIVXZ3nF/UkiznM09YNZA/Mvt7mE
         Z8SzZzIftEM366nGGKZLc8buZ2xVR5E9rAOIUoAuIDfNC1HHIj8L42nuL01my2utFo1P
         cEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274196; x=1785878996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
        b=gL6LdtZEkRxGtKDRlKhVFwwp3XRhpHcu1lYw9u+Ufu4m+OWyy+HcwOvjp5aW2S3l5Z
         TQotAZx6aFZ7kj2zfNbHhEy4PSb+4P5qCEWAgamIBNv+1zvepo4VMmRsRnr6ywA8OW8V
         siy4tYUAA3tLUnOwQ+sLyczFDQXEb1ArPPM1i87W9J3ofmnUZdesT8O7rFHcbm71fzB/
         N8BYprAlZyj8GLlBwrPFs+m8K7NEY/2Q6gzej4kynk8L1iwyBD12y6OIrstG7zuRep3k
         Kc376Mqy61vw0S0asHwwgebwt0GMaU99NxvaaJXeCWa2Y9QZNmJEQAEw28osnBwkVqB/
         C+jg==
X-Forwarded-Encrypted: i=1; AHgh+Rqei6/bMEIh6KY3fy9TgL8n7MQCVnVbAq9RzrJhvxiT+oz2XtvoSnu9yyrRZ4/Z13xyxw1DGyl9+8lb@lists.infradead.org
X-Gm-Message-State: AOJu0YxNOdyxjB/SXQGpoYrimSL6/GaSueAtF4Y7ca2haDvfxtBkMy9e
	8W1if107H1nl9mSbnZNczu7VYfqzI9UTZYtGVpEI8jz5UcR7L5tupfy9
X-Gm-Gg: AR+sD13cksM1oV1UU/DriERLwJXLpi0RT/Og6smHnErIweNcdecYKRWvJ1rB2auRYFb
	f9cvy4gw2+0aI7me0L1Q0JjTtPSC2JkY9U7eNnf8LRNU5Vbs31ngREc13UZPMnqzDKFIfPUC+dh
	VP85b8g5kCYnebmNNxvYAVTB9gWPdRQlnORWXKYW4oa27mGX1Q2lpiW7dpF0JiRYsVkjgN/9PQE
	RACktngU7G2qiq1lSclnYmnVF2H+l1ncJmNwz87ZrR71ElB3wk93Hd6j7mH6qF36HANPnxSk6sX
	7JtNQqllvPmYd82P1sSbjYGP2oH3qpWE74eeMvwTgbJyxy6HNtgC4ZdGLxxnDctNj9jrLWgeatl
	yNh4K6cy/DxvvsJVat33GGQc7pAIn68l4U37kPYTa5h5zbUIrms9Bp2KFnWJnPfkb31HCQqyqzK
	49EtDl5yJduzQ6c6Q4SzsiLIKoHAnepyrKt6/qr0ZUbJp+14upOIQoETQg8YMoZg4Uy0ot+UAtg
	Gy36Qwi
X-Received: by 2002:a5d:5d09:0:b0:47f:94a8:d6db with SMTP id ffacd0b85a97d-47fb1f14a61mr4656094f8f.34.1785274196213;
        Tue, 28 Jul 2026 14:29:56 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:54 -0700 (PDT)
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
Subject: [PATCH v4 07/14] block: forward init_dma_buf_io_ctx to drivers
Date: Tue, 28 Jul 2026 22:29:19 +0100
Message-ID: <e0cc82a15419ba7b38eb0bb00ae34cf3d0c3a938.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_142958_203948_FAFC27AC 
X-CRM114-Status: GOOD (  15.50  )
X-Mailman-Approved-At: Tue, 28 Jul 2026 19:16:17 -0700
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
the call to a new struct block_device_operations operation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 37d491f45015..d83cdbab65a6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -926,6 +926,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -944,6 +957,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
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


