Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17581C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:17:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA9120707
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pudv8k91";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiAbWXa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA9120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TdD7bnJLRKvEInWuggGSuLRQ+FnVcZN2iFhrckzxJCU=; b=pudv8k91W81pt9
	MzhUNvOOV/H5NeequAHo7rB5L6h31fIHVIVLSZEshguNbo5ZmQMf7eEPcOha6wTBg5iuZYpSelEaw
	O2wz+1AUmSnx9puneBhywofxm3+Hb9ASI277cAqw+VYqoDYcl81QpEZuQZhUxxqGRAxAWqWkh0E/G
	yl37gSzmrT8HnzEHf0l9R0eF3lohJR1e8UKMxoVeOeU/7RoAciffpGAPIrLQuxiAo03/dwVW1SsOp
	fDU2gUk/WOhEUtmYSCrDMoK3rRloyZxhPsZ1iLVdECl/Tg1HpUvfTw6umrDkHM6BvS+V2NqzJPUjm
	PyQg0aK18oQQs0JkcR2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jefot-0007ui-Nx; Fri, 29 May 2020 14:17:11 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jefjM-0004aS-FU
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 14:11:30 +0000
Received: by mail-pl1-x643.google.com with SMTP id bg4so1208845plb.3
 for <linux-nvme@lists.infradead.org>; Fri, 29 May 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xgMt8/Ap5gvlX6ynibkokY447a53n7PgRJd4O0S9s1g=;
 b=CiAbWXa/UnMPkO6KPS69UlWCIlGlJ0uEZUrL/5cENWQhkx+7M88kEouiTRuIcHiBFY
 cwU9+0BTLQgK0HN68/GUdBAnqo3S6tnlxi5Bv3/ATQG4kmIwqIPmLkKRuRGMWPX9/KWV
 3EYvDr6B0GQlxYU/8XYS2zwFUDtKcU4Vg65sBMsmgoiTb1k3dfRUBkfD0Lj/azF4H7ew
 2rvkTouIQR8A46Ykxge5BsK2WfM9LUqkEHGstrpRhDLO1D3xbpWs+JQtCE1oBZ9PduE8
 oARZ6xrOyeD3rFB1dbZDF0FxIDtidd7aRq++3+47eTuMo9RCJY83xZQorP61fvtph9Jb
 7/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xgMt8/Ap5gvlX6ynibkokY447a53n7PgRJd4O0S9s1g=;
 b=k90vTMOY2pTuoRqnfv6ycFCWL64KnuyWX+F54lAD985z2i4M+VvYS03DyynTm2cAk9
 9T/qDYVXfnYBgbbjZ4dqgdL1KciPTS4VLzxiLyCffl3jCJQGCvK+xp/X41cLr1+45+RV
 8ACT1z33Sf14gXk8DJ2v+UhdryQOohpf2bQxHBi+hCrr1W0Hk9/ZjPpi7jh0SJK/4bvH
 NrQSw+h4OpSV7R4cS6KNPObQYqT71ohLQaHggVVPJ/PS7Zgm34ZRcwioIyv2AJRfiFgE
 +1Ik315CJ71jlwfxx6h1hQpwmFVH8Wo03//YmJopSrXBl4iJINMMGW8aZ8BP1FVrgztb
 79QQ==
X-Gm-Message-State: AOAM53217jBc4JvLl8IUsRfVDcg52Ttal1LNUDTptifCrAivPI2J7qrm
 GJcRWORty0w0D2owoZGR3Ek=
X-Google-Smtp-Source: ABdhPJzFMCwkzDp3IkhKL3lk0R3scS2Yh0i7BgzdBQ154tbip+aLEfVcaO1NgL+5iytcLq+RymuMpA==
X-Received: by 2002:a17:90a:2622:: with SMTP id
 l31mr1765843pje.18.1590761483912; 
 Fri, 29 May 2020 07:11:23 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.67])
 by smtp.gmail.com with ESMTPSA id o25sm7048777pgn.84.2020.05.29.07.11.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 May 2020 07:11:23 -0700 (PDT)
From: Kaitao Cheng <pilgrimtao@gmail.com>
To: axboe@kernel.dk, hch@lst.de, sth@linux.ibm.com, viro@zeniv.linux.org.uk,
 clm@fb.com, jaegeuk@kernel.org, hch@infradead.org, mark@fasheh.com,
 dhowells@redhat.com, balbi@kernel.org
Subject: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Date: Fri, 29 May 2020 22:11:00 +0800
Message-Id: <20200529141100.37519-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_071128_537622_885B4151 
X-CRM114-Status: GOOD (  13.37  )
X-Mailman-Approved-At: Fri, 29 May 2020 07:17:11 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, joseph.qi@linux.alibaba.com,
 deepa.kernel@gmail.com, houtao1@huawei.com,
 Kaitao Cheng <pilgrimtao@gmail.com>, linux-s390@vger.kernel.org,
 bvanassche@acm.org, darrick.wong@oracle.com, chaitanya.kulkarni@wdc.com,
 satyat@google.com, borntraeger@de.ibm.com, ajay.joshi@wdc.com,
 gor@linux.ibm.com, chao@kernel.org, josef@toxicpanda.com, ming.lei@redhat.com,
 jlbec@evilplan.org, songmuchun@bytedance.com, dsterba@suse.com,
 sagi@grimberg.me, damien.lemoal@wdc.com, martin.petersen@oracle.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, asml.silence@gmail.com,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is a function named ilog2() exist which can replace blksize.
