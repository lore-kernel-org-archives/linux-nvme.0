Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74167CCF9EB
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InMbU78HSjwppAae9D4gDxLQbH7U7RcqSK3i/Vxrdik=; b=GS0B+g0FtbiKbx2d9myeKvHaqr
	DyoyXlzbFpPu31TxhnGienSxzOFdFrL+qzdEg+dxZVgcrEcTsKFg5SE+jzTcoY/sRE3BRos2INcuM
	45lP/7JasxCxl43V8RHTsB+kOfJOvcoFEZ060Ypeti/kr1L282lx8aJmJCA92SSZE9OY2vzPN9EaT
	WZc7jo7eQXMS1rG5CI6dVz6wJTz0pwyc7fz5dSVkpXoZwGxcd7XZu0LMGD97icgPujmxBTt9zwXaQ
	xn5ZmnquTAmTF2E8U7fIyBytzIqhRPNodwnFuKOzt8Ha6BRlyvsnbWkV9JwPlHvWx/h7ujBzZBGJw
	RRp7naXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRv-00000005Rsy-2NGR;
	Fri, 31 Oct 2025 06:17:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRp-00000005RmT-0cCT
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 91BF160440;
	Fri, 31 Oct 2025 06:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F17C4CEE7;
	Fri, 31 Oct 2025 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891436;
	bh=ydgsw2wcznZzTu38cw+B1aKQUqRSklGzj6y7geTfj5o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oBq1f26WAlUfHvi57TraA0gr+j2omcNiJ4qW0+Ugc3GTV68UwNmyJw+Vie+FwY9gY
	 60JXBMZlPnZy2XKgpd3iM5vwgSFVPHYOiFK2Pft3W9ZmAn5Z/2e87obkzYfnM0Ggdt
	 8/4fRcEc+zTN26ZAyiMyEgagH4bcIYa36AUdnRFwTsHhSrBs3ELufasiAusAtIJ816
	 RoLivkM9iOLYStd1OIFOuex78xyyRKEbhHCHOXhMDdRX2qyElz8ak0uSSmhNWjuEwx
	 UbMgnTRAPXoz6RNfkasP6G4SAY3Gnbq9LlfRXAyNmYfTtSGSNvi+B5f6eGFkpwhZbk
	 KtF1LLBgpJO3w==
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
Subject: [PATCH 12/13] btrfs: use blkdev_report_zones_cached()
Date: Fri, 31 Oct 2025 15:13:06 +0900
Message-ID: <20251031061307.185513-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
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


