Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5FCC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 07:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBa9LsiRImBSY+o6GyXRGCIZ6ax9E5V+uOb6KPrd9EQ=; b=Mw3zXDfxtJBntX7qLTvtE7gzUR
	EaXxpUVvkveOtoI2IR9FGpJMQhARPH6gxdyG+ownnPEQ2nizqV+Ud1X8O0NUorKh0XpAwucdwCbV+
	kA4lnRnF/ysEravI2E0qNjgIoVbluLEkXBLrUpQXdlTGof06TQ2x9/zO932Ll5toZ+6w0zr6ZgtuJ
	61T4yH+3/Kg8kTKVTcKvt1glb5NONxJO0Pwjo8L5YL7JOYnIQvOeMc6E94PRv/FwF7EGSMiSoCKyj
	TnLrCTECE8ys5h933jGSv+prKN58RiDHcWv2TNOBraFq9Zl+R+WLyvQt3WM+pu/pOC8E2XZaQcPm3
	mopjdogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvHB-0000000HX6E-2mM7;
	Thu, 08 May 2025 07:02:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvDg-0000000HWor-1pXU
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:59:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B51B7A4D9F5;
	Thu,  8 May 2025 06:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BBDC4CEED;
	Thu,  8 May 2025 06:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746687539;
	bh=0ID1XfnhxqH/bTbp6kkK8VNsWq4JMwXmC1nh2j3y2eI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=phOIFi94paVY4vP0l0e0dw674opOM8PBE05mA/zv1IvChHwVO+XhYv6gsdAMzbv8R
	 SDwGdy3z4SDqtNVNa7q4n8qSL5EWNESKAYUt5hDhIs3SlNmZ7JJL6pXONQrh1EvHcH
	 ILce9YS3FZKIi6ICgc0bK8IlDSQ/bToaNMFKUjfRCJJVPXR7G3ax1EroDUfiVEFL0c
	 RsjrM1WI5DGTH0LBy890UnH45+cuxBfSGWgk4hlHiVJ1jdTWH+unZ1RCgfdxqSY0GZ
	 8j2AppE3lynw6tZl+Z1NtxOCsd3O8Lo5AlsS7pMPRgewKUrrbY2BWzEI8weFtj+tHH
	 wAltFd9zi88ag==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/4] nvmet: pci-epf: Cleanup nvmet_pci_epf_raise_irq()
Date: Thu,  8 May 2025 15:57:44 +0900
Message-ID: <20250508065745.389199-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508065745.389199-1-dlemoal@kernel.org>
References: <20250508065745.389199-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_235900_539694_6DDE4234 
X-CRM114-Status: GOOD (  13.04  )
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

There is no point in taking the controller irq_lock and calling
nvmet_pci_epf_should_raise_irq() for a completion queue which does not
have IRQ enabled (NVMET_PCI_EPF_Q_IRQ_ENABLED flag is not set).
Move the test for the NVMET_PCI_EPF_Q_IRQ_ENABLED flag out of
nvmet_pci_epf_should_raise_irq() to the top of nvmet_pci_epf_raise_irq()
to return early when no IRQ should be raised.

Also, use dev_err_ratelimited() to avoid a message storm under load when
raising IRQs is failing.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 859953041da8..34dd73d6457c 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -596,9 +596,6 @@ static bool nvmet_pci_epf_should_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
 	struct nvmet_pci_epf_irq_vector *iv = cq->iv;
 	bool ret;
 
-	if (!test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
-		return false;
-
 	/* IRQ coalescing for the admin queue is not allowed. */
 	if (!cq->qid)
 		return true;
@@ -625,7 +622,8 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
 	struct pci_epf *epf = nvme_epf->epf;
 	int ret = 0;
 
-	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
+	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags) ||
+	    !test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
 		return;
 
 	mutex_lock(&ctrl->irq_lock);
@@ -658,7 +656,9 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
 	}
 
 	if (ret)
-		dev_err(ctrl->dev, "Failed to raise IRQ (err=%d)\n", ret);
+		dev_err_ratelimited(ctrl->dev,
+				    "CQ[%u]: Failed to raise IRQ (err=%d)\n",
+				    cq->qid, ret);
 
 unlock:
 	mutex_unlock(&ctrl->irq_lock);
-- 
2.49.0


