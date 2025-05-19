Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E979C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W2Vuc2W26x5nB6hZVKG70pGaHNLmVzGagmgoRIjwoB8=; b=rIB377glUXO1ICyZtC3Q+BihdP
	vj9ldlly/TcD00Lp6ggBFbgKwPZDaIfV//B8QSgTuleqqrEm8ozFlIGksw5k6qf9AN3YR5A9qylul
	Q2ezbe1sq8z1XZXNvJ2Jk9c0geYEfjg3QfxPRUwcM4xXNdMVc07GTLJfD9puUiNs91WO2apuG1flJ
	up0dMhFlzpfocOuCb14PZdF64YY+5RmgC22s2vC4ribb+WBSjQQ0nZdoK1jmu72txGfJxoNpHCRaF
	Xfxw84YKJFVKP2b4iIUfRn/p3mrNO8kLBnvIW1GWYLcsm9JtfDf2gxe1a4OUdqjC2TruVrs8NpNK3
	cUFGnzaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7vf-0000000AVn2-0Xof;
	Mon, 19 May 2025 21:21:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7vc-0000000AVly-1Ynq
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 21:21:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F93D450E1;
	Mon, 19 May 2025 21:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035E1C4CEE4;
	Mon, 19 May 2025 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689704;
	bh=8eoPs6kGfUHklSE/0zBqDnlRCHuVPwGUq6nnsbtYVDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjeR1hnFebAsewwGL2PEGUKuNNRyhVyFks2g0B0VzYfWgj+h8rWlaD2K1LM1EqCOy
	 fDZchaa9zySwf0r1+HD2pQYK41XEFx/bV0Fm6zh+b4xYVlEXHLiUrTn/72vVrkWg7l
	 bke4+iA0cNqKAnIpvMeEhNipuozfCdyVnpHiraEm6d0yBQOA9biLUnVquwHhIv9lpw
	 WK+S/z7JUR/nQlM80Ixrh7WNOeJ3nQ9AvZhdpbONIEd+wFh/ptsQS1uOd4+I8w/ACR
	 YuMRueaeio7K2CDYYBY5uEwZYGFBb8pK2ISGulfTAZlO10dA4OGGDNke20gtSa1PKN
	 CMKbDZbe8Humg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 08/23] nvmet: pci-epf: cleanup nvmet_pci_epf_raise_irq()
Date: Mon, 19 May 2025 17:21:15 -0400
Message-Id: <20250519212131.1985647-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212131.1985647-1-sashal@kernel.org>
References: <20250519212131.1985647-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_142144_433362_3ACF7B15 
X-CRM114-Status: GOOD (  13.86  )
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

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 4236e600bf902202214aa6277e84c4738c56f762 ]

There is no point in taking the controller irq_lock and calling
nvmet_pci_epf_should_raise_irq() for a completion queue which does not
have IRQ enabled (NVMET_PCI_EPF_Q_IRQ_ENABLED flag is not set).
Move the test for the NVMET_PCI_EPF_Q_IRQ_ENABLED flag out of
nvmet_pci_epf_should_raise_irq() to the top of nvmet_pci_epf_raise_irq()
to return early when no IRQ should be raised.

Also, use dev_err_ratelimited() to avoid a message storm under load when
raising IRQs is failing.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index bc1daa9aede9d..80d857798bddd 100644
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
@@ -656,7 +654,9 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
 	}
 
 	if (ret)
-		dev_err(ctrl->dev, "Failed to raise IRQ (err=%d)\n", ret);
+		dev_err_ratelimited(ctrl->dev,
+				    "CQ[%u]: Failed to raise IRQ (err=%d)\n",
+				    cq->qid, ret);
 
 unlock:
 	mutex_unlock(&ctrl->irq_lock);
-- 
2.39.5


