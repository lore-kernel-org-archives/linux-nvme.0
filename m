Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F60C54E60
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ie9Ap0Vg8rzZC4lIOYHUtldkDGU569+6gIelLh9GLyA=; b=cdENoKSSLIilZlNg9JikbIn2u2
	k3cPxd+ffT4S4xJhCyQDrMcEasRMp4vmC4mnHfoI49RpgkSIPaQfnbVXvLeNa8WgQwYHHb+4rjbQ5
	6w6CqioNQgSZ6DKEmMXH2zw+M57DCHxAGQx0iX1UwC84YRScNNlZixoiijhdE8S7Xp2cj4IAosjvT
	+ChPMRq5WZzUAzfRh5nIjK3F5fmaiG6A86G3SkLUvljlL3IBRGp4rBPqOHWJ+9KMG6UQ+YcC79kXH
	QKRtyGrwblyYR+cpXJctlG2/e6AMuxdNHXSwXQWJN+TwvxdYf67zudX+eW/sYRKMyFaZKPzxkW0lm
	eUDEq7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm2a0-000000071ON-2SiR;
	Mon, 18 Mar 2024 02:18:24 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm2Zx-000000071NT-3n7C;
	Mon, 18 Mar 2024 02:18:21 +0000
Date: Sun, 17 Mar 2024 19:18:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	axboe@fb.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Message-ID: <Zfekbf0V5Dpsk_nf@infradead.org>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
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

Hi Nilay,

thanks for the report!

I'm currently travelling without easy hardware access, but can you try
the patch below?  This simply rebuilds the limits from scratch.  It
probably wants a bit of a cleanup if it works, but this should be
fine for testing:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00864a63447099..9ef41e65fc83bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2215,10 +2215,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 
-		lim = queue_limits_start_update(ns->head->disk->queue);
+		blk_set_stacking_limits(&lim);
+		lim.dma_alignment = 3;
+		if (info->ids.csi != NVME_CSI_ZNS)
+			lim.max_zone_append_sectors = 0;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
-		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
+		ret = queue_limits_set(ns->head->disk->queue, &lim);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
 

