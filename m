Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E50EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fnQ9POx1r5cz1As2CDzItKDOzQqGmHn6p/2Bswc8lUI=; b=wBx+8ewTsxhb2f9jJeEvkFkprZ
	XJ0/aSt+yTFdTyW8xkmAWSPYfZ8QkS8ulw5MYZlFzy5oeXc+AqAIES7fRA8RMs4DBBqrXvnYdV3Ge
	MgG+xkEHp68WZkS8ONvhzOAZiMBGb+nCv433jnkPjSKptH33moMjhBGkKtopU2AiKYZmfYBIAODsB
	WgAlHQbpw7rs3TfzFKm+wfak4WWUX38iDkvX61V5rtpu15946PC89rJZB+4Zx9+xxpBQSduxF2oFS
	NwyBQr5SsNewuuMj3f28vuNdnXWK0vTy/JkAogQq3Vh/1QrxtLuA0VGr73HkTlgkM4Dq6moiT5CmT
	T2vRTs1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bx-00961z-1B;
	Mon, 03 Jul 2023 02:48:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bu-009609-2g
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 02:48:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6299360D41;
	Mon,  3 Jul 2023 02:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE660C433CC;
	Mon,  3 Jul 2023 02:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688352497;
	bh=SLutSjrXX/nlfqSkQykqUXldUhXcN1qaN4toNu4ttbM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YSYICn+eyCjxeu1oUG7s5xLGKEyF3tPooTRIWCtOtYaStjVuKmfvB/rO/SvVN8VC5
	 fYqeDKxLFimZIl9uKRVvcN4+KUwJg40aNh43FmrlDQec9cpOcmzPwetXn+JkVoj3JN
	 x7RJndww62pc0bN+1FgiGu5ipSh1TcWyrkwjds4jlPsCPrYpLmBv1u7gYiuFS4TTAw
	 vBf0mVPO2Gy0RTPgw7768ZGUEgVVDpIn1sD9oJWDVX8OMR0PFaTw2zePFHM3U9FnxZ
	 vsXt/aTSyBQlY3HTRuNBnJ5ZsQY7JSL4amavbxUS3RA2NYrIehjurnlWE9pZAM3NKO
	 FgUHGlt8kI7Ag==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 3/5] block: nullblk: Set zone limits before revalidating zones
Date: Mon,  3 Jul 2023 11:48:10 +0900
Message-ID: <20230703024812.76778-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703024812.76778-1-dlemoal@kernel.org>
References: <20230703024812.76778-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_194818_909532_01C72284 
X-CRM114-Status: GOOD (  13.00  )
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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


