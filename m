Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAF6C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgNSe+v3GZ1ofs/l7mw6pEzUPqYvYaFb7ZgcuivXAXw=; b=aLHf6E1LD+0EJZOzDRsyskpr+z
	CCKBWgRczKzV6aWKX0kDkAqc+EhGB4YJjqJNi1O/Gzj/G3p1XLhovkC5BfsCH1yeWAo3f35WPFwY5
	1yOdMSkXgnRBPWvqvoM/n7taVtUN5+dJGf5mj4WW5WNO5+zzSo1C7nIhfBwbDA/e2Z8TNQXOcn5mT
	4baBIPGaaj0AkzZMFuh/MZVAKs3zHG2M6xlkJSQKO3S3KBrt4RqDCidUbHhw9qDmbI2hDl05QpYcm
	8xjzTZWVZFMrr8GCR+kisxnJMSGqdIkxezQWMBOcRhIBdldBzeRytpirYizqQhanTGYAlxDtrRYMr
	ufaXpjnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8xp-00000009IYy-1UPN;
	Mon, 04 Mar 2024 14:06:45 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8xc-00000009IPU-3nlV;
	Mon, 04 Mar 2024 14:06:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 15/16] nvme-multipath: pass queue_limits to blk_alloc_disk
Date: Mon,  4 Mar 2024 07:04:59 -0700
Message-Id: <20240304140500.78583-16-hch@lst.de>
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

The multipath disk starts out with the stacking default limits.
The one interesting part here is that blk_set_stacking_limits
sets the max_zone_append_sectorts to UINT_MAX, which fails the
validation for non-zoned devices.  With the old one call per
limit scheme this was fine because no one verified this weird
mismatch and it was fixed by blk_stack_limits a little later
before I/O could be issued.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index dc5d0d0a82d0e2..5397fb428b242c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -516,6 +516,7 @@ static void nvme_requeue_work(struct work_struct *work)
 
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 {
+	struct queue_limits lim;
 	bool vwc = false;
 
 	mutex_init(&head->lock);
@@ -532,7 +533,12 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
 		return 0;
 
-	head->disk = blk_alloc_disk(NULL, ctrl->numa_node);
+	blk_set_stacking_limits(&lim);
+	lim.dma_alignment = 3;
+	if (head->ids.csi != NVME_CSI_ZNS)
+		lim.max_zone_append_sectors = 0;
+
+	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
 		return PTR_ERR(head->disk);
 	head->disk->fops = &nvme_ns_head_ops;
@@ -553,11 +559,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
 		blk_queue_flag_set(QUEUE_FLAG_POLL, head->disk->queue);
 
-	/* set to a default value of 512 until the disk is validated */
-	blk_queue_logical_block_size(head->disk->queue, 512);
-	blk_set_stacking_limits(&head->disk->queue->limits);
-	blk_queue_dma_alignment(head->disk->queue, 3);
-
 	/* we need to propagate up the VMC settings */
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
-- 
2.39.2


