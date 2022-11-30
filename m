Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB26C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYNpzNSsCzXbdDO5JbDPwrBvaBJ3fGPL7e+/jecvzQY=; b=ZV/5yZCfj7S12d0ODmNgKiP+h9
	iZzP+HZESxQ3eVtt0gU516QgYfjgyuXGtbgJ1/A14nkq9yl4hSdbT5Fetu6qDE62guM7C2Qd9jLee
	UGUQ3EP8UFerNoF6n6B0gPVlAip0f7m7SZSyF2vxcrmN/F1UVoMEs0VSaTDybmWv8vOrpYDDLwQ/W
	FgbfHshKhcIjAs6I/qild0eNOP4QCP8y6+Bt6S4PnZWrLVeqhu2SMBad0aENmsDDavHLw+JeV3xzc
	+60BApMGGdnSta58TmQSralkDbAKDfru6m+RU6gKdGkVbtdCcihewqnBusnI5EUA66tRXUF0UBSeX
	nxuZBeqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0RMR-001IFc-SE; Wed, 30 Nov 2022 17:59:07 +0000
Received: from [2001:4bb8:192:26e7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0R6k-0017a1-Ds; Wed, 30 Nov 2022 17:42:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/5] nvme: add the Apple shared tag workaround to nvme_alloc_io_tag_set
Date: Wed, 30 Nov 2022 18:42:38 +0100
Message-Id: <20221130174240.227616-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130174240.227616-1-hch@lst.de>
References: <20221130174240.227616-1-hch@lst.de>
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

Add the apple shared tag workaround to nvme_alloc_io_tag_set to prepare
for using that helper in the PCIe driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ed163c53976722..d404a3778b1d28 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4899,8 +4899,14 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = ctrl->sqsize + 1;
+	/*
+	 * Some Apple controllers requires tags to be unique across admin and
+	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
+	 */
 	if (ctrl->ops->flags & NVME_F_FABRICS)
 		set->reserved_tags = NVMF_RESERVED_TAGS;
+	else if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
+		set->reserved_tags = NVME_AQ_DEPTH;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.30.2


