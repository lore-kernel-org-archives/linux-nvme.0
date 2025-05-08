Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CDFC3ABCC
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l5EFr2FdsuvfjLQ0M4lorDJUTrWGyND9RNmPEd4X+0s=; b=oohgjQD2BxQ0QBPcy/dey5SfTN
	NspRwG5wekiqAwbfL+IJPQJ7i40phrkOfAf27P3nc4oncJOAAc4UehIkJai97mOyvDxeO0rzh6x0p
	v7kPFkRf3/lPdJP+O/ULrdlFEZ5w6S16d+zcU3J/PJSR8A0eOCNsBX+wBIJHzyozJnRgPepO8zmyI
	hMOg1baA8nDiXR9ssTEgFSfgDGW4LFJaRif6BKFtdy2HdFKeuuBG3R2jPv6qhHZcshc45Qjs2PDSz
	hK8ne48FCpEVPg5XfIuG/rTx34OPG/l5biqbVLTp318mX9wun73xrF8/X+vcXrYhvH/xC9Uj2Bdnd
	NCKdiqUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdC-00000001ypa-1snT;
	Thu, 08 May 2025 23:26:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAd9-00000001ync-2OL2
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:26:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BB3635C64EB;
	Thu,  8 May 2025 23:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B65C4CEE7;
	Thu,  8 May 2025 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746778;
	bh=vjK/5H3UFqG4uiHKsA9uOIx12pFfCKXZJ0D2LDqQyh4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZJAzVz6sNR+6L8BLM2EBcGibHi/W/l3KS4IGXqVqNciakh3CAQD9qebchYGsM76Ba
	 Txz/sO82U5A1D8geDM6ILEl7o3nAOJS1rySWNEKG9b1jgWkTh4vzveRU813Df3bq2p
	 xhq1NZT3RjhBLidLsxDK1B+i5BkOswoZWIUgJUQQwQkQHwZuAw06HTN3KSSgy4Uif3
	 3dWL2qHJu5m8zYrXQIrGjpNl+f8KagaC8utd3H2lxMUVitJgVUvQDknKlA/EBZ6WUj
	 br9qa9SX+2Ik/tsiQKXGEtCdsNTBGJV48Cepp6T9EFXmgGZ2FQUPjTpcG56r2EoyN6
	 HnZQ7Iti3orRw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 3/5] nvmet: pci-epf: Cleanup nvmet_pci_epf_raise_irq()
Date: Fri,  9 May 2025 08:25:02 +0900
Message-ID: <20250508232504.437470-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508232504.437470-1-dlemoal@kernel.org>
References: <20250508232504.437470-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_162619_662029_99469503 
X-CRM114-Status: GOOD (  13.12  )
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index bde7818c673d..a6ccf3fcccc2 100644
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


