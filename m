Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0F0C021A2
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsgwhLyUJQXJ/7XCzb95Zlwy0RKa5WuM+xvkaGAHzL0=; b=JnJn3kychrpg/sxXUWDMe2txe2
	h8ugP/ZGwaBQRRN3/fOTgLlaOUTxBFQHe9OQexYmAxAx865/7zL5He+DGIISPJRuE9zMGivIze6SG
	Q3QAfELYBKQpQcAnHuYUQCgjF1lABhWiVpRcJlDia+DjX6ZWl4BtbzDpd/D9rcwjBz9fcbGVplPgz
	ysRKgqTgCBz1yy7XthgA691mm3A0rQ13gKvNnjAWE92DXCTzHVyUMr10kbcXIcnPtQmkoVHjDUvo6
	mz2WNcp4xl4lgB37a9GvJ10IQQee7Ou2Eqe31DmhE5VfHH+wzoPXJptL+w5Hk0JeJUUs6vxlWW6Lw
	KwD982aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf7s-000000027eS-0Jdn;
	Tue, 11 Feb 2025 01:31:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf7k-000000027a9-2yZ9
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:31:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F0D55C5FE9;
	Tue, 11 Feb 2025 01:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D7FC4CED1;
	Tue, 11 Feb 2025 01:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237499;
	bh=5912KsFpGho0h7f/0XmXLAOYwS451DDOhyzrxBaurB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLZ8clihbs6x+7g55TE7yREAZJ1AYbsKrE1CvzRq2gfesnYAdRw2h4QlQJhnn3Ub5
	 Rk9VhX0qva6Oi/H5dI9onmbOV/a6YKmeA8NZ4UtlLFwcGQ6rlIAIUUTOjR1u5Gmabu
	 qW+Ny4DbfSlmggBYoB4IV8j3ALo4B0oPlfSknZL9Tm5JhxnibV3kD47xcP8jdUqU9j
	 pT+Yd2QPfAfpB6Q7Bafk+EaNSE5aYR+id9vPj2IDEK+J2+e6joyQQTF25tGQYn4WE/
	 VCmqvae6xbHt63RFPsdNyflaHKGFmr/OgDog8MuNGwVYdcan8ZKfksxFPOQGtd/eSC
	 KarQrhIbOhS3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 02/15] nvme-fc: do not ignore connectivity loss during connecting
Date: Mon, 10 Feb 2025 20:31:22 -0500
Message-Id: <20250211013136.4098219-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_173140_832334_F6CABD34 
X-CRM114-Status: GOOD (  18.74  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit ee59e3820ca92a9f4307ae23dfc7229dc8b8d400 ]

When a connectivity loss occurs while nvme_fc_create_assocation is
being executed, it's possible that the ctrl ends up stuck in the LIVE
state:

  1) nvme nvme10: NVME-FC{10}: create association : ...
  2) nvme nvme10: NVME-FC{10}: controller connectivity lost.
                  Awaiting Reconnect
     nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
  3) nvme nvme10: Could not set queue count (880)
     nvme nvme10: Failed to configure AEN (cfg 900)
  4) nvme nvme10: NVME-FC{10}: controller connect complete
  5) nvme nvme10: failed nvme_keep_alive_end_io error=4

A connection attempt starts 1) and the ctrl is in state CONNECTING.
Shortly after the LLDD driver detects a connection lost event and calls
nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
state, this event is ignored.

nvme_fc_create_association continues to run in parallel and tries to
communicate with the controller and these commands will fail. Though
these errors are filtered out, e.g in 3) setting the I/O queues numbers
fails which leads to an early exit in nvme_fc_create_io_queues. Because
the number of IO queues is 0 at this point, there is nothing left in
nvme_fc_create_association which could detected the connection drop.
Thus the ctrl enters LIVE state 4).

Eventually the keep alive handler times out 5) but because nothing is
being done, the ctrl stays in LIVE state.

There is already the ASSOC_FAILED flag to track connectivity loss event
but this bit is set too late in the recovery code path. Move this into
the connectivity loss event handler and synchronize it with the state
change. This ensures that the ASSOC_FAILED flag is seen by
nvme_fc_create_io_queues and it does not enter the LIVE state after a
connectivity loss event. If the connectivity loss event happens after we
entered the LIVE state the normal error recovery path is executed.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bb85e79b62fad..3f24da154590d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -782,11 +782,19 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
 static void
 nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 {
+	enum nvme_ctrl_state state;
+	unsigned long flags;
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: controller connectivity lost. Awaiting "
 		"Reconnect", ctrl->cnum);
 
-	switch (nvme_ctrl_state(&ctrl->ctrl)) {
+	spin_lock_irqsave(&ctrl->lock, flags);
+	set_bit(ASSOC_FAILED, &ctrl->flags);
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	switch (state) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_LIVE:
 		/*
@@ -2543,7 +2551,6 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
-		set_bit(ASSOC_FAILED, &ctrl->flags);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
@@ -3165,12 +3172,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
-	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
-		ret = -EIO;
 	if (ret)
 		goto out_term_aen_ops;
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (!test_bit(ASSOC_FAILED, &ctrl->flags))
+		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	else
+		ret = -EIO;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	if (ret)
+		goto out_term_aen_ops;
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-- 
2.39.5


