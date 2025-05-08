Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CC7C3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 07:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RsP53H4Ikfu3h+pmFI6WYYGeH/n8Aw7CQ8okgLgEAO4=; b=Prc69GLwriLHbH/8Nk3/cL06qK
	PqlbRm9cKaLspLigNSDgZCM9MgU5oq5ob+znWdpfEI2VNWuDUGklxNU+a8/AE3cH/ovF05vP93w3a
	wafq8qYXibLPdO43mDRdUEgmgse+aimpsZu+u2jf1PI15wl5Uvp8kOg+EQpnMph9uq0JGTeXzcQMm
	jSKQrK7K3ye1h6aTZsfIjqAoGprTyrXwS+ToXZWZEVBY8zUtPltm8LPP4ZW2u5us49IrSy1W1/u9X
	ywVQ4cptxdpHkwZlduMeGGtGaD7+8Y08916IRQ+N7DZwXZkKYecPxCj8Go9g/HSuLE83lDgRFguab
	EIGBgFfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvHA-0000000HX5m-3sWq;
	Thu, 08 May 2025 07:02:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvDf-0000000HWoV-2FoU
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:59:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 943655C5E9F;
	Thu,  8 May 2025 06:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5F1C4CEEB;
	Thu,  8 May 2025 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746687538;
	bh=S8DPSwGSiWgJxg+m9FbbOxMwLv9Yn7inXT06U36CIOk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c9EDz+sy/cVkrAhoSjadJcWD/uncHwVir4v7mM7KgMbOLdWCGtUjVWDlyvCd+bGBW
	 p9l7jlw9p7x6Ei7Lh9v8talrSD/A6Ks20RRM36TKn743YuBRt7ntMqkiID847Rh0ko
	 NAtSaRKbkh4rUMNXoFYq3EkYBi6/xvOp90aEHq/qIT4DZlw6aWgvpicRxZc4KMD0pr
	 AzND9EjpybEsloSzWdcwCrgaljnNdI4SrqiuzfWUpw41aPinsz8Wnh4FsErUvzNCYU
	 So3xksAD8eEv6KUohXC2nmDTH5Iq2nEk8IZD2s/oF/diB+rtfh8xIY88QuMhC7VxtU
	 a9/7I36vjUGLw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] nvmet: pci-epf: Do not fall back to using INTX if not supported
Date: Thu,  8 May 2025 15:57:43 +0900
Message-ID: <20250508065745.389199-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508065745.389199-1-dlemoal@kernel.org>
References: <20250508065745.389199-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_235859_629992_46D3D26E 
X-CRM114-Status: GOOD (  14.17  )
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

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index d5442991f2fb..859953041da8 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -636,14 +636,16 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
 	switch (nvme_epf->irq_type) {
 	case PCI_IRQ_MSIX:
 	case PCI_IRQ_MSI:
+		/*
+		 * If we fail to raise an MSI or MSI-X interrupr, it is likely
+		 * because the host is using legacy INTX IRQs (e.g. BIOS,
+		 * grub). But we can fallback to the INTX type only if the
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


