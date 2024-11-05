Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BCCD2B94E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2pI4muBBDotpdXxdR5iT9OwjkhWYqDjshZgezWHTJk=; b=LgrevHBmUQEvutsMpeyLK/yp/w
	0G5zo/LaMYQ8WbGpe60qxZReb8t4AJVGIrxDP/zXLJZE4bp2LW4bxGmD6hXyuVZIh0Qo8vb5KVuoX
	OSU68jRreO8sJ+vAJJYDz7VS6rpwqcrcB9y3UUJEyVgawuEbCW5FrHHFwDr7XtK1SXAjnFgN3yDi4
	TD51ZTdtcFXkQAYRPa9NUk4GFhql8EXNASkFiZVq5bbv1wLLZr6Xn8uwkUNLQFWitw4yT+pyG18IO
	75Ra4bD0D6i/0041xFQHzws11u1sBUEOP7aMXHpH60IHcsXBiR6/zLO9Um645Gn/LrB5aGIurBfEr
	lqOeeQvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Lo7-0000000HUF6-2fJl;
	Tue, 05 Nov 2024 15:49:27 +0000
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ln8-0000000HU8v-24RA;
	Tue, 05 Nov 2024 15:48:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-multipath: don't bother clearing max_hw_zone_append_sectors
Date: Tue,  5 Nov 2024 16:48:12 +0100
Message-ID: <20241105154817.459638-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
References: <20241105154817.459638-1-hch@lst.de>
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

The limits stacking now properly zeroes it if at least one of the
underlying limits clears it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c26cb7d3a2e5..f04cfe3fb936 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -635,8 +635,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
 	if (head->ids.csi == NVME_CSI_ZNS)
 		lim.features |= BLK_FEAT_ZONED;
-	else
-		lim.max_hw_zone_append_sectors = 0;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
-- 
2.45.2


