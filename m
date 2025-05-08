Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78314C3ABC5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=beTzt5H61dr9cmEppcQuQ6+C17jhoOJJ6jbo5QEipws=; b=uc7+cqPTpyAdRaQGZG8BIb+Q3G
	RmxuUiJKwxFV02qRiSCMk5fAFUf9WYmgGCd7j6/6ciqjU0UYDXduPMmMe8hslU3AZywf4KXnBFC+k
	XFLaQq9TsNHYG5/qz3wWPr2Bb4ZamvJorCx3Mh8cL6B6mikVzqPoucp4JaI73/IwsQq3lXBxRjNLW
	l56eRILnRiV/XAzHUDMvhbpIAcBd4jLUuHAPLq9j5VzZJ+SSp6aSQ0OLpqrFQstZrAk+rW5OvuWfG
	10PKPaenyV1iem+ko1+xM8skDRUsv/KStSh3k1G/2tPOGtB3Q8PWkkgKuzPiCIsgmv1sgkd7d97my
	WXDR/3QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdB-00000001ypA-3L6d;
	Thu, 08 May 2025 23:26:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAd8-00000001ynB-2AUQ
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:26:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C839B5C6440;
	Thu,  8 May 2025 23:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288F9C4CEEF;
	Thu,  8 May 2025 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746777;
	bh=DQM8RoeSmHrPeQ/bDeUDrsLq1orGOvd/U1qzch4I/YE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UFXeYsu879rs4j2z2Zq4tdlyPEKaRyAIXdX+GV4RmdqvkXkYmONmwBo+X0oMaAeI/
	 UwwHCwIPw6DbSSOUMFq45IStcvz7HjccOdk2kTr2FLkhfWmC76Uxb4Wsn3b4EQyR/S
	 0CdaZWXNQZXNJwxO/qphOOShiyDNSQeaFdaSrRkENhWG5Yj+HSDzhEHdFBjNA2gsBS
	 XlJC0Rh3UOIrcQ0+mqUyEuRjpUdGwK5xABn48VW4qgk2jDORmuTzG52qe7UGMksBRb
	 kP/8aowKCpqX/5x9OhvFOg8GYwVVUmOMSCYmr4fWkWD29Yk4F0HGJfcZ8pPFEVlOWH
	 kf/h0TLbuH5pg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 2/5] nvmet: pci-epf: Do not fall back to using INTX if not supported
Date: Fri,  9 May 2025 08:25:01 +0900
Message-ID: <20250508232504.437470-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508232504.437470-1-dlemoal@kernel.org>
References: <20250508232504.437470-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_162618_594832_598AA52D 
X-CRM114-Status: GOOD (  14.42  )
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

Some endpoint PCIe controllers do not support raising legacy INTX
interrupts. This support is indicated by the intx_capable field of
struct pci_epc_features. Modify nvmet_pci_epf_raise_irq() to not
automatically fallback to trying raising an INTX interrupt after an MSI
or MSI-X error if the controller does not support INTX.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index d5442991f2fb..bde7818c673d 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -636,14 +636,16 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
 	switch (nvme_epf->irq_type) {
 	case PCI_IRQ_MSIX:
 	case PCI_IRQ_MSI:
+		/*
+		 * If we fail to raise an MSI or MSI-X interrupt, it is likely
+		 * because the host is using legacy INTX IRQs (e.g. BIOS,
+		 * grub), but we can fallback to the INTX type only if the
+		 * endpoint controller supports this type.
+		 */
 		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
 					nvme_epf->irq_type, cq->vector + 1);
-		if (!ret)
+		if (!ret || !nvme_epf->epc_features->intx_capable)
 			break;
-		/*
-		 * If we got an error, it is likely because the host is using
-		 * legacy IRQs (e.g. BIOS, grub).
-		 */
 		fallthrough;
 	case PCI_IRQ_INTX:
 		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
-- 
2.49.0


