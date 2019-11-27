Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BDDC432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:59:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A26720871
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TNnIYXqf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyBZSpxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A26720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AAbjBmG6tAxpPm3kAwVNXhUMGKN8hSflkmojSq6SIg8=; b=TNnIYXqfvY2nJw
	yJNkJDVlZwm8fg+AtZlRFWx3cP/9z55cFTnD6dsKfe3OIiI6LD78jxA6MbxUAQKd1Hh2sOMI4JYnp
	IUAPbOOb4RW7EKuEYflKL6l9l/6PmWeQYTHTEi6t8g+KPr31LHGLHreNWz69QI0HuUmi5ZwzDlHe4
	28orxXmD1l5h8K+zU4+qHlpPVssx1U+8f//Q5pnUdYU1sO7pIisZBdJjcV2tMyhGB2A88QoHoNf19
	Jr8+PROHBMRo9dgDPF8mgLxwvo8fD9NNdkZ3/9gaGBAZN1EPDlgUkyC6cAHzN4oYcgWXa7kVuBn0M
	n609zcbkjnGnXhJkwoDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ia1bK-0007Um-9d; Wed, 27 Nov 2019 17:59:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ia1aW-0006q6-41
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 17:58:53 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A56BF20863;
 Wed, 27 Nov 2019 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574877531;
 bh=/bILODYX1k8hpYcHVnGzJu8NJM6xRDFuivx4koGDHsw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KyBZSpxubWaVJWOLuMk8sQqNYwT/z0uswu1qBJL8Rdtd+3cfUudsN5sYrqDTCum2r
 dx3oa6VpEysNlrr1ebgwIBj5YeqsQMznfRJ1cH3g/pM5PkOilXAq7x4abaBCsCMzEy
 iNhXVD98YM6P7zqokIaeMOKtgVdVYPBG/kXVyo/g=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Date: Thu, 28 Nov 2019 02:58:24 +0900
Message-Id: <20191127175824.1929-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127175824.1929-1-kbusch@kernel.org>
References: <20191127175824.1929-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_095852_214079_3F82C1F8 
X-CRM114-Status: GOOD (  10.05  )
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

For deeply queued workloads, the nvme controller may be posting
new completions while the threaded interrupt handles previous
completions. Since the interrupts are masked, we can spin for these
completions for as long as new completions are being posted.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 571b33b69c5f..9ec0933eb120 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1042,9 +1042,15 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return ret;
 }
 
+static void nvme_irq_spin(int irq, void *data)
+{
+	while (nvme_irq(irq, data) != IRQ_NONE)
+		cond_resched();
+}
+
 static irqreturn_t nvme_irq_thread(int irq, void *data)
 {
-	nvme_irq(irq, data);
+	nvme_irq_spin(irq, data);
 	__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
 	return IRQ_HANDLED;
 }
@@ -1065,7 +1071,7 @@ static irqreturn_t nvme_irq_thread_msi(int irq, void *data)
 	struct nvme_queue *nvmeq = data;
 	struct nvme_dev *dev = nvmeq->dev;
 
-	nvme_irq(irq, data);
+	nvme_irq_spin(irq, data);
 	writel(1 << nvmeq->cq_vector, dev->bar + NVME_REG_INTMC);
 	return IRQ_HANDLED;
 }
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
