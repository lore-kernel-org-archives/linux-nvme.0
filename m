Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96308C3DA40
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r1wq6dF/wwfmdpx1vM1YuRcJ86WXk25W0kl8jltAJ/o=; b=VxsX5AH8cCDty2eN3N6pPkjnkT
	FGfDTA1eoSxUL/rHGVAu0QqjQwRSzZ6OW8omDhqC+LbQ/vdxCXAK/iRloMDx9GfduZ08OJqwYTgcP
	fc0ptOa0/p7pcHexsbIGr6WLaqw08cOypH2XlNOWOpSM5ef2MI/TWgBZF3e1QZmHoTfrG5axixI88
	Xktu9j5LA/WPXd4GgTTU57kpnIqe8L6Ewx/uMJwVaiGb9RQEWhsEXaw7iI0dY5xbVdzJgnnVCltL0
	TT3R9B4lVym5REXRt7++wWTKFzEaOMgYuzUvH2dYc45Su0KkkO9znLhKPcxJ4JvFp36oQLaeGpXKY
	yqIWaIkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bu-009603-15;
	Mon, 03 Jul 2023 02:48:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9br-0095ys-0y
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 02:48:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C855760DB5;
	Mon,  3 Jul 2023 02:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE18C433B9;
	Mon,  3 Jul 2023 02:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688352494;
	bh=6GZto+pVfutjvCNVgn2qE0kch1Ur5YkjwUQsX8M0fiQ=;
	h=From:To:Subject:Date:From;
	b=o/bZ+5ajQ0S9AB6W9WltMAv1GPT2ZfildaSo1qNlDgAwCcrr9FbGZJQyuGPrrbRUj
	 QjgU5revdnbPUPuu9yrkPh1LB4KEVHqGzRS2+bb7DSF0S+10tpt5oBLHvisaPPkvWI
	 DeWntvEljzSkMO3kNp6ujdpLAg63EXtJ3ASJ6jiTVCsomyJ3XnRSXEFmZTPS7uw54x
	 iwMlhx+Usz7rkhWRW8BdckBi+w3rPzcAp3n1ox/wtX53G1QfOmKLMi1ah3fRzSJQMj
	 8ZwTw1Z22iUyr6Ftp/BvHi6JecnUr1bpdWrTsFV89wuZ5G/LSdGU6z/BlXg0U+G7MF
	 krAKEUY6F9Mtw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 0/5] Improve checks in blk_revalidate_disk_zones()
Date: Mon,  3 Jul 2023 11:48:07 +0900
Message-ID: <20230703024812.76778-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_194815_380454_3B44E047 
X-CRM114-Status: GOOD (  15.29  )
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

blk_revalidate_disk_zones() implements checks of the zones of a zoned
block device, verifying that the zone size is a power of 2 number of
sectors, that all zones (except possibly the last one) have the same
size and that zones cover the entire addressing space of the device.

While these checks are appropriate to verify that well tested hardware
devices have an adequate zone configurations, they lack in certain areas
which may result in issues with potentially buggy emulated devices
implemented with user drivers such as ublk or tcmu. Specifically, this
function does not check if the device driver indicated support for the
mandatory zone append writes, that is, if the device
max_zone_append_sectors queue limit is set to a non-zero value.
Additionally, invalid zones such as a zero length zone with a start
sector equal to the device capacity will not be detected and result in
out of bounds use of the zone bitmaps prepared with the callback
function blk_revalidate_zone_cb().

This series address these issues by modifying the 4 block device drivers
that currently support zoned block devices to ensure that they all set a
zoned device zone size and max zone append sectors limit before
executing blk_revalidate_disk_zones(). With these changes in place, 
patch 5 improves blk_revalidate_disk_zones() to address the missing
checks, relying on the fact that the zone size and zone append limit are
normally set when this function is called.

Changes from v2:
 - Rebased on current Linus tree to fix a conflict with scsi changes in
   patch 1.
 - Added Reviewed-by tags.

Changes from v1:
 - Updated this cover letter and commit messages to include better
   explain for these patches
 - Reworked patch 5 to simplify the checks
  
Damien Le Moal (5):
  scsi: sd_zbc: Set zone limits before revalidating zones
  nvme: zns: Set zone limits before revalidating zones
  block: nullblk: Set zone limits before revalidating zones
  block: virtio_blk: Set zone limits before revalidating zones
  block: improve checks in blk_revalidate_disk_zones()

 block/blk-zoned.c              | 86 ++++++++++++++++++++--------------
 drivers/block/null_blk/zoned.c | 16 ++-----
 drivers/block/virtio_blk.c     | 34 ++++++--------
 drivers/nvme/host/zns.c        |  9 ++--
 drivers/scsi/sd_zbc.c          | 12 ++---
 5 files changed, 79 insertions(+), 78 deletions(-)

-- 
2.41.0


