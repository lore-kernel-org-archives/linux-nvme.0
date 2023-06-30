Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21CBEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89hzQ1Aj+znn0umivOI0zVhPjvvDkyY9I3jqzwlCs1I=; b=XtQ/Vw62qNUytrdxVAPIzAZ1AT
	jpMqhqqs+Q562U04WFQN/p4LMyX5gWUvWIWlpSc+/rcjYbWm+lN+I4yL90igTMCiXzKA29yo84Zz8
	1+lCHJS/KvjazHv5llfwyahnqX1MATUJyY7yfk8UBvJkRh4Hyxi0OA4j8luOLQtTa6kJUWCsyK00g
	5spGPtG1vUGrizh5YJOiTgEC7LwZXGPRkWqnq4CA6BnUZnrUvcFa5s119MUrAx+TeGG/v8dEwBKtD
	SKU5q4kdTcw5QdJ8ebhVWSrV9A9uj0KzqmRy0RU8/CMnszEWHiADG+bWGHIutDU59B47Sz+pXcwR6
	y7lMEzdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fM-003Cmo-2s;
	Fri, 30 Jun 2023 08:39:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9fI-003Cjt-0n
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 08:39:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C4B2161703;
	Fri, 30 Jun 2023 08:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68273C433C9;
	Fri, 30 Jun 2023 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114379;
	bh=oZUH+aGuaNokG6mpzJLFGf85p884Ot0RaMjfhyYrdWo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K18N30Pg7RNQQHd8gGMn5peSb+1f8rzmv7CCyUZpoM3MkMidAF2WaBarW9N2JcpYx
	 bMtZtrIFUA9dE0dfHBHdg33evHsbpKuRUTPKTEnw4mGwr3b6CDDeVYoMFNCNDToVfS
	 81bzBPyM01RhEiowyTYeqSDpHHLovixLIbS3rLHToguthUoOKLW/Prq87n8KC25esH
	 bRb/uEcexRd2SDdnXymD9SD0FTE648Yc/Y06rhO35k+Ecxr1+QIuW1bmHR9wf4jqk4
	 6APvM2OPO8IHXFz+Xucy58P9PZQZElibQg9seigv/rZ0PTndmoQkys4vjZxDsFP3gw
	 NpS3tqxdp69lA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 2/5] nvme: zns: Set zone limits before revalidating zones
Date: Fri, 30 Jun 2023 17:39:32 +0900
Message-ID: <20230630083935.433334-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083935.433334-1-dlemoal@kernel.org>
References: <20230630083935.433334-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_013940_324110_5F4B23D9 
X-CRM114-Status: GOOD (  11.87  )
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

In nvme_revalidate_zones(), execute blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set a ZNS namespace
zone size and maximum zone append sector limit before executing
blk_revalidate_disk_zones(). This is to allow the block layer zone
reavlidation to check these device characteristics prior to checking all
zones of the device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/zns.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..ec8557810c21 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -10,12 +10,11 @@
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
 	struct request_queue *q = ns->queue;
-	int ret;
 
-	ret = blk_revalidate_disk_zones(ns->disk, NULL);
-	if (!ret)
-		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
-	return ret;
+	blk_queue_chunk_sectors(q, ns->zsze);
+	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+
+	return blk_revalidate_disk_zones(ns->disk, NULL);
 }
 
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
-- 
2.41.0


