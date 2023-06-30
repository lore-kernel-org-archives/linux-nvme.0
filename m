Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DA3EB64DD
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P5q84iniPknYhWpru3E6/VXnWVYNzQFrvGrynxrbDCA=; b=Qw7N9GSg2JfzpWBu5bICR3Fv43
	8ly3+F9B9zUqt2+xurur2DiBl3blWxZ+1w82TtiwWcgPO6oHaeStEOY4coN6cyGdMAhb4iCH0LX1W
	xAAPkHxGHA+4O1xGdxutscwSshd6GdrkZqrHOQsS1hgHB88AxLvzeFL/bvr5Bl9VmVlBprrVs2PxW
	7IXrCok+fp1EGmlL8PwiNVzo6rvkBCW090GHCPWUTWyrFzL/1KlR9UA4npyS6R5pn1533uNoyb2Ou
	H2UV/90xpeYlCvoVgpqnV29s6Zisb7tClcvAPMuHx50cYyaCcYaQfARLjtTBOOcXMAOZvFY8DI86G
	nOmWB18Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fN-003Cnp-33;
	Fri, 30 Jun 2023 08:39:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fJ-003CkG-10
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 08:39:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D468F609E9;
	Fri, 30 Jun 2023 08:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B966C433C8;
	Fri, 30 Jun 2023 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114380;
	bh=bbajuzLvUWwwdTbld5XYYfeTrAfvglhYfafdpdararM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MvH5007mYb1dbvaGIRHyVq/UeUPYh2bGPJR4iycz3+9AkjKKFuufzOuI1Pe//M7Wg
	 2+cxs6U0CHDZZTrt9eN7cJqQOrbVNXBlsr3dVPRoNlWbl2n9BUUXYcdmATXjUe514h
	 5yTP+lCqaaFtFCtI1Y1jgEgSyCQqLmmdkDvKYeBTViL50nlNf8WmFiqzJ7rQBWt8xc
	 u0Jx9p4oi6FCJo4u7pkjVZeA7wMelxip2C0J3GsSGKDBhEs1IrPVudCmhh7ZMsWrQ9
	 AdPEa2Gt+dE5ewF+osf5Hb8QbnnwiAZ9Q6C8I2wuH6MbTKtwB6ZEGnwYuZ+EYrWB8u
	 WIGaOaQTzW5tw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 3/5] block: nullblk: Set zone limits before revalidating zones
Date: Fri, 30 Jun 2023 17:39:33 +0900
Message-ID: <20230630083935.433334-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083935.433334-1-dlemoal@kernel.org>
References: <20230630083935.433334-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_013941_400347_20527334 
X-CRM114-Status: GOOD (  12.60  )
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

In null_register_zoned_dev(), execute blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set the zoned device
zone size and maximum zone append sector limit before executing
blk_revalidate_disk_zones(). This is to allow the block layer zone
reavlidation to check these device characteristics prior to checking all
zones of the device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 635ce0648133..55c5b48bc276 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -162,21 +162,15 @@ int null_register_zoned_dev(struct nullb *nullb)
 	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
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
+	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
 	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
 	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
 	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
 
+	if (queue_is_mq(q))
+		return blk_revalidate_disk_zones(nullb->disk, NULL);
+
 	return 0;
 }
 
-- 
2.41.0


