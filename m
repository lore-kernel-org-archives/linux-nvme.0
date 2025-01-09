Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BAE7719A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzHB+nAbWR8/wepuWUkKv1CwJ8SDGN+fo1ovd/ssd9Q=; b=ja2S3qkEiLXTVdJ7uEpZM8KRNW
	cxb7BfzPzyLreZ+ssdDJLByXPEcUHonKR4IB+L0YisA9zICzQnpi0PxPvZJ+RrpA2h8rpMpBfHyAL
	Ccnu8r3OECEo2ardoPwSLYaW8z0McILBUrOYeNzRNqbQTdCW2uV2UR+hwucrxRKzGCD9PtzPQZsUs
	b/pSEXuf/QNTpm8Xp1eKNYjai3bPQ9/6pS+/mYDEFbO8oLv3jpGyckaz48PQX26TQAsJZB62rbJyv
	FClWSMLhT60aWtrJAd5e9gqxEZQ0tUOGPEyOJYxxmKMugIotg//qpcSNEeq0W+btYhSiY5BBwFnti
	Os+yhI7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscs-0000000C1lT-0TO9;
	Thu, 09 Jan 2025 13:31:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscp-0000000C1kC-37D5
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 13:31:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 347935C3C66;
	Thu,  9 Jan 2025 13:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B03C4CED6;
	Thu,  9 Jan 2025 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736429462;
	bh=SNgDfj00OqljITRWu1bkZd/iWfQC01LmrSzpDRvZOYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YpcMkjyyF8mw6YEsYP0LBZ1UUfvtZ3m9HhW8L71zJG5TOAFsKSjKTozRNwqGf1/GB
	 ZxR0SainwcXXZhXIJCLrjsWmZ7DSEpAqkhDm5uTzqUyr3SIoXmdxRLP+jU6DkA8nC/
	 EE8k24UrWUAmGnkATGffpmSA2NGdgoMeCf3BneEeZlNtF6U9x2gYhpKqAYKlFzL3SK
	 1HkFSc1DXsU++pZcKyjvWrvPOtTGmacx8NTaXFgWopFyuoQ3GkgH5h88i1jHcyNDdX
	 PREZPZZitZlrHCScqubLXtLqDCySFun0gXzkeQiT17P/unI2ON3nuTTWUysH7+w3m8
	 AhNHfmQwJQS4g==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 09 Jan 2025 14:30:47 +0100
Subject: [PATCH v4 1/3] nvme-fc: go straight to connecting state when
 initializing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-nvme-fc-handle-com-lost-v4-1-fe5cae17b492@kernel.org>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_053103_881305_2A514132 
X-CRM114-Status: GOOD (  12.13  )
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

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 094be164ffdc0fb79050cfb92c32dfaee8d15622..7409da42b9ee580cdd6fe78c0f93e78c4ad08675 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3578,8 +3578,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;

-- 
2.47.1


