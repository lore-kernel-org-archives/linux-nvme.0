Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90591E77199
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkGdiIi+6y7rs4zjIGDit7CFD7bli5i41cV/+3Y3Tpc=; b=ncIGXfajbjtv3tnNED2cuRZS4X
	I7/nMGe2nyotqN5g3vUs1xtX56o7qSTS93AFYnbH/wFlst2X2mHvpl9S9uairw7Dg/sbLeS88inH4
	lQOpkC1vABoEozmKTgNGNAPqVFHovFtTuz9qdKa2EcOqTS7u4nRfQSXJCDFDt+KvQwBLSq8E/eGGc
	qNPQ4TXTqyd7/RmoafSw19HRNj1Y40o11KxXpbJowqL67rs/lJLrWVLnNJxonE5yYRJbw7fhbVOvV
	MiR0dGdC0xRZL6UyxVkJ0BvNrwXXhtTw4RxJrnoEpLEOuNjzVF1petS3Prrs6q165YS7zCVmFEbaO
	7bXp+MoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscx-0000000C1po-3ci4;
	Thu, 09 Jan 2025 13:31:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscv-0000000C1nP-06x8
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 13:31:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B8722A41CB8;
	Thu,  9 Jan 2025 13:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C63BC4CEE2;
	Thu,  9 Jan 2025 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736429468;
	bh=3QGicS42gxFxR+GV2Bop0Uf8DmbC5XfA8QuhBkB8Huw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ti40nWHnCy/ZXojSWdvg1iO3hRS5GpEC6vp8nynZkVEXi52dLW4EqzjW4Iu+er5h5
	 VHaUg3j5altZz6OsHIOd84ZJMedlm5AfMl8saD19CI5JOIHt3DGZj7r0df0Z1FG3LF
	 xNRu2Hfax79Wl6uCZlR7kP6jWCys+o0v4QZj5S/PlCCh0QOgTPDVKel6HgJOovlL1T
	 HGCGRBcudEHn2d7OGA08Eo6c7YCyjuNvKT+V1e/J/bxn+H6xEYTlQ6kGcaGHyQ8+MU
	 wE+ZJMhuNbBopQHO718cNn/1SZ88qoCuMOY4apM4qIg2p79ntyhEMxjEdFxI8uhSGQ
	 XJjdE/DagdbJw==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 09 Jan 2025 14:30:49 +0100
Subject: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_053109_214327_5E989CE1 
X-CRM114-Status: GOOD (  19.21  )
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
---
 drivers/nvme/host/fc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7409da42b9ee580cdd6fe78c0f93e78c4ad08675..55884d3df6f291cfddb4742e135b54a72f1cfa05 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -781,11 +781,19 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
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
@@ -2542,7 +2550,6 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
-		set_bit(ASSOC_FAILED, &ctrl->flags);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
@@ -3167,12 +3174,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
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
2.47.1


