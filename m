Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EBAC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JkfGQa7KOskg08fvS4HAPLNYwKvousPKstD++UlUgWk=; b=nN8mUa5jZUV5eUUy7lRWC+Bu3W
	GAbKyi0VqfaEC9zhcq4du6qf5R9ePEZkbPL13oLnO3bS+wiiDr6KnoamTJiMV2vae5pYk0SxJkajc
	YcPVZeiv2oqQ5rmned2pEhY+6s+w84cdO3+DsPoYds6MRWGzp0MJxCWa2jBdC3Pux4zZIuAzyUBn7
	UgE+VgH08UNdQdcZMGeh4x7WcokMxia56IOq4qgnwNFNMpu+Q4zqmxMtDV3ybOv3kx77hFFjK2VFY
	wLzhOIYctAH7+wweAWRLn4J/j3Z0vfL53XN8H85/oZlg9dPuWozQs2XxHCiu250gvfEW9OgfWv8y5
	FehCLelw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ8d-006C02-CQ; Tue, 08 Nov 2022 15:03:43 +0000
Received: from [2001:4bb8:191:2450:b4e6:4796:2c38:d4bf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ7u-006BmC-TN; Tue, 08 Nov 2022 15:02:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 01/12] nvme-pci: don't call nvme_init_ctrl_finish from nvme_passthru_end
Date: Tue,  8 Nov 2022 16:02:41 +0100
Message-Id: <20221108150252.2123727-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108150252.2123727-1-hch@lst.de>
References: <20221108150252.2123727-1-hch@lst.de>
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

nvme_passthrough_end can race with a reset, so we should not call
nvme_init_ctrl_finish from here.  Instead just log that the controller
capabilities might have changed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f94b05c585cbc..706499d4bfefb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1120,8 +1120,10 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
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


