Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE31C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFS1vk1v8NtuWIRVuBhDSkJVVxbYnxii6nA7IyiGfgk=; b=H0M/mdwM1wbMhk8hITobOB1MHi
	UjqnhltLhrJXfV19e/UP0fMaJkLtfFW2Aee/Fv9NtsC2Ax0qTOjulwqM0L7FFCwGhXg+jb2Tz23DJ
	WPyZyS1WJL02EKX2kb9Mt1gV4OU0KFYhlL80AomemPhROfnk4hwhop3sYPaZTSUCNLvC2eX/pgw7s
	J7vpI0lLkT3XZ5WR0QdszzTGmDLID7AdlgED5cbWfPHnh/7A2N5Y3XCC4wJZJDO2COtkdfv/8sDaR
	onPGpvqNG//oRNcU+8Dv4x8Bg3oeQul9DiW/FEpFn7FU5mg4kgHm2dsbe9E5YZoHnux3sju8xdNRF
	d7glfwdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2U-003dm3-H6; Wed, 16 Nov 2022 13:01:14 +0000
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2R-003dl9-UM; Wed, 16 Nov 2022 13:01:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvme: return an errno from nvme_cmd_allowed
Date: Wed, 16 Nov 2022 14:01:01 +0100
Message-Id: <20221116130104.2186334-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116130104.2186334-1-hch@lst.de>
References: <20221116130104.2186334-1-hch@lst.de>
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

Return an errno value instead of bool from nvme_cmd_allowed to prepare
it for returning different kinds of errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9550a69029b36..9a2f0f5ccef57 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -8,11 +8,11 @@
 #include <linux/io_uring.h>
 #include "nvme.h"
 
-static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
+static int nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 		fmode_t mode)
 {
 	if (capable(CAP_SYS_ADMIN))
-		return true;
+		return 0;
 
 	/*
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
@@ -20,7 +20,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	if (c->common.opcode >= nvme_cmd_vendor_start ||
 	    c->common.opcode == nvme_fabrics_command)
-		return false;
+		return -EACCES;
 
 	/*
 	 * Do not allow unprivileged passthrough of admin commands except
@@ -34,10 +34,10 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 			case NVME_ID_CNS_NS:
 			case NVME_ID_CNS_CS_NS:
 			case NVME_ID_CNS_NS_CS_INDEP:
-				return true;
+				return 0;
 			}
 		}
-		return false;
+		return -EACCES;
 	}
 
 	/*
@@ -45,9 +45,9 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * special file is open for writing, but always allow I/O commands that
 	 * transfer data from the controller.
 	 */
-	if (nvme_is_write(c))
-		return mode & FMODE_WRITE;
-	return true;
+	if (nvme_is_write(c) && !(mode & FMODE_WRITE))
+		return -EACCES;
+	return 0;
 }
 
 /*
@@ -331,8 +331,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, mode))
-		return -EACCES;
+	status = nvme_cmd_allowed(ns, &c, mode);
+	if (status)
+		return status;
 
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
@@ -379,8 +380,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, mode))
-		return -EACCES;
+	status = nvme_cmd_allowed(ns, &c, mode);
+	if (status)
+		return status;
 
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
@@ -549,8 +551,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
-	if (!nvme_cmd_allowed(ns, &c, ioucmd->file->f_mode))
-		return -EACCES;
+	ret = nvme_cmd_allowed(ns, &c, ioucmd->file->f_mode);
+	if (ret)
+		return ret;
 
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
-- 
2.30.2


