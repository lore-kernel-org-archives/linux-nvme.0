Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38374EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/8JgnqhKAwnWZX8Hd7+tyimTuVXwhWU7zKH2hFpaf4k=; b=rSIqlr7S5bkdgRszGq7IyvW0Tr
	szBPPds2xmUmWdEiLRbzb7+JpG8Dzo+Ved7kh9YQh0V3M998mAqutVTa7r9lmDhhCSYqs9mFNuJ7h
	5Yl19DAtZykTY6QHXeiI2L+4At+CDJqCXtl2QFcy41EGJM3/XlW5cPKTT9fZl0rc60G6DRAL3j6Hp
	oyLac5LvvOqyZ7PdHAYENN/BVCAdkNSFdCLVW9Bkp0kbEl7g9j9x51uWeoZLwPsG2EE4BghbETID+
	NeuZyp2FNAwXMaeTPhrQnX25nNjpwvm5zwPhDrzNfbh/u60pxZoJl98RcgYZE6PKl1yc9fBnQ9gvB
	f2swX1yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fL-003CkE-0o;
	Fri, 30 Jun 2023 08:39:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fG-003CjP-1y
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 08:39:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 969E8609E9;
	Fri, 30 Jun 2023 08:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A78C433C8;
	Fri, 30 Jun 2023 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114377;
	bh=Rc6sCD5uTdJFBlUMasF2QuJU2L8t22jN/jo1b9z3E+A=;
	h=From:To:Subject:Date:From;
	b=CQbEzPnfqFQwdVFvIKB82JazqyQtAa6LHu/kcp3zZGiaF33rp46ld0AkrIs4JJHm3
	 zfZ6PXPT0NPs3DzU45D99PBqL6diPzLsEX4N9wUkm+VNGMIuBZiwtAZPgEzhUZqIKJ
	 JqlH3onQ47ZqrOJurNM9fEfy5xpKg3ItYhmKUVOai8vPqqU5caczw3FmP5T0OCNoq4
	 5c7lKIdok6KRwHKE9b3QsxoCjA/RVimpQSbn2+4XUhVRRmMj1X/Sb/tJbEwiGrUVDH
	 9viD4rkLjBte8jLz9ar4G9ndhkf2gxS6IEuzPl4dWPIwdhbxFPf1nacdWWfWL6SZ2U
	 Sl/3Pu5Xu5DmA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 0/5] Improve checks in blk_revalidate_disk_zones()
Date: Fri, 30 Jun 2023 17:39:30 +0900
Message-ID: <20230630083935.433334-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_013938_711035_B0F71361 
X-CRM114-Status: GOOD (  14.74  )
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


