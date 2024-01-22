Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3BAC47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGWbKYlVFWK+oadU1xwjKPo8yRfdDiY9GpjAcsWorHA=; b=S5HYE2TmUheiY+FSP+CPLLjy8u
	SoiXsBXhLJxtmHOv/jV2XtldGgte9VkbF1ZZkxWiI0nO21nJMgCP+vBhy0D8S/ZWroqCST0LDV+ZX
	8lffO2BDPSCFAz6nxmgfXXZHn8Vs2T7y21B5muA1HXyhGpr//sqc+bDbCiDscSfXpR+TIVjfr/RLG
	Br7lCsMmWzhqTeiZ67G1qF6LykeTbUb62q01BsFS3WsoMC//z/yA3+qxGMtaeoWaZ/e/v1j/s6DgV
	O6pAV6c6z9+kYXqqBqT4OO+pEl8sFwGKJyWl6F19VBdxNBjx7vRM7llTaXOE/qzaqHFKyTCWF8gbU
	ZTcpfNiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEM-00DGl5-0S;
	Mon, 22 Jan 2024 17:37:06 +0000
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyEK-00DGiY-2D;
	Mon, 22 Jan 2024 17:37:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH 06/15] nvme: remove the hack to not update the discard limits in nvme_config_discard
Date: Mon, 22 Jan 2024 18:36:36 +0100
Message-Id: <20240122173645.1686078-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122173645.1686078-1-hch@lst.de>
References: <20240122173645.1686078-1-hch@lst.de>
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

Now that the block layer tracks a separate user max discard limit, there
is no need to prevent nvme from updating it on controller capability
changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e8864..ef70268dccbc5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1754,16 +1754,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	/*
-	 * If discard is already enabled, don't reset queue limits.
-	 *
-	 * This works around the fact that the block layer can't cope well with
-	 * updating the hardware limits when overridden through sysfs.  This is
-	 * harmless because discard limits in NVMe are purely advisory.
-	 */
-	if (queue->limits.max_discard_sectors)
-		return;
-
 	blk_queue_max_discard_sectors(queue, max_discard_sectors);
 	if (ctrl->dmrl)
 		blk_queue_max_discard_segments(queue, ctrl->dmrl);
-- 
2.39.2


