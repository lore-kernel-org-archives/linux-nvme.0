Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1C1C47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uZnLlRLZ90/xIjsN+vRhXp/5liPPrf1FaB57k4zH/r4=; b=Jug34i8pIxKjkz21p9H01HzHYa
	YE6ludfOTxU+VNH0iTaWWpGs+Jd/trNl4DNlpWQqxN9NJQaUTR8afdiEkbAnkT9v6mvGqbSOW5A+M
	1jE/iR3xgU6e0LuL6WL+d22YXM110+14n9KdlQSr5PI7rSKi4+E9ANeEjvng0/Rxgh1FMXs540rce
	Q6kMCxWNbgh0tXmIlebKN/9WAtR4IHtoEM2vv0yoQrBhSJ1zFwfVya2/fm/3wDJrqMSjQB6+w+YKJ
	/BeuQ13TzgxbgbAyHPU68Tq0KvtZpQKtGlS4mS9+N5y69d2sqlQuPvD90wOzWBZenA4oy4Ob6r4+D
	16ozSyZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNpZ2-00GJ1i-10;
	Thu, 11 Jan 2024 07:33:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNpYz-00GIzw-1U
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 07:33:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1DA71CE1E51;
	Thu, 11 Jan 2024 07:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176ABC433C7;
	Thu, 11 Jan 2024 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704958394;
	bh=/m+2h2ol9bUdEJakxrXoZbQHQRjp2vaN4sa5xZJ+PmM=;
	h=From:To:Cc:Subject:Date:From;
	b=NdRinl1DBAwR8uBF2r8T1RNcxKjqeJtPLRqUtj4GXUS+FM3l3nQ3vsanmE6nsiB6/
	 gUkYeDfWsr8K+xAG0CKyDnIQn5fYX3ujSa9s8QF2wenLaKWSeQUngX1YtF3ryaOq4O
	 cWoEIzuUIgJR5tIe9kJWAsGPb4Es4HkoG834I8BlttwrkDNdx1OFONld0CL5Q4H/z7
	 S0tF2T5BCKTee8mJ8Kqfc7JTBNGc4uIhTL8zQnD+I/f1Z8f19Mn4eg2B8hYA6HwuND
	 9bQoEsT/KPySmz1sFPRTUvJmCfPfkJ0FpOWO7TRQ2vcSMss6MOgRoELdqX+SNRjrVo
	 lKFfS4m8fkP6g==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-rdma: Do not terminate commands when in RESETTING
Date: Thu, 11 Jan 2024 08:33:09 +0100
Message-Id: <20240111073309.46644-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_233317_673980_4B739F15 
X-CRM114-Status: GOOD (  12.32  )
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

From: Hannes Reinecke <hare@suse.de>

Terminating commands from the timeout handler might lead
to a data corruption as the timeout might trigger before
KATO expired.
This is the case when several commands have been started
before the keep-alive command and the command timeouts
trigger just after the keep-alive command has been sent.
Then the first command will trigger an error recovery,
but all the other commands will be aborted directly
and immediately retried.
So return BLK_EH_RESET_TIMER for I/O commands when
error recovery has been started to ensure that the
commands will be retried only after the KATO interval.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2e77c0f25f71..b45522b130e2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1950,6 +1950,18 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 		 rq->tag, nvme_cid(rq), opcode,
 		 nvme_opcode_str(qid, opcode, fctype), qid);
 
+	/*
+	 * If the error recovery is started we should ignore all
+	 * I/O commands as they'll be aborted once error recovery starts.
+	 * Otherwise they'll be failed over immediately and might
+	 * cause data corruption.
+	 */
+	if (ctrl->ctrl.state == NVME_CTRL_RESETTING && qid > 0) {
+		/* Avoid interfering with firmware download */
+		if (!WARN_ON(work_pending(&ctrl->ctrl.fw_act_work)))
+			return BLK_EH_RESET_TIMER;
+	}
+
 	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
-- 
2.35.3


