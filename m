Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E6C4706C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+ezZJfeZrvdY53kMq5UO6L8baxSUaGltnOuzUOm3/2Q=; b=0nqveVyJZpS2pV7+twGPzfCEcP
	oGaZeIVabbRBUis+jpr1GM8iGpg8tms2qOuS4HbIT/7PfuZdMEVXrivR+ag424whyeJwmzYhFWMae
	Yw//yhqVZd3lf4GtnbF8veKNRN3tuWVEGFubL8pWqpdzJi8MBd9YIbPwaN0hp7hbJvJRl5XuVk1/4
	ybG59VUMebQMiKxd2MvLVxEmjBjNa6R4e6xu2XP84KVpO3Tl2hOZAauC9krjgmuDdbIvbyu29Ke6f
	BxgW5ZADBnxpWXmAbsgZTBIkPW6R/1kNzktbLF56pWSzK+uSbIO4L0SUBBZxxlsG8NQyTBbQfRiXX
	/K4aq9AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOETY-002Rkc-1j;
	Fri, 12 Jan 2024 10:09:20 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOETS-002RjB-3B
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 10:09:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id D55D9B82296;
	Fri, 12 Jan 2024 10:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F06C433F1;
	Fri, 12 Jan 2024 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054152;
	bh=lU8eHTf7D3YV0MsDLoA+MpYDKIkypf+ypT3/VMAG2js=;
	h=From:To:Cc:Subject:Date:From;
	b=UC8uA/MdrE/3tG4jD5nFiP0OeuTfMCgW3xxzSlEl+8zCythEgbdjW1oMfImzRsbMt
	 clh8oE1y/jtqSWbe03QCM9VIcR1srd/vbZuqcQmXGn2/E12aUhcPOsEC3Qqed5kJoI
	 LdBQqnc0NR5bNTJpu+WQFebUAPdLe6s4+VeMKwyJZ1JWEB0J6cuZNXIfD+4Y+ta0Nx
	 RslgwydJ02D6omnDyQc5alufEmc8RYCIkHdsnWnZUgPR7VzVIW9dAgpNJm+/TGPIXL
	 BraI5cKOpgFj8p8o5jG+Lo0AfzdvePB2RviJ3Sq/f/vvg+FUT+CWv+avkrAafGdO/p
	 XJ5fOya2OSGUQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme-tcp: Do not terminate i/o commands during RESETTING
Date: Fri, 12 Jan 2024 11:09:07 +0100
Message-Id: <20240112100907.80765-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_020915_181267_E4460A47 
X-CRM114-Status: GOOD (  15.66  )
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
When several commands have been sent in a batch and
the command timeouts trigger just after the keep-alive
command has been sent then the first command will trigger
the error recovery. But all other commands will timeout
directly afterwards and will hit the timeout handler
before the err_work workqueue handler has started.
This results in these commands being aborted and
immediately retried without waiting for KATO.
So return BLK_EH_RESET_TIMER for I/O commands when
the controller is in 'RESETTING' or 'DELETING'
state to ensure that the commands will
be retried only after the KATO interval.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08805f027810..9dcb2d3b123c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2431,17 +2431,27 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
 	int qid = nvme_tcp_queue_id(req->queue);
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
 	dev_warn(ctrl->device,
-		"queue %d: timeout cid %#x type %d opcode %#x (%s)\n",
+		"queue %d: timeout cid %#x type %d opcode %#x (%s) state %d\n",
 		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
-		opc, nvme_opcode_str(qid, opc, fctype));
+		opc, nvme_opcode_str(qid, opc, fctype), state);
+
+	/*
+	 * If the controller is in state RESETTING or DELETING all
+	 * inflight commands will be terminated soon which in turn
+	 * may failover to a different path.
+	 */
+	if ((state == NVME_CTRL_RESETTING ||
+	     state == NVME_CTRL_DELETING) && qid > 0)
+		return BLK_EH_RESET_TIMER;
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	if (state != NVME_CTRL_LIVE) {
 		/*
-		 * If we are resetting, connecting or deleting we should
-		 * complete immediately because we may block controller
-		 * teardown or setup sequence
+		 * If the controller is not live we should complete
+		 * immediately because we may block controller teardown
+		 * or setup sequence
 		 * - ctrl disable/shutdown fabrics requests
 		 * - connect requests
 		 * - initialization admin requests
-- 
2.35.3


