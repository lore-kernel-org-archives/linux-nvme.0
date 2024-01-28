Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFC0C47DA9
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t8/5TaCxuroVSP4GMjqC2cE3K0Q1/cXcNHEHPiYjfPk=; b=G1k8hyuOUw/UUPy+AQSGFOczNJ
	6SpaMWyV9L2pH78+5tCkJEBlQw+M1q2Tny06QWjdLylLS2lRhngGlPaPv377ePGk5PRpcOtoqytME
	MfgCFGYJRYseWb35FPEFxkUEUT2kQ6syNeDmsczvN4fCRKFPLcHRXsvllm/lAR1+Lqikb3NoxrCHk
	pQjKi/iqW7tx0eX7l1FDhUciQEkC9DFYGsaxJMdtv58bxq01BzdfY61esSNOrRP/08hAZu2P908Wl
	c3mJQ36+IFstX6Phqj7VX+TopGfJyOpjVxMMrxgtjo5fyxdMRBcqsWEfmT//DWXnLCEHkoC8C5uHN
	M79gYtqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8U9-0000000A1xd-1VYk;
	Sun, 28 Jan 2024 16:58:21 +0000
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8U5-0000000A1xA-0ggr;
	Sun, 28 Jan 2024 16:58:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: atomic queue limits updates v2
Date: Sun, 28 Jan 2024 17:57:59 +0100
Message-Id: <20240128165813.3213508-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

currently queue limits updates are a mess in that they are updated one
limit at a time, which makes both cross-checking them against other
limits hard, and also makes it hard to provide atomicy.

This series tries to change this by updating the whole set of queue
limits atomically.   This in done in two ways:

 - for the initial setup the queue_limits structure is simply passed to
   the queue/disk allocation helpers and applies there after validation.
 - for the (relatively few) cases that update limits at runtime a pair
   of helpers to take a snapshot of the current limits and to commit it
   after picking up the callers changes are provided.

As the series is big enough it only converts two drivers - virtio_blk as
a heavily used driver in virtualized setups, and loop as one that actually
does runtime updates while being fairly simple.  I plan to update most
drivers for this merge window, although SCSI will probably have to wait
for the next one given that it will need extensive API changes in the
LLDD and ULD interfaces.

Chances since v1:
 - remove a spurious NULL return in blk_alloc_queue
 - keep the existing max_discard_sectors == 0 behavior
 - drop the patch nvme discard limit update hack - it will go into
   the series updating nvme instead
 - drop a chunk_sector check
 - use PAGE_SECTORS in a few places
 - document the checks and defaults in blk_validate_limits
 - various spelling fixes

Diffstat:
 arch/um/drivers/ubd_kern.c          |    2 
 block/blk-core.c                    |   31 ++-
 block/blk-mq.c                      |   26 +--
 block/blk-settings.c                |  213 ++++++++++++++++++++++++-
 block/blk-sysfs.c                   |   59 +++----
 block/blk.h                         |    3 
 block/bsg-lib.c                     |    2 
 block/genhd.c                       |    4 
 drivers/block/amiflop.c             |    2 
 drivers/block/aoe/aoeblk.c          |    2 
 drivers/block/ataflop.c             |    2 
 drivers/block/floppy.c              |    2 
 drivers/block/loop.c                |   75 ++++-----
 drivers/block/mtip32xx/mtip32xx.c   |    2 
 drivers/block/nbd.c                 |    2 
 drivers/block/null_blk/main.c       |    2 
 drivers/block/ps3disk.c             |    2 
 drivers/block/rbd.c                 |    2 
 drivers/block/rnbd/rnbd-clt.c       |    2 
 drivers/block/sunvdc.c              |    2 
 drivers/block/swim.c                |    2 
 drivers/block/swim3.c               |    2 
 drivers/block/ublk_drv.c            |    2 
 drivers/block/virtio_blk.c          |  299 ++++++++++++++++++------------------
 drivers/block/xen-blkfront.c        |    2 
 drivers/block/z2ram.c               |    2 
 drivers/cdrom/gdrom.c               |    2 
 drivers/memstick/core/ms_block.c    |    2 
 drivers/memstick/core/mspro_block.c |    2 
 drivers/mmc/core/queue.c            |    2 
 drivers/mtd/mtd_blkdevs.c           |    2 
 drivers/mtd/ubi/block.c             |    2 
 drivers/nvme/host/apple.c           |    2 
 drivers/nvme/host/core.c            |    8 
 drivers/s390/block/dasd_genhd.c     |    2 
 drivers/s390/block/scm_blk.c        |    2 
 drivers/scsi/scsi_scan.c            |    2 
 drivers/ufs/core/ufshcd.c           |    2 
 include/linux/blk-mq.h              |   10 -
 include/linux/blkdev.h              |   36 +++-
 40 files changed, 526 insertions(+), 296 deletions(-)

