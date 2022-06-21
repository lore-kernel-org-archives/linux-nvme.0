Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E89C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5lYWFLriN961GAbGDJMad4nWmVdP/4YqY2DFHAHb4AQ=; b=zA371f1mRqqLfu+itEGJtxgvuu
	lFWKZ82iqNJ8mJq2Q4SiAymBdHGfkA3XbHW5Rq2cUyZL1e1zqQCTr/KMYHtkwco3NDIOKMOs3NGCq
	x/pXortR8pbQx2p3Ir1SEcw0aBHva3rx5x+JnwWJDndYgQplFzEiCXUWyDeeGmjOOKio8Yi0kUP69
	2H1tzam0vWYsZY7MMR2CFZ7ggwpxSoxPNwoftpcj6mbEjyJr/GCmo/N5C4sCD33HEEWj/rWSLiYGg
	7rexvOR2muZPeSRmY4Kl6pbhdUAHfIHOZ6BXJpM/RY+9gbZeYSAD3IpbGjEUQrbZjQ0P8F5F/VywU
	pRRzGZ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kp7-0076EG-Ux; Tue, 21 Jun 2022 20:50:09 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3koq-00763w-QG
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2C529B81B30;
	Tue, 21 Jun 2022 20:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D04BC341C6;
	Tue, 21 Jun 2022 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844587;
	bh=BR1HAj6K/jdDr3B8GY7a3yhVgwEikZfitTZ05ctiO18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ih0S/KXBNAPMWYCS/MwuZ/mmpqz2xJCmFUXpI4nkgS3fngYhRKS2+LoQn856cst8+
	 Wo5jClprY9QLcvHREFpVFVJOfkoC8cIk3b6Svkve5Q6iPyWPQgHcIXvXmwvRLHFOQs
	 1n7kfRzM6RcUlZShTBRXS4NT+CfyhrhSsCQKCILtM2rmYSqyWgnn5MmAfYR+v/8+95
	 N1X5Pq83YMWB54xY3kpUK0g6+vT3qfG3dAVXZmFjALfX2J5FUJLAp4erAeWEAt5kMR
	 9BJvTL0iml+5gzu+vB8oRK8rL9THDvpzLT4dqo4bUiT0otOvt/uhgD/G8izUqWtLnE
	 Fv3P0WU/bNJ3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 06/22] nvme: add bug report info for global duplicate id
Date: Tue, 21 Jun 2022 16:49:12 -0400
Message-Id: <20220621204928.249907-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134953_179266_46A39C76 
X-CRM114-Status: GOOD (  16.18  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 2f0dad1719cbbd690e916a42d937b7605ee63964 ]

The recent global id check is finding poorly implemented devices in the
wild. Include relavant device information in the output to help quicken
an appropriate quirk patch.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 16 ++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2d6a01853109..0e18f8b38081 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3803,6 +3803,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	if (ret) {
 		dev_err(ctrl->device,
 			"globally duplicate IDs for nsid %d\n", nsid);
+		nvme_print_device_info(ctrl);
 		return ret;
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2b53ca63335..764dd1d88777 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -502,6 +502,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	void (*print_device_info)(struct nvme_ctrl *ctrl);
 };
 
 /*
@@ -547,6 +548,33 @@ static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
 	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
 }
 
+/*
+ * Return the length of the string without the space padding
+ */
+static inline int nvme_strlen(char *s, int len)
+{
+	while (s[len - 1] == ' ')
+		len--;
+	return len;
+}
+
+static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
+{
+	struct nvme_subsystem *subsys = ctrl->subsys;
+
+	if (ctrl->ops->print_device_info) {
+		ctrl->ops->print_device_info(ctrl);
+		return;
+	}
+
+	dev_err(ctrl->device,
+		"VID:%04x model:%.*s firmware:%.*s\n", subsys->vendor_id,
+		nvme_strlen(subsys->model, sizeof(subsys->model)),
+		subsys->model, nvme_strlen(subsys->firmware_rev,
+					   sizeof(subsys->firmware_rev)),
+		subsys->firmware_rev);
+}
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17aeb7d5c485..37e05c83786d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2970,6 +2970,21 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s\n", dev_name(&pdev->dev));
 }
 
+
+static void nvme_pci_print_device_info(struct nvme_ctrl *ctrl)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+	struct nvme_subsystem *subsys = ctrl->subsys;
+
+	dev_err(ctrl->device,
+		"VID:DID %04x:%04x model:%.*s firmware:%.*s\n",
+		pdev->vendor, pdev->device,
+		nvme_strlen(subsys->model, sizeof(subsys->model)),
+		subsys->model, nvme_strlen(subsys->firmware_rev,
+					   sizeof(subsys->firmware_rev)),
+		subsys->firmware_rev);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2981,6 +2996,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+	.print_device_info	= nvme_pci_print_device_info,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.35.1


