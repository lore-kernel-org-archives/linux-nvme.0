Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10892C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 07:50:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53E6216F4
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 07:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tDJo19Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53E6216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=emwK01sLLlKvd5Mf84yRrIsFMnEDV8Pc0QTRMzAw+8M=; b=tDJo19VmB0est8
	r/IuSqaEXLU3F6+bRIFQ9qdZ6cQ1fnaPXjGnSsWyiH7RWdIZL1rfbsk3l9V1JEoFp7dGKkTuu9Ige
	aYTTTqHxTMt9yh+pnFHpPfiiKlhAL4pJdIih9H8pIUYCovLm5XOBmteV8Kk8+qWTYVYW3uQ3d+2TW
	AN2HoHwPV/AuTboSABIlDyKg7uMdN+YPnUo2C/A6O1xPoL6duUgLIZ+6yHf3ZVhycv5DGGUheF0Wx
	LTclhT6PUTWvBeMD7W0oAwc/iGGhmennEUBrSn85HDzEstb+4IDty2Ia2OduGswalB/cbVqPyES5d
	Ix3GTpiNC7j2EIGwyptw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaEZh-0007sV-MZ; Thu, 28 Nov 2019 07:50:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaEZe-0007rw-CF
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 07:50:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A0DCE68B05; Thu, 28 Nov 2019 08:50:47 +0100 (CET)
Date: Thu, 28 Nov 2019 08:50:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191128075047.GC20659@lst.de>
References: <20191127175824.1929-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191127175824.1929-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_235050_570549_E89858E7 
X-CRM114-Status: GOOD (  11.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, bigeasy@linutronix.de, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, helgaas@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

FYI, this is how I'd imagine my comments to look like on top of your
tree, modulo the posted interrupt disabling part that will need
changes outside nvme.  If we want to be fancy we can split the irq
disable/enable into separate helpers.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e62fede7d4e4..1d6a222ddcc3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1042,50 +1042,45 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return ret;
 }
 
-static void nvme_irq_spin(int irq, void *data)
-{
-	while (nvme_irq(irq, data) != IRQ_NONE)
-		cond_resched();
-}
-
 static irqreturn_t nvme_irq_thread(int irq, void *data)
-{
-	nvme_irq_spin(irq, data);
-	__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+	u16 start, end;
 
-	if (nvme_cqe_pending(nvmeq)) {
-		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);
-		return IRQ_WAKE_THREAD;
+	/*
+	 * The rmb/wmb pair ensures we see all updates from a previous run of
+	 * the irq thread, even if that was on another CPU.
+	 */
+	rmb();
+	for (;;) {
+		nvme_process_cq(nvmeq, &start, &end, -1);
+		nvmeq->last_cq_head = nvmeq->cq_head;
+		if (start == end)
+			break;
+		nvme_complete_cqes(nvmeq, start, end);
+		cond_resched();
 	}
-	return IRQ_NONE;
-}
-
-static irqreturn_t nvme_irq_thread_msi(int irq, void *data)
-{
-	struct nvme_queue *nvmeq = data;
-	struct nvme_dev *dev = nvmeq->dev;
+	wmb();
 
-	nvme_irq_spin(irq, data);
-	writel(1 << nvmeq->cq_vector, dev->bar + NVME_REG_INTMC);
+	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
+		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
+	else
+		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMC);
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t nvme_irq_check_msi(int irq, void *data)
+static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	struct nvme_dev *dev = nvmeq->dev;
 
-	if (nvme_cqe_pending(nvmeq)) {
-		writel(1 << nvmeq->cq_vector, dev->bar + NVME_REG_INTMS);
-		return IRQ_WAKE_THREAD;
-	}
-	return IRQ_NONE;
+	if (!nvme_cqe_pending(nvmeq))
+		return IRQ_NONE;
+
+	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
+		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);
+	else
+		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMS);
+	return IRQ_WAKE_THREAD;
 }
 
 /*
@@ -1542,11 +1537,6 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 	int nr = nvmeq->dev->ctrl.instance;
 
 	if (use_threaded_interrupts) {
-		/* MSI and Legacy use the same NVMe IRQ masking */
-		if (!pdev->msix_enabled)
-			return pci_request_irq(pdev, nvmeq->cq_vector,
-				nvme_irq_check_msi, nvme_irq_thread_msi,
-				nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
 				nvme_irq_thread, nvmeq, "nvme%dq%d", nr,
 				nvmeq->qid);

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
