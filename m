Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4224DCCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p/knmDkVfGKHx2lXhiKwLasQbbyK0aT5yJllYdrg0pk=; b=11C2Qrv6sFcX0tLOBsW4WkyHRm
	gteU4fYeB4eiGmsd7b1qbWGK+xljLNrVomuBiv+fiGqsYmwd1IMPDPbd88NVFcGIZtDYBscClre6E
	uSMDzNDX+SDyVvISV4tEQAK0xYGMtTYiJatYzTq/AMGipKAwpu5l8f0eMgQGweuhuZEB2uNFyNzMl
	dPuVMUALYWJJKES/sZ5YKBufA9rQ6bE4vf8DptC/2a8kicYtF8sydTaxE5JXwqKusKJoUiXFuhtZe
	zPqbBdAFEa8Sz6iG1cBB003K4OXrpXnUy1Sc7vUZVQx9xLXrPoqRHKVlrWspUyEJr1AYJj/Es7T4K
	E5CnswtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiP-00000009u3E-3fTS;
	Mon, 03 Nov 2025 13:35:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuiM-00000009u0g-16Cp
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C2FA343862;
	Mon,  3 Nov 2025 13:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A1CC4CEE7;
	Mon,  3 Nov 2025 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176917;
	bh=LTm6BRN1/E0TEs1v3UQpAGeeBxcejN2EF7uTV0DB94E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sAlIW2Q3lRNjeb0v041b0CkVfOh6vOlPGFyD9NmqMjrLnO1bd7FEYSN1X+BEab+AM
	 tKKGbLPuXoq+sK9wuF+VD8PqgCM48MWd6aYrO+YZyQ4l/rUiwgt5DbBw1pr4rNWvq6
	 zJ+kQBGOMPeGblC5axF4kigfMGGSpl2I5YcLfwmrEDqb6m/qnvbCAQPpZrr1Qzmwip
	 ZaJHNzbnb3dgwiv6RwnBur06R8du0Ivkf3ht/uShIkmR55YOLQgS1NzCea7hSspubp
	 Z0bo9qHFrXdQKVGBFE//q8J2mwyviG/Zgx4XdCHHshfDuqmqh1pwAsgFUnMw8MiU1X
	 OUoSDzM8pxGUA==
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
Subject: [PATCH v2 03/15] block: cleanup blkdev_report_zones()
Date: Mon,  3 Nov 2025 22:31:11 +0900
Message-ID: <20251103133123.645038-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053518_322523_2022E756 
X-CRM114-Status: GOOD (  11.63  )
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

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 39381f2b2e94..345a99c0b031 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -161,7 +161,6 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
 	struct disk_report_zones_cb_args args = {
 		.disk = disk,
 		.user_cb = cb,
@@ -171,7 +170,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!nr_zones || sector >= capacity)
+	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
 	return disk->fops->report_zones(disk, sector, nr_zones,
-- 
2.51.0


