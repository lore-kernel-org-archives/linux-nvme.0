Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E75C00528
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 02:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ojNmkOmc6KE1jFcywVBwNtRy03uqW8MleaS7eldOso=; b=YhA8PVbP2mYt1qf0eX7ilY6j6R
	LXK+DDI18bWtlgSZEnX+WXn0CToowi6WQ9nMbFzH8P7P/pzV87enPMAxjE1EEqoC3HrqfD0K/XD0f
	uA8IjIsV0wbD6shXyFIwyGMRJPXpf6UKbcdUJPjdeg2WfziII9kYAmU9YlBMaqJJvAqjbQtGMMYgE
	Pxp+iQmYy5mvH6ilkcxQU9Wq12PWTZlF7LKBnr0o2QmJBI/S6zZNWxvX2Xg4/Inw8YAFmnQMQSMR9
	Rrg3o8YMK8TGF2im43yNqAT+LRHpxe7YvVAAvc250VJWJzDzXfHODctq+PUKZrj4+EB8H3A8u7o1w
	Z6zndKcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bv-00960f-2I;
	Mon, 03 Jul 2023 02:48:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qG9bt-0095zk-2m
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 02:48:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4627C60D39;
	Mon,  3 Jul 2023 02:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20BEC433D9;
	Mon,  3 Jul 2023 02:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688352496;
	bh=aQz14JDPpfYBy7pNRQoQLYD4d3slnZtaCXTLLik5g6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oOGR1CKLB2WfEy4CtDVZPIwBmxIG7WiKDObbpsX9WlnsU5bKQbbSninmibwhvbyHY
	 prf8CgkapsEuu2SxeiKfYNWYNGJWO6wx14nC8NPwmbD76/mTx7JiTDaErw16IhoJl3
	 qu+PZB2QOUQ3GBxA6XUKR/mZatbQekHNhezzLq/4YdgPJBZ8lZDXHOV4nxfZPVszFo
	 ZHAoVPsE9zg+2j5JTguUnV15o62dwt60AhI3JfKqHE4SWFvjH6gcIOPGTRV7pX1w/Y
	 R7gwMHZHW8q/ooZpuo8rqozdnDl6aTtlJSyUcKwjxGEU/E31kGWmK1Sc+8PAeTRvxn
	 nH/6xwykrMU8w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 2/5] nvme: zns: Set zone limits before revalidating zones
Date: Mon,  3 Jul 2023 11:48:09 +0900
Message-ID: <20230703024812.76778-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703024812.76778-1-dlemoal@kernel.org>
References: <20230703024812.76778-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_194817_939957_3A7A0C6B 
X-CRM114-Status: GOOD (  12.30  )
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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


