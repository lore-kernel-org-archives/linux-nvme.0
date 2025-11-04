Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6AECCFA05
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ht2X5HiiINcMB/laCmjvqB6vE4AHOLHIxcgUW3OWVK8=; b=Tl/uVwtvjLPHuW1dEN0Nyhkllc
	wX1/8o6hYoqij4/MdIJu1zO57E6lEFvhEF6kirrWK6nJ6CZ8+uKn51q2IxuQyPqnk48GNc9xsNTig
	7v+xBG7Jz2AEo7SE29zk0HBPkQSVUpZNm1HfYfy2J7ncENuJcwW84GlwokP9fvhRlrfM4RcSC93+I
	m3PJn4V63DVf7ERzQm0nbR5at0y3M3B0WxhDaxHchciH39JTBtXTOv3q8Hd5Q7hDTW68fYbnAMyQR
	u3lpGz8PCPYFFkMlF9r5a2i5vR5cmP8VisP8OZG/1AvOiTF8goaJFE0Br/mwtgnhpXFkq0LAMhUSD
	AUuf6ewg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOY9-0000000CbEs-44uH;
	Tue, 04 Nov 2025 21:26:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOY8-0000000CbDx-1Dyw
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 21:26:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B2E46601EF;
	Tue,  4 Nov 2025 21:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF15C116C6;
	Tue,  4 Nov 2025 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291603;
	bh=goTxUR9sY+5MZ0Lvwe28IT8BAyNBWJDCOxJ6MfQCEWM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gDQf46WUf84CW33weesHt+zt6u/6rH8erAEFUjOaZ9CGkNJ5FhfjvurhX/aBlX17v
	 R7+uKdgGiEh73ZmnFKAiW7wZikYdrijVP6T7iuXd2Wn4eBSsv2VjjkOq2ZjZUZunII
	 dJJ2UjzXlvYA1IP6llRtVgDVEhia5rdArF6upEYj0qCEvhdMIQHb1yTSJC4CHcO2in
	 BiEhy0EskKoHUIG9shfIw7NghRHIMKJljPUqSh4K9J5Ksh5gAF7HYbdvrv+kB9VCGk
	 C6l6afyKaVcp/ps7hL+pFpZqHWuHsi8kqiQFg8IgfxgBqzPYYKJ0yB8w5WE510bBmw
	 yIqa7kXzITO4w==
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
Subject: [PATCH v4 03/15] block: cleanup blkdev_report_zones()
Date: Wed,  5 Nov 2025 06:22:37 +0900
Message-ID: <20251104212249.1075412-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
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

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


