Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F104EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FF760200
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1FF760200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vRl4Zm9Wc0bX9vcfgcN3R2fcrAySbja8d/dJRwsxk/k=; b=fPz1V4t8Ywq/1vZBr0YOPyCIhC
	wWsWJr6A/JXMnOQkczJnHKU/kjPU150ecvdjIhwpF3axYGiQ+iqT8qvpKkF3zE+P5D4WgcxQ7jxQ5
	vPtVQxgGTJ9jnhIbsQflRple7WdtpPlIJ/v3/ch9yK+PaghbTjoht8YQT20Tw3xj/CWwyN/KvrCpA
	0EKPTxsTxjKbsImuCLVTcu6Brym/0xIs6U4oGNnEZ6DvxibdqUBzmPbQYjxEBlALw0L1H0pqxtmmn
	BwyD0TknnJthW3Fl1WoCSbiv19Pu2YwiD74a5RUMYe3cXyuPv9Bqznv39qXRxOjsRx603PGl77bVD
	Zo7y9I3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbNTG-007KGh-Lf; Fri, 15 Oct 2021 13:42:02 +0000
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNEz-007D1k-7p; Fri, 15 Oct 2021 13:27:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, "Theodore Ts'o" <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 12/30] btrfs: use bdev_nr_bytes instead of open coding it
Date: Fri, 15 Oct 2021 15:26:25 +0200
Message-Id: <20211015132643.1621913-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 Oct 2021 06:36:25 -0700
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

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 fs/btrfs/dev-replace.c | 3 +--
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/ioctl.c       | 4 ++--
 fs/btrfs/volumes.c     | 8 ++++----
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d029be40ea6f0..fbb8b4457a721 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -283,8 +283,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 
-	if (i_size_read(bdev->bd_inode) <
-	    btrfs_device_get_total_bytes(srcdev)) {
+	if (bdev_nr_bytes(bdev) < btrfs_device_get_total_bytes(srcdev)) {
 		btrfs_err(fs_info,
 			  "target device is smaller than source device!");
 		ret = -EINVAL;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 355ea88d5c5f7..29e7598584c4c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3740,7 +3740,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	else if (ret)
 		return ERR_PTR(ret);
 
-	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
+	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
 	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cc61813213d83..36ff713da1b12 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1730,7 +1730,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	}
 
 	if (!strcmp(sizestr, "max"))
-		new_size = device->bdev->bd_inode->i_size;
+		new_size = bdev_nr_bytes(device->bdev);
 	else {
 		if (sizestr[0] == '-') {
 			mod = -1;
@@ -1771,7 +1771,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		ret = -EINVAL;
 		goto out_finish;
 	}
-	if (new_size > device->bdev->bd_inode->i_size) {
+	if (new_size > bdev_nr_bytes(device->bdev)) {
 		ret = -EFBIG;
 		goto out_finish;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ec3b8ac8fa35..676c7c4e6e59d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1286,7 +1286,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	pgoff_t index;
 
 	/* make sure our super fits in the device */
-	if (bytenr + PAGE_SIZE >= i_size_read(bdev->bd_inode))
+	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
 	/* make sure our super fits in the page */
@@ -2610,8 +2610,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->io_width = fs_info->sectorsize;
 	device->io_align = fs_info->sectorsize;
 	device->sector_size = fs_info->sectorsize;
-	device->total_bytes = round_down(i_size_read(bdev->bd_inode),
-					 fs_info->sectorsize);
+	device->total_bytes =
+		round_down(bdev_nr_bytes(bdev), fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
@@ -7236,7 +7236,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 
 	fill_device_from_item(leaf, dev_item, device);
 	if (device->bdev) {
-		u64 max_total_bytes = i_size_read(device->bdev->bd_inode);
+		u64 max_total_bytes = bdev_nr_bytes(device->bdev);
 
 		if (device->total_bytes > max_total_bytes) {
 			btrfs_err(fs_info,
-- 
2.30.2


