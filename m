Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEDAC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgNSe+v3GZ1ofs/l7mw6pEzUPqYvYaFb7ZgcuivXAXw=; b=SPi8l3pwurJi2j6ak6ui4fF6km
	D+J7U0us8v67qZ4H3NRVhLdFQn8cj09AmnZyJm/DSQVgFWPG9G5CVWZoT+vrVQ+CCkRXLECLFs2IJ
	qOANb6LQ3wOsTCcxL9id5hnWrK4tO4LcmBv1vwim/AZzGrpVfPcek8sE+wTSNiGZyDlnOfadqWxtr
	bH1P5iPtP4j2doZey5RzxkZiwHW7ti0Ra1CbNnwc0gc800QFMgamI4G2i3T5Rwe8oj6SiME0YHHxE
	bydRLiV4WauRPymaq9GpuL/rP9F1Sy5IHjQx49AYFIsYQw0iTuTm+dwo9aNSkOu8qHJjSgoNWn9i3
	sygzLN3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfPQF-0000000Ada4-1xZz;
	Wed, 28 Feb 2024 19:16:55 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPr-0000000ARJS-2xT1;
	Wed, 28 Feb 2024 18:12:27 +0000
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
Subject: [PATCH 21/21] nvme-multipath: pass queue_limits to blk_alloc_disk
Date: Wed, 28 Feb 2024 10:12:15 -0800
Message-Id: <20240228181215.873854-22-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
References: <20240228181215.873854-1-hch@lst.de>
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


