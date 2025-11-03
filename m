Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF71CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UqoAgN2ChCUcwyskxiAjOMUPe5mLMipbgwdQeX5Cg+I=; b=JuobdJZVr0tOXu/XC1hUVnZA46
	1wwwhzhMfXXp9LKsjWWWvZEuYsjIXd5PUevbPUyYH8MRrnyXZn4jOUKlV8kFIOJysFC3Iyt+jISR4
	XMrHiRx3UPFVEjokAio+uz8K7zzmzlB+oFaB78+HE9xzhDpUC299PuyeKI9sImVVUWt6K5Bh9cJWR
	o9kMjvqo14+MhfA4kDE3tLwShmSb5BYUM4Ot8RToDr5x49cpfho7NpRCW79PjjpNjhjvfJ4bB4z0F
	/G8USzvzaw10jKs/5awxVleLrQ5udoqPQyDyfX7KJZOafW3I6HVaPvz/J+VrtCr9xmfZWGvytfFrH
	jH2TX1eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiI-00000009tyT-44Kq;
	Mon, 03 Nov 2025 13:35:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiG-00000009txu-12qX
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 47B526013E;
	Mon,  3 Nov 2025 13:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D7C4CEE7;
	Mon,  3 Nov 2025 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176911;
	bh=kipPvaFiey0COV9EM0kWVSk7RINlLWVsCFeKU1yW3Sc=;
	h=From:To:Subject:Date:From;
	b=geRvIv5tSUYrwESv0YQwzEYQ3KRXQgaZkPvj4DAePAULw3aryfrRyqrP0v96shMdF
	 JMbBHL2WaWG5NcPu6PqSyVVS/S2m8+YI1dNuNlSVHdJkkp0I8DARUgPim5B53L/aA4
	 Rhd35JbuV4AdPOzXAKv++X/P3/gE0eNd/RPRoaaY1Jv8NrlTwCpEzclk7MttFx8fff
	 mdFu15Qk+BcZd7N7yyKpkZIWxqyZwdpOF5ECdOwem7BgKipU0wXsW8L3yIoTjzwF2q
	 tSJiOqD9b9qFCNHduo/2BUJpw7SLQU+622baMHIPAP5PUNZbMxsRle/7fzJEM6jKwY
	 xF7W7Y8lJqSjQ==
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
Subject: [PATCH v2 00/15] Introduce cached report zones
Date: Mon,  3 Nov 2025 22:31:08 +0900
Message-ID: <20251103133123.645038-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
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

 block/blk-zoned.c                 | 788 +++++++++++++++++++++++-------
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
 drivers/scsi/sd_zbc.c             |  17 +-
 fs/btrfs/zoned.c                  |  11 +-
 fs/xfs/xfs_zone_alloc.c           |   2 +-
 include/linux/blkdev.h            |  49 +-
 include/linux/device-mapper.h     |  10 +-
 include/uapi/linux/blkzoned.h     |  41 +-
 include/uapi/linux/fs.h           |   2 +-
 22 files changed, 767 insertions(+), 274 deletions(-)


base-commit: ba6a8208cc205c6545c610b5863ea89466fc486a
-- 
2.51.0


