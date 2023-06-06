Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A325C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bx845IbLKzkGRvWV55FKIp8e9aTOJjM9m43DuTWzdx0=; b=dqYCh0WnZctm+0VIa0e03Zmdl/
	DKPmcGtp86OCIee0daYtXyfszTa+OGfVsZfbzq8VIFRMhLP30ZzuD+BkUM8El5IpioQrknUZmhRmv
	gl8Dz4VVJe6UStiJciKgeDoeX7GC4dRQYlOnZ+ayMnzidIqUiu9Mb4vY44JPc+LHtzA12u9RqsAa4
	BYptbYx4YK4e3AbyjkVwbgA++2Abf1OD6VczgLZGceHTjgh748nm/JhxLCPKSHJ3AMUr2gtfBmaBG
	sAm+oLKD58z6hiAbrRJxRyht4R68h1KBcV8Hf5RceIeBaxf1BLG72XvXlt6v+/+/WuWrOZLYl3V6K
	56ywuq7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RKn-000bDD-25;
	Tue, 06 Jun 2023 07:42:29 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RJE-000ZZD-1u;
	Tue, 06 Jun 2023 07:40:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 18/31] fs: remove sb->s_mode
Date: Tue,  6 Jun 2023 09:39:37 +0200
Message-Id: <20230606073950.225178-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There is no real need to store the open mode in the super_block now.
It is only used by f2fs, which can easily recalculate it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/super.c    | 10 ++++++----
 fs/nilfs2/super.c  |  1 -
 fs/super.c         |  2 --
 include/linux/fs.h |  1 -
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a5adb1d316e331..5a764fecd1c7ef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3993,6 +3993,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	unsigned int max_devices = MAX_DEVICES;
 	unsigned int logical_blksize;
+	fmode_t mode = sb_open_mode(sbi->sb->s_flags);
 	int i;
 
 	/* Initialize single device information */
@@ -4024,8 +4025,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 		if (max_devices == 1) {
 			/* Single zoned block device mount */
 			FDEV(0).bdev =
-				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev,
-					sbi->sb->s_mode, sbi->sb->s_type, NULL);
+				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
+						  sbi->sb->s_type, NULL);
 		} else {
 			/* Multi-device mount */
 			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
@@ -4043,8 +4044,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
 			}
-			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
-					sbi->sb->s_mode, sbi->sb->s_type, NULL);
+			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
+							  sbi->sb->s_type,
+							  NULL);
 		}
 		if (IS_ERR(FDEV(i).bdev))
 			return PTR_ERR(FDEV(i).bdev);
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index a41fd84d4e28ab..15a5a1099427d8 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1316,7 +1316,6 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 		s_new = true;
 
 		/* New superblock instance created */
-		s->s_mode = mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", sd.bdev);
 		sb_set_blocksize(s, block_size(sd.bdev));
 
diff --git a/fs/super.c b/fs/super.c
index dc7f328398339d..86f40f8981989d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1308,7 +1308,6 @@ int get_tree_bdev(struct fs_context *fc,
 		blkdev_put(bdev, fc->fs_type);
 		down_write(&s->s_umount);
 	} else {
-		s->s_mode = mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
 					fc->fs_type->name, s->s_id);
@@ -1382,7 +1381,6 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		blkdev_put(bdev, fs_type);
 		down_write(&s->s_umount);
 	} else {
-		s->s_mode = mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
 					fs_type->name, s->s_id);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7b2053649820cc..ad1d2c9afb3fa4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1215,7 +1215,6 @@ struct super_block {
 	uuid_t			s_uuid;		/* UUID */
 
 	unsigned int		s_max_links;
-	fmode_t			s_mode;
 
 	/*
 	 * The next field is for VFS *only*. No filesystems have any business
-- 
2.39.2


