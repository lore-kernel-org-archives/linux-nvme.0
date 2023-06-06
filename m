Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88607C7EE33
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 07:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/taWYn/VrvQVP7vJekvmlkcZ3skKwwlLMp5HGMR5SQ=; b=gMvD5UjU75e6l9plz8XjXszRMM
	BzUqVdDD6abbcC/3gQiHC0I59Zj2vj+jALl09arkfn1Jg8vd0bmX8Jr+kWAwIjRnWcNV4vVbDOlPo
	Xjv9+uGUkif2rN/8DUdACB7QgVQrlqv06+SWl4vtiB50t85FqwkApv0ngTn9hX+M809Eim3HEYKGK
	kVig7FG5rnnvlJcLwNbOM917Ii0xee8U0n/fbwh7LT7Ra9syuB7KTqWMN4V/wBRAj9ZQVs+SxGfjP
	PTwmIVZyzrSk6NUnVS34XYO6abMG/9rwk+G2iB0GL7xtLCWQtCjzH0H0d2cSJH0PQGYri3W2skOdT
	UZRDZz0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RKh-000b78-1u;
	Tue, 06 Jun 2023 07:42:23 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RJB-000ZUg-1x;
	Tue, 06 Jun 2023 07:40:50 +0000
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
Subject: [PATCH 17/31] block: add a sb_open_mode helper
Date: Tue,  6 Jun 2023 09:39:36 +0200
Message-Id: <20230606073950.225178-18-hch@lst.de>
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

Add a helper to return the open flags for blkdev_get_by* for passed in
super block flags instead of open coding the logic in many places.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c       |  5 +----
 fs/nilfs2/super.c      |  7 ++-----
 fs/super.c             | 15 ++++-----------
 include/linux/blkdev.h |  7 +++++++
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1a2ee9407f5414..fd02b92e39106a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1440,12 +1440,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_fs_info *fs_info = NULL;
 	void *new_sec_opts = NULL;
-	fmode_t mode = FMODE_READ;
+	fmode_t mode = sb_open_mode(flags);
 	int error = 0;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
 	if (data) {
 		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
 		if (error)
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 61d5e79a5e81df..a41fd84d4e28ab 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1278,14 +1278,11 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 {
 	struct nilfs_super_data sd;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ;
 	struct dentry *root_dentry;
 	int err, s_new = false;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
-	sd.bdev = blkdev_get_by_path(dev_name, mode, fs_type, NULL);
+	sd.bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
+				     NULL);
 	if (IS_ERR(sd.bdev))
 		return ERR_CAST(sd.bdev);
 
diff --git a/fs/super.c b/fs/super.c
index 8563794a8bc462..dc7f328398339d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1255,17 +1255,13 @@ int get_tree_bdev(struct fs_context *fc,
 {
 	struct block_device *bdev;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ;
 	int error = 0;
 
-	if (!(fc->sb_flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type,
-				  &fs_holder_ops);
+	bdev = blkdev_get_by_path(fc->source, sb_open_mode(fc->sb_flags),
+				  fc->fs_type, &fs_holder_ops);
 	if (IS_ERR(bdev)) {
 		errorf(fc, "%s: Can't open blockdev", fc->source);
 		return PTR_ERR(bdev);
@@ -1344,13 +1340,10 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 {
 	struct block_device *bdev;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ;
 	int error = 0;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
-	bdev = blkdev_get_by_path(dev_name, mode, fs_type, &fs_holder_ops);
+	bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
+				  &fs_holder_ops);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5b99796f12c11..97803603902076 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1473,6 +1473,13 @@ struct blk_holder_ops {
 	void (*mark_dead)(struct block_device *bdev);
 };
 
+/*
+ * Return the correct open flags for blkdev_get_by_* for super block flags
+ * as stored in sb->s_flags.
+ */
+#define sb_open_mode(flags) \
+	(FMODE_READ | (((flags) & SB_RDONLY) ? 0 : FMODE_WRITE))
+
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
-- 
2.39.2


