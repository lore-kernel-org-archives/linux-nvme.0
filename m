Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1255EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjvnRk0279Ufwv1hmYJwX0c9p8kU2ItlBx94Iee+tH0=; b=DW99QaF8EZa0HNJ1PE7l5pNd/V
	bdoOon0olL6dXVyOUwfH2jaAwqsIe8rK1O0J7nhCUL6ytwQnEUrU5ssaOlAyNA0tIq9sTpT5MlbHG
	8ySKMtQr/askS3A58+e1T7v9UK6S/rfqc15WQ2XfyKQPMi5tXyqlxdVMRpRmzOHUyvUufgSidJFd+
	E/9aodCzmMvIoxX7S1CnnS/F58kwu8GFozMzOFF6leA9s9ASSpWhzc08tvHR8hMvq6i7h7h/CQOml
	Cb8REaeudRWN+PC2ve+bBzIT63PEus2JXLGdnnGRQ+Ltzmt3cv/rsU04CcOWYOEtj7puQtQzQO26T
	+RzWq9Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5863-002ovq-L5; Tue, 13 Dec 2022 16:25:35 +0000
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585i-002oiY-Rd; Tue, 13 Dec 2022 16:25:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 7/7] nvme: don't allow unprivileged passthrough of commands that have effects
Date: Tue, 13 Dec 2022 17:24:53 +0100
Message-Id: <20221213162453.584965-8-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213162453.584965-1-hch@lst.de>
References: <20221213162453.584965-1-hch@lst.de>
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
actually transferring data.  To protect against this check the Commands
Supported and Effects log and refuse unprivileged passthrough if the
command has any effects.  This also includes more intrusive effects which
currently can't happen for I/O commands.

Fixes: e4fbcf32c860 ("nvme: identify-namespace without CAP_SYS_ADMIN")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 2ed8fdd09bb35a..e71d136816eae0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -11,6 +11,8 @@
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 		fmode_t mode)
 {
+	u8 opcode = c->common.opcode;
+
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 
@@ -18,8 +20,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
 	 * commands as we can't be sure about their effects.
 	 */
-	if (c->common.opcode >= nvme_cmd_vendor_start ||
-	    c->common.opcode == nvme_fabrics_command)
+	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
 		return false;
 
 	/*
@@ -29,7 +30,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * potentially sensitive information.
 	 */
 	if (!ns) {
-		if (c->common.opcode == nvme_admin_identify) {
+		if (opcode == nvme_admin_identify) {
 			switch (c->identify.cns) {
 			case NVME_ID_CNS_NS:
 			case NVME_ID_CNS_CS_NS:
@@ -43,11 +44,11 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	}
 
 	/*
-	 * Only allow I/O commands that transfer data to the controller if the
-	 * special file is open for writing, but always allow I/O commands that
-	 * transfer data from the controller.
+	 * Only allow I/O commands that transfer data to the controller, change
+	 * the logical block content or have any other intrusive effects if the
+	 * special file is open for writing. 
 	 */
-	if (nvme_is_write(c))
+	if (nvme_is_write(c) || nvme_command_effects(ns->ctrl, ns, opcode))
 		return mode & FMODE_WRITE;
 	return true;
 }
-- 
2.35.1


