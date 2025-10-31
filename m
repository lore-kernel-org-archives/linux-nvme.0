Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8798BCCF9EE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+qCNiIhKXALhhL0eKDHSAy22lbYdIbK7QxlgYvvAHk=; b=gvNJGhy8VpW6vWcVQdYIcZbmpN
	IHoUgpgqt0Nu3WfBysywDiubLAPzgWjuNokUobLAmjMhF3vqj8X7+HE0RfBkaneZY1Bd+339VSoAH
	T77LE/oaMDSh7IbJ5S3GKVC5aIvohBYBK5p22xLFOsmpr6rZfeTj+OvKsVGMpK4DMoyMQI5Sis0CA
	B0MhBfFsrvL961y9BRwCPIIifB0lUoLbf32eQW6eEW+uV5oHCyA6f1biGGPDwfrAGSZKEtwx4V197
	9pNDPsItcrt2Su6Eh1hTmPEM2TxIQ87oYcLJ7e9DKv1LFRLe7dNJaLoZlTk5B4V53eHpMjc3YlNst
	hKx4ommg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRa-00000005RdZ-3Yx9;
	Fri, 31 Oct 2025 06:17:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRX-00000005Rcl-3Wko
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E72F660194;
	Fri, 31 Oct 2025 06:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29851C4CEFB;
	Fri, 31 Oct 2025 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891418;
	bh=xwJGKs+ja6Mu5nwgEcOtg9NZDElPFC8sS7FDYIJ5NIQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V6DSOOTD+Cnpj6XY6hneK8tmeOOrOKZ9EUj/Vj1TD+JAe0Ij9GI48eC9HxHtHucBt
	 cVukCSw28oau3s1oTzNBarL5Si3Aqzhxm8YNnr0IPxQzrYHBQSiWfb1B2Nj8WS9IPI
	 uO7hog2b6GwN4f6w2OFgdSQi1Z9cyng8ih5E557tKay/rj06YpGSeJvgdxOM6kDpgY
	 y7h0HRtGC5H48MxUcHZXPp3sW+4YMHPnxJyzfHgHvqEkrQ/dkhGnepHR8r5Cq5gOTa
	 Ls10oeR0BR9iJUJbhXvRb7TJ/w7fJYA3y0WS/zMWBNItLNPZ60MRNQsX+NdrNzXMHG
	 xSezGolvE1iUQ==
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
Subject: [PATCH 02/13] block: cleanup blkdev_report_zones()
Date: Fri, 31 Oct 2025 15:12:56 +0900
Message-ID: <20251031061307.185513-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f3b371056df4..8d2111879328 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -156,7 +156,6 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
 	struct disk_report_zones_cb_args args = {
 		.disk = disk,
 		.user_cb = cb,
@@ -166,7 +165,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!nr_zones || sector >= capacity)
+	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
 	return disk->fops->report_zones(disk, sector, nr_zones,
-- 
2.51.0


