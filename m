Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35286E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 05:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0B4AcewyHLe5lbzTdd298RHiUIWYc/wtUkYlBOgfrs=; b=Ab2/UYHjQ4kKcHXgHwjGB8C5hE
	CK+8wrQ4NqAGM06yyStF0IftCZ+CTLxc7Dxx2xNiTtcWDZoeJ+ugbPugi09fmoCuZfh/iPN0pghe4
	AEzyVo9ey7F00je3lCVT7TGhwbjHyDK+YY2nb8lZwb85Yptq/koOuvpxuUYFV6dHKBT2s25W4zrqe
	ly1k9Fr6BXl6rDqZJONvwpbWCzw8fY+Z9lmX4VlWLIqv+UCI88u/Dy95eyg9lQN7Tv3bi2ZWobOAZ
	SZAlVsPI6lmmMYVAe3YXh6yqbT5ySvpb8v9wBBMYYz4d8hl5EnKLYVf2MxkAWy7pUX/1UaH9OJvxq
	PpWxdsVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTwHN-0000000EU8V-36WZ;
	Sat, 04 Jan 2025 05:00:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTwHK-0000000EU0W-1fWd
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 05:00:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8CB6A5C2722;
	Sat,  4 Jan 2025 05:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EC8C4AF0D;
	Sat,  4 Jan 2025 05:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966849;
	bh=vahkHyrrQ+7Ktj725yqX7FxiPXaU1HEhPEgDjbif0Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyKI2Z2z2a/i+Rba3PFtIJoCCYJ7RZ+24KK4Z9NqiwMHyIZmcqVyePsJM//TGLf/Q
	 KmYjJY+EmeB8s9suZwQV9f0LvTPVvgF1dQ4kgPKU6YktbR3TgA1ITaG+JVkiZ11FrG
	 ap7gmzGOsnAikYlrZF8Kaq0iDoeC/aHwnoRMrYc8qNN7e4SrqYcVzpyR5FTF7hvLLj
	 2qMf9rpapzC0QFY/SLdJPEuhhklyohADC5US6FT/6J8IuodAfn0UhwPnTfQfAop9VQ
	 3pslO+Hd28F1toaAGihxja3HedvnaePm8+P9oX/PajI8z93rSLvuAUrRaUhEC+zMiJ
	 LAHegkX6R7atg==
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
Subject: [PATCH v9 13/18] nvmet: Implement host identifier set feature support
Date: Sat,  4 Jan 2025 13:59:46 +0900
Message-ID: <20250104045951.157830-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
References: <20250104045951.157830-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_210050_559177_9EACEF9A 
X-CRM114-Status: GOOD (  18.91  )
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

The NVMe specifications mandate support for the host identifier
set_features for controllers that also supports reservations. Satisfy
this requirement by implementing handling of the NVME_FEAT_HOST_ID
feature for the nvme_set_features command. This implementation is for
now effective only for PCI target controllers. For other controller
types, the set features command is failed with a NVME_SC_CMD_SEQ_ERROR
status as before.

As noted in the code, 128 bits host identifiers are supported since the
NVMe base specifications version 2.1 indicate in section 5.1.25.1.28.1
that "The controller may support a 64-bit Host Identifier...".

The RHII (Reservations and Host Identifier Interaction) bit of the
controller attribute (ctratt) field of the identify controller data is
also set to indicate that a host ID of "0" is supported but that the
host ID must be a non-zero value to use reservations.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/admin-cmd.c | 35 +++++++++++++++++++++++++++++----
 include/linux/nvme.h            |  1 +
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0c5127a1d191..efef3acba9fb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -659,7 +659,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys *subsys = ctrl->subsys;
 	struct nvme_id_ctrl *id;
-	u32 cmd_capsule_size;
+	u32 cmd_capsule_size, ctratt;
 	u16 status = 0;
 
 	if (!subsys->subsys_discovered) {
@@ -707,8 +707,10 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT |
-		NVME_CTRL_ATTR_TBKAS);
+	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
+	if (nvmet_is_pci_ctrl(ctrl))
+		ctratt |= NVME_CTRL_ATTR_RHII;
+	id->ctratt = cpu_to_le32(ctratt);
 
 	id->oacs = 0;
 
@@ -1255,6 +1257,31 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 	return 0;
 }
 
+static u16 nvmet_set_feat_host_id(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+
+	if (!nvmet_is_pci_ctrl(ctrl))
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
+
+	/*
+	 * The NVMe base specifications v2.1 recommends supporting 128-bits host
+	 * IDs (section 5.1.25.1.28.1). However, that same section also says
+	 * that "The controller may support a 64-bit Host Identifier and/or an
+	 * extended 128-bit Host Identifier". So simplify this support and do
+	 * not support 64-bits host IDs to avoid needing to check that all
+	 * controllers associated with the same subsystem all use the same host
+	 * ID size.
+	 */
+	if (!(req->cmd->common.cdw11 & cpu_to_le32(1 << 0))) {
+		req->error_loc = offsetof(struct nvme_common_command, cdw11);
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	}
+
+	return nvmet_copy_from_sgl(req, 0, &req->sq->ctrl->hostid,
+				   sizeof(req->sq->ctrl->hostid));
+}
+
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
@@ -1285,7 +1312,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		status = nvmet_set_feat_async_event(req, NVMET_AEN_CFG_ALL);
 		break;
 	case NVME_FEAT_HOST_ID:
-		status = NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
+		status = nvmet_set_feat_host_id(req);
 		break;
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_set_feat_write_protect(req);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 42fc00dc494e..fe3b60818fdc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -276,6 +276,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_RHII		= (1 << 18),
 };
 
 struct nvme_id_ctrl {
-- 
2.47.1


