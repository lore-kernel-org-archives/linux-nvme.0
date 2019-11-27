Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD993C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9071F20871
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GuM1wO4X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v6ZWz4nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9071F20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xlNcLU7uFt0AmBmQ09Gp2NYDSkmMF1kXRYLqyp9uVVU=; b=GuM1wO4XmfTnu1
	rzA3yVsGj6ZxCeOOoJYvOgRXySJcVT42OMhwN+jJPKEg7s53dB0SehJKGtv5YuIgIScZmpeU8qoO0
	taosQi5fT7CxBcwX0DCbbIEJpSfufvNe7BzEJZFBUKhOmogoIRkeTWe4Eha4oAbd71zAh6mT+nT75
	YtGFsZZQKgoV0vyR8KZW7JbaPjYmQOmMyOUHPsjGsY/0VRonbjOgyHz9vGmlK3nqRhtv9bDFwaJ/F
	ho85V9AguWNHBTXQc5gvMNKHdotro8LYgrtELAr6+YeufXJIKR1GcdXrkVgYZmW9YzOpVTr/1sRr3
	6dEnMl5f4YVvJaqESvxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia1b4-0007Iz-JB; Wed, 27 Nov 2019 17:59:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia1aU-0006pF-KB
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 17:58:51 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AFF120869;
 Wed, 27 Nov 2019 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574877530;
 bh=GQjLhQ4sAACHOmdW0eUspyXpnyoMzTnhOgAdzvLUDRE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=v6ZWz4nLbNMOFTFA1kgBbeZEtYyFqPn7+FdcXeep/4G/XLoMQcmLiicyaKvLTE3hr
 rdWOBdWPIqoo7rsxRnQO77X0NE2tCbb3DG8pzOxMTzG4bzkYHD72Dy2yyJwBdbbEnp
 vpzdZoixm4AzZidVL3zEivoiwSQKwplVS4jQaeLE=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 3/4] nvme/pci: Mask MSIx interrupts for threaded handling
Date: Thu, 28 Nov 2019 02:58:23 +0900
Message-Id: <20191127175824.1929-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127175824.1929-1-kbusch@kernel.org>
References: <20191127175824.1929-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_095850_682448_DF12DB22 
X-CRM114-Status: GOOD (  11.45  )
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
Cc: Keith Busch <kbusch@kernel.org>, bigeasy@linutronix.de, helgaas@kernel.org,
 ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme irq thread, when enabled, may run for a while as new completions
are submitted. These completions may also send MSI messages, which could
be detected as spurious and disables the nvme irq.

Use the fast MSIx mask to disable the controller from sending MSIx
interrupts while the nvme bottom half thread is running.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c5b837cba730..571b33b69c5f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -13,11 +13,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
@@ -1040,11 +1042,21 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return ret;
 }
 
+static irqreturn_t nvme_irq_thread(int irq, void *data)
+{
+	nvme_irq(irq, data);
+	__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	if (nvme_cqe_pending(nvmeq))
+
+	if (nvme_cqe_pending(nvmeq)) {
+		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);
 		return IRQ_WAKE_THREAD;
+	}
 	return IRQ_NONE;
 }
 
@@ -1530,7 +1542,8 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 				nvme_irq_check_msi, nvme_irq_thread_msi,
 				nvmeq, "nvme%dq%d", nr, nvmeq->qid);
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
