Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31984C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CguPRvQxrjD6y/IzPOGivdt7zD5O3eoa4wiCpjmt0bM=; b=BWz3BWBTZeCF5iMLGU6TYxLpqV
	HAd+jvW3A7wTvyob8g4wYStaakOUNf/kbMDpM0wCG83+riP4Dw5h6B06xkTEZ28qyFklnBo/zLlgw
	MpObQLPcQV3A+kBZC1hJqOl1qRnCkIyUI+tLzFA30MLMk4+JCjRQrpqXYWprtnpcAcKhLxip/yOKt
	q/7ohAEvNjhujFeMu0Uedc2udwesA9zTg6Y3Kk22jrfuMprOGm6g9ibg+3x/ym9quCQOsyn0Nz845
	QVxmjjzNVDa0WijqjOrmCNKlKQELh8ek0VkDRuo90IxAXFeLn0nAOw/asp++2V+TCEe/ELWDfSGY4
	RvAMsCgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQI-0000000ARcQ-1WOX;
	Wed, 28 Feb 2024 18:12:54 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPn-0000000ARGY-1Dqa;
	Wed, 28 Feb 2024 18:12:23 +0000
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
Subject: [PATCH 13/21] nvme: split out a nvme_identify_ns_nvm helper
Date: Wed, 28 Feb 2024 10:12:07 -0800
Message-Id: <20240228181215.873854-14-hch@lst.de>
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

Split the logic to query the Identify Namespace Data Structure, NVM
Command Set into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 78667ba89ec491..adcd11720d1bb4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1831,12 +1831,35 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 		a->csi == b->csi;
 }
 
+static int nvme_identify_ns_nvm(struct nvme_ctrl *ctrl, unsigned int nsid,
+		struct nvme_id_ns_nvm **nvmp)
+{
+	struct nvme_command c = {
+		.identify.opcode	= nvme_admin_identify,
+		.identify.nsid		= cpu_to_le32(nsid),
+		.identify.cns		= NVME_ID_CNS_CS_NS,
+		.identify.csi		= NVME_CSI_NVM,
+	};
+	struct nvme_id_ns_nvm *nvm;
+	int ret;
+
+	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
+
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	if (ret)
+		kfree(nvm);
+	else
+		*nvmp = nvm;
+	return ret;
+}
+
 static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 		struct nvme_id_ns *id)
 {
 	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
 	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	struct nvme_command c = { };
 	struct nvme_id_ns_nvm *nvm;
 	int ret = 0;
 	u32 elbaf;
@@ -1849,18 +1872,9 @@ static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 		goto set_pi;
 	}
 
-	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
-	if (!nvm)
-		return -ENOMEM;
-
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(head->ns_id);
-	c.identify.cns = NVME_ID_CNS_CS_NS;
-	c.identify.csi = NVME_CSI_NVM;
-
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	ret = nvme_identify_ns_nvm(ctrl, head->ns_id, &nvm);
 	if (ret)
-		goto free_data;
+		goto set_pi;
 
 	elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
 
-- 
2.39.2


