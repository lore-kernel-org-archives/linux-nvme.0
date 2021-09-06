Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE6C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 01:30:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3913860FE6
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 01:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3913860FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yBa/cIaCxR8HEEAdWo+OytQv0Qo6vY6gL2Fl9rFERE0=; b=UePK8a1HL2g/7c
	mssWYPxorU/BujtJrFGYHBxJBu5fTisfdZrt8x27kF3zj3RZKHrSFY5cF2AXL71x3ZP1/x/RCMrnc
	RMKRksy2usRyZ8jDELAab86yR1atvvFjkNYRZkVrfdw1L2L3BX8vrclK2lCqpF/F3t6LDMJ1UaAH3
	6w3gP3KDedfIeKk4CwRP2ZHBNITfBbAJYMpEMN7Sy2J0TpK6V6JWUmwObI4O/TVRwiIjJD2JfYd5M
	+sfaVIcJZ8ReOGDlTH0Em7q2QCFhtmvFRuvWDP88Fm2SrKzI5ddaVXHLorVS1jPkTIV9YS43Mz6SI
	Z0bD5d7e8bPIU9QmpuNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN3S7-00Gwwl-R0; Mon, 06 Sep 2021 01:29:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN3Lm-00Gudk-IV
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 01:23:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9266461103;
 Mon,  6 Sep 2021 01:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630891386;
 bh=LCusNe/AMO3RUFyj6lq33r72Gup2BEzvmGh1RFSV8nM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OrQafpGw86Y5KFab4R0uOWMsaN6S2FiRhMKXFrJiYkMPhP0CH50bPokbhE4S6RESg
 nmWXmFVOK9vGg/ES69Xp31JzoqPwHdpVP1C/IUuU3woMNOOYDVupm9HjdCtP5FzIYJ
 Qp5qBe/NyDtTQbeGSHa59a2oDl+2mXNPhJlomMIGMdt6rhIRvZ3Wg3ooWX5WHLe/RR
 qbBYDUEZ0QEyJCbAYXiPTw9or5zH6ehKMl11qCR/cLbLFVJ/ujMI9voqurgxV/Cws6
 vXMpJzmm3ZVpy8aq9ObPrRmCBSOVk6aJPqtl/AodDius2HDRcSuUoqNxXZY9YDeuv6
 2p1bsTP00ttqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amit Engel <amit.engel@dell.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 18/30] nvmet: pass back cntlid on successful
 completion
Date: Sun,  5 Sep 2021 21:22:31 -0400
Message-Id: <20210906012244.930338-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012244.930338-1-sashal@kernel.org>
References: <20210906012244.930338-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_182306_679688_9DD8F88A 
X-CRM114-Status: GOOD (  11.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

[ Upstream commit e804d5abe2d74cfe23f5f83be580d1cdc9307111 ]

According to the NVMe specification, the response dword 0 value of the
Connect command is based on status code: return cntlid for successful
compeltion return IPO and IATTR for connect invalid parameters.  Fix
a missing error information for a zero sized queue, and return the
cntlid also for I/O queue Connect commands.

Signed-off-by: Amit Engel <amit.engel@dell.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fabrics-cmd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 4e9004fe5c6f..5e47395afc1d 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -116,6 +116,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (!sqsize) {
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
 		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto err;
 	}
@@ -250,11 +251,11 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	}
 
 	status = nvmet_install_queue(ctrl, req);
-	if (status) {
-		/* pass back cntlid that had the issue of installing queue */
-		req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
+	if (status)
 		goto out_ctrl_put;
-	}
+
+	/* pass back cntlid for successful completion */
+	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
