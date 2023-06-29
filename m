Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C5FC3DA40
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9GFsfLq3nGbhJ31BXhnMKJpABcuuxg7E5Tzcs+7pww=; b=W47zfZKKslDfPJVgN1kPs2ZpYN
	5s26E+j+GxJc4TPJkuMBFBYzjQ6IaI7vCBpBtnAlolNF0mjpN9XgdsXECPJNq0qiS5yDItdnNO+mM
	UkqtY2ARaXKGMpSI+u4uRve0Dnvp/e7X3ozB1V6AriWhn/EneMjiHCOWn5P6PF+LfYk4+u/+4MpPj
	ylZGM+OHDMGYHrwiDemwgLz1sVD4L1Y813g5urxCXPxTxBW9mcdF9c7uNQ8K8bgZ+RI9vonYq1BWy
	j2pnpFZqDxH/PWPwbVfXo7YR4CZLCdvfq2aa4bBAKcKUlkxHfThF2VgCQXapIsnGV2wnkWxXYIDAf
	S2FNzgtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6d-0005wQ-28;
	Thu, 29 Jun 2023 06:26:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6X-0005ts-2V
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:26:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA22614B2;
	Thu, 29 Jun 2023 06:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AAFC433C0;
	Thu, 29 Jun 2023 06:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688019967;
	bh=iwBl29tNxXNIsNWLUVnJCMDPgmC2XkOQIOPgLE1r9Yg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OVwrYydYI/I2k+/del815xw2PgWv9avP8KzVHqLZqmoC52ikaWOvcejWOCbfbzsaY
	 Ek4irfm8XwkLzBMKRQxBlUUvWTprGkRhjLIm2e83PzhwkOwTq1z+WxFh4N+AldBCK8
	 E36xBdoTlPuFm7ZKAic/7X6YU1oqAx5tCOaT3UN+tyo/+zk2k6/N+JytTB0v7dKobl
	 G70LhFYbyPKns4gE4+xbUagWb4Tyv6Gz9x0jsLFpObtn+6WDw/GFzv5eSBU7I82z+S
	 4e1QvwEPrjV+/glTnIwOlgAmPOM//p2brOQCmhQOKOd+uaDUq8iyV3LsC0fj0qW6WC
	 HzriTMtG5NQOA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3/5] block: nullblk: Set zone limits before revalidating zones
Date: Thu, 29 Jun 2023 15:26:00 +0900
Message-ID: <20230629062602.234913-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629062602.234913-1-dlemoal@kernel.org>
References: <20230629062602.234913-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_232609_851906_D7FB6DDD 
X-CRM114-Status: GOOD (  12.12  )
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

In null_register_zoned_dev(), call blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set the device zone
size and maximum zone append sector limit before executing
blk_revalidate_disk_zones() to allow this function to check zone limits.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 635ce0648133..84fe0d92087f 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -160,22 +160,17 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
+	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
+	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
+
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
-
-	if (queue_is_mq(q)) {
-		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
-
-		if (ret)
-			return ret;
-	} else {
-		blk_queue_chunk_sectors(q, dev->zone_size_sects);
-		nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
-	}
-
+	blk_queue_chunk_sectors(q, dev->zone_size_sects);
 	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
-	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
-	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
+	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
+
+	if (queue_is_mq(q))
+		return blk_revalidate_disk_zones(nullb->disk, NULL);
 
 	return 0;
 }
-- 
2.41.0


