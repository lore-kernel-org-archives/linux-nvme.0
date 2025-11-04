Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B001FCCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+K8aY0NHAPLm6uMSYgmjsSAgiUYAOCdzDWXV2mw13mg=; b=UYRXXPKHMNMopYkhX/Kz7W3Byf
	eYCh/iKz9GP4HobokRYjpMPJBud+GPjkDkeJbUDAZugwTK2JKD9dQpI6ZM+uh21upGNaBtU6LBh1a
	gt3VMtgU7Ipf21na1MBEE7mx8lmCYRizllgmufpI/E3HYWIpP60zVVJP7E6Ha2V9Xqld1X0ameK9z
	xLzyKq6PY/pxMIM0dXLPhZBDWGsNGEgCkO0St5gPFV4+2tirhleMneLZ/hi41LG+TE1lQ3pOgUChq
	q5+R7pMh10rR0pIYyXLrEyJEL6mA2m5jLObxbFHEZsLrzu1PSXzpFVr9H5jVb3+JqhCBWcmr1BWA+
	5106YpyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5y6-0000000Aumo-3nin;
	Tue, 04 Nov 2025 01:36:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5y4-0000000Auje-3Meg
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:36:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 298DC601E3;
	Tue,  4 Nov 2025 01:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6738CC4CEFD;
	Tue,  4 Nov 2025 01:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220175;
	bh=OQJzlNo20cxcnEk3FJgiDo6Dfxs8oL2XA0KXotU9jrQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k2JNc3fUlQAm++2dsZAOKRxIOhde2xHUpSndWj6z398/JxPsbMFOybS6ARsEcmRyD
	 YxDMmA/5j+lSviehZwLtJXO6M1X7mYH0YVsseysDy00Z87s9JMeMpchSETSLBHjzLR
	 jZXYZ6GX7OpPtk4X/TFcs3GaOs/OJ82qi0jUrQX1ZOnUleAApzCHCjZfNGNzUy/QOW
	 s9es4oE1mFj3dBydAtIfqWsV2pARuQd08b03eURHHJWJMkwEvXZt7pfjBhRC6X/A5y
	 XvtzOvW6LJxaMOFII4tkPAyM0rL064Xs0eklNOdCdMg/x1EX/X6K2KTEqm+g7PVeCY
	 15JA+MZHTKW+g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v3 14/15] btrfs: use blkdev_report_zones_cached()
Date: Tue,  4 Nov 2025 10:31:46 +0900
Message-ID: <20251104013147.913802-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
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

Modify btrfs_get_dev_zones() and btrfs_sb_log_location_bdev() to replace
the call to blkdev_report_zones() with blkdev_report_zones_cached() to
speed-up mount operations. btrfs_get_dev_zone_info() is also modified to
take into account the BLK_ZONE_COND_ACTIVE condition, which is
equivalent to either BLK_ZONE_COND_IMP_OPEN, BLK_ZONE_COND_EXP_OPEN or
BLK_ZONE_COND_CLOSED.

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 100ms compared to over 1.8s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0ea0df18a8e4..a16b1a896c78 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -264,8 +264,8 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 		}
 	}
 
-	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
-				  copy_zone_info_cb, zones);
+	ret = blkdev_report_zones_cached(device->bdev, pos >> SECTOR_SHIFT,
+					 *nr_zones, copy_zone_info_cb, zones);
 	if (ret < 0) {
 		btrfs_err(device->fs_info,
 				 "zoned: failed to read zone %llu on %s (devid %llu)",
@@ -494,6 +494,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 			case BLK_ZONE_COND_IMP_OPEN:
 			case BLK_ZONE_COND_EXP_OPEN:
 			case BLK_ZONE_COND_CLOSED:
+			case BLK_ZONE_COND_ACTIVE:
 				__set_bit(nreported, zone_info->active_zones);
 				nactive++;
 				break;
@@ -896,9 +897,9 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-	ret = blkdev_report_zones(bdev, zone_start_sector(sb_zone, bdev),
-				  BTRFS_NR_SB_LOG_ZONES, copy_zone_info_cb,
-				  zones);
+	ret = blkdev_report_zones_cached(bdev, zone_start_sector(sb_zone, bdev),
+					 BTRFS_NR_SB_LOG_ZONES,
+					 copy_zone_info_cb, zones);
 	if (ret < 0)
 		return ret;
 	if (unlikely(ret != BTRFS_NR_SB_LOG_ZONES))
-- 
2.51.0


