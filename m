Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ED5EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PpUbD3wBpDDPr1+spHDA2r/Ebw1W6F3khlcslI4IHWU=; b=a6tKEXEL1drHt1KRUVI6r/wE/q
	+rFGPfXHDcY2ZId6ZQcta5Ou6FX19CX8cgF0Z28nuheYBxlWRhT3YwaoDFb7MYj3MYtVbL1kCoAGA
	Py9pWGCrTb+ppK18Zs5hz9npwud6wRnGjmfUIT2AoG56aUiA5FglSUjAPPMLA0u2MoiBlIoVsgSit
	kTT18OeNN7aSxkRPP1dgYWVIrlabMg3oDoXcJFOzv3J+C+8EVayfCpOSThrqk261YDm7Kqmg26KBV
	vpeXIBcpGyRGdfsJGHw7CanbxsnHi0dKSDWAJGnRex9z+ZBE0SfO/hrm76kOViN4SCDK28CRrDkkt
	4Ri5sg1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6b-0005uh-1n;
	Thu, 29 Jun 2023 06:26:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6V-0005t6-19
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:26:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4A29E61492;
	Thu, 29 Jun 2023 06:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBCC433CA;
	Thu, 29 Jun 2023 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688019965;
	bh=9GrsNX3cIPYwDUJ797RxS6JlvLu3++Z2w7OHomzyUNM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Yqobn8ey9rOo7HaEJQaEHVF9lfLr6ByTscptqb1DiCDNAvXIw7l5KDaNuYCo7ZtvG
	 nvrVb0wCoxLxEco0QcJUwSU6u1rIc+WoQ2ANemh12/ffgED9m8oFdwhqsUNgG8d2gf
	 5vPc2wjM+YuOatDHawr8yncWKuPRr7E63dhDsVwBD88DZ4G8Szgj+fMNjOZmCp9Ket
	 nbybD4Q0oFU72eBPqYkibW4WAncsDoMO/5pjPC+MQutM1Q7BjAnV+uOtQrLXRySg+9
	 dd+hTt+gm/ObF5jYZm0mMpXgCFizu87gzA477XS7JP+rUjLcStwon9SimhWTUzBclk
	 GFVwOzAxStwZA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/5] scsi: sd_zbc: Set zone limits before revalidating zones
Date: Thu, 29 Jun 2023 15:25:58 +0900
Message-ID: <20230629062602.234913-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629062602.234913-1-dlemoal@kernel.org>
References: <20230629062602.234913-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_232607_433838_758F7A93 
X-CRM114-Status: GOOD (  11.95  )
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

Call blk_queue_chunk_sectors() and blk_queue_max_zone_append_sectors()
to respectively set a ZBC device zone size and maximum zone append
sector limit before executing blk_revalidate_disk_zones() to allow this
function to check zone limits.

Since blk_queue_max_zone_append_sectors() already caps the device
maximum zone append limit to the zone size and to the maximum command
size, the max_append value passed to blk_queue_max_zone_append_sectors()
is simplified to the maximum number of segments times the number of
sectors per page.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd_zbc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 22801c24ea19..a25215507668 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -831,7 +831,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	struct request_queue *q = disk->queue;
 	u32 zone_blocks = sdkp->early_zone_info.zone_blocks;
 	unsigned int nr_zones = sdkp->early_zone_info.nr_zones;
-	u32 max_append;
 	int ret = 0;
 	unsigned int flags;
 
@@ -876,6 +875,11 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 		goto unlock;
 	}
 
+	blk_queue_chunk_sectors(q,
+			logical_to_sectors(sdkp->device, zone_blocks));
+	blk_queue_max_zone_append_sectors(q,
+			q->limits.max_segments << PAGE_SECTORS_SHIFT);
+
 	ret = blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);
 
 	memalloc_noio_restore(flags);
@@ -888,12 +892,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 		goto unlock;
 	}
 
-	max_append = min_t(u32, logical_to_sectors(sdkp->device, zone_blocks),
-			   q->limits.max_segments << (PAGE_SHIFT - 9));
-	max_append = min_t(u32, max_append, queue_max_hw_sectors(q));
-
-	blk_queue_max_zone_append_sectors(q, max_append);
-
 	sd_zbc_print_zones(sdkp);
 
 unlock:
-- 
2.41.0


