Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C60C982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=; b=xNelXel2IZrkO3IVxCjnGu7tja
	+4kk5JD9hZeZ4Km7n4tSXZQseZKELAbepcSu+70onpTV68rJ8lMW8fCsYNDN+9/7hYbzEbO9s82T2
	ADPLe9YgLt8zQwIhasKV1XnL0kpzlerl/K3onfBfuDoCXlHJmOUTDZ2osxVkpqOx1JboaA3V3Dixi
	qfAZN1uanklf/UUUyHH6I0DfSZPBATsSTJgqtifc0tvw5ok4ZztbfR0p/uozYX/uAGb+JrzZEx5gp
	jQPeyD31BFYZcTaFrkv7oBKgj65By9mwKjHypHue+qVcFuk+YbKFFpeKOr9lqyQDJzLi7NYMDeToE
	/hmUjS6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWG-00000002Vi0-03mp;
	Mon, 21 Sep 2026 15:01:24 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eF8-00000002GUY-2pQG
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:39 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912d391aso20187445e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997977; x=1790602777; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=;
        b=REhWOhmjKBBJX/+EYNw2y0Uf8RvQUOxSn69P+ud0Vn4TSBkZ9gmx0bICfBTGWYrJFI
         uYarOYdiFdEaa6uLxZT0QLdXVQhlZnyDW8ctY17R3PC090+ewp0QHLd6lvNQmOTfw6am
         Ki5g12vI8NKSj5UJ+LI3RbjxaEuYfRom6PywUUn0Raw7CurvFAcB8FsFtyZgSq54lQup
         iNWx5AQ1104gddTYdk8zO8vtxvY/9K7R++DwCjz6H+Lwh5Im9dW8Wiil2VHezdi4/JWT
         ZIS8O64CdrhLVq2MLxZ7Me0FHjoCg2mhuQHp9AB34+254+dV5r26QJ3wCDmAXs3ncrzq
         e/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997977; x=1790602777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=;
        b=Yqmf1Dw/LcbFkVOc8G/ENKI9n9iwCACc7KlAVpE8xUqz87fMV+wwoh2gioJ+G4jKjL
         Aq3sEyq3GqObVIkl5CpKCIayyIPYvrjqHb2FHgp/UQX4p5kKyCgVsW/4tJpOGXbfVxAq
         3LLeZJu7cNRjb0OPxzy3aH/wl7NvlAwg+Weps8hU0f9oS707yff5UP7j6C9u/VMvka8G
         DFZj8UTozQFLq9oKn4UVtEayRVAycQMBSTBnlkR5DAV+tQV8p902n2X3kK0NVh10UpPP
         eVFT4pq3mSgZRZBeXrSCqwaDAIgEzVz4Ixh5J68ULI24A3wb4GTOyUTYq7Yz/9AYLeXF
         bpnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOg40smZ1o9sANxFY7xc8LAJvQ6Kw/XFXXD0fhEhRSZU+YmK3TyjNNn8l2Pml2LKG1Nlg7g/BI6ZB6@lists.infradead.org
X-Gm-Message-State: AFuF++lCJgceaxDvKzi0EAfnvjZJCY+FbdG2uQFE6TK4h6TB3QvG4isP
	HZusj2WNEAzrHtfMEdPJSSAvSo0cMRigfTbaeX/QWB1H7p9YZQ47fa1t
X-Gm-Gg: AYBFou2G2F2VSamh/6ufQ2PtD0Mcmoz14UCGwNRMxy1EjNOBlNUH6YIxH7AkEdijk7t
	A341y1XflhCfqE862Ww7530wQb6fhSAvlxiEAdARoVlmUviNJjjPIlE7aPOA4+ahNmTnHRSxgMO
	W5cLxqYOx0c6l36+EOufaklSYkfRs1ML5GtyWnqv2+uczHFfroFfAeoC9PknkKCMj8fFkGtLA2+
	EPVkKyQPKLKi7O1+Ruch/YktUE+AAFSYKN2tuWtbmtEg19jWfyC7E1pq97OgT8NIkJQ8nZvMcPQ
	JUiSsw7v2SQE8MDF4gXKGmNyAVyr+3lC67tlI/NR8FB0GZZLk08y+IIItvtvGSQ0K1efh7bQ7t3
	nMlzGBKdn4DWYOFAEs8SrhvsJF1O4tygZ4m1zSxay5fVB5w3AyTsfF+M/KGMV9XaO72E4CBuyLO
	ruboatXTBVtmqlajF2h6j6HDR5qgVxJyY3nLdGRrvKnLfQoSxWyhCuzF9J4V0IsxhQshwuQOLIx
	uo6w2s9v+dTC+0ueQPTBiaMNlEj5I5CIJ8ph43SFDtKsqtfmAf6ZH9rkJ7j+u57btJPQpchpwGZ
	H58dsDnr1QpAaW70LsI8xWZyEXbLhSi9veLA+i84
X-Received: by 2002:a05:600c:c493:b0:49e:74b6:740f with SMTP id 5b1f17b1804b1-49fc573603amr145209165e9.17.1789997977065;
        Mon, 21 Sep 2026 06:39:37 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:35 -0700 (PDT)
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
Subject: [PATCH v6 05/13] block: add dma-buf support for raw bdev
Date: Mon, 21 Sep 2026 14:38:49 +0100
Message-ID: <eafcbbf7e75e75e98d0791b843fae0f2423a4ecd.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063938_736212_F416B26A 
X-CRM114-Status: GOOD (  20.08  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:20 -0700
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
 block/fops.c           | 22 +++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 09fa42f8d8fa..0252d26969a4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,7 +782,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -795,6 +796,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -850,6 +854,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to)))
+		return -EOPNOTSUPP;
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -953,6 +959,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -971,6 +990,7 @@ const struct file_operations def_blk_fops = {
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


