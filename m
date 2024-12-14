Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34341E7716A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 06:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNTKmQWb3+2C+ICf/ZECLs+ocQeJWt+NxoPR+4oBmcQ=; b=B61TaLgeGO3fyIXJR0oxq5cihc
	5zy+98Z2+O2aPIYkitfcrjcAoP5HDVK/rix/FiMP6xPKqY6TRH55sDTAYUnjCXIpp4qayG5ujEpME
	92qfgDovn3QsP3PeYYZttNar2/b8+0kz0DKJe4/Ns5q/QbtedUpKzz0vC2O/kmWcZrLwPCnBbFGKN
	IHJ2yPCTBacgjEf793RMZ17JMqWt94u6UYcuafpGPjq7zxZtkDlo7ps7FvEpqDT6bDvlPF/cA0Sh7
	2332uQD49F5xKpmy6ZFDeksBH/vf5V6WjfyJz71ykF60ryixyjFqPf/Rat852yGCGjhRKDeJghqTO
	R7PK0Cew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLJj-00000005nPU-0m6J;
	Sat, 14 Dec 2024 06:07:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMLJc-00000005nGy-3TcM
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 06:07:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF9975C0490;
	Sat, 14 Dec 2024 06:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E36C4CED1;
	Sat, 14 Dec 2024 06:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156467;
	bh=8lXi6vt39kj6wKiHNXwC0kpLAdjFl/FOHh358U2v3Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHk7VVHsJX9JnUfSeAHKM6AjPrhZnUtDrAQA5Rrzw9lYuIPl+fwO5feIYdsu7skSk
	 dq2F1sgxG9UXcSB8sJqLv+d62DyyaBOKKNUoRgFfq1rTkwLp592Hij+Raib2OO0g28
	 nlTM4Zxj9DzDHGHHX+AQ6tsnJLrBM81eTtWu4K+T6WQvv9SsmfMjbp8PtFT4VzTDmA
	 1fx+2rOx7TNIq8C5MTVMk1IIVLp1c7s8z4ZtISsIQE99krlLeNa9Ro6lJyJDGKv/+W
	 theI9OrCpv+srQfygQ3r52WbUrT/G5AI9qWOuehfd8AMNTYXxvqQbTAZSQaa3HAhpe
	 IrXCrJV+xnj9A==
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
Subject: [PATCH v5 14/18] nvmet: Implement interrupt coalescing feature support
Date: Sat, 14 Dec 2024 15:06:51 +0900
Message-ID: <20241214060655.166325-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_220748_972755_013E9E10 
X-CRM114-Status: GOOD (  18.58  )
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

The NVMe base specifications v2.1 mandate Supporting the interrupt
coalescing feature (NVME_FEAT_IRQ_COALESCE) for PCI controllers.
Introduce the data structure struct nvmet_feat_irq_coalesce to define
the time and threshold (thr) fields of this feature and implement the
functions nvmet_get_feat_irq_coalesce() and
nvmet_set_feat_irq_coalesce() to get and set this feature. These
functions respectively use the controller get_feature() and
set_feature() operations to fill and handle the fields of struct
nvmet_feat_irq_coalesce.

While the Linux kernel nvme driver does not use this feature and thus
will not complain if it is not implemented, other major OSes fail
initializing the NVMe device if this feature support is missing.

Support for this feature is prohibited for fabrics controllers. If a get
feature or set feature command for this feature is received for a
fabrics controller, the command is failed with an invalid field error.

Suggested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 53 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     | 10 +++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index efef3acba9fb..eff9fd2e81ed 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1282,6 +1282,27 @@ static u16 nvmet_set_feat_host_id(struct nvmet_req *req)
 				   sizeof(req->sq->ctrl->hostid));
 }
 
+static u16 nvmet_set_feat_irq_coalesce(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	struct nvmet_feat_irq_coalesce irqc = {
+		.time = (cdw11 >> 8) & 0xff,
+		.thr = cdw11 & 0xff,
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
+	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_COALESCE, &irqc);
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1305,6 +1326,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		nvmet_set_result(req,
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
 		break;
+	case NVME_FEAT_IRQ_COALESCE:
+		status = nvmet_set_feat_irq_coalesce(req);
+		break;
 	case NVME_FEAT_KATO:
 		status = nvmet_set_feat_kato(req);
 		break;
@@ -1349,6 +1373,30 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	return 0;
 }
 
+static u16 nvmet_get_feat_irq_coalesce(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_feat_irq_coalesce irqc = { };
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
+	status = ctrl->ops->get_feature(ctrl, NVME_FEAT_IRQ_COALESCE, &irqc);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_set_result(req, ((u32)irqc.time << 8) | (u32)irqc.thr);
+
+	return NVME_SC_SUCCESS;
+}
+
 void nvmet_get_feat_kato(struct nvmet_req *req)
 {
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
@@ -1383,13 +1431,14 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_ERR_RECOVERY:
 		break;
-	case NVME_FEAT_IRQ_COALESCE:
-		break;
 	case NVME_FEAT_IRQ_CONFIG:
 		break;
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
 #endif
+	case NVME_FEAT_IRQ_COALESCE:
+		status = nvmet_get_feat_irq_coalesce(req);
+		break;
 	case NVME_FEAT_ASYNC_EVENT:
 		nvmet_get_feat_async_event(req);
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8325de3382ee..555c09b11dbe 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -906,4 +906,14 @@ static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
 {
 	percpu_ref_put(&pc_ref->ref);
 }
+
+/*
+ * Data for the get_feature() and set_feature() operations of PCI target
+ * controllers.
+ */
+struct nvmet_feat_irq_coalesce {
+	u8		thr;
+	u8		time;
+};
+
 #endif /* _NVMET_H */
-- 
2.47.1


