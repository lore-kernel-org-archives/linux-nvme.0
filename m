Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D56CCF9EB
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lzW88r5cELg8XHIKwhgSdrHhbz92vObocE2d1kM3+9o=; b=ONfqqx45yku7K9DLV4mukTpFBJ
	nrX2swtqGaVrzkJymsOXYobAUnW0rmqMy4xR0UNU0FmriABznh40YwzxoB3UBjzwYaA8zaoV9J6m+
	3KA/+59nZO4qy4JjTvAI3mKitATDWGquhY6gWunoBoBTVO5S0eg/b/YLPYsNKOnD7sV7Z6c6eOBv4
	yuFmkLhCJfnsm8+dcvrISw/WU3l1QCT3bXtTdBYaT/RytpGp6QBuNzk+AuQhPwGMfJhBVgsOdOxia
	Fve06t+sW59yveTdU9+BngxgCQ47kAN1SXrhNUDtuTTkbZAdXquPSL+c+bWBbfjqmAHgFTDvHDWTm
	A0vBet7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRX-00000005Rcm-2xyK;
	Fri, 31 Oct 2025 06:16:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRU-00000005Rc8-1Y51
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:16:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C71B44B25;
	Fri, 31 Oct 2025 06:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E61C4CEF1;
	Fri, 31 Oct 2025 06:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891415;
	bh=7GvVW4uZiDm+Tw9/lHA4zIrauzC8lt+7kjJjVl6Nmh0=;
	h=From:To:Subject:Date:From;
	b=ADhIOAk3iHBYRPIDhHIJjRfXk6JxkMJw0eZF/SzWIlcPcsZ/YgeHV7UISZCt8MENk
	 0PVhOU+HjBCos0FR0+6Z177Q9VZXrZNnTQIjCRjlFC/GVA+nn2MD8jEuCELMCqDzvY
	 3tRDqADSx1LiUZqU7vtIM14dYrOmKXEeHG9fsPamPXCs7jcGh3Tpv8jxSltWtfGfvK
	 LJNHu2zMa18ez6uDTPDK8WaANNs7ZmsS1hBqyjihnKyJ5juo9YrUwAGd8+H8YtDT3f
	 R44DBY1xYY8Trh2ZqwXdFMNbc/7UCDpfoCXvNZjS7z7PChUkOdXN6TpYYlsZLE/TgQ
	 bJjJOFxVLu+vw==
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
Subject: [PATCH 00/13] Introduce cached report zones
Date: Fri, 31 Oct 2025 15:12:54 +0900
Message-ID: <20251031061307.185513-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231656_481485_C9580647 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
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

The patch series implements a cached report zones using information from
the block layer zone write plugs and a new zone condition tracking. This
avoids having to execute slow report zones commands on the device when
for instance mounting file systems, which can significantly speed things
up, especially in setups with multiple SMR HDDs (e.g. a RAID volume).

The first patch improves zone resource updates. The following 3 patches
cleanup and improve handling of zone reports and of other zone
management operations. From patch 5 to 10, cached report zones in
implemented and made available to users with a new ioctl() command.

Finally, patches 12 and 13 introduce the use of cached report zones in
the mount operation of XFS and BTRFS.

These patches are against Jen's for-next tree.

Damien Le Moal (13):
  block: freeze queue when updating zone resources
  block: cleanup blkdev_report_zones()
  block: handle zone management operations completions
  block: introduce disk_report_zone()
  block: reorganize struct blk_zone_wplug
  block: use zone condition to determine conventional zones
  block: track zone conditions
  block: introduce blkdev_get_zone_info()
  block: introduce blkdev_report_zones_cached()
  block: introduce BLKREPORTZONESV2 ioctl
  block: add zone write plug condition to debugfs zone_wplugs
  btrfs: use blkdev_report_zones_cached()
  xfs: use blkdev_report_zones_cached()

 block/blk-zoned.c                 | 762 ++++++++++++++++++++++++------
 block/blk.h                       |  14 +
 block/ioctl.c                     |   1 +
 drivers/block/null_blk/null_blk.h |   3 +-
 drivers/block/null_blk/zoned.c    |   4 +-
 drivers/block/ublk_drv.c          |   4 +-
 drivers/block/virtio_blk.c        |  11 +-
 drivers/block/zloop.c             |   4 +-
 drivers/md/dm-zone.c              |  54 ++-
 drivers/md/dm.h                   |   3 +-
 drivers/nvme/host/core.c          |   5 +-
 drivers/nvme/host/multipath.c     |   4 +-
 drivers/nvme/host/nvme.h          |   2 +-
 drivers/nvme/host/zns.c           |  10 +-
 drivers/scsi/sd.h                 |   2 +-
 drivers/scsi/sd_zbc.c             |  17 +-
 fs/btrfs/zoned.c                  |  11 +-
 fs/xfs/xfs_zone_alloc.c           |   2 +-
 include/linux/blkdev.h            |  44 +-
 include/linux/device-mapper.h     |  10 +-
 include/uapi/linux/blkzoned.h     |  36 +-
 include/uapi/linux/fs.h           |   2 +-
 22 files changed, 746 insertions(+), 259 deletions(-)


base-commit: ba6a8208cc205c6545c610b5863ea89466fc486a
-- 
2.51.0


