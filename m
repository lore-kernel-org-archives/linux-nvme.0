Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A268C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X31JrfduvjuRIHa/+ABWfVE8zFt0lykJSOflQdZnnHU=; b=P/zgc+q6m6FR7PG20TbP7s4Ny3
	WOuiKjFbJAdPTWx6EXv0cB0TIZT9Zy5gUjmixobrhsWSPepnfgteHVW2/qND1h/dc3XnbZHiNDslq
	0BrNEVEHTBqbCXsK0A8rOZHZHNASS28qoiTGxWoHTMiVEg3tBlp+DGJCcgrfVSin4IP1OpVj+TxEl
	qOqQEqa7ArN4UR+pqzxahkDIWU311jZCm5jHUuu2wvX9SA0F8kmolW+Il9AMbETceCXcTsuxwOTwJ
	31LXvo4uRE6Ma4unjDzLWfB6t8h/SyIV3Gk30TKUXAdo2I2LUQkoC3lux0V/8P15SvoTC5kr/4rhi
	vAdskFjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf6C-000000026xO-2bNf;
	Tue, 11 Feb 2025 01:30:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf66-000000026wQ-2AN2
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:29:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1ADB4A4207B;
	Tue, 11 Feb 2025 01:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23EFC4CED1;
	Tue, 11 Feb 2025 01:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237397;
	bh=WFxr/y9LJF0Ox1+qtFw5ab55rZwBdjgkMAZy8r9P928=;
	h=From:To:Cc:Subject:Date:From;
	b=GAnlS7yfmwbl8AyrDqVrzU8T78BAouRQEMBCdH6okFpB5Wz9BT7zNO/frGthPVAAx
	 OaXtdeUtlmN6V8cZkfs7GxNn4eu4jUNfea+15pYVgPZ6ydqv0w4009PI4t2XxtRpNq
	 2fI4S/3JBUsMCyhQw5vlcFTDacMpeApTYhhAmvEo2GEET9yCsyf+tO8luf1s9kqVPk
	 0Zvf0UuvSB5vR6XXGDUMdplD+7z8uOa56ICr8gOcpZ49a/LSZYEg+xvMYvNdgL9hjX
	 8cJq8YIfCJXUC7B1WynpCZrEnUS59t4XAMctMLfAnw8F4nF0kBBRjy31YVPAAXAVoJ
	 fpOVLnVhD5YWg==
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
Subject: [PATCH AUTOSEL 6.13 01/21] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:29:34 -0500
Message-Id: <20250211012954.4096433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_172958_622384_87331178 
X-CRM114-Status: GOOD (  12.15  )
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


