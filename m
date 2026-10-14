Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A82ACC6B33
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=; b=m5xw89qya6VkHLtqZt1ymSUamI
	eADTFcll59UZtS6eAC7T0We4r+2970UzbgbpJHCFfrh7Lj5D+Iyhkq5HCiTZmxfN8RqoC+Muc5Eza
	NzYLcUNWGN4JnySlNuzYnWzJSYowBdNWuHw5XdpUlAc3yDqVlWAYhQmOIgVfU75vOowTFR+OvZt05
	YiR8zOZzcdKssnUAJ8sGOJurO7IPEPfsvB53xdaHtuRg09Zz8kMBQMpePhYfwhb35U0HQZRuaPKob
	zFRriV8CgJFb/XJuJGJzhpil8LU2cqsn7Nt0qi0Kzjr2KU38Wy02noyMb11PGBIagrJnU2jZffdpC
	bEvDENew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMyk-00000000UI8-0tIj;
	Thu, 15 Oct 2026 15:02:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwki-0000000FH45-0fSM
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:02:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=; b=oRQM0PvxlHG0HgBNe31YWyUKBY
	/neu6ces2Qt+axjwvs7ovvywJr5wbSxIyJlYlanrr0rzJ6fkcgSmKHd5T88SNz0aqMo9Viyy5BFm8
	cvS9WwzRBRXz5NUvSTervuHMIZo5kxlo9L7eHYAnaOoZZOXnwUx6m8b1OtvFisXy5n8ym4WyUawy2
	BS7LL3BC8Z2GsgYWRQ4zULWClP5IlfwjBpSaucHvTya0hMUwgWkmxhMVp1fmontLYjPsy4AGIhyyi
	xnZwXAFTgdrZkZg3Xu8BxgcJF9H40cNGOH5UCxTqsuXS24m6kc26kDgKAqZYGtvvTHogfKSePIc84
	cOeQRyMA==;
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwkf-0000000Gf2X-11mT
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:30 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so8280865e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975748; x=1792580548; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=LUpjeeFmFt6C6BPZaV9kFiu3j6vzXbVfLoIoipqtlEmxWHb9HbG+q/BnvqUXYyTI5V
         qhO2eUrcR/oQaUszQu2VfAhGFpKq/oAWSLtmtQZUtiozjmPZa1fG/vrwFG6iLjaSwXMS
         /Ks380WbRL6dWdjUD+FcM+JBJHHqXG7e8yQ4NRcVN7bm8MSKJ67PSv34aOSnt7VhAPZ2
         bKjdqiuI7IafdyDaeM1oxp8WZZ2WE7Tz/Vq6iBvSjAPoLC5bEUIuQuW02qN6L0Vo6j2s
         4+oocwtiGsKa49+ekDDL1l5iY0LPTTf74oN+Vq0x996raPDhgH8hHaNkXVl4N9/CURZS
         838g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975748; x=1792580548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
        b=ZTUJAjKxuFrQkC0gtBWB0oA/T6uxvP5mc+pg+Xvlfq4kH5PyjG1g0yLxj6alL+gPGa
         fU9pyXv2GKOnxBe8tGWQlxtXCjc1gSrhrzvmI96DeRs0xsdNhH0rK35YPfUP2w/Bvncf
         Z1pIyuy8iafn6IIGidYHhiowHVAehhdRXYg9VCe192YE89Y+ghNaQb74r3dVQ0FIBlFR
         FhyFhmcGWl+iBxrHV3CapaxWd6qQsaf2oqsWQIm0waYqCjLcblRLw5Hz9sNxo2j+9R/m
         gQqcCw1XN+rOm1btlYIrjxBMXlh7jwiIHsWeH3OckolfZJPyYDsbDIHfGgrpszFNUsj4
         CYCA==
X-Forwarded-Encrypted: i=1; AKwUvBwI4opcJ6kWpIv1yDyYlO5aHIJwCjevptPIey9oHxqftw1NlVsM4kj54gAO/Gdgi2H438ZWYJnXCaqM@lists.infradead.org
X-Gm-Message-State: AFq9FYJDn/IagDaPzhKqoh2UdR0pjnrklCs2PsmynY0/za1iX32Y2tC3
	dAeduPUasVcz5q1+jJIxmma/lPvZi3NFiTa/5p7yNHgwtGhQFxpCwDZA
X-Gm-Gg: AYBFou2zHXZDBWQTN8U6G+PEoQHgWj1QqvOE2S73ytC9GYMjwFEj5/Eh+0N7l7B8gaS
	ZakDiG/l76ZvjOiJrEUHYIiX61yttqQyadYA9LLO4ukcDljK8jW0kuzSj8p3D8/6ZfkxUBYEaLz
	qgjrXlHNtYGr460gHIFbwm62u/J1uZ3VvOSufXsjcKaZLImO94OL97KnspZTbSbFsWI/XDDu80F
	8cQ4b7TIY049BuEPXUYlF8ZqIWXcl05oYlq5Vqvc6V8vr5Jc+jDKygzmxCJSBIy2uOugniLKkCf
	zI377ZNgQQ4htk5yOyCLZ1r+lp3WtQGNkH78G3e6sY49J/Yk4kStlShlaERLEuGDA60ZvtpDf20
	b71tid3gsA7lu1M9hsOV975ELDoY4k7QFvvw0WysdtwFGi3RkjQ/pA4FcAa65b1lbTm+uO3gmYd
	+sTBSxtEeArU8W3XrDtIFr8uKRr3h0cvGDvVZCD+uhwgz5/qX2DNFeFAFG97Ds6RpyOGqFC8Kbj
	YwoSDRmXtCE+SdIFvTaXsqWt/ScYwnPvE1o7T03uUBtdizzjYiIpEQsms3H5eCSudrG8wywX70E
X-Received: by 2002:a05:600c:8716:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a18e44885dmr316691205e9.2.1791975747413;
        Wed, 14 Oct 2026 04:02:27 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:26 -0700 (PDT)
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
Subject: [PATCH v11 05/13] block: add dma-buf support for raw bdev
Date: Wed, 14 Oct 2026 12:02:03 +0100
Message-ID: <c01c4709dc55a12fb0f2fe1ec847b5f1f0c92789.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120229_386886_D22FBB2E 
X-CRM114-Status: GOOD (  19.90  )
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


