Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E162FC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgM/wLYMFF7uyLiYvGLj/vvs8vigdc0PjAm1zVdrdFY=; b=G06CnZ1g+ugIYmpUKeciK44BlB
	NISmJKuZcblcocfrwAku/o4tQLb0QNhvYcK+kjnamp8gtau8uLLC0fuaSFauLmyGWGbZCYQaAfC+X
	5L+zFoguW/t7x2klgOuMU9eqvI4WbJiJ5sqyzSK/VvWknlhuAH7nfwwWAr9A5rQMJAYCCYrlHOgfJ
	W5ZJYEC8PtOQcOFW1+MxgmnWY/97Xv2GOpjIliAZ/S9JYrAcS9Ny8lAzwAWIH7id6fHj9QkwcN1vB
	u4YH2URbQUr4Z1KPnSOaL3LY7C7ntQ0yjglAYdxRRy0U1b6yixAq6E6yOhfYSAft10zZ1RQwDyIpg
	ywGnWw0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cL3-004iGq-1k; Fri, 23 Dec 2022 07:19:29 +0000
Received: from [2001:4bb8:199:7829:8d88:c8b3:6416:2f03] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cK8-004hp6-Hq; Fri, 23 Dec 2022 07:18:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6/6] nvme: consult the CSE log page for unprivileged passthrough
Date: Fri, 23 Dec 2022 08:18:14 +0100
Message-Id: <20221223071814.43564-7-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223071814.43564-1-hch@lst.de>
References: <20221223071814.43564-1-hch@lst.de>
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

Commands like Write Zeros can change the contents of a namespaces without
actually transferring data.  To protect against this, check the Commands
Supported and Effects log is supported by the controller for any
unprivileg command passthrough and refuse unprivileged passthrough if the
command has any effects that can change data or metadata.

Note: While the Commands Support and Effects log page has only been
mandatory since NVMe 2.0, it is widely supported because Windows requires
it for any command passthrough from userspace.

Fixes: e4fbcf32c860 ("nvme: identify-namespace without CAP_SYS_ADMIN")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 28 ++++++++++++++++++++++++----
 include/linux/nvme.h      |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9ddda571f0461f..a8639919237e6a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -11,6 +11,8 @@
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 		fmode_t mode)
 {
+	u32 effects;
+
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 
@@ -43,11 +45,29 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	}
 
 	/*
-	 * Only allow I/O commands that transfer data to the controller if the
-	 * special file is open for writing, but always allow I/O commands that
-	 * transfer data from the controller.
+	 * Check if the controller provides a Commands Supported and Effects log
+	 * and marks this command as supported.  If not reject unprivileged
+	 * passthrough.
+	 */
+	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
+	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
+		return false;
+
+	/*
+	 * Don't allow passthrough for command that have intrusive (or unknown)
+	 * effects.
+	 */
+	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			NVME_CMD_EFFECTS_UUID_SEL |
+			NVME_CMD_EFFECTS_SCOPE_MASK))
+		return false;
+
+	/*
+	 * Only allow I/O commands that transfer data to the controller or that
+	 * change the logical block contents if the file descriptor is open for
+	 * writing.
 	 */
-	if (nvme_is_write(c))
+	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
 		return mode & FMODE_WRITE;
 	return true;
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d1cd53f2b6abd9..4fad4aa245fb06 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -642,6 +642,7 @@ enum {
 	NVME_CMD_EFFECTS_CCC		= 1 << 4,
 	NVME_CMD_EFFECTS_CSE_MASK	= GENMASK(18, 16),
 	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
+	NVME_CMD_EFFECTS_SCOPE_MASK	= GENMASK(31, 20),
 };
 
 struct nvme_effects_log {
-- 
2.35.1


