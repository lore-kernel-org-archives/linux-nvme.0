Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AB9C3DA6E
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Dec 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zthoML/uhpAs1hPvD/fh13swKppKnu7l7FTtACwvAxE=; b=stKj+YMXEbIDj0hRBqXZBaeYra
	z8DWbP2bBqz4wRxYoUEFVptYQzo9EAcKtmdccZjt1OgOr284r75Gap3veTNAO3l2azGHIrDrrbJpb
	TtG8fhS+fNjQT0vz5txYbdAshgBI8SZtd2xhurTJlRslNHc83gUec1G5QJvfdmLE1fvQt34hItRfg
	hp15QNj60D/mjH6NI0RFT5TzBjKrymmnM2oYigWI5ri4vepq4CueD0J2P3A1dr/BsR+LhqsQFqmkI
	FPV8zokoDnqKCPoQeZ6djcQYozdkIDsx2sytx6csMZrMmyV5JfEE5dgJGrSsSKBUSUR1c49qDDStv
	8TjKP0tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuOz-0088LQ-1A;
	Sun, 17 Dec 2023 16:54:05 +0000
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuOw-0088L9-1x;
	Sun, 17 Dec 2023 16:54:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: remove support for the host aware zoned model
Date: Sun, 17 Dec 2023 17:53:54 +0100
Message-Id: <20231217165359.604246-1-hch@lst.de>
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

Hi all,

hen zones were first added the SCSI and ATA specs, two different
models were supported (in addition to the drive managed one that
is invisible to the host):

 - host managed where non-conventional zones there is strict requirement
   to write at the write pointer, or else an error is returned
 - host aware where a write point is maintained if writes always happen
   at it, otherwise it is left in an under-defined state and the
   sequential write preferred zones behave like conventional zones
   (probably very badly performing ones, though)

Not surprisingly this lukewarm model didn't prove to be very useful and
was finally removed from the ZBC and SBC specs (NVMe never implemented
it).  Due to to the easily disappearing write pointer host software
could never rely on the write pointer to actually be useful for say
recovery.

Fortunately only a few HDD prototypes shipped using this model which
never made it to mass production.  Drop the support before it is too
late.  Note that any such host aware prototype HDD can still be used
with Linux as we'll now treat it as a conventional HDD.

Diffstat:
 block/blk-settings.c           |   83 +++++------------------------------------
 block/blk-sysfs.c              |    9 ----
 block/blk-zoned.c              |    3 -
 block/blk.h                    |    2 
 block/partitions/core.c        |   12 -----
 drivers/block/null_blk/zoned.c |    2 
 drivers/block/ublk_drv.c       |    2 
 drivers/block/virtio_blk.c     |   78 +++++++++++---------------------------
 drivers/md/dm-kcopyd.c         |    2 
 drivers/md/dm-table.c          |   45 +++++++++-------------
 drivers/md/dm-zoned-metadata.c |    7 +--
 drivers/md/dm-zoned-target.c   |    4 -
 drivers/nvme/host/zns.c        |    2 
 drivers/scsi/scsi_debug.c      |   27 ++++++-------
 drivers/scsi/sd.c              |   50 +++++++++++-------------
 drivers/scsi/sd_zbc.c          |   16 -------
 fs/btrfs/zoned.c               |   23 +----------
 fs/btrfs/zoned.h               |    2 
 fs/f2fs/data.c                 |    2 
 fs/f2fs/super.c                |   17 +++-----
 include/linux/blkdev.h         |   38 +-----------------
 21 files changed, 124 insertions(+), 302 deletions(-)

