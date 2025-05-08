Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4A6C3ABC5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 07:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKM9KdhdKfF8qOlrdrGzEq/aZm+UXzyBX4R1xEh8PNo=; b=HPAwQ8SW5/r3UiHo+GFDcZ1saD
	DAwxjxfo8f6ecQd/LCtf70RF3lFdlCQKHQEOepIZ9Jcky/TQtm0uURElqYAzRzgfS+l0jk5U9Jqhy
	GEXVztCLRaDleb44bAw98q83nQEgvq7jXA+V/sPS1B5EG1aA+F+VY1aXnhg9LHSGTyxkeM6GKAUdg
	uaRvwzjzbJ2Ovh9lyqwiHn0Fe6JQjhEPhq/eD/nM9L2r4cakOFh6ThHYgeVBhD69PWE1shxj0DTYy
	Gkxcy2GN5N1xUXI2My7YqZcO2Ulqn7L6tiOJtoiG07ZJMHqyDm8GaK1uKm0Ll40p+00rM0FH9uvL6
	/6PCn0Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvHC-0000000HX77-1cuf;
	Thu, 08 May 2025 07:02:38 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvDh-0000000HWpF-0vXt
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:59:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 925E3A4D922;
	Thu,  8 May 2025 06:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC42DC4CEEE;
	Thu,  8 May 2025 06:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746687540;
	bh=MhwTe56ucl+UTtB8qlVI9dXtJ8BqiicDcmQNh8DvatE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rZgJdRsdjl4YS3wKGsk7IMznrqZvCL6tb9wBfyJ8qTBtpI7sL75yyh3IYEMC/twK1
	 Gd0Ztsjsu8sGMUyLAHG6snuwhP3PBcincd5R/TCLUZb3SDRq+8ETGMK7tavpY9NQwi
	 Ne+02JRhwPp4gv3dTTNDdpHv3DxUfzyIItAdXUlngCU5OoOTZFYo+ZM2XQG//jj6yY
	 U9hOg7ZmH7IemY9nqdlzKqH3cBcrkBf2RNVBzkjXYdLEP4VzuGrl0MxSH4gGHMElfq
	 8uzK6TEcc+Uy0rG7CPJ+4h9iBfEVxuOp/ns2rZMf+fe81ppwBtwT2zCgyG6xTGYWka
	 Z9QyyXYjjMcHA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/4] nvmet: pci-epf: Improve debug message
Date: Thu,  8 May 2025 15:57:45 +0900
Message-ID: <20250508065745.389199-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508065745.389199-1-dlemoal@kernel.org>
References: <20250508065745.389199-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_235901_320075_9D842406 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

Improve the debug message of nvmet_pci_epf_create_cq() to indicate if a
completion queue IRQ is disabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 34dd73d6457c..bd79e059e066 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1321,8 +1321,14 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 
 	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
 
-	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
-		cqid, qsize, cq->qes, cq->vector);
+	if (test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
+		dev_dbg(ctrl->dev,
+			"CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
+			cqid, qsize, cq->qes, cq->vector);
+	else
+		dev_dbg(ctrl->dev,
+			"CQ[%u]: %u entries of %zu B, IRQ disabled\n",
+			cqid, qsize, cq->qes);
 
 	return NVME_SC_SUCCESS;
 
-- 
2.49.0


