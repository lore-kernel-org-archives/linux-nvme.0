Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E690CCD184
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75ltemOU45V1Sr09scUA1M03qv0jezQGAkGwRHr22XI=; b=JiHIKV4cQwqU6hQcBj8rlqoGEj
	Z7OjsgCELTKbZjaGod9LTj9q1p5/Qymop3XaJk5MCWLySiPWSsQu89JEgHMC3NNaTabVi/q3Veyb+
	MREnSFQyJ4zjs/RIqDfw/zWdRzIVHAoIUNVDb8M9ZJMBnGXRiWvGQqYQR3Ekz4nd3NUEwLl1KlzcW
	IUdXNlCifEfD5AM/jbwOOmGLi3oN/SjAWVs8snQXHAhtm4toyDzCt8w0Y8QUlmrUFHhtdfjzAkb0m
	fhmZmlDdBKiRYbKgYAPy0hxmXW++G5Uk9QO7zMZKXiGAhgmH6EH4zLcf/HBdSfdVeBsCol8wJycHF
	1sn+AN+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6t4k-00000006cS9-1xQ0;
	Thu, 09 Oct 2025 16:01:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6t4i-00000006cQc-3dH9
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 16:01:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2698062371;
	Thu,  9 Oct 2025 16:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89612C4CEF8;
	Thu,  9 Oct 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025663;
	bh=s6E6DxFLAxma+oKOTr17ggDa1wGixk9Y8lcLACFjhbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnQk+lyF/WkFD1aNjqEXCJu5LBMZjSjZFO8pR8o0mSyk7O6IA2TQEuZW5krykSzdK
	 UuvUcu4f0rWwiTeJKODWJGGpExP6MoBH7Zy7UILHgc5tGgO9r5VzQYUyXXlJH1CfZC
	 zdfUZ+29Po8pILzPmrRTbYW1Bxy16WaOm+Ix2UBWceIRvu5MlfrCVd2bG64ANGOfUB
	 ZKdXd5zTgbbvbmjvYm8bX5iSJEq4Z0e+nHyOTUif/q1mtmbUPgIKNoCjK4sfyvIAZO
	 +D4tiDY+bTIHc67u+QkkxZ6tj6RhY+P5uDD+jIZGFwJXUpDfMPt33TiFHmhHfC11sc
	 d3eCv2OIGlQqQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-5.10] nvme-fc: use lock accessing port_state and rport state
Date: Thu,  9 Oct 2025 11:56:07 -0400
Message-ID: <20251009155752.773732-101-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 891cdbb162ccdb079cd5228ae43bdeebce8597ad ]

nvme_fc_unregister_remote removes the remote port on a lport object at
any point in time when there is no active association. This races with
with the reconnect logic, because nvme_fc_create_association is not
taking a lock to check the port_state and atomically increase the
active count on the rport.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- Adds the missing synchronization in `nvme_fc_create_association()` so
  we hold `rport->lock` while checking `remoteport.port_state` and
  bumping `act_ctrl_cnt` via `nvme_fc_ctlr_active_on_rport()`
  (`drivers/nvme/host/fc.c:3034-3044`). That makes the state check and
  reference grab atomic with respect to other rport users.
- Without this lock, `nvme_fc_unregister_remoteport()` can flip the same
  `remoteport.port_state` and tear down the rport under lock
  (`drivers/nvme/host/fc.c:813-839`) while a reconnect path is still
  between the state check and the `act_ctrl_cnt` increment
  (`drivers/nvme/host/fc.c:2987-2999`). This window lets the reconnect
  code touch freed memory or miss the counter bump, causing crashes or
  failed reconnections—the bug reported on the mailing list.
- The fix is tightly scoped to this race, no API or behavioral changes
  elsewhere, and it follows existing locking rules for the rport. The
  affected logic is unchanged across supported stable branches, so the
  patch applies cleanly and removes a long-standing use-after-free
  hazard.

 drivers/nvme/host/fc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e12d4683ac72..03987f497a5b5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3032,11 +3032,17 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENODEV;
+	}
 
-	if (nvme_fc_ctlr_active_on_rport(ctrl))
+	if (nvme_fc_ctlr_active_on_rport(ctrl)) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENOTUNIQ;
+	}
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: create association : host wwpn 0x%016llx "
-- 
2.51.0


