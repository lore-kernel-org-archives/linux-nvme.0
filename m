Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912ACC5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n4waFSVlAIyzX5aRXU9CzyIn4fH9mLAI+aTGoMdaST0=; b=X/4tH3ahm4Ovi9iQ+k0Jt8fSiX
	81JOdK3z6V8kE0dcUnO3UdU5yW3N5b1aXKW3fT7MFGg/DyvXtiRCqcGj1LwGMC6WAOIzluZc6JztC
	pOsQ0uAyIXlhZi/RFAd/tg8FtbIazKY7goRwGi/aB0+RI4fl/2qCxOqrf7SsYs8ZpPD8vfswTfq6F
	Qw031ksBl911SbkLKBucsgVz3TIr6XypsFZU2vAYIJqnt6+/gadl5gu/9EEFrQX3ZIOhgzZj7tejX
	Y22D2dmER7YzZWMnU+y4pl+k5Z0zcRjbJtI2o0/0xhS4kcMQgk8/x5i1rqrdsswT6cg8IrsWEYbrJ
	myLAU30Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wX-00000009Hj6-0PZ2;
	Mon, 04 Mar 2024 14:05:25 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wU-00000009Hh4-2qh8;
	Mon, 04 Mar 2024 14:05:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 03/16] nvme: remove nvme_revalidate_zones
Date: Mon,  4 Mar 2024 07:04:47 -0700
Message-Id: <20240304140500.78583-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304140500.78583-1-hch@lst.de>
References: <20240304140500.78583-1-hch@lst.de>
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

Handle setting the zone size / chunk_sectors and max_append_sectors
limits together with the other ZNS limits, and just open code the
call to blk_revalidate_zones in the current place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h |  1 -
 drivers/nvme/host/zns.c  | 12 ++----------
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6c0b2f4cf796e..2817eea07e967d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2154,7 +2154,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
-		ret = nvme_revalidate_zones(ns);
+		ret = blk_revalidate_disk_zones(ns->disk, NULL);
 		if (ret && !nvme_first_scan(ns->disk))
 			goto out;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4a484fc8a073c8..01e8bae7886584 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1036,7 +1036,6 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
-int nvme_revalidate_zones(struct nvme_ns *ns);
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 499bbb0eee8d09..852261d7891362 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -7,16 +7,6 @@
 #include <linux/vmalloc.h>
 #include "nvme.h"
 
-int nvme_revalidate_zones(struct nvme_ns *ns)
-{
-	struct request_queue *q = ns->queue;
-
-	blk_queue_chunk_sectors(q, ns->head->zsze);
-	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
-
-	return blk_revalidate_disk_zones(ns->disk, NULL);
-}
-
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 {
 	struct nvme_command c = { };
@@ -113,6 +103,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
 	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
+	blk_queue_chunk_sectors(ns->queue, ns->head->zsze);
+	blk_queue_max_zone_append_sectors(ns->queue, ns->ctrl->max_zone_append);
 free_data:
 	kfree(id);
 	return status;
-- 
2.39.2


