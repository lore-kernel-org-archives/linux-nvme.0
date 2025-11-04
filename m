Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4099BCCFA03
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PG2DZhf+hlIudd7UawIwKe7xLCWp4iy0uduR/aaUdeA=; b=BdyVn2Z/apM84BoWeQzLlVdWN8
	4wXufoXj0GR+SfQwGyMDsvB1Qj34zuRYWE0pGgxI9GZMELmYxEqbOWmGMq8XNW9ExqZRiJGZ8JhlG
	Sfx+yl1E5PBdXSfPsSw05K6D8wLUvb52qH7kzg9uMiuAieaaVw2i/WBSLUA+v2eTEMbi57fnm6SH5
	Lu305VpXSLu3NL+QLkHNUPRVU+ZlRQK94LMORpsmajxtL+/mREUCXGY3nKm/KEUzrE+6lM59/BLJd
	KSjKEd18g/YXqUT/gCHn40/VvaLJVA6rncUgHbznZUQ37AMaR9JSXFUnDHsESi/yqQCzKe47fwRTD
	62BA5reQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5yA-0000000Auru-2LuE;
	Tue, 04 Nov 2025 01:36:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5y7-0000000AunL-2KW0
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:36:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E8A11601E5;
	Tue,  4 Nov 2025 01:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40052C4CEE7;
	Tue,  4 Nov 2025 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220178;
	bh=lM97F0v5u7tfzv4+N5DwIFhzxaeVeb7f7Oe6yZJKG98=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KLfzZ7iAhUUxgx+ZouN+LaA+t1fyTUZ8WBjFe4KCDPCXjki/eom+RJ/zdYd59XR40
	 7MJLGiBw3Nd9fHZt4GARXkiXkeiQnzjmpmrfuPoG1GgTWHkFhyeoF+toNAX9od+iot
	 2C83IrodQsRB0MTpgDsQsXecUwo/a8TFtXuReVSwmZuAsBVG2YPHl4AqkFwg1haFYF
	 9rB9OJPxbbaMywPbkqxtTvm93kcHPXCb0WGtnKY8TCKeCLfhYV0DSIpC6wESvpa068
	 9PhkbJGeLLXmr8+PgfKGnxMAiazurD/ChKjJCW3BSjjbKTWDAp1M12gR0RBUd6P41y
	 tMximekj6slNg==
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
Subject: [PATCH v3 15/15] xfs: use blkdev_report_zones_cached()
Date: Tue,  4 Nov 2025 10:31:47 +0900
Message-ID: <20251104013147.913802-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
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

Modify xfs_mount_zones() to replace the call to blkdev_report_zones()
with blkdev_report_zones_cached() to speed-up mount operations.

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 2s compared to over 4.7s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/xfs/xfs_zone_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 23cdab4515bb..8d819bc134cd 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1231,7 +1231,7 @@ xfs_mount_zones(
 	trace_xfs_zones_mount(mp);
 
 	if (bdev_is_zoned(bt->bt_bdev)) {
-		error = blkdev_report_zones(bt->bt_bdev,
+		error = blkdev_report_zones_cached(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
 				mp->m_sb.sb_rgcount, xfs_get_zone_info_cb, &iz);
 		if (error < 0)
-- 
2.51.0


