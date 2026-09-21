Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DB6C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wifUEhlXIzQK+gLNq4FmLgjlqIAakAFwgoz354bZC2c=; b=W3mAdreqLNLy3FyNz6JYvV59Ng
	H1u9BrsSEQHB4VLigkxF+pawQygLyIv4p/VzkhpukGGdXhJYCp8HkwAJL9uRlpzF/rTSzmD3LVkXR
	GBErkGMtj+N6v3Ou7tUH0ihlvBaQsPfXd5a/qn6kB1I79YOTN4UYI5Qp+VUSlppZWYRNDjxthVLyF
	Yh5NAqT5NaPLFy3BwVoWyUzt1WRO3UN9PRKhYxtbsao5T1hqmlU/zx9ozNrLFmhRDizg/Slx83Mwm
	sBAIol7mZh1pp0nx/67PK8QZz7wq7sqR8YbVI82v0z+eMP1Sd3FvZwx164PH7kkgWJ40ZbMTlyISJ
	GDLaTW9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXd-00000001MWu-3Jhk;
	Mon, 21 Sep 2026 08:38:25 +0000
Received: from out-130.mta0.migadu.com ([2001:41d0:1004:224b::82] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXU-00000001MPH-0UJP
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:38:19 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=suPrxEreYmxdYHqtvnEA6/1wSOD5fNyBvN6FM+CZl9E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979892; v=1; x=1790584692;
 b=r49dz3hUJOFrbvDfG4O72lr2XigicRnDMXRnwFTubbqA73UeZY8Dxqn+wbZM5CsVyXZQth02
 Ru/vVJnKMabypQq163DaPAq+o44Kl/D/ZuEx/hVKtDb5iczy6iNZypN1lSdC8GRY6YGXdva4JJr
 EunputfAHNfPSqvu2waX9SpQ=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 96719b6f531fda21;
	Mon, 21 Sep 2026 08:38:12 +0000
X-Mizu-Trace-ID: 96719b6f531fda21
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 1/4] block: support cloning partitions
Date: Mon, 21 Sep 2026 09:37:49 +0100
Message-ID: <20260921083752.1154316-2-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_013816_308091_738B11E5 
X-CRM114-Status: GOOD (  15.84  )
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

For NVMe multipath support, per-path gendisks have flag GENHD_FL_HIDDEN
set. This means that no partition scan will be run for those disks.
However the head disk will still have its partitions scanned.

Even though for hidden disks there is no partition scan, it can be useful
to have the partition table available. Such is a case for NVMe multipath
when we want to send bios to specific partitions.

Support allowing a disk to clone the partitions from a multipath head disk.

Add struct block_device_operations.disk_changed_notify callback to allow
block drivers be notified of when partition layout may have changed. In
the NVMe multipath case, the head disk would use this callback to re-clone
the partitions onto the per-path disks.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 block/partitions/core.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7c..b03b206bc050 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -703,6 +703,9 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 	}
 
+	if (disk->fops->disk_changed_notify)
+		disk->fops->disk_changed_notify(disk);
+
 	return ret;
 }
 /*
@@ -711,6 +714,46 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
  */
 EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
+int bdev_clone_partitions(struct gendisk *disk, struct gendisk *mirror)
+{
+	struct block_device *part;
+	unsigned long idx;
+
+	if (disk_has_partscan(mirror))
+		return -EINVAL;
+
+	lockdep_assert_held(&disk->open_mutex);
+	mutex_lock_nested(&mirror->open_mutex, SINGLE_DEPTH_NESTING);
+
+	xa_for_each_start(&mirror->part_tbl, idx, part, 1) {
+		/* Same as bdev_disk_changed() */
+		bdev_unhash(part);
+		WARN_ON_ONCE(atomic_read(&part->bd_openers));
+		invalidate_bdev(part);
+		drop_partition(part);
+	}
+
+	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
+		struct block_device *part_added;
+
+		part_added = add_partition(mirror, idx, part->bd_start_sect,
+					part->bd_nr_sectors, ADDPART_FLAG_NONE,
+					part->bd_meta_info);
+		if (IS_ERR(part_added)) {
+			if (PTR_ERR(part_added) != -ENXIO) {
+				dev_err(disk_to_dev(mirror), "p%ld could not be added: %pe\n",
+				       idx, part_added);
+			}
+			mutex_unlock(&mirror->open_mutex);
+			return PTR_ERR(part_added);
+		}
+	}
+	mutex_unlock(&mirror->open_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdev_clone_partitions);
+
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
 	struct address_space *mapping = state->disk->part0->bd_mapping;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..249a4250a56d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -978,6 +978,7 @@ static inline unsigned int bdev_nr_zones(struct block_device *bdev)
 }
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
+int bdev_clone_partitions(struct gendisk *disk, struct gendisk *mirror);
 
 void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
@@ -1599,6 +1600,7 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	void (*disk_changed_notify)(struct gendisk *disk);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.43.0


