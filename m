Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB457C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bYey9WkXnHWRH3csRjAu+t5udLzCMg52S2MWwWM8tQI=; b=tH1nUfSZW0LDt2iduG4Z2sNMTE
	i56lWLY2U9/eOcQxvL3TAFTlOG2Wha/m7LWW46IgHHeG68l30tS3GyQQ3h56BKdl20p3Q1P6heBkM
	JazfXHw9swHWmWqc36j36bRgbp1J1l+S9MxbfljnNCqkJ0b/eHkET1ESpN3dqeY4NhYcqb4WO3NX0
	elt9OnIngdYYl4hCkczP95p7VEDnfEg2Ln30b83FMo1YS22CYlwyq5wWgmgn+iOl1khT6+EC6D3ro
	llFcX9gzPkZ29+mzBAQdHEuJ2ghaI4LtULs4zoehNrzWK8iS7BYbX1pDzCUzJe8xWnyAt4FOre//J
	mUecm/qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8w-000000028S4-0tiq;
	Tue, 11 Feb 2025 01:32:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8t-000000028Pz-46GS
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:32:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D5C605C5FF8;
	Tue, 11 Feb 2025 01:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD2C4CED1;
	Tue, 11 Feb 2025 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237571;
	bh=vBCEJhkvhL8m42FZn4nwtaID0zY/K448LpVIKyP3ksw=;
	h=From:To:Cc:Subject:Date:From;
	b=keMhmnCcaLb9RHzcWFPVWGRqu+d7iofi+cYSn4nj8Hq+duxm+zW2t68RKJg4aCrXk
	 1DS7VkwTMW0MD+kOjzObBWBzHDO8NZno5UhFz7KiJuzDNvXG4k1L6xEns4yZja5Awn
	 zRyBpuTktl0IkgOV4DHloBLRqVThDHxFioS2cXBkZETbcsf/QjmMcD8dbVS+eQlGsS
	 UxUkzNF++uP/By120JIGAfY+tWZk+M5EtHPvp5zsQdFCvDk225knjSF3ya2HVxjyf1
	 9I7OauV4HbwQPh0yrHH3ZdoDFfZMIgAGs8VHnNLEdySdq+UeZTUNebufY/lZfH6sun
	 qRKY+x3BULm5A==
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
Subject: [PATCH AUTOSEL 5.10 1/8] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:32:41 -0500
Message-Id: <20250211013248.4098848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_173252_067591_EB971F9D 
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
index 8e05239073ef2..f49e98c2e31db 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3536,8 +3536,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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


