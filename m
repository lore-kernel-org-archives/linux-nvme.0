Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A352C432C3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA37207DD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/C/KrTu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yGTQVhAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA37207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnLvxy2pMayzMlQRuuri+7WsFIYkEfEFG5s7wa9DAcc=; b=Y/C/KrTummPRBj
	PXFkOdURDqtBngbMioEBBhjD1H9GQuLqb5AI+FKE6PT4tcViwgf68/SJjyq6vyEY86QzJM6wDAXGQ
	kSXBojohQnMyjCqygrlk5K7u+aRBDHrw/8Gu8Z6HvHAooMC4/Iuymrc/8y1vt3vnDZz/Ed8VMI1W9
	K3Z6jAtNV30GZVikLnGe1DnM/UrCrDDwk+gsWveVpkJpJ9SB/y1S+aPcwaPVwaAxrV908EmC74XRp
	x3Wc8SRUGjZHWpovZ59hGCmrJV5lxX6cYTv83HU1ykP8mWBpzswV0NHQSsjYtinimWZ14pcmir3xr
	9/9cZK4DWStctfdJIekw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibu5D-00075p-GS; Mon, 02 Dec 2019 22:22:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibu54-0006zg-5f
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:22:14 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 249EF20848;
 Mon,  2 Dec 2019 22:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575325329;
 bh=gARiSK1SvEF5YFEymkce9IhftRA2UBiMMSz1KE3T1ZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yGTQVhAtu1TT5yW0Skz5RwC/sCXJ3ECqnDaxQQDL2oUpW2m1QIXX1AZu9vAzW77Xe
 HmJIXHowWTCQMA/oihkL8Hi30lnMxh/LDlF3i+j8xrNDY8jPf4uy/9Jlihor+mTa8W
 RV9UvTWFNXQjCgsQ7oFQJeDVpTCx7kqHIUpugrUE=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 1/3] nvme/pci: Poll the cq in the primary irq handler
Date: Tue,  3 Dec 2019 07:22:04 +0900
Message-Id: <20191202222206.2225-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202222206.2225-1-kbusch@kernel.org>
References: <20191202222206.2225-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_142210_234404_0389A4AC 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: Keith Busch <kbusch@kernel.org>, bigeasy@linutronix.de, ming.lei@redhat.com,
 hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme threaded interrupt handler reduces CPU time spent in hard irq
context, but waking it increases latency for low queue depth workloads.

Poll the completion queue once from the primary handler and wake the
thread only if more completions remain after. Since there is a window
of time where the threaded and primary handlers may run simultaneously,
add a new nvmeq flag so that the two can synchronize which owns processing
the queue.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4022a872d29c..c811c0984fe0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -186,6 +186,7 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_THREAD		4
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -1047,15 +1048,27 @@ static irqreturn_t nvme_irq_thread(int irq, void *data)
 		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
 	else
 		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMC);
+	clear_bit(NVMEQ_THREAD, &nvmeq->flags);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+	irqreturn_t ret;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return IRQ_NONE;
+
+	if (test_and_set_bit(NVMEQ_THREAD, &nvmeq->flags))
+		return IRQ_NONE;
+
+	ret = nvme_irq(irq, data);
+	if (!nvme_cqe_pending(nvmeq)) {
+		clear_bit(NVMEQ_THREAD, &nvmeq->flags);
+		return ret;
+	}
+
 	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
 		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 1);
 	else
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
