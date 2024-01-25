Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08058C47422
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLhezGN2ooOqwf1rRyp++iPoYB+U7gUCrqzkKgaViR0=; b=uyuoWHROecd1zrMX+m6kD0yhUR
	0d/lflHP0zGg4JUoiz+DK1FQe6E8RDVKXV0NG3oGZ+IsTUaCB30BzGe89BxKy571I2Z1qg/Zzefol
	yYhgJ6AYD3NTbL2oDBrb4TG9j69d5gFTgOoKX7HOaozD6E/lBkrAEcEIZimpyRUj1ngDOzVZrOk/p
	8NuzPY9tmpICLozZO6+gYc5x5OC9gjIaoOSTbe3kn+BYtd4WTSWkTbZNV6gvkF9Nzj6zy967b9f1G
	Z7DSAaIyQXGMThn2B4/pryh4+9IV/TSo8cTItCWPvIblyZ8p5H4NPk7+bZAk9hPpUheO3pJwcX6P/
	B0Ld09hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2zH-00000000yLn-1qIP;
	Thu, 25 Jan 2024 16:53:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2zE-00000000yIw-1XXO
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 16:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201636; x=1737737636;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aOQGuVXVKnWXSkXzQjMJhwwtHyTg4oH1lbCa+QOjXsc=;
  b=SH5dYK4Z6f5eRtfrpYW+pbJ5TCS0rZFLjST9bev3WPl3AWMDww6xaezC
   Gfhv6ORShAPaX8lUjt76/pqlXUMtExE/uYJdGcETjXVWUxLTRYJvPfr3I
   0ICPBCbvrKdecWo/KnQwf0UeCthtAyDyRQ1s83LzBESTBZ4EfgjDc5CPN
   iyIc3Yo10ViYPRaoVsPWVOSx54iW3WFI90GoHBCVaWqVhjBjLLahEC7I9
   qbMMfWqCJAOSLV7akI/BKnAs8G4Zp4K68J4om1fxh6oDgG2h6P3ozuzAa
   IqvQi0Aoa51JHpyMzAXupS8kxjj45JCIX5R1HUuSx/NeI9hSuQBI/9QNj
   g==;
X-CSE-ConnectionGUID: 5QYYMvezRM6j09wlxQksaw==
X-CSE-MsgGUID: KFWovhU0RAysSYs7sD1dBw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7456590"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:53 +0800
IronPort-SDR: Ruhap+7q03JEMabcF4mC7wDtUcmntf4lEHOtoP3mJLLV8C1WfAqGzNsJ3wrU6JGjboNvpmYrlL
 U7Zc9C0GxIJA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 07:58:13 -0800
IronPort-SDR: TBCDD4Thkm8BrPR1XzWIPOZqfzdkz1041ne0LyGGutnRmfcC/stR3be2CIXXIpt7JC9paTeRFa
 RFgyYlmFlmlA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:49 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 25 Jan 2024 08:53:28 -0800
Subject: [PATCH v2 5/5] block: remove gfp_flags from blkdev_zone_mgmt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-zonefs_nofs-v2-5-2d975c8c1690@wdc.com>
References: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
In-Reply-To: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=8572;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=aOQGuVXVKnWXSkXzQjMJhwwtHyTg4oH1lbCa+QOjXsc=;
 b=8HbsS72JbdVISVJtRSkp1fHOlxfE3YR6cby4sKXHjUFnvYpEI/MMFArO04UDtfIQfvhJkYxY5
 sfwKGXTd9KAAbvVOsOHpZ6pmMpLCZkWaDj9z/EQE1RRI+WHbigR7Vc0
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_085356_515060_2DAF7E43 
X-CRM114-Status: GOOD (  18.75  )
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

Now that all callers pass in GFP_KERNEL to blkdev_zone_mgmt() and use
memalloc_no{io,fs}_{save,restore}() to define the allocation scope, we can
drop the gfp_mask parameter from blkdev_zone_mgmt() as well as
blkdev_zone_reset_all() and blkdev_zone_reset_all_emulated().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c         | 19 ++++++++-----------
 drivers/nvme/target/zns.c |  5 ++---
 fs/btrfs/zoned.c          | 14 +++++---------
 fs/f2fs/segment.c         |  4 ++--
 fs/zonefs/super.c         |  2 +-
 include/linux/blkdev.h    |  2 +-
 6 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d343e5756a9c..d4f4f8325eff 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -177,8 +177,7 @@ static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int idx,
 	}
 }
 
-static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
-					  gfp_t gfp_mask)
+static int blkdev_zone_reset_all_emulated(struct block_device *bdev)
 {
 	struct gendisk *disk = bdev->bd_disk;
 	sector_t capacity = bdev_nr_sectors(bdev);
@@ -205,7 +204,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
 		}
 
 		bio = blk_next_bio(bio, bdev, 0, REQ_OP_ZONE_RESET | REQ_SYNC,
-				   gfp_mask);
+				   GFP_KERNEL);
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
 
@@ -223,7 +222,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
 	return ret;
 }
 
