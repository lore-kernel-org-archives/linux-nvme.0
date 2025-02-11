Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB00DC02198
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cFBjeLQ2zYgW2s+XEra7/z73Yayzyjc/JW7t9OSBBeg=; b=KPd42417vuhxCe6RRY6xzZqkjr
	yhAQ3FhClOj0Y0wfLda4/JOfsLeCS37fF40hJEkP87w8MmMe+pKDb13AebqUmw5scv79EggoYF38e
	QmxaCjm5xQiTjkavsOA4ZqWp8lh4hVcqPJMvcMIGuv3tBLRp/EJj4hYlg9kiPFrdMQGNO2fsYRmcz
	hCNeuVTDTOnwuijpHzAwJ7x0jgqgtDHRZOxJ4dOHzM67hp54lIqomPWCFO2MPxRGyJ53JyTJdaxX0
	GZRRpvDXWxSgFU9jETNzqWMQen59TY9Rs4Eav4fLMaBUmNiW0it6QZa3zaLaaz8lKwHJ04Z9LMXjY
	ycGeJNhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8e-000000028Ep-1ltX;
	Tue, 11 Feb 2025 01:32:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8b-000000028CA-1eev
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:32:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 49D5B5C5FF7;
	Tue, 11 Feb 2025 01:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C5C4CEE5;
	Tue, 11 Feb 2025 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237552;
	bh=yWXRVg8GbGEfxVc2POhOhGPiMA4DTp9jMMX6TH02wnU=;
	h=From:To:Cc:Subject:Date:From;
	b=IjXcPnZow7zdalcYgcxHJy5oxmeloWco7aO4o9sN5Wl835Iysc12mwXon8ocBcv+L
	 q3v6zppXtMr2m2sHnBgwJsMUYYfJtNwOt/Bb54Hx/C711VI5zLzViwiRAKYE34HTpE
	 u7Oo8D9R7H2JYfHzifFLNUv7xBQ5Q3L9sp20RPFhBc0K+Rxo46U94wNmg0XWd5jiFn
	 R8TPSNLE8vDE9YYK/IkkXfJGS5Ka6tPdHTq2oqzFqx2WFMTGCdqNAmn1Z7s1u+YVm2
	 8S+F2nG3qhR1+O9UNNbVl4lQDpx9OSsH2oBT//fpvI4VyqIBJiFutJX8qBfENL72GA
	 Gi2w4Q0d1D8PA==
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
Subject: [PATCH AUTOSEL 5.15 1/9] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:32:22 -0500
Message-Id: <20250211013230.4098681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_173233_492200_75BB374A 
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
index 8dfd317509aa6..ebe8c2f147a33 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3547,8 +3547,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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


