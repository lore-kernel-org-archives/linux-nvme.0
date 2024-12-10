Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553CDE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GE7yvKXwmwlHIMlF7PsXTMz+r1LSRLw5syeK3+A8IWI=; b=gLL7zRnrhPA4DV/b/e4bGeqPe8
	DzSyoEg4R6S4aY2IX/HSocXVOSpdvyIM7XgH0Zpo5+b/KsuvOi0QHgfre1FS4ZMev/Efy+I1MfjAy
	upBsu4oIyNZSZJ11qhFKIfNECrbVcDm45mPKAn7ZVlAK5G7GWdv+euMndpSGJhzLPfr44DBT3OpIG
	iGpL+uL3RrzYKu3gjGzzXcSk7EVMc8EHs751RrBxKGVdsxoaI0xYobvk/+Jr+xf1xRJ8GlEz29ZsJ
	EwIOt4g6rkPe1aHlQmqN1DsVteohns2iQca3wWRjlQOlx5TvSJbShpzg9S4JJ4DpZHUFGJlq6n2ac
	NWuJaXeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwgz-0000000Avxz-1dAD;
	Tue, 10 Dec 2024 09:38:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwe5-0000000AuXo-0jHa
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 09:35:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 309A55C4A41;
	Tue, 10 Dec 2024 09:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81088C4CEE0;
	Tue, 10 Dec 2024 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823308;
	bh=+X/wsRvpYMVsVg/DvYoWjCPmiVKTIhH2lSR7TbP6uFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpjo+xwAMfNlwoaAsDDi/PPROGYonpcPAyssqvdFbZlY14I+Uxkq3zpqj52EXT6j3
	 /pPY8LcHSIfQRtBt4gxFTudf+3r6amWUf3x2uHFzz8yW4zAETXjZ0oPcMtX9ALxXn/
	 uiqzt1UYkkCaK/wviApuTEISRjPp/u3UGvZt34mj8I9fRXzW3Ppe/NQRLth1zIEG+S
	 sLXAhTKRY4Ph7g6hjEgAsQpgut1jEKWUZVglHe4NYNp2EYa1HHJIqj9P698NR7n/S0
	 V++YNTg+I8Fn8hPsrXXiW8fh4MjTNBxElZP1IvEQFg5J2IArecHU7hFPtlQyNQSs85
	 PryVhGbhJqoUg==
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
Subject: [PATCH v3 14/17] nvmet: Implement interrupt config feature support
Date: Tue, 10 Dec 2024 18:34:05 +0900
Message-ID: <20241210093408.105867-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_013509_294833_1140A95B 
X-CRM114-Status: GOOD (  17.40  )
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