The generated code will be shorter and more efficient on some
architecture, such as arm64. And ilog2() can be optimized according
to different architecture.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
changes in v2:
	Remove all blksize_bits

 drivers/nvme/target/io-cmd-bdev.c            |  2 +-
 drivers/s390/block/dasd_ioctl.c              |  2 +-
 drivers/usb/gadget/function/storage_common.c |  2 +-
 fs/block_dev.c                               |  6 +++---
 fs/btrfs/disk-io.c                           |  4 ++--
 fs/buffer.c                                  |  2 +-
 fs/direct-io.c                               |  2 +-
 fs/f2fs/data.c                               |  2 +-
 fs/iomap/direct-io.c                         |  2 +-
 fs/ocfs2/super.c                             |  2 +-
 fs/romfs/super.c                             |  2 +-
 include/linux/blkdev.h                       | 11 -----------
 12 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index bcf979eb8e83..58bd947e232e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -63,7 +63,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	ns->blksize_shift = ilog2(bdev_logical_block_size(ns->bdev));
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 777734d1b4e5..55adb134451b 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -228,7 +228,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 	 */
 	if (fdata->start_unit == 0) {
 		struct block_device *bdev = bdget_disk(block->gdp, 0);
-		bdev->bd_inode->i_blkbits = blksize_bits(fdata->blksize);
+		bdev->bd_inode->i_blkbits = ilog2(fdata->blksize);
 		bdput(bdev);
 	}
 
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index f7e6c42558eb..eada3e801dd7 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -233,7 +233,7 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 		blkbits = 11;
 	} else if (inode->i_bdev) {
 		blksize = bdev_logical_block_size(inode->i_bdev);
-		blkbits = blksize_bits(blksize);
+		blkbits = ilog2(blksize);
 	} else {
 		blksize = 512;
 		blkbits = 9;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index a333a648244e..d18496dfc6e7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -115,7 +115,7 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_block_size = bsize;
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	bdev->bd_inode->i_blkbits = ilog2(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -132,7 +132,7 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (bdev->bd_block_size != size) {
 		sync_blockdev(bdev);
 		bdev->bd_block_size = size;
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		bdev->bd_inode->i_blkbits = ilog2(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -147,7 +147,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 	/* If we get here, we know size is power of two
 	 * and it's value is between 512 and PAGE_SIZE */
 	sb->s_blocksize = size;
-	sb->s_blocksize_bits = blksize_bits(size);
+	sb->s_blocksize_bits = ilog2(size);
 	return sb->s_blocksize;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7c6f0bbb54a5..711b9fc31c94 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2765,7 +2765,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 
 	fs_info->sb = sb;
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
-	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
+	sb->s_blocksize_bits = ilog2(BTRFS_BDEV_BLOCKSIZE);
 
 	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
 	if (ret)
@@ -3059,7 +3059,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
 	sb->s_blocksize = sectorsize;
-	sb->s_blocksize_bits = blksize_bits(sectorsize);
+	sb->s_blocksize_bits = ilog2(sectorsize);
 	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
 
 	mutex_lock(&fs_info->chunk_mutex);
diff --git a/fs/buffer.c b/fs/buffer.c
index fc8831c392d7..fa92e0afe349 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -907,7 +907,7 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 	loff_t sz = i_size_read(bdev->bd_inode);
 
 	if (sz) {
-		unsigned int sizebits = blksize_bits(size);
+		unsigned int sizebits = ilog2(size);
 		retval = (sz >> sizebits);
 	}
 	return retval;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 1543b5af400e..7ea2cd3effcc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1148,7 +1148,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	if (align & blocksize_mask) {
 		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+			blkbits = ilog2(bdev_logical_block_size(bdev));
 		blocksize_mask = (1 << blkbits) - 1;
 		if (align & blocksize_mask)
 			goto out;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cb05f71cf850..b896da27942a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3458,7 +3458,7 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 
 	if (align & blocksize_mask) {
 		if (bdev)
-			blkbits = blksize_bits(bdev_logical_block_size(bdev));
+			blkbits = ilog2(bdev_logical_block_size(bdev));
 		blocksize_mask = (1 << blkbits) - 1;
 		if (align & blocksize_mask)
 			return -EINVAL;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..2a807657d544 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -203,7 +203,7 @@ static loff_t
 iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
 {
-	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
+	unsigned int blkbits = ilog2(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	unsigned int align = iov_iter_alignment(dio->submit.iter);
 	struct bio *bio;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 71ea9ce71a6b..9b5622881d34 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2054,7 +2054,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	osb->osb_dx_seed[3] = le32_to_cpu(di->id2.i_super.s_uuid_hash);
 
 	osb->sb = sb;
-	osb->s_sectsize_bits = blksize_bits(sector_size);
+	osb->s_sectsize_bits = ilog2(sector_size);
 	BUG_ON(!osb->s_sectsize_bits);
 
 	spin_lock_init(&osb->dc_task_lock);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792..4f6963570739 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -470,7 +470,7 @@ static int romfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb_set_blocksize(sb, ROMBSIZE);
 	} else {
 		sb->s_blocksize = ROMBSIZE;
-		sb->s_blocksize_bits = blksize_bits(ROMBSIZE);
+		sb->s_blocksize_bits = ilog2(ROMBSIZE);
 	}
 #endif
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7d10f4e63232..16038b609c14 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1502,17 +1502,6 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
 	return !(addr & alignment) && !(len & alignment);
 }
 
-/* assumes size > 256 */
-static inline unsigned int blksize_bits(unsigned int size)
-{
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
-}
-
 static inline unsigned int block_size(struct block_device *bdev)
 {
 	return bdev->bd_block_size;
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
