Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14FCC02198
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X31JrfduvjuRIHa/+ABWfVE8zFt0lykJSOflQdZnnHU=; b=lVThOtapmRpWEiv3ELRp/pM3jC
	75vf83BYfLhvD7Hx9U1iT+i0fc6fy2mLGNoeVozfpYZB1fhbJr58GU26iH/r4QurkoV87lz+EiLhG
	Tp6na+m6QtYn0pxNrY/zK0gMGxFFMIEYy89YSO0noMYwxB57Vy2GvxkGuV+G3bP5z6x+fxogFKLhK
	PT0lKiuzdPF4jqxucPXo7CexkcU42yDxwZmhlcRzQSu0N+RaLcwzkFHwnP9HqIpuUc6T2pSPypFW7
	2Fu/Upo1M+wj+uM2Q3iaUrHBF6Ut2DQVlCylrDmgjYeLBRFVZfug0y4GdoFrqlrLqfYI3NqIiQ+NN
	h0suzYzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf7q-000000027cZ-0Gck;
	Tue, 11 Feb 2025 01:31:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf6w-000000027GQ-3WBP
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:30:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B72975C5783;
	Tue, 11 Feb 2025 01:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411AC4CEEA;
	Tue, 11 Feb 2025 01:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237450;
	bh=WFxr/y9LJF0Ox1+qtFw5ab55rZwBdjgkMAZy8r9P928=;
	h=From:To:Cc:Subject:Date:From;
	b=NNzBR9OeQe5ULtl/VZPzX1YbxNjoUYTkFSXsu8zbXmWKkC29MIHfZbqycK85bqvCO
	 xFZo62pevqWIon+aPSVTOJAQdP2vwK4CNMKCDywcduJTuaYmuWxLiubcdIpSZeDt0q
	 aqI+BS884eeJZKijy/iTKK4i4kxui5xn4ugKIzKseZ8ahuUbqYfkTXS2kzizOiyTeO
	 PCHjzkRwfds4AjYAnae3AMnIHS6asuJKlpGYZdHb+dXtk74wIwie9E8QPOw4m92yAk
	 MaLl9k7tYcDf7onx8JID0inteBwfv2c6i3AeSnziTi4fY/q7oKgkhElo6837ovNMIB
	 JCv+nfxDWoy/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 01/19] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:30:29 -0500
Message-Id: <20250211013047.4096767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_173050_911033_A6149F24 
X-CRM114-Status: GOOD (  12.05  )
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

[ Upstream commit d3d380eded7ee5fc2fc53b3b0e72365ded025c4a ]

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94c..d45ab530ff9b7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3579,8 +3579,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
-- 
2.39.5


