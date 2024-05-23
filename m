Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91136C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yrec9zA5FIK6Rnk9f0TIofBp6P9UHg+qBFFyH7h3LgY=; b=NHT/D84DP+Ek9zLFux29owHNhf
	D6yIMyF1T+sI4+XugiTvG0h6irDLRNivjj8UfCIJmCHrq3M2dMbn/hBELI/bw4lWtflF3/iVaXRSA
	JoO/LrH9FxoY39vt/aROHOKGj/RbFzgM73coHy3FjZjKZIqDpgY335x7Bn69TvexM87uOloBQX+2F
	VYtXqpG2u1+UZGQvaDm8ge+bubl9F4u4z4ZjNR7npJlzV2neYVrU7wdhdNuL7/0Oe/BGmzrUY3jqb
	lGpBQafsmQpR6b6d5EZuWmSjfA4gwTyp6TKSO2/aFvfIZkKntYLlVTRJBe0BsOGU/p2WipOn8h3uF
	QiT1Q2uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA75V-000000066w4-326S;
	Thu, 23 May 2024 11:58:25 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA75S-000000066vV-1EVR
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 11:58:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 64478CE13D1;
	Thu, 23 May 2024 11:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B76C2BD10;
	Thu, 23 May 2024 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716465497;
	bh=68zABJIKxl8iLI3sy9YzD6leoXVO6C2XAN95v3xyg+M=;
	h=From:To:Cc:Subject:Date:From;
	b=nZprH5sfNw0u3IhXnljy91ATPMR/4JWiH1/YjZJF1FhYf3MGdlMf7cyJiJNXis4qv
	 B0D3K708ZfwumOnAvcCfs3qmLul3Jm9R+mNc/F3KMRC6jT4RjT8tImyatLxqJRPsUU
	 ScL1wgz3AHHQTyhhvkuFYNGYiPWvQKMoXfgcqPOxLMhK8NwhxkVwfCNQrvMreKmhCJ
	 lALQESeAR9iq3JSM2pJIHf/FTDU6cXAKX/rg+UBuvRTUqeBhbqvl56LhS0ShqzAVtj
	 TLNP6tq+4y+jSxGFOKez1IPVkogOGR6YhOMNXCvr+lrCrs6LvGVWwobTtoap2Aklld
	 JgofT7cD7Th6A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Damien LeMoal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme: fixup zns namespace initialisation
Date: Thu, 23 May 2024 13:58:10 +0200
Message-Id: <20240523115810.133470-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_045822_551193_DBFF120B 
X-CRM114-Status: GOOD (  11.01  )
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

nvme_set_chunk_sectors() needs to know whether it's a zoned namespace
or not, but the information is only set in a later call.
So move the calls around and ensure that the namespace is marked as
non-zoned initially to avoid calculation errors when trying to derive
a non-existing zone geometry.

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8324f231b79c..bcb4a1a37d68 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1952,6 +1952,12 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
 	lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;
 	lim->max_segment_size = UINT_MAX;
 	lim->dma_alignment = 3;
+	lim->chunk_sectors = 0;
+	lim->zoned = false;
+	lim->max_open_zones = 0;
+	lim->max_active_zones = 0;
+	lim->zone_write_granularity = 0;
+	lim->max_zone_append_sectors = 0;
 }
 
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
@@ -2115,13 +2121,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm);
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ns->head->ids.csi == NVME_CSI_ZNS)
+		nvme_update_zone_info(ns, &lim, &zi);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 	nvme_config_discard(ns, &lim);
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
-		nvme_update_zone_info(ns, &lim, &zi);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
-- 
2.35.3


