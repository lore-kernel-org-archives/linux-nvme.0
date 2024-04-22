Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A6FC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J8Qoghwco/VQmgqsF+4q/QYcXZav68r5906wc06JM0A=; b=qpog8zFhfuUnIMjLKrzjcti6rb
	pBRmHksFW2XjEiuNAxI0B3/gXEjXAke0/611e0+KfkWyR8+CeFL/Ajgkm73WuMXKT+bx7uu7qebZU
	YJsVXAN+tLXWN2j/58ItdRkeoDlc79oGaZ3RynWXr2VlRZOvYGo+2+PBRxfGjpMmX5MUxh5qgZxKn
	q/Cr/2N6PSMYIlWGD6K2/qlP4KgRPSFflXcqSbRXtaUaOuo9zPq9Du+XF+l4F+6B4bygDmdXLPWhS
	KL9zkkVEt7PoMM83/E+2IN4lgs7v8R5nBzZNcfoCKp9gJ6jpZC+DoSr8B0VuRs4Xxp3TAsINYNVHZ
	mbA+C2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rywYA-0000000EI6b-0SBm;
	Mon, 22 Apr 2024 16:29:50 +0000
Received: from out-182.mta0.migadu.com ([2001:41d0:1004:224b::b6])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rywY7-0000000EI4r-0UjD
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 16:29:49 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713803376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J8Qoghwco/VQmgqsF+4q/QYcXZav68r5906wc06JM0A=;
	b=kkgG4HtfgR6UWSdWZpTEms0r0sHOCM2mSxG2sAUBmafgI+d8QY/yGkRTMTTmywWLl57XZF
	b5Rs47VzO+kqhnnLeYuB6P5qyD1GZzhAGGrlgle1KdI6rqJBrVEi81XUFRABFzHTyB06V0
	NumqB0GWISyZ/rDN47M1IHKa7gtM190=
From: Sean Anderson <sean.anderson@linux.dev>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: Add quirk for broken MSIs
Date: Mon, 22 Apr 2024 12:28:23 -0400
Message-Id: <20240422162822.3539156-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_092947_545185_C15902E8 
X-CRM114-Status: GOOD (  15.90  )
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

Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
support, all commands time out resulting in the following message:

nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled

These timeouts cause the boot to take an excessively-long time (over 20
minutes) while the initial command queue is flushed.

Address this by adding a quirk for drives with buggy MSIs. The lspci
output for this device (recorded on a system with MSI-X support) is:

02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Sandisk Corp Device 5008
	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 3
	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
	Capabilities: [c0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [1b8] Latency Tolerance Reporting
	Capabilities: [300] Secondary PCI Express
	Capabilities: [900] L1 PM Substates
	Kernel driver in use: nvme
	Kernel modules: nvme

Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 14 +++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b87763e2f8a..738719085e05 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -162,6 +162,11 @@ enum nvme_quirks {
 	 * Disables simple suspend/resume path.
 	 */
 	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
+
+	/*
+	 * MSI (but not MSI-X) interrupts are broken and never fire.
+	 */
+	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..d1f0fa2e7c96 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2218,6 +2218,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.priv		= dev,
 	};
 	unsigned int irq_queues, poll_queues;
+	unsigned int flags = PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one I/O queue
@@ -2241,8 +2242,10 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	irq_queues = 1;
 	if (!(dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR))
 		irq_queues += (nr_io_queues - poll_queues);
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
-			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	if (dev->ctrl.quirks & NVME_QUIRK_BROKEN_MSI)
+		flags &= ~PCI_IRQ_MSI;
+	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
+					      &affd);
 }
 
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
@@ -2471,6 +2474,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned int flags = PCI_IRQ_ALL_TYPES;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
@@ -2487,7 +2491,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
 	 * adjust this later.
 	 */
-	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (dev->ctrl.quirks & NVME_QUIRK_BROKEN_MSI)
+		flags &= ~PCI_IRQ_MSI;
+	result = pci_alloc_irq_vectors(pdev, 1, 1, flags);
 	if (result < 0)
 		goto disable;
 
@@ -3381,6 +3387,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
+		.driver_data = NVME_QUIRK_BROKEN_MSI },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-- 
2.35.1.1320.gc452695387.dirty


