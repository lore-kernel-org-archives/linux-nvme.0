Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D5AC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TC0h2wU4Eu5nenLJLEWOQKJwOD/2eKQIZpug5OnJ8RA=; b=o/jrBIGCAl5gCRqFmQlmfSHVjq
	Rzi6xWh8fHKK9SOt7UWusa+sFCiUiMY89MR1ANPn4cSikQxBYA6vwEtWlRABG5wTSMUYNn5PX79Wl
	Gq60P481cAssG/TnYhqRd+FqVcfBlC1rUsIN5ha/khigkDqwJ5XuErUMk1IxD8oImywzHK8C1LU0v
	/bstmwVHRV6V/LZUpsznP1HKSya0ITKQEWNuuuCDjo1e9hL1hw++xzBOevfqVeq4VCqmSXJU8JojQ
	4DdyGz9VCNxLBpEdEOsfFgmf8NNtvNLko4avhnZYmS4g+Gwm7YglaVGU16ZQd9D8e8zzKysFgnMU1
	JCmEQetQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaH-00CBp3-Qc; Sun, 13 Nov 2022 16:11:49 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaE-00CBnM-LW; Sun, 13 Nov 2022 16:11:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 01/13] nvme: don't call nvme_init_ctrl_finish from nvme_passthru_end
Date: Sun, 13 Nov 2022 17:11:26 +0100
Message-Id: <20221113161138.883195-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
MIME-Version: 1.0
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

nvme_passthrough_end can race with a reset, which can lead to
racing stores to the cels xarray as well as further shengians
with upcoming more complicated initialization.

So drop the call and just log that the controller capabilities
might have changed and a reset could be required to use the new
controller capabilities.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a87a072fbed3..ce8314aee1ddf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1123,8 +1123,10 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		mutex_unlock(&ctrl->subsys->lock);
 		mutex_unlock(&ctrl->scan_lock);
 	}
-	if (effects & NVME_CMD_EFFECTS_CCC)
-		nvme_init_ctrl_finish(ctrl);
+	if (effects & NVME_CMD_EFFECTS_CCC) {
+		dev_info(ctrl->device,
+"controller capabilities changed, reset may be required to take effect.\n");
+	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
-- 
2.30.2


