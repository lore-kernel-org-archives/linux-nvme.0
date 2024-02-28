Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EA9C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1u9QV5OL/xXoZkSISwcKCUoB5a/StW+iEME5VTNJUo=; b=fZyhDSIr2vkN9MM0xxwZcvMDww
	+qhzoB7mv7iw2nDJGdWbUnS12jYnQxiYG3O470dB92G8B6TwejAh5+2v50fp9UFRbXj6DxkoX9NHh
	12WwlloxdiTNESVGnH4eEEsjU8/DeeGZVoztEpei68p2/5FInqUyLky8an+yrxarAv5gIc27IWSW1
	Wyp6191t4tBTb272XbOx3mwliC+z725N+t8/p4a9TbNnboBQ5/k8YDFGWqQFUkH4hpJIzVG24AQCm
	GeZIqpboXsX3FNkInMF3iGeycXiZZ+v7sJz+bvlGftxrHe3Up64tZbMoyrhegZpskUEdCkTw/i2z9
	ZWzqOcCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQN-0000000ARgb-0zzE;
	Wed, 28 Feb 2024 18:12:59 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPo-0000000ARHe-2Kxh;
	Wed, 28 Feb 2024 18:12:24 +0000
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
Subject: [PATCH 15/21] nvme: cleanup nvme_configure_metadata
Date: Wed, 28 Feb 2024 10:12:09 -0800
Message-Id: <20240228181215.873854-16-hch@lst.de>
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

Fold nvme_init_ms into nvme_configure_metadata after splitting up
a little helper to deal with the extended LBA formats.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 47 ++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 531230ccd12210..f4ec8683b3b725 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1855,26 +1855,14 @@ static int nvme_identify_ns_nvm(struct nvme_ctrl *ctrl, unsigned int nsid,
 	return ret;
 }
 
-static void nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+static void nvme_configure_pi_elbas(struct nvme_ns_head *head,
 		struct nvme_id_ns *id, struct nvme_id_ns_nvm *nvm)
 {
-	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
-	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	u32 elbaf;
-
-	head->pi_size = 0;
-	head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
-	if (!nvm || !(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
-		head->pi_size = sizeof(struct t10_pi_tuple);
-		head->guard_type = NVME_NVM_NS_16B_GUARD;
-		goto set_pi;
-	}
-
-	elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
+	u32 elbaf = le32_to_cpu(nvm->elbaf[nvme_lbaf_index(id->flbas)]);
 
 	/* no support for storage tag formats right now */
 	if (nvme_elbaf_sts(elbaf))
-		goto set_pi;
+		return;
 
 	head->guard_type = nvme_elbaf_guard_type(elbaf);
 	switch (head->guard_type) {
@@ -1887,29 +1875,32 @@ static void nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 	default:
 		break;
 	}
-
-set_pi:
-	if (head->pi_size && head->ms >= head->pi_size)
-		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	else
-		head->pi_type = 0;
-
-	if (first)
-		head->pi_offset = 0;
-	else
-		head->pi_offset = head->ms - head->pi_size;
 }
 
 static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 		struct nvme_ns_head *head, struct nvme_id_ns *id,
 		struct nvme_id_ns_nvm *nvm)
 {
-	nvme_init_ms(ctrl, head, id, nvm);
-
 	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	head->pi_type = 0;
+	head->pi_size = 0;
+	head->pi_offset = 0;
+	head->ms = le16_to_cpu(id->lbaf[nvme_lbaf_index(id->flbas)].ms);
 	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return;
 
+	if (nvm && (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+		nvme_configure_pi_elbas(head, id, nvm);
+	} else {
+		head->pi_size = sizeof(struct t10_pi_tuple);
+		head->guard_type = NVME_NVM_NS_16B_GUARD;
+	}
+
+	if (head->pi_size && head->ms >= head->pi_size)
+		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	if (!(id->dps & NVME_NS_DPS_PI_FIRST))
+		head->pi_offset = head->ms - head->pi_size;
+
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
 		 * The NVMe over Fabrics specification only supports metadata as
-- 
2.39.2


