Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1DBC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E6C2073C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4dtAmcg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMgwzfeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6C2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I5kPagX2tvKKkMnMOts1+OnjAo3i9OguFq9hozlkb+c=; b=P4dtAmcgZV0m75
	XJ/unyUaFnzcGPDVP254dX1cYt/fRKzhBqPy+bVRQrYytzKaXTCm1A+of7Ibvl0pkwrXK7yefg5T5
	c58iuZKZgU5b6gxoNAcKXmXEp02vpxmAh5fKZxdQbn2PjDwzUhsj8vbdFaVZ+2VPcixPTOc464oC4
	R7aVmVD08H6sgfes3On+xCDvWBQ0WIzCcLCvMuc3VYI1Dg5f8VMjdxcBT1bAM+EU/r1Iwcbqjw7ET
	FtIrOhclejMSyLKomFLsTY8CQ2bYbH7mTIuQSyoqenkzdAHY5dRpOByKGhqx5ACWpYLjodwb04n+h
	N5cxBdIzcDRI9X0wcEjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibu5h-0007UP-Tw; Mon, 02 Dec 2019 22:22:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibu56-00070H-7q
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:22:16 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3577620862;
 Mon,  2 Dec 2019 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575325332;
 bh=utqBfIh+WVL+He4e1e3Ui7RYgIjwXBWO3REgFOkyvaw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BMgwzfeLnKBFuw7h7g9RPMD346gBlbcQ2pxKGuqE30m10/7EO51Mc9ZGgWNFo2kE1
 RtPx/6s9pPn5DX+8nS5Xk+r+qlVgrdYJcN/OTMOqRIcCnqk8iMtQAzuaiGBgkpIo9m
 gMS4wsuJkD78LebmmrQLR750rETD553SiHvzUcPQ=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 3/3] nvme/pci: Poll for new completions in irq thread
Date: Tue,  3 Dec 2019 07:22:06 +0900
Message-Id: <20191202222206.2225-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202222206.2225-1-kbusch@kernel.org>
References: <20191202222206.2225-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_142212_304339_CE17B694 
X-CRM114-Status: GOOD (  10.33  )
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

A controller may post new completions while the irq thread is handling
previously seen completions. Have the irq thread poll for these as long
as new completions are available. This improves bandwidth and reduces
CPU time spend in irq context.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 634c96bafb70..44d8f701dce8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1040,7 +1040,9 @@ static irqreturn_t nvme_irq_thread(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 
-	nvme_irq(irq, data);
+	while (nvme_irq(irq, data) != IRQ_NONE && !need_resched())
+		cpu_relax();
+
 	if (to_pci_dev(nvmeq->dev->dev)->msix_enabled)
 		__pci_msix_desc_mask_irq(irq_get_msi_desc(irq), 0);
 	else
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
