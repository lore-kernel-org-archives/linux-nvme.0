Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB4AC001DF
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gjmp7TpuwQSlxosiPkxvHOJCkY3JGvARC/NHcsnAJJk=; b=bfjDsy1dELQ9MNTgssA+OBR0ql
	G0FCXfjR8Xi7UpeLlvFFrGEMbt4AkeFqO7mK24+rnB0lphnNjcE36tJolYvVo+rJf2maeCPDOrLHt
	w3savfGt3emSIfTE0H8/gl05SsQ3DrkzuOgZ94eAPLhHrdvf5sMYITchuK8IsmeeMTWiTJEqH8wTP
	/iPtu1n03VOVABc4LDW0VX3RpgBR9SPvTrS8QgeeIPbupMwgeRVwrIQLyDgRryIJ/Up+hfXyIUc9n
	5EEuzgnC6XsV8uBbPT2UAUlI+kg1vWoqkZxRyPR4GUG+AY0h9Uft/IZofK0V4glL74VMH8YYBOH0v
	jFsXtx1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bv-00960P-02;
	Mon, 03 Jul 2023 02:48:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bs-0095zJ-26
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 02:48:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 368DA60D32;
	Mon,  3 Jul 2023 02:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC5CC433C8;
	Mon,  3 Jul 2023 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688352495;
	bh=Q01VZD1Q7rg9nXiwpy4RY4zCwtmYfAeCmZAUUJA97o0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dc19aNosefurUS6kfeNi6zwQhADyqu0UzBxf9p8LyzI+nsUTiNLCJqbie/5PxOclS
	 GNS6ozy+sHhyOuNtc6Mu8rVKtEfHz2u7oCjQJH1jbrGEAjhXHFzTsxS+aKMhlya9O6
	 3EQp2QLz3e7fCJA0E/FqjwHQ6HZxj94PyJLmHaLGzv6LBS2o+YpeQTaH64yPrV/9Of
	 Hpqke/b/wd1D7v8AeRYGcB6Ij3Q87H+Tp9/eJxoQ0Xp0nRR8GPWXSeMq8l1wYDujPP
	 6XcOjHjr9TGnxhq8CfiQQDuDEv6nlmpGVUNoqR4kfor6HnB8E1ggWSedMqxMsyLOLA
	 Jhk/HVUJMlaNw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 1/5] scsi: sd_zbc: Set zone limits before revalidating zones
Date: Mon,  3 Jul 2023 11:48:08 +0900
Message-ID: <20230703024812.76778-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703024812.76778-1-dlemoal@kernel.org>
References: <20230703024812.76778-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_194816_729130_E8E01147 
X-CRM114-Status: GOOD (  12.43  )
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

In sd_zbc_revalidate_zones(), execute blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set a ZBC device
zone size and maximum zone append sector limit before executing
blk_revalidate_disk_zones(). This is to allow the block layer zone
reavlidation to check these device characteristics prior to checking all
zones of the device.

Since blk_queue_max_zone_append_sectors() already caps the device
maximum zone append limit to the zone size and to the maximum command
size, the max_append value passed to blk_queue_max_zone_append_sectors()
is simplified to the maximum number of segments times the number of
sectors per page.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd_zbc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index abbd08933ac7..a25215507668 100644
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
-			   q->limits.max_segments << PAGE_SECTORS_SHIFT);
-	max_append = min_t(u32, max_append, queue_max_hw_sectors(q));
-
-	blk_queue_max_zone_append_sectors(q, max_append);
-
 	sd_zbc_print_zones(sdkp);
 
 unlock:
-- 
2.41.0


