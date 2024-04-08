Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60660CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQCgD6x1bNjJruigBbUFjIdHnFnx8dp5N4lLkCaYvHQ=; b=rvvZum4lv8K/j3/aiz4470RFf/
	HkHr5G4l4NDNM46vjqv7nmZ6TKTrmqtU+J6wdnQTfGPkfATIX2vRjNGZex9zsy0jaIeo68qXiW/sI
	x5f5NWaoha/mLrhwOGma69WiLGZRZWcENKf7clK6NKRfMmZeuSX35ev5aTvELp5qvmZIGotcvkE/K
	EBY83ZujyjurNAktRMqOqOa9E/D2xGX1r6kLe2td2Xawlg99qR++3K4xzfs8zzNMA4ZSYtA4S+iAC
	NNdNPv02CvISr1C63DdFH3QDcXrPW5GHzxKd6fKjh0P+WrqBguz0DRPh4qALMNzY9ujPUxuANxDjU
	g1MG0J2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1i-0000000DvvD-0mJq;
	Mon, 08 Apr 2024 01:42:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1G-0000000DvW0-21UM
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D58AC60DDF;
	Mon,  8 Apr 2024 01:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C1DC43394;
	Mon,  8 Apr 2024 01:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540517;
	bh=BAiWNhCwyIY1LaDWb3Dd92O78HHu2u6zYh3FJtbEcvw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T9XSrn2gljA/maWyfaIMjWYg+nPDvbA9ATjAGUw+rN6GsoqxJVeC/6hUMyy10B1dw
	 WHc7ai5v+idZuBYvvp+oADDgChySFyEvSxH4QYQaTu7UKXGh6vO7Z2wNnPPcG/zzT/
	 SHDIXWSzSbgZS9bcBHEkHc+tezyZqgufgWqmwqXX7U0j/+FUovAif1iJEfriH4qJ2C
	 bHDeLMp8wwoyGsfnI4BOnJsWMQQFtYcOH+xN4fH3hlyj3epFk5lOEls9N92c63mI/d
	 Gwj5gHzV80TluQKZj4euC0wVHq1qSgOxA2RY2ncohyYZmSZMjtUfaa3MgbNBofMr2Y
	 wnvrQcXliUp4A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 14/28] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Mon,  8 Apr 2024 10:41:14 +0900
Message-ID: <20240408014128.205141-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184158_839870_2F907BFD 
X-CRM114-Status: GOOD (  12.27  )
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

With zone write plugging enabled at the block layer level, any zone
device can only ever see at most a single write operation per zone.
There is thus no need to request a block scheduler with strick per-zone
sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
feature. Removing this allows using a zoned ublk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/ublk_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bea3d5cf8a83..ab6af84e327c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -249,8 +249,7 @@ static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
 static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
 {
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
-	blk_queue_required_elevator_features(ub->ub_disk->queue,
-					     ELEVATOR_F_ZBD_SEQ_WRITE);
+
 	ub->ub_disk->nr_zones = ublk_get_nr_zones(ub);
 }
 
-- 
2.44.0


