Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1484CCA47C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r8Vz34uF3hgjoNeR0v/rpIhSqu91TXSVbFAMBKa/d70=; b=EwWnlaMcWrYupoLZadj8pymz/a
	4jc6ZENk3fAzYgk8fvJZUQKyxnUET8ES28AAM1n+Zzn5q6l4kIQGsmt/HrXuCslcibf/ySsNyv5wN
	lodPd70VWkCAMlFm/XC/5Se7yXfgreFayiB2u/4GklH7eMG+/Gyb8GtIZU8Bj8TwzPEX794QUpEx5
	g0GhvvOl0eA4NncGVMjfYwdIr1SbR970NcR3koe2l/sQR2TH1sEIXyV8/uwSiqae/NxlZY1RGXE4A
	4pE2jgfo/j+E8mli3myFPlE6TKLKQU5LXccgNb87e2Wo0ImEOgQPHQyhXkJzJFIoYFmXZjK+7I1Vm
	uuebTZMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LRn-008s9x-HH; Mon, 04 Jul 2022 12:45:03 +0000
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8LRm-008s8e-3R; Mon, 04 Jul 2022 12:45:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: clean up zoned device information
Date: Mon,  4 Jul 2022 14:44:43 +0200
Message-Id: <20220704124500.155247-1-hch@lst.de>
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

Hi all,

this cleans up the block layer zoned device information APIs and
moves all fields currently in the request_queue to the gendisk as
they aren't relevant for passthrough I/O.

Diffstat:
 block/bio.c                    |    2 
 block/blk-core.c               |   13 +--
 block/blk-merge.c              |    2 
 block/blk-mq-debugfs-zoned.c   |    6 -
 block/blk-mq.c                 |    2 
 block/blk-mq.h                 |   18 ++---
 block/blk-settings.c           |   11 +--
 block/blk-sysfs.c              |    8 --
 block/blk-zoned.c              |   95 +++++++++++++-------------
 block/blk.h                    |    8 +-
 block/genhd.c                  |    1 
 block/ioctl.c                  |    2 
 block/partitions/core.c        |    2 
 drivers/block/null_blk/zoned.c |    8 +-
 drivers/md/dm-table.c          |    6 -
 drivers/md/dm-zone.c           |   86 +++++++++++-------------
 drivers/md/dm-zoned-target.c   |   25 +++----
 drivers/md/dm.c                |    2 
 drivers/nvme/host/multipath.c  |    2 
 drivers/nvme/host/zns.c        |    6 -
 drivers/nvme/target/zns.c      |  110 +-----------------------------
 drivers/scsi/sd.c              |    6 -
 drivers/scsi/sd_zbc.c          |   10 +-
 fs/zonefs/super.c              |   17 ++--
 include/linux/blk-mq.h         |    8 +-
 include/linux/blkdev.h         |  146 ++++++++++++++++-------------------------
 26 files changed, 233 insertions(+), 369 deletions(-)

