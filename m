Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF6C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:15:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C612060F22
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C612060F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gZf+H891s0ly+N+We+WSsOR96hNSH99XqMkm5gKgvI=; b=J6it/Sl4bGaGE4PrS3z8vnpUC2
	BLORzWjhuXoEJebIC0eL4A1UeJhgvc4+2PBSV+aKJOm0ocVllIKvfQ3b/poDiyLNMHU+IRNAQ4bmh
	lFC/pob4eBlozzt8abspbs6i2D989BKj5Ibq5Zn/kA6vMp5AWr6MhO08k5f6puw5xESPkLUA58QO1
	zP915eJzrGLhTePJhIH1NSHVQyrK/v3/BYXATninfnmZcaz/eEiwvzXSzG3geOkx5847ZMaGUTuCO
	PGJnkusPXsLrmPCswiwpfWsZaxiu3Jo1TPBALqUGfU0jnnK0pJAelXQ3eqMOX8Bx0nTIeoM34MTSK
	hxhs34oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcPgL-00Ewo0-8R; Mon, 18 Oct 2021 10:15:49 +0000
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcPcT-00Eu4B-82; Mon, 18 Oct 2021 10:11:49 +0000
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
 reiserfs-devel@vger.kernel.org
Subject: [PATCH 06/30] md: use bdev_nr_sectors instead of open coding it
Date: Mon, 18 Oct 2021 12:11:06 +0200
Message-Id: <20211018101130.1838532-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Oct 2021 03:14:03 -0700
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ec09083ff0eff..0c75ba047ef60 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -890,8 +890,7 @@ static struct md_personality *find_pers(int level, char *clevel)
 /* return the offset of the super block in 512byte sectors */
 static inline sector_t calc_dev_sboffset(struct md_rdev *rdev)
 {
-	sector_t num_sectors = i_size_read(rdev->bdev->bd_inode) / 512;
-	return MD_NEW_SIZE_SECTORS(num_sectors);
+	return MD_NEW_SIZE_SECTORS(bdev_nr_sectors(rdev->bdev));
 }
 
 static int alloc_disk_sb(struct md_rdev *rdev)
@@ -1633,8 +1632,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	 */
 	switch(minor_version) {
 	case 0:
-		sb_start = i_size_read(rdev->bdev->bd_inode) >> 9;
-		sb_start -= 8*2;
+		sb_start = bdev_nr_sectors(rdev->bdev) - 8 * 2;
 		sb_start &= ~(sector_t)(4*2-1);
 		break;
 	case 1:
@@ -1789,10 +1787,9 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		else
 			ret = 0;
 	}
-	if (minor_version) {
-		sectors = (i_size_read(rdev->bdev->bd_inode) >> 9);
-		sectors -= rdev->data_offset;
-	} else
+	if (minor_version)
+		sectors = bdev_nr_sectors(rdev->bdev) - rdev->data_offset;
+	else
 		sectors = rdev->sb_start;
 	if (sectors < le64_to_cpu(sb->data_size))
 		return -EINVAL;
@@ -2170,8 +2167,7 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 		return 0; /* too confusing */
 	if (rdev->sb_start < rdev->data_offset) {
 		/* minor versions 1 and 2; superblock before data */
-		max_sectors = i_size_read(rdev->bdev->bd_inode) >> 9;
-		max_sectors -= rdev->data_offset;
+		max_sectors = bdev_nr_sectors(rdev->bdev) - rdev->data_offset;
 		if (!num_sectors || num_sectors > max_sectors)
 			num_sectors = max_sectors;
 	} else if (rdev->mddev->bitmap_info.offset) {
@@ -2180,7 +2176,7 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 	} else {
 		/* minor version 0; superblock after data */
 		sector_t sb_start, bm_space;
-		sector_t dev_size = i_size_read(rdev->bdev->bd_inode) >> 9;
+		sector_t dev_size = bdev_nr_sectors(rdev->bdev);
 
 		/* 8K is for superblock */
 		sb_start = dev_size - 8*2;
@@ -3384,7 +3380,7 @@ rdev_size_store(struct md_rdev *rdev, const char *buf, size_t len)
 			if (!sectors)
 				return -EBUSY;
 		} else if (!sectors)
-			sectors = (i_size_read(rdev->bdev->bd_inode) >> 9) -
+			sectors = bdev_nr_sectors(rdev->bdev) -
 				rdev->data_offset;
 		if (!my_mddev->pers->resize)
 			/* Cannot change size for RAID0 or Linear etc */
@@ -3711,7 +3707,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 
 	kobject_init(&rdev->kobj, &rdev_ktype);
 
-	size = i_size_read(rdev->bdev->bd_inode) >> BLOCK_SIZE_BITS;
+	size = bdev_nr_bytes(rdev->bdev) >> BLOCK_SIZE_BITS;
 	if (!size) {
 		pr_warn("md: %s has zero or unknown size, marking faulty!\n",
 			bdevname(rdev->bdev,b));
@@ -6882,7 +6878,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 
 		if (!mddev->persistent) {
 			pr_debug("md: nonpersistent superblock ...\n");
-			rdev->sb_start = i_size_read(rdev->bdev->bd_inode) / 512;
+			rdev->sb_start = bdev_nr_sectors(rdev->bdev);
 		} else
 			rdev->sb_start = calc_dev_sboffset(rdev);
 		rdev->sectors = rdev->sb_start;
@@ -6969,7 +6965,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	if (mddev->persistent)
 		rdev->sb_start = calc_dev_sboffset(rdev);
 	else
-		rdev->sb_start = i_size_read(rdev->bdev->bd_inode) / 512;
+		rdev->sb_start = bdev_nr_sectors(rdev->bdev);
 
 	rdev->sectors = rdev->sb_start;
 
-- 
2.30.2


