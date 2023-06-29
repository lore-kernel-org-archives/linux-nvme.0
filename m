Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7A1C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qaZPK0bNF7hO0Q5soxf7maOVGskORkOgxfGjGEoHMKE=; b=BMMps3mRhgrDYKZf90KqPjop0l
	Ko1l5g35FfWcKxAslWiSYPnBdcKm0/UsgolJWF8R2+hZDgqDcuN1ifwTRsk72tC4Q38vLDhOkXH25
	ngp0M3Oo//V5cH7+KVVBFxRPWxjxl4Fq1yEwmc7yR9LacW1MD58/iZSrrEf0enbSeTCwBHMR9POQO
	MJOL2n0FghYbP+0r5niBuu0cxN/l27N5NUxsrro3YqBOdyXJIfOsRZNel1SsWbZNZPPLhQBzKFwjZ
	ZH379TQspR7gK/atiUxVJVmWtkpwzRX39xJiTeZdomylnpG94OI3vNGikQWxMUFvunq0TXnKluEeP
	SqGLZ92g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6c-0005vl-0h;
	Thu, 29 Jun 2023 06:26:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6V-0005t4-14
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:26:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 379E361462;
	Thu, 29 Jun 2023 06:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBE7C433C8;
	Thu, 29 Jun 2023 06:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688019964;
	bh=8RqCu/onJv58TzXNwEU9CLDkGzmYgA7eGXK/nH0yQEw=;
	h=From:To:Subject:Date:From;
	b=IWR+rRSApsvsEe8aMd+mXoYjtjEidNjyRqSyP7XfUavtaUGGwj/fF6BN1cB4ZslAo
	 /AJSlJVRCqyJzdx2lWKOSbQT8rjOGX9Z8aJdljtPiLHiSTKEgSGEpceD4Pkrerf7mw
	 kTb8KsSnG+nqOCel2Gy/ZC+y+2F1V9FkXHEEMl5QTJ0omEOrsE0m+WqB+dIMr54P5B
	 IJ380ynzWz9QMstiWmjakwM6gxJBc+ckkgqconBVD3iCEjv1gJx+A7/qKdKc6p/WuX
	 0lgcXBxgZb2tXP1AlZrcdkQNpB5bk6EtbebRDT+sllWcR8HKCWMZqvgDQOLmui/qJY
	 0d32yvf6hUclw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 0/5] Improve checks in blk_revalidate_disk_zones()
Date: Thu, 29 Jun 2023 15:25:57 +0900
Message-ID: <20230629062602.234913-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_232607_432111_30B6F67A 
X-CRM114-Status: GOOD (  10.31  )
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

This series slightly modifies the 4 block device drivers that support
zoned block devices to ensure that they all call
blk_revalidate_disk_zones() with the zone size and max zone append
limits set. This is done in the first 4 patches.

With these changes, the last patch improves blk_revalidate_disk_zones()
to better check a zoned device zones and the device limits.

Damien Le Moal (5):
  scsi: sd_zbc: Set zone limits before revalidating zones
  nvme: zns: Set zone limits before revalidating zones
  block: nullblk: Set zone limits before revalidating zones
  block: virtio_blk: Set zone limits before revalidating zones
  block: improve checks in blk_revalidate_disk_zones()

 block/blk-zoned.c              | 99 +++++++++++++++++++++-------------
 drivers/block/null_blk/zoned.c | 21 +++-----
 drivers/block/virtio_blk.c     | 35 ++++++------
 drivers/nvme/host/zns.c        |  9 ++--
 drivers/scsi/sd_zbc.c          | 12 ++---
 5 files changed, 96 insertions(+), 80 deletions(-)

-- 
2.41.0


