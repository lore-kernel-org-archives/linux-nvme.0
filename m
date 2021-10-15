Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E976CC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7318610E8
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 00:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7318610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qipf6So8PiT9INdx54i/oyCsyup0P8n0B263b/OsQJ4=; b=oaShL9y6A4uELzmZHz+S70mI+M
	HyPl8hSj+pPjM3vDYNfp4tPlJ6K7MOp3JuxigK6h8P0TOc6nZ/NsRSh5NOmihff6ZutlBxFSKDZ0q
	Z3tTeNFui06URYUHJlxDJS5p8YtCdk+Izkcle7PEZ8eRW36rjSBkVeZSFvy5ayCmFmDnRffsk8ouf
	K7FLkYYWscUshZiuXL5yz3nxFooxcV8eloye4WjuQUpdONoRbX0BqfZixs+YJWLw+RvX029iYC0Ke
	1UHn2rGFC/RWNASFFOIF6ltjGCZ+QcfjfZg14UXEYD/V2I8kD4WNmhlZL1P6qafR3YwtJnDBsvZc1
	QsMk0zRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbXLm-009JxR-5w; Sat, 16 Oct 2021 00:14:58 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mbWzs-009C2t-UH; Fri, 15 Oct 2021 23:52:20 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/13] block: add_disk() error handling stragglers
Date: Fri, 15 Oct 2021 16:52:06 -0700
Message-Id: <20211015235219.2191207-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
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

This patch set consists of al the straggler drivers for which we have
have no patch reviews done for yet. I'd like to ask for folks to please
consider chiming in, specially if you're the maintainer for the driver.
Additionally if you can specify if you'll take the patch in yourself or
if you want Jens to take it, that'd be great too.

Luis Chamberlain (13):
  block/brd: add error handling support for add_disk()
  nvme-multipath: add error handling support for add_disk()
  nvdimm/btt: do not call del_gendisk() if not needed
  nvdimm/btt: use goto error labels on btt_blk_init()
  nvdimm/btt: add error handling support for add_disk()
  nvdimm/blk: avoid calling del_gendisk() on early failures
  nvdimm/blk: add error handling support for add_disk()
  zram: add error handling support for add_disk()
  z2ram: add error handling support for add_disk()
  ps3disk: add error handling support for add_disk()
  ps3vram: add error handling support for add_disk()
  block/sunvdc: add error handling support for add_disk()
  mtd/ubi/block: add error handling support for add_disk()

 drivers/block/brd.c           |  9 +++++++--
 drivers/block/ps3disk.c       |  8 ++++++--
 drivers/block/ps3vram.c       |  7 ++++++-
 drivers/block/sunvdc.c        | 14 +++++++++++---
 drivers/block/z2ram.c         |  7 +++++--
 drivers/block/zram/zram_drv.c |  6 +++++-
 drivers/mtd/ubi/block.c       |  8 +++++++-
 drivers/nvdimm/blk.c          | 21 +++++++++++++++------
 drivers/nvdimm/btt.c          | 24 +++++++++++++++---------
 drivers/nvme/host/multipath.c | 14 ++++++++++++--
 10 files changed, 89 insertions(+), 29 deletions(-)

-- 
2.30.2


