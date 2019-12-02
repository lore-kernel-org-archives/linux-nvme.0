Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E27FC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F368D2073C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TjqQ/VwS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOVZjyzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F368D2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yngOctkyet2PPWwgaE389b71JArrbSS4h9dcb1ioX/g=; b=TjqQ/VwSuzEtf3
	rrtxb11ER7+kbeLtE0EhLoARws++40NxwhkXrr1znxIR3IrUx5f8yWHGtgnbiXw5OkbszTe5I6oNX
	ibKd25sHsDA+7GzGYLIrd4EVuALmS0TY0FtaOXnaVMLfSp9GsjWev2ORtfvYS8MHQHGjdehBi1I8F
	MS6QOxb/JlHvC+00i9umHbDsucSNeyCFo+d7/qMiYQ7TUcvBDatCzAFE+acsgEXXyjyPhYH9Jzeib
	LaJxG4X7JSqMhewvKK9/2PzeOlylwnZg1UjmgS4I1ZZYEwZu6F2vV7cKseSyGHtzkmAnZNOG4PrmE
	u6buVvf0KoW0xoECj19w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibu4V-0006cl-5g; Mon, 02 Dec 2019 22:21:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibu4F-0006LW-KA
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:21:21 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF1C620722;
 Mon,  2 Dec 2019 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575325279;
 bh=i9aBMRg8PYQWZjW1REcJHPQXulgO/s5uHa1ORsNypYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uOVZjyzZWyG5ar1srT56dyJadHKwE5EbkTO6/TgSVBSaXtRrdpMBGrnQZRCVba7Sn
 3SLYxhi5LA8iAmEM8DkGDb2w6ljkNzb+7L0951p53MJdKqAXRE1eNxZux4jk99I6Qd
 sQVQppZFBf1n1g/9QIxEVc/mqXAJuwoPySqr0Alg=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCHv2 2/2] nvme/pci: Mask device interrupts for threaded handlers
Date: Tue,  3 Dec 2019 07:20:58 +0900
Message-Id: <20191202222058.2096-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202222058.2096-1-kbusch@kernel.org>
References: <20191202222058.2096-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_142119_709389_33816724 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, ming.lei@redhat.com,
 helgaas@kernel.org, Keith Busch <kbusch@kernel.org>, tglx@linutronix.de,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Local interrupts are reenabled when the nvme irq thread is woken, so
subsequent MSI or a level triggered interrupts may restart the nvme irq
check while the thread handler is running. This unnecessarily spends CPU
cycles and potentially triggers spurious interrupt detection, disabling
our nvme irq.

Prevent the controller from sending future messages. For legacy and MSI,
use the nvme interrupt mask/clear registers. For MSIx, use the quick
control mask function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0590640ba62c..4022a872d29c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -13,8 +13,10 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
@@ -1036,12 +1038,29 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return ret;
 }
 
+static irqreturn_t nvme_irq_thread(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+
+	nvme_irq(irq, data);
+	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
+		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
+	else
+		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMC);
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	if (nvme_cqe_pending(nvmeq))
-		return IRQ_WAKE_THREAD;
-	return IRQ_NONE;
+
+	if (!nvme_cqe_pending(nvmeq))
+		return IRQ_NONE;
+	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
+		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);
+	else
+		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMS);
+	return IRQ_WAKE_THREAD;
 }
 
 /*
@@ -1499,7 +1518,8 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 
 	if (use_threaded_interrupts) {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+				nvme_irq_thread, nvmeq, "nvme%dq%d", nr,
+				nvmeq->qid);
 	} else {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
 				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
