Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88CDCCFA03
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qmn7o/dEAH/g9gDcTqVp/RheEooqzs6rBQFWXvVelDI=; b=Tfys1P6PUksnyI8URUKndS1wpg
	nZ0MfFzVf9Ff5b9NF3EjN3N0eSssiNXUMM3/uuq+yYXve0chPGuKzMdgg1XEmlcwKexE/v7eGE1Aa
	RwsMCH+7dYmhgpzUhjYTYpFrv1I/+aZqqdAcovw9axVD1xyHYoVg65hBCz+JGL5Nq3wIe+6bsPOmC
	d+vAshADBEKqM8/YLiOQlcLOWTUkuacLyj2OC/S9hWO0fnqmXigUju/+4bFsshKE/z1LDwKAa7XtX
	4uWQ2+AjJLnP0hdVtByese8z0lVzg9KI8zU5dvODBK7YRf/gKK3LnJKpKJtm2dx2d1TACLYL1sILZ
	YqlAFjrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xS-0000000AuA7-33d8;
	Tue, 04 Nov 2025 01:35:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xQ-0000000Au9c-2hdm
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:35:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 48F5B4013E;
	Tue,  4 Nov 2025 01:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3352C4CEFD;
	Tue,  4 Nov 2025 01:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220136;
	bh=E4sdnP60o+W5GBAMSZaGMY71b2TSCKqPh9HWyY4k1gU=;
	h=From:To:Subject:Date:From;
	b=huht8O2OLPMAIR6ZU1YuP2gqNEeRsIlg4HuyBjrTfueZW61tSBb54zIMMgC6RJf3R
	 jqDnJq4Kf5YeU0NMuKsAuHVoFeNlT64wwe2mzJgGPw8JqatG9YczOEmIOVIZhh6waI
	 446AhUq6DWAoHBi5Kdz4/cS0YiBebN6gJJfBjR669iZdGcFrTNR/O6dsFcYhpUvl+7
	 08q7wjIytIuLVSUowA6qOKThOW4ofyoiWc6KVJYYCOpUzg282+AHBtV9OhmD8vuUDz
	 jvPAiHtR0xUzEanUb6eDvtLHHaNsNa3w0aeoqU7bXBIeAhw4+hRJtI0VBRLx+i7CeH
	 1UryUzkc7WzHQ==
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
Subject: [PATCH v3 00/15] Introduce cached report zones
Date: Tue,  4 Nov 2025 10:31:32 +0900
Message-ID: <20251104013147.913802-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_173536_745825_3FBEDFD6 
X-CRM114-Status: GOOD (  13.78  )
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

This patch series implements a cached report zones using information
from the block layer zone write plugs and a new zone condition tracking.
This avoids having to execute slow report zones commands on the device
when for instance mounting file systems, which can significantly speed
things up, especially in setups with multiple SMR HDDs (e.g. a BTRFS
RAID volume).

The first patch improves handling of zone management commands. Patch 2
fixes zone resource updates and the following 3 patches cleanup the zone
code in preparation for introducing cached zone report support.
From patch 6 to 13, cached report zones is implemented and made
available to users with a new ioctl() command.

Finally, patches 14 and 15 introduce the use of cached report zones in
the mount operation of XFS and BTRFS.

These patches are against Jens' for-next tree.

Changes from v2:
 - Rebased on the latest block for-next tree
 - Fixed compilation warning (undocumented argument) in patch 4
 - Modified patch 13 to display condition name instead of raw value, as
   suggested by Johannes.
 - Added review tags

Changes from v1:
 - Move the patch "block: handle zone management operations completions"
   at the beginning of the series and added a Fixes tag.
 - Reworked a little patch 2 as suggested by Bart (error path handling)
 - Added patch 8 as requested by Bart.
 - Added patch 12 as suggested by Bart.
 - Corrected various typos in commit messages and code comments.
 - Added review tags

Damien Le Moal (15):
  block: handle zone management operations completions
  block: freeze queue when updating zone resources
  block: cleanup blkdev_report_zones()
  block: introduce disk_report_zone()
  block: reorganize struct blk_zone_wplug
  block: use zone condition to determine conventional zones
  block: track zone conditions
  block: refactor blkdev_report_zones() code
  block: introduce blkdev_get_zone_info()
  block: introduce blkdev_report_zones_cached()
  block: introduce BLKREPORTZONESV2 ioctl
  block: improve zone_wplugs debugfs attribute output
  block: add zone write plug condition to debugfs zone_wplugs
  btrfs: use blkdev_report_zones_cached()
  xfs: use blkdev_report_zones_cached()

 block/blk-zoned.c                 | 790 +++++++++++++++++++++++-------
 block/blk.h                       |  14 +
 block/ioctl.c                     |   1 +
 drivers/block/null_blk/null_blk.h |   3 +-
 drivers/block/null_blk/zoned.c    |   4 +-
 drivers/block/ublk_drv.c          |   4 +-
 drivers/block/virtio_blk.c        |  11 +-
 drivers/block/zloop.c             |   4 +-
 drivers/md/dm-zone.c              |  54 +-
 drivers/md/dm.h                   |   3 +-
 drivers/nvme/host/core.c          |   5 +-
 drivers/nvme/host/multipath.c     |   4 +-
 drivers/nvme/host/nvme.h          |   2 +-
 drivers/nvme/host/zns.c           |  10 +-
 drivers/scsi/sd.h                 |   2 +-
 drivers/scsi/sd_zbc.c             |  20 +-
 fs/btrfs/zoned.c                  |  11 +-
 fs/xfs/xfs_zone_alloc.c           |   2 +-
 include/linux/blkdev.h            |  49 +-
 include/linux/device-mapper.h     |  10 +-
 include/uapi/linux/blkzoned.h     |  41 +-
 include/uapi/linux/fs.h           |   2 +-
 22 files changed, 770 insertions(+), 276 deletions(-)


base-commit: 359212b8a23d517d3eb1708d4f28995634afd7d3
-- 
2.51.0