-static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
+static int blkdev_zone_reset_all(struct block_device *bdev)
 {
 	struct bio bio;
 
@@ -238,7 +237,6 @@ static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
  * @sector:	Start sector of the first zone to operate on
  * @nr_sectors:	Number of sectors, should be at least the length of one zone and
  *		must be zone size aligned.
- * @gfp_mask:	Memory allocation flags (for bio_alloc)
  *
  * Description:
  *    Perform the specified operation on the range of zones specified by
@@ -248,7 +246,7 @@ static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
  *    or finish request.
  */
 int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
-		     sector_t sector, sector_t nr_sectors, gfp_t gfp_mask)
+		     sector_t sector, sector_t nr_sectors)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
@@ -285,12 +283,12 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 	 */
 	if (op == REQ_OP_ZONE_RESET && sector == 0 && nr_sectors == capacity) {
 		if (!blk_queue_zone_resetall(q))
-			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);
-		return blkdev_zone_reset_all(bdev, gfp_mask);
+			return blkdev_zone_reset_all_emulated(bdev);
+		return blkdev_zone_reset_all(bdev);
 	}
 
 	while (sector < end_sector) {
-		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, gfp_mask);
+		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, GFP_KERNEL);
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
 
@@ -419,8 +417,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return -ENOTTY;
 	}
 
-	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
-			       GFP_KERNEL);
+	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
 
 fail:
 	if (cmd == BLKRESETZONE)
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 5b5c1e481722..3148d9f1bde6 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -456,8 +456,7 @@ static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
 	switch (zsa_req_op(req->cmd->zms.zsa)) {
 	case REQ_OP_ZONE_RESET:
 		ret = blkdev_zone_mgmt(req->ns->bdev, REQ_OP_ZONE_RESET, 0,
-				       get_capacity(req->ns->bdev->bd_disk),
-				       GFP_KERNEL);
+				       get_capacity(req->ns->bdev->bd_disk));
 		if (ret < 0)
 			return blkdev_zone_mgmt_errno_to_nvme_status(ret);
 		break;
@@ -508,7 +507,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 		goto out;
 	}
 
-	ret = blkdev_zone_mgmt(bdev, op, sect, zone_sectors, GFP_KERNEL);
+	ret = blkdev_zone_mgmt(bdev, op, sect, zone_sectors);
 	if (ret < 0)
 		status = blkdev_zone_mgmt_errno_to_nvme_status(ret);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 05640d61e435..cf2e779d8ef4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -830,8 +830,7 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 
 			nofs_flags = memalloc_nofs_save();
 			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-					       reset->start, reset->len,
-					       GFP_KERNEL);
+					       reset->start, reset->len);
 			memalloc_nofs_restore(nofs_flags);
 			if (ret)
 				return ret;
@@ -984,7 +983,7 @@ int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 				nofs_flags = memalloc_nofs_save();
 				ret = blkdev_zone_mgmt(device->bdev,
 						REQ_OP_ZONE_FINISH, zone->start,
-						zone->len, GFP_KERNEL);
+						zone->len);
 				memalloc_nofs_restore(nofs_flags);
 				if (ret)
 					return ret;
@@ -1023,8 +1022,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 	nofs_flags = memalloc_nofs_save();
 	ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
 			       zone_start_sector(sb_zone, bdev),
-			       zone_sectors * BTRFS_NR_SB_LOG_ZONES,
-			       GFP_KERNEL);
+			       zone_sectors * BTRFS_NR_SB_LOG_ZONES);
 	memalloc_nofs_restore(nofs_flags);
 	return ret;
 }
@@ -1143,8 +1141,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 	*bytes = 0;
 	nofs_flags = memalloc_nofs_save();
 	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
-			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
-			       GFP_KERNEL);
+			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT);
 	memalloc_nofs_restore(nofs_flags);
 	if (ret)
 		return ret;
@@ -2258,8 +2255,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		nofs_flags = memalloc_nofs_save();
 		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
 				       physical >> SECTOR_SHIFT,
-				       zinfo->zone_size >> SECTOR_SHIFT,
-				       GFP_KERNEL);
+				       zinfo->zone_size >> SECTOR_SHIFT);
 		memalloc_nofs_restore(nofs_flags);
 
 		if (ret)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0094fe491364..e1065ba70207 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1977,7 +1977,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 			trace_f2fs_issue_reset_zone(bdev, blkstart);
 			nofs_flags = memalloc_nofs_save();
 			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-						sector, nr_sects, GFP_KERNEL);
+						sector, nr_sects);
 			memalloc_nofs_restore(nofs_flags);
 			return ret;
 		}
@@ -4921,7 +4921,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 
 	nofs_flags = memalloc_nofs_save();
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
-				zone->start, zone->len, GFP_KERNEL);
+				zone->start, zone->len);
 	memalloc_nofs_restore(nofs_flags);
 	if (ret == -EOPNOTSUPP) {
 		ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 63fbac018c04..cadb1364f951 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
 
 	trace_zonefs_zone_mgmt(sb, z, op);
 	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
-			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
+			       z->z_size >> SECTOR_SHIFT);
 	if (ret) {
 		zonefs_err(sb,
 			   "Zone management operation %s at %llu failed %d\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e72213..8467c1910404 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -325,7 +325,7 @@ void disk_set_zoned(struct gendisk *disk);
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
 int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
-		sector_t sectors, sector_t nr_sectors, gfp_t gfp_mask);
+		sector_t sectors, sector_t nr_sectors);
 int blk_revalidate_disk_zones(struct gendisk *disk,
 		void (*update_driver_data)(struct gendisk *disk));
 

-- 
2.43.0


