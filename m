Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00757C28B23
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uGD++K6rDnsK/RblqLTOQYdVcCTKDfGfGq3zkAQNeXw=; b=DdQ0jlSfaFN+uuHrkSXlJIQVkr
	Xv68kyKsQMrhud7i5XkC289Y6HTpdh8a5ukH1NP67fDrA2Ptp0F/Fsuu+wJbBbZTnXhFoDezMBBcx
	zHiUVEff5zNv4w02IgCsAvAFvGUvk5CdwCT99dPZrvE/fj+wk4PfN7OXWvVsqzje8retMQMVmAzwV
	Q/rjN0mf4/dDXodgICYUcADTWaymEyH5pSY62Iu6Vud/KW+qMS5GiXejrmarCUQEaCPfZeZ0yXlqP
	uRp4L73fAj/Kzrj9oldKabSeU3X5kiDGAH1Ac92hzqIpVP1MPCquU9DYPX3U1egHtt3qI1xvtQkYV
	FvdkNJMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq8CO-0000000Aaf4-1nhk;
	Thu, 06 Mar 2025 10:11:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq71S-0000000APIH-0D0q
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 08:56:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 760A45C55A1;
	Thu,  6 Mar 2025 08:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9080BC4AF0E;
	Thu,  6 Mar 2025 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251365;
	bh=mZD6gPQNpkhWm+EEF7tfenN1i12LDxhSMGFoeNFnLJw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c2E5dMLQ/A9+gqdC3DN7Bs4YkWZ8fjIHQl8ttZnDFKfMCnEVyJCaXRzeIqwcXeIQs
	 i2dhFcjOuM6T5NhT/7JRc8tWPOWMYOjnpHM0Uz4kwP1n0pGT1c189SOQH+rZlAFiu2
	 56H4U4XK2XQtsJAeaG2vhTB8xhha5AtKR3nHQMqX9BtJRf3xvqNimvncxTdtLYhL3s
	 hdqTKTweotjlWeuxh1N0u8ljh5eFSsBUpCC8HQKUiNPritOXssR2D2hXGe/upCrXs0
	 fvRf/ZhtJgXQjaLjgunEcXNE/U/CNHhThpnzx1j7d6LSuH+ezJFuDWKrKusfhWxMI0
	 csq/MrglM0yDw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 2/2] nvmet: pci-epf: Do not add an IRQ vector if not needed
Date: Thu,  6 Mar 2025 17:55:49 +0900
Message-ID: <20250306085549.834943-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306085549.834943-1-dlemoal@kernel.org>
References: <20250306085549.834943-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_005606_194770_DD042F98 
X-CRM114-Status: GOOD (  14.45  )
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

The function nvmet_pci_epf_create_cq() always unconditionally calls
nvmet_pci_epf_add_irq_vector() to add an IRQ vector for a completion
queue. But this is not correct if the host requested the creation of a
completion queue for polling, without an IRQ vector specified (i.e. the
flag NVME_CQ_IRQ_ENABLED is not set).

Fix this by calling nvmet_pci_epf_add_irq_vector() and setting the queue
flag NVMET_PCI_EPF_Q_IRQ_ENABLED for the cq only if NVME_CQ_IRQ_ENABLED
is set. While at it, also fix the error path to add the missing removal
of the added IRQ vector if nvmet_cq_create() fails.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index d55ad334670c..b1e31483f157 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1271,9 +1271,6 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	if (!(flags & NVME_QUEUE_PHYS_CONTIG))
 		return NVME_SC_INVALID_QUEUE | NVME_STATUS_DNR;
 
-	if (flags & NVME_CQ_IRQ_ENABLED)
-		set_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags);
-
 	cq->pci_addr = pci_addr;
 	cq->qid = cqid;
 	cq->depth = qsize + 1;
@@ -1290,10 +1287,11 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 		cq->qes = ctrl->io_cqes;
 	cq->pci_size = cq->qes * cq->depth;
 
-	cq->iv = nvmet_pci_epf_add_irq_vector(ctrl, vector);
-	if (!cq->iv) {
-		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
-		goto err;
+	if (flags & NVME_CQ_IRQ_ENABLED) {
+		cq->iv = nvmet_pci_epf_add_irq_vector(ctrl, vector);
+		if (!cq->iv)
+			return NVME_SC_INTERNAL | NVME_STATUS_DNR;
+		set_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags);
 	}
 
 	status = nvmet_cq_create(tctrl, &cq->nvme_cq, cqid, cq->depth);
@@ -1308,7 +1306,8 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	return NVME_SC_SUCCESS;
 
 err:
-	clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags);
+	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
+		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
 	return status;
 }
 
-- 
2.48.1


