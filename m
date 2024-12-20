Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F8FE7718A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4XnPNZYXddtnEDd3of/B8A8zQULf25QvQxR/N2y9d0=; b=EzCeu3i5C5Qlhh0h6QwbuVls47
	X90f0dbP11idtlPWla1hX3Un2Ac16VbAs1/LPo0PYNv0rEe4FfvuE99FGhIaMtosJWJqk8Ril2j3e
	ZdeMqPH7w1WO37LevXtfFydB4As/jLjpZ1xheFCh40xMbS+s1vkCmSIPUl4mN4mZGSZAzybpKLyfD
	qcaA87+8G26AKRENegBl1j3wWXfarIeFbdlyWLGaoDg6NQICkCLglvw2LPmbo1EOMN5jbny3QB2uO
	9R+pldi4lCmjLVH1Tj1wMLF3ehR4SqgiBpwEfnnUKh5GcjCNoVN0wh6OzHJqjfX5pY67mJm8HO6fb
	geQPz22g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZfK-00000004TsS-3TGN;
	Fri, 20 Dec 2024 09:51:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZfI-00000004TpG-3mEP
	for linux-nvme@bombadil.infradead.org;
	Fri, 20 Dec 2024 09:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=E4XnPNZYXddtnEDd3of/B8A8zQULf25QvQxR/N2y9d0=; b=PbfPiXnUTvHaY0Jc1tgaeGoy2z
	4GLycQGrJUUFHh2w3uBybTCV1bIHWAOIGUc+Ojwlk2+D+noUvWgu5KybaoVrhYqoBXnyYvZzKYo6K
	TLiWQr1R6IEwLcHwRwoyZSFoJEFT1p2CmGExBIuEAcVqakiEUXhHGKg/JTW2Gpkzxs1uO+Q8WsmEx
	avM6GU0ofQHJyHjWqyO2PvHYtZKhUjtUkmoGWXiIuehUgTKauSgOGuTcfmqc0t9IKTDZmVZwPv4S7
	snRd8A2DHRXA6bcMM4jzSPXtNtf6YWx3eJE90t4NaW4QbqZ3yHLmz4JOO6FmkpL2U/sjDdYLXVrnw
	nLZSq4UQ==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZfF-00000005c4L-00yd
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:51:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1F28AA417AF;
	Fri, 20 Dec 2024 09:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E0AC4CEDE;
	Fri, 20 Dec 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688276;
	bh=XJFN7jjVVW9/+5EGraiq76uL/mtxYXnj+S1et5dI5cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMRiLal955c+l/0CzTPRg5n8THXmAGaf7PKaFWVer/ZePhWmna4Bg7SBrqWkX2pzc
	 n8tre1/0IgyPfY1bn4e+084r4LIDDKNhMFWwEsm9V2AIMjSfOhLqgplPJQaOZ3ja2/
	 QOavKC4DqCQ3xF0AnCa6EUDYtJH4AUbZJfYtzOYR5CDwZsVq4f8k+hSOCND7VohVza
	 I6Rle+5UikBnrKoOX8LefYdEucKopXr6OgHOq1CNB2sDkomMEhDc0sPR/3HDRoMgTl
	 u2n6sR0W9M6d/VjdEiwwKurf58Ph0bKKZCfnuHUd5XaWMj763ulSwq3ztHmSlxUlzG
	 o5rSx4ENZleCA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v7 15/18] nvmet: Implement interrupt config feature support
Date: Fri, 20 Dec 2024 18:51:05 +0900
Message-ID: <20241220095108.601914-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
References: <20241220095108.601914-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_095121_303523_53C53E46 
X-CRM114-Status: GOOD (  17.59  )
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

The NVMe base specifications v2.1 mandate supporting the interrupt
config feature (NVME_FEAT_IRQ_CONFIG) for PCI controllers. Introduce the
data structure struct nvmet_feat_irq_config to define the coalescing
disabled (cd) and interrupt vector (iv) fields of this feature and
implement the functions nvmet_get_feat_irq_config() and
nvmet_set_feat_irq_config() functions to get and set these fields. These
functions respectively use the controller get_feature() and
set_feature() operations to fill and handle the fields of struct
nvmet_feat_irq_config.

Support for this feature is prohibited for fabrics controllers. If a get
feature command or a set feature command for this feature is received
for a fabrics controller, the command is failed with an invalid field
error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 54 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |  5 +++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index eff9fd2e81ed..8b8ec33330b2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1303,6 +1303,27 @@ static u16 nvmet_set_feat_irq_coalesce(struct nvmet_req *req)
 	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_COALESCE, &irqc);
 }
 
+static u16 nvmet_set_feat_irq_config(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	struct nvmet_feat_irq_config irqcfg = {
+		.iv = cdw11 & 0xffff,
+		.cd = (cdw11 >> 16) & 0x1,
+	};
+
+	/*
+	 * This feature is not supported for fabrics controllers and mandatory
+	 * for PCI controllers.
+	 */
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_CONFIG, &irqcfg);
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1329,6 +1350,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_set_feat_irq_coalesce(req);
 		break;
+	case NVME_FEAT_IRQ_CONFIG:
+		status = nvmet_set_feat_irq_config(req);
+		break;
 	case NVME_FEAT_KATO:
 		status = nvmet_set_feat_kato(req);
 		break;
@@ -1397,6 +1421,31 @@ static u16 nvmet_get_feat_irq_coalesce(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
 
+static u16 nvmet_get_feat_irq_config(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 iv = le32_to_cpu(req->cmd->common.cdw11) & 0xffff;
+	struct nvmet_feat_irq_config irqcfg = { .iv = iv };
+	u16 status;
+
+	/*
+	 * This feature is not supported for fabrics controllers and mandatory
+	 * for PCI controllers.
+	 */
+	if (!nvmet_is_pci_ctrl(ctrl)) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	status = ctrl->ops->get_feature(ctrl, NVME_FEAT_IRQ_CONFIG, &irqcfg);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_set_result(req, ((u32)irqcfg.cd << 16) | iv);
+
+	return NVME_SC_SUCCESS;
+}
+
 void nvmet_get_feat_kato(struct nvmet_req *req)
 {
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
@@ -1431,14 +1480,15 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_ERR_RECOVERY:
 		break;
-	case NVME_FEAT_IRQ_CONFIG:
-		break;
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
 #endif
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_get_feat_irq_coalesce(req);
 		break;
+	case NVME_FEAT_IRQ_CONFIG:
+		status = nvmet_get_feat_irq_config(req);
+		break;
 	case NVME_FEAT_ASYNC_EVENT:
 		nvmet_get_feat_async_event(req);
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 555c09b11dbe..999a4ebf597e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -916,4 +916,9 @@ struct nvmet_feat_irq_coalesce {
 	u8		time;
 };
 
+struct nvmet_feat_irq_config {
+	u16		iv;
+	bool		cd;
+};
+
 #endif /* _NVMET_H */
-- 
2.47.1


