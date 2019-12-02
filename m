Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4DC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:18:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBAE20718
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFPSZlDS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbacTdyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBAE20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3Q9xC1Wi6LMuOH7ywfF9xwq/ZH+8jK8rwsINL5jedkk=; b=NFPSZlDSnjLWX5
	T+x4v7iDeNg3m3PYy4gNEJEXBKuzOIgX4Ro+ibeSezqg+5SLPlhCJc3MnaatmeSDTC0zIPHtc/ovI
	V8UQui0w/LadN1uFpOBSL2YFA8Ss7eY1LkeRhbQXhsE+EpaaNjyi6Qw9F21oLJc39XMxd23dM/hKr
	WW/CEvaf/otG9QDp0U2o7NP9n/sHBd3uGf0CnLZ72NsX+g7uNHcyd8WGr48IheUryHtrf+XQAlblH
	ofR05a0aX3LQPkCxzXbVGNSdBj1/chVs6AN+0WoRLU246QZQpGBc9WQp4zkShIzV+BbusWzYzxFv9
	BwD/sLd010xycyt6uGtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibu1j-0004fm-Tf; Mon, 02 Dec 2019 22:18:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibu1h-0004fO-8j
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:18:42 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AB9220718;
 Mon,  2 Dec 2019 22:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575325120;
 bh=g1CmRXueHMSPzV/HQtbNAB3vAS7HtqTluTpqs1GXD3Y=;
 h=From:To:Cc:Subject:Date:From;
 b=qbacTdyZPkX1m0A1sdIVBfLJQa5iyD7V+5Hcn3jcyFz7bHlAANGzWf0dxdoz7RWu/
 xVNaMBrKfmxZT9RaLv2CUJEp+jOxtmjYJc0wb07N+0aQ8hEgthGVqlecBB76rzNKqV
 36LZ1pOviF3LdXZbpRka1l6vSxDWOIwK1Vfr9kpU=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme/pci: Remove last_cq_head
Date: Tue,  3 Dec 2019 07:18:29 +0900
Message-Id: <20191202221829.1940-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_141841_327498_ED80C4BD 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We had been saving the last_cq_head seen from an interrupt so that a
polled queue wouldn't mistakenly trigger spruious interrupt detection. We
don't poll interrupt driven queues any more, so saving this value is
pointless.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d307593b94f..0590640ba62c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -176,7 +176,6 @@ struct nvme_queue {
 	u16 sq_tail;
 	u16 last_sq_tail;
 	u16 cq_head;
-	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
 	u8 sqes;
@@ -1026,10 +1025,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	 * the irq handler, even if that was on another CPU.
 	 */
 	rmb();
-	if (nvmeq->cq_head != nvmeq->last_cq_head)
-		ret = IRQ_HANDLED;
 	nvme_process_cq(nvmeq, &start, &end, -1);
-	nvmeq->last_cq_head = nvmeq->cq_head;
 	wmb();
 
 	if (start != end) {
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
