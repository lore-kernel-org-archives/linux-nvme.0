Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8913EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9YB95mEx8VBgc30JJGPXBU7Qb2DuhrC8yRjF6VF0IU=; b=jijVBrSfHb+DItUQ4hv4GeouaR
	cZYjdDtQW/zzKhVLgXGjCIPL7/ie1hD+UhZ7sssoHUjJJ05cXAzSgXSiU/D3TCQtmnnmnHPlwb3OH
	pPobDb/TE+/i/TfingEjpte6HJ823Vkdb+7M/a83eM0K+mTRe3W3oAFN8v9b5v/4stzMmPwV3cwgo
	v5uFi4x6bRGsXf81e7/4j26PhAMcS8pYeP0tX7dsYb53ufpdkoE1PyYUxYWfUOlSxlYsEwxmlglfe
	8+c04fVQ6lnC0u6UJeTujTHoMTlPGBjAEJNJkAkW6mHGMd/o7e+hKB6923df22EtqjG+PelPVUarB
	S43TQ2Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p80Kd-00Fj43-Vg; Wed, 21 Dec 2022 14:44:32 +0000
Received: from [2001:4bb8:199:7829:6251:5281:de26:c6d1] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7w42-00DEMg-Mr; Wed, 21 Dec 2022 10:11:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/6] nvmet: don't defer passthrough commands with trivial effects to the workqueue
Date: Wed, 21 Dec 2022 11:10:48 +0100
Message-Id: <20221221101050.759606-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221101050.759606-1-hch@lst.de>
References: <20221221101050.759606-1-hch@lst.de>
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

Mask out the "Command Supported" and "Logical Block Content Change" bits
and only defer execution of commands that have non-trivial effects to
the workqueue for synchronous execution.  This allows to execture admin
commands asynchronously on controllers that provide a Command Supported
and Effects log page, and will keep allowing to execute Write commands
asynchronously once command effects on I/O commands are taken into
account.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/passthru.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 79af5140af8bfe..adc0958755d66f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -334,14 +334,13 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	}
 
 	/*
-	 * If there are effects for the command we are about to execute, or
-	 * an end_req function we need to use nvme_execute_passthru_rq()
-	 * synchronously in a work item seeing the end_req function and
-	 * nvme_passthru_end() can't be called in the request done callback
-	 * which is typically in interrupt context.
+	 * If a command needs post-execution fixups, or there are any
+	 * non-trivial effects, make sure to execute the command synchronously
+	 * in a workqueue so that nvme_passthru_end gets called.
 	 */
 	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
-	if (req->p.use_workqueue || effects) {
+	if (req->p.use_workqueue ||
+	    (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
 		req->p.rq = rq;
 		queue_work(nvmet_wq, &req->p.work);
-- 
2.35.1


