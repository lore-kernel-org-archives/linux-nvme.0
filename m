Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D42C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:14:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4951260524
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4951260524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xIQXFEedkyUMwUWMA0AhvclyoMaC1lz2jwTRQ3Uge+s=; b=XX9sEqs2+PkrM2
	Nxpyr0mDVvO8i+Y+42d5JEzV3+9I24DxdljixT/OelgdPPZavEPAuHI8fXDR8v2U6zfs/zSBTExRP
	aOZuNAlxhHS4DZm5IEYaiQiUHzUuQvRjtjYvA3sVfMjqS8DXwBOofawfjJWUpgNWFOFFoFYBMkkBB
	Lv6A8ECW3zeRJcafg/yAbyj41/Oy5Ua48KU76JkpwvgUMioTCqhgAyWQFbQTElPtDSKWQLe2orsia
	UDciUi9PuO2ZI3Cur3dxZSZyHC98asTleLaqrGToyRe6ifMfKG45e77kMpxVrStCdrc5AQ45aRah8
	+Fn2lvUHMzTyJN/A8eYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFiw-00CWqZ-Kf; Tue, 12 Oct 2021 11:13:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFiv-00CWqS-6J
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=77IJowW/Q0/pGzV1XJZbK1a/2ZtwRut4p0r7Zv++j/g=; b=IT/u2aU66tTR1mrb2wzNcrNpp3
 RlSo9NJYvEu9ft74AIl0QmUroR1J8wWQE5dZB+1ArjPk7a0LM8RmRP2BHTaR6PdYnNMJoSZUdqZmU
 eQIJHEqkuZwrrv0oTDXO3u5pX/m9El7f3+WKgh3TxBiJSMd3yjHncHcy8AWfrQY0WPXJuqGp/rt+U
 UUVVWigburiDzaaNcNpWdahn79mOEandF3zRIIz5ALyl21hphv1wCNNKQaZv4NTN5D3EHMzYB82+o
 eny6u48EZ4WFNe08ItLGSWwqK8xb2Cj4aiQM97L4OQiGvv43Q+gdw7oSjFpWRrpSS2hMsKlTFCYJS
 Q3+2nkfw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFhw-006RPB-6F; Tue, 12 Oct 2021 11:12:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: switch block layer polling to a bio based model v4
Date: Tue, 12 Oct 2021 13:12:10 +0200
Message-Id: <20211012111226.760968-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

This series clean up the block polling code a bit and changes the interface
to poll for a specific bio instead of a request_queue and cookie pair.

Polling for the bio itself leads to a few advantages:

  - the cookie construction can made entirely private in blk-mq.c
  - the caller does not need to remember the request_queue and cookie
    separately and thus sidesteps their lifetime issues
  - keeping the device and the cookie inside the bio allows to trivially
    support polling BIOs remapping by stacking drivers
  - a lot of code to propagate the cookie back up the submission path can
    removed entirely

The one major caveat is that this requires RCU freeing polled BIOs to make
sure the bio that contains the polling information is still alive when
io_uring tries to poll it through the iocb. For synchronous polling all the
callers have a bio reference anyway, so this is not an issue.

Git tree:

   git://git.infradead.org/users/hch/block.git bio-poll

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bio-poll

Chances since v3:
 - rebased to the latests for-5.16/block tree + "two small blk-mq cleanups"
 - fix the refcount logic in __blkdev_direct_IO
 - split up a patch to make it easier to review
 - grab a queue reference in bio_poll
 - better document the RCU assumptions in bio_poll

Chances since v2:
 - remove support for writing to the poll attribute
 - better document the block_device life time assumptions in bio_poll
 - only set QUEUE_FLAG_POLL on nvme-multipath queues where it makes sense

Chances since v1:
 - use SLAB_TYPESAFE_BY_RCU to only free the pages backing the bio
   slabs bio RCU
 - split the spin argument to bio_poll to avoid sleeping under RCU from
   io_uring
 - add support for polling nvme multipath devices

Diffstat:
 arch/m68k/emu/nfblock.c             |    3 
 arch/xtensa/platforms/iss/simdisk.c |    3 
 block/bio.c                         |    4 
 block/blk-core.c                    |  129 ++++++++++++++++++++------
 block/blk-merge.c                   |    2 
 block/blk-mq-debugfs.c              |    2 
 block/blk-mq.c                      |  173 ++++++++++++++----------------------
 block/blk-mq.h                      |    6 -
 block/blk-sysfs.c                   |   23 ----
 drivers/block/brd.c                 |   12 +-
 drivers/block/drbd/drbd_int.h       |    2 
 drivers/block/drbd/drbd_req.c       |    3 
 drivers/block/n64cart.c             |   12 +-
 drivers/block/null_blk/main.c       |    3 
 drivers/block/pktcdvd.c             |    7 -
 drivers/block/ps3vram.c             |    6 -
 drivers/block/rsxx/dev.c            |    7 -
 drivers/block/zram/zram_drv.c       |   10 --
 drivers/lightnvm/pblk-init.c        |    6 -
 drivers/md/bcache/request.c         |   13 +-
 drivers/md/bcache/request.h         |    4 
 drivers/md/dm.c                     |   28 ++---
 drivers/md/md.c                     |   10 --
 drivers/nvdimm/blk.c                |    5 -
 drivers/nvdimm/btt.c                |    5 -
 drivers/nvdimm/pmem.c               |    3 
 drivers/nvme/host/core.c            |    4 
 drivers/nvme/host/multipath.c       |   17 ++-
 drivers/s390/block/dcssblk.c        |    7 -
 drivers/s390/block/xpram.c          |    5 -
 drivers/scsi/scsi_debug.c           |   10 +-
 fs/block_dev.c                      |   44 ++-------
 fs/btrfs/inode.c                    |    8 -
 fs/direct-io.c                      |   14 --
 fs/ext4/file.c                      |    2 
 fs/gfs2/file.c                      |    4 
 fs/io_uring.c                       |   14 +-
 fs/iomap/direct-io.c                |   56 ++++++-----
 fs/xfs/xfs_file.c                   |    2 
 fs/zonefs/super.c                   |    2 
 include/linux/bio.h                 |    4 
 include/linux/blk-mq.h              |   15 ---
 include/linux/blk_types.h           |   34 +------
 include/linux/blkdev.h              |   12 +-
 include/linux/bvec.h                |    2 
 include/linux/fs.h                  |    8 -
 include/linux/iomap.h               |    3 
 mm/page_io.c                        |   10 --
 48 files changed, 350 insertions(+), 408 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
