Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD13BE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 03:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FDYrtCEzTJ8GnSD/gF/wbwe6Bk7w7QnuEPGOeh1xPw=; b=YLiTF+mc2ibYQ4LmsPovKdw+y/
	MFE1I9bEblxDlL3RCfVDiSLBBbeZvv7LJa3K/SQxyTlmDZK6UlGzrBMkQ6wb9/tjKAzP762KqQ6n/
	/o+is/y7aUOowTCHGgHJkGgQy7IWBh2cMngZvbkcrzYfYYuvfT9Qq77iHxAeSuwt6N0nDsgqg6Bgf
	2HhfBVrIhMMrY3CZSUGNfq0w7C63JdnvLRlNQWWZVtuM0f9w/TCrlm4ivOaKseV0WanV6YiXtDJY1
	T5LcfV/n4ErF7wDZEci2A4QC4f1ax5hbU6KhtqVXn3u/ReNJ2CUYTWCPl31xyfXoRQDbrEU4Il+xK
	r2ZGcnjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU6K-00000003qRR-47wi;
	Fri, 20 Dec 2024 03:54:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU6H-00000003qL9-1Wkv
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 03:54:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D4CA85C6AD0;
	Fri, 20 Dec 2024 03:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C8C4CEDE;
	Fri, 20 Dec 2024 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666892;
	bh=g/QDBHQyttOxZZtzqO75xNJmVtK8xvqODSyt8y5XPq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+huBBrJKghfO0cgTMfKVlIuJxuk82cVAqIAw5K+c01qzAjtTRXyFQt5K5mUyBSZa
	 ahP8IjnoBRByUFfZ+ymJGyodgYzXyE8sB+p8XVB9we8ccMoeiDrh/fQWixjMG/h06/
	 yaiUjOLMRhFqCLOF6Q51b+5D5LIontwvecB4piu8CbyXiqkigxyvsbJY/w0HjOzwfL
	 i6twVQkCvvxny3CplOQRMhKcZI+kotdShkdR/tW6jtnzBFSEw+hxwqa/goCTsmQZtv
	 oyY8rDetAtO+cU75fLFa/awF45DJHP9LwKIpG9ia6SlzjvB9X/dmIFWE6sFoLik3zY
	 6xEycxb+iL4aA==
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
Subject: [PATCH v6 16/18] nvmet: Implement arbitration feature support
Date: Fri, 20 Dec 2024 12:54:39 +0900
Message-ID: <20241220035441.600193-17-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_195453_586194_C9445B55 
X-CRM114-Status: GOOD (  17.88  )
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

NVMe base specification v2.1 mandates support for the arbitration
feature (NVME_FEAT_ARBITRATION). Introduce the data structure
struct nvmet_feat_arbitration to define the high, medium and low
priority weight fields and the arbitration burst field of this feature
and implement the functions nvmet_get_feat_arbitration() and
nvmet_set_feat_arbitration() functions to get and set these fields.

Since there is no generic way to implement support for the arbitration
feature, these functions respectively use the controller get_feature()
and set_feature() operations to process the feature with the help of
the controller driver. If the controller driver does not implement these
operations and a get feature command or a set feature command for this
feature is received, the command is failed with an invalid field error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 51 +++++++++++++++++++++++++++++++--
 drivers/nvme/target/nvmet.h     |  7 +++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8b8ec33330b2..3ddd8e44e148 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1324,6 +1324,25 @@ static u16 nvmet_set_feat_irq_config(struct nvmet_req *req)
 	return ctrl->ops->set_feature(ctrl, NVME_FEAT_IRQ_CONFIG, &irqcfg);
 }
 
+static u16 nvmet_set_feat_arbitration(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	struct nvmet_feat_arbitration arb = {
+		.hpw = (cdw11 >> 24) & 0xff,
+		.mpw = (cdw11 >> 16) & 0xff,
+		.lpw = (cdw11 >> 8) & 0xff,
+		.ab = cdw11 & 0x3,
+	};
+
+	if (!ctrl->ops->set_feature) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return ctrl->ops->set_feature(ctrl, NVME_FEAT_ARBITRATION, &arb);
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1337,6 +1356,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		return;
 
 	switch (cdw10 & 0xff) {
+	case NVME_FEAT_ARBITRATION:
+		status = nvmet_set_feat_arbitration(req);
+		break;
 	case NVME_FEAT_NUM_QUEUES:
 		ncqr = (cdw11 >> 16) & 0xffff;
 		nsqr = cdw11 & 0xffff;
@@ -1446,6 +1468,30 @@ static u16 nvmet_get_feat_irq_config(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
 
+static u16 nvmet_get_feat_arbitration(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_feat_arbitration arb = { };
+	u16 status;
+
+	if (!ctrl->ops->get_feature) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw10);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	status = ctrl->ops->get_feature(ctrl, NVME_FEAT_ARBITRATION, &arb);
+	if (status != NVME_SC_SUCCESS)
+		return status;
+
+	nvmet_set_result(req,
+			 ((u32)arb.hpw << 24) |
+			 ((u32)arb.mpw << 16) |
+			 ((u32)arb.lpw << 8) |
+			 (arb.ab & 0x3));
+
+	return NVME_SC_SUCCESS;
+}
+
 void nvmet_get_feat_kato(struct nvmet_req *req)
 {
 	nvmet_set_result(req, req->sq->ctrl->kato * 1000);
@@ -1472,8 +1518,6 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	 * need to come up with some fake values for these.
 	 */
 #if 0
-	case NVME_FEAT_ARBITRATION:
-		break;
 	case NVME_FEAT_POWER_MGMT:
 		break;
 	case NVME_FEAT_TEMP_THRESH:
@@ -1483,6 +1527,9 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
 #endif
+	case NVME_FEAT_ARBITRATION:
+		status = nvmet_get_feat_arbitration(req);
+		break;
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_get_feat_irq_coalesce(req);
 		break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 999a4ebf597e..f4df458df9db 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -921,4 +921,11 @@ struct nvmet_feat_irq_config {
 	bool		cd;
 };
 
+struct nvmet_feat_arbitration {
+	u8		hpw;
+	u8		mpw;
+	u8		lpw;
+	u8		ab;
+};
+
 #endif /* _NVMET_H */
-- 
2.47.1


