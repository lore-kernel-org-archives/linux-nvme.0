Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E350C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qXa+nHsF4ib8pqm3+C6isbrNyq3S/iGUXTiYLDTa2Vw=; b=HOHo5WhsoyshssxooyimKrl4Io
	BFw78d8eAytvDiWyQ4o+Sd2YaqH85L0n4qBtXSbpYvZbgpOzuV8oFzVDopVypC4868mgJZuXARlJl
	fvpVM5WyNpPRHObcWcUfs+8fsjn51EKb26wfThswb2UZT0BLWw35kU7kL4WQey1Fyz1zcMXTru1Za
	n1SfYZT1cFQ+iu6KgKVtY/tXN2iyOLawCFnwn3BonrwsmI2VzGoJ/cd4YhckHtXhNSNzXqYGLZYaa
	nfHKwOEz75I1TKA63VT5Se+ybaJ3hQ+AsCv9Qlup0NSRw5lNBDjUNcGFeVR8NOnRKQvKG/DXL7vGG
	ov4WcG5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585h-002oiQ-4S; Tue, 13 Dec 2022 16:25:13 +0000
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585Y-002odj-1n; Tue, 13 Dec 2022 16:25:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/7] nvmet: allow async passthrough of commands that change logical block contents
Date: Tue, 13 Dec 2022 17:24:49 +0100
Message-Id: <20221213162453.584965-4-hch@lst.de>
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

Mask out the logical block change effect to allow to keep supporting
passthrough for Write commands once I/O Command effects are properly
propagated.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/passthru.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 79af5140af8bfe..ad80ba61c42236 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -295,7 +295,6 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	struct nvme_ns *ns = NULL;
 	struct request *rq = NULL;
 	unsigned int timeout;
-	u32 effects;
 	u16 status;
 	int ret;
 
@@ -334,14 +333,16 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	}
 
 	/*
-	 * If there are effects for the command we are about to execute, or
-	 * an end_req function we need to use nvme_execute_passthru_rq()
-	 * synchronously in a work item seeing the end_req function and
-	 * nvme_passthru_end() can't be called in the request done callback
-	 * which is typically in interrupt context.
+	 * If there are any non-trivial effects for the command we are about to
+	 * execute, call nvme_execute_passthru_rq in a workqueue, so that the
+	 * effects can be properly handled by the calls to nvme_passthru_start
+	 * and nvme_passthru_end.
 	 */
-	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
-	if (req->p.use_workqueue || effects) {
+	if (nvme_command_effects(ctrl, ns, req->cmd->common.opcode) &
+	    ~NVME_CMD_EFFECTS_LBCC)
+		req->p.use_workqueue = true;
+
+	if (req->p.use_workqueue) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
 		req->p.rq = rq;
 		queue_work(nvmet_wq, &req->p.work);
-- 
2.35.1


