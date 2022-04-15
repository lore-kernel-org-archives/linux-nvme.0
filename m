Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBCDC4167B
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 04:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T00AEFQ4LdY1QMdERyaPozZpUOF+QiWNLetpSJJQdDo=; b=hXVrfnfYUXjF3RXfHD6qdq9vOH
	cY11VyNu+JEU8a+WbpwtMmO4OLDxLm/xfTUXPQTyRyoRSzfm4mqgZ+ASkEQ/DHW4Iv4iV4+De+8XH
	CY1g3CzrzHmfXs1G/hm8xlOfVzmCZL9xMnAuSHJDlQcYRyRHjxXlLVEtI3lugPS/J8kpYeo7cVlQu
	NxTvYll1pFTJUQs+FxjI1VOrnrsp14+emVxgkh5eNcrx3bX6tgvlaubDiOtlcXGlNrgHWg+s2fqCf
	goUEY6B4aqlZP6M+UnsMxQat0Crt8Fxs1aAMwW+/MdQa4L9489T6Yv2rEceUJKmNN3jC0ZlvJG2U2
	d46qiKug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfDxO-008Onj-U5; Fri, 15 Apr 2022 04:53:18 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfDxI-008OmY-4r; Fri, 15 Apr 2022 04:53:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: use block_device based APIs in block layer consumers v3
Date: Fri, 15 Apr 2022 06:52:31 +0200
Message-Id: <20220415045258.199825-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

Hi Jens,

this series cleanups up the block layer API so that APIs consumed
by file systems are (almost) only struct block_devic based, so that
file systems don't have to poke into block layer internals like the
request_queue.

I also found a bunch of existing bugs related to partition offsets
and discard so these are fixed while going along.

Changes since v2:
 - fix an inverted check in btrfs
 - set max_discard_sectors to 0 in all places where the flag was
   previously cleared
 - fix a few sligtly incorrect collected Acks

Changes since v1:
 - fix a bisection hazard
 - minor spelling fixes
 - reorder hunks between two patches to make the changes more obvious
 - reorder a patch to be earlier in the series to ease backporting


Diffstat:
 arch/um/drivers/ubd_kern.c           |    2 
 block/blk-core.c                     |    4 -
 block/blk-lib.c                      |  124 ++++++++++++++++++++---------------
 block/blk-mq-debugfs.c               |    2 
 block/blk-settings.c                 |   74 ++++++++++++++++++++
 block/blk.h                          |   14 ---
 block/fops.c                         |    2 
 block/genhd.c                        |    4 -
 block/ioctl.c                        |   48 ++++++++++---
 block/partitions/core.c              |   12 ---
 drivers/block/drbd/drbd_main.c       |   51 ++++++--------
 drivers/block/drbd/drbd_nl.c         |   94 +++++++++++---------------
 drivers/block/drbd/drbd_receiver.c   |   13 +--
 drivers/block/loop.c                 |   15 +---
 drivers/block/nbd.c                  |    5 -
 drivers/block/null_blk/main.c        |    1 
 drivers/block/rbd.c                  |    1 
 drivers/block/rnbd/rnbd-clt.c        |    6 -
 drivers/block/rnbd/rnbd-srv-dev.h    |    8 --
 drivers/block/rnbd/rnbd-srv.c        |    5 -
 drivers/block/virtio_blk.c           |    2 
 drivers/block/xen-blkback/blkback.c  |   15 ++--
 drivers/block/xen-blkback/xenbus.c   |    9 --
 drivers/block/xen-blkfront.c         |    8 +-
 drivers/block/zram/zram_drv.c        |    1 
 drivers/md/bcache/alloc.c            |    2 
 drivers/md/bcache/request.c          |    4 -
 drivers/md/bcache/super.c            |    3 
 drivers/md/bcache/sysfs.c            |    2 
 drivers/md/dm-cache-target.c         |    9 --
 drivers/md/dm-clone-target.c         |    9 --
 drivers/md/dm-io.c                   |    2 
 drivers/md/dm-log-writes.c           |    3 
 drivers/md/dm-raid.c                 |    9 --
 drivers/md/dm-table.c                |   25 +------
 drivers/md/dm-thin.c                 |   15 ----
 drivers/md/dm.c                      |    3 
 drivers/md/md-linear.c               |   11 ---
 drivers/md/md.c                      |    5 -
 drivers/md/raid0.c                   |    7 -
 drivers/md/raid1.c                   |   18 -----
 drivers/md/raid10.c                  |   20 -----
 drivers/md/raid5-cache.c             |    8 +-
 drivers/md/raid5.c                   |   14 +--
 drivers/mmc/core/queue.c             |    3 
 drivers/mtd/mtd_blkdevs.c            |    1 
 drivers/nvme/host/core.c             |    4 -
 drivers/nvme/target/io-cmd-bdev.c    |    2 
 drivers/nvme/target/zns.c            |    3 
 drivers/s390/block/dasd_fba.c        |    1 
 drivers/scsi/sd.c                    |    2 
 drivers/target/target_core_device.c  |   20 ++---
 drivers/target/target_core_file.c    |   10 +-
 drivers/target/target_core_iblock.c  |   17 +---
 fs/btrfs/disk-io.c                   |    3 
 fs/btrfs/extent-tree.c               |    8 +-
 fs/btrfs/ioctl.c                     |   12 +--
 fs/btrfs/volumes.c                   |    4 -
 fs/btrfs/zoned.c                     |    3 
 fs/direct-io.c                       |   32 +--------
 fs/exfat/file.c                      |    5 -
 fs/exfat/super.c                     |   10 --
 fs/ext4/ioctl.c                      |   10 --
 fs/ext4/mballoc.c                    |   10 +-
 fs/ext4/super.c                      |   10 --
 fs/f2fs/f2fs.h                       |    3 
 fs/f2fs/file.c                       |   19 ++---
 fs/f2fs/segment.c                    |    8 --
 fs/fat/file.c                        |    5 -
 fs/fat/inode.c                       |   10 --
 fs/gfs2/rgrp.c                       |    7 -
 fs/iomap/direct-io.c                 |    3 
 fs/jbd2/journal.c                    |    9 --
 fs/jfs/ioctl.c                       |    5 -
 fs/jfs/super.c                       |    8 --
 fs/nilfs2/ioctl.c                    |    6 -
 fs/nilfs2/sufile.c                   |    4 -
 fs/nilfs2/the_nilfs.c                |    4 -
 fs/ntfs3/file.c                      |    6 -
 fs/ntfs3/super.c                     |   10 +-
 fs/ocfs2/ioctl.c                     |    5 -
 fs/super.c                           |    2 
 fs/xfs/xfs_discard.c                 |    8 +-
 fs/xfs/xfs_log_cil.c                 |    2 
 fs/xfs/xfs_super.c                   |   12 +--
 fs/zonefs/super.c                    |    3 
 include/linux/blkdev.h               |  112 +++++++++++--------------------
 include/target/target_core_backend.h |    4 -
 mm/swapfile.c                        |   31 ++------
 89 files changed, 494 insertions(+), 651 deletions(-)

