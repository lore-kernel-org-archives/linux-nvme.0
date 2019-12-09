Return-Path: <SRS0=+L2C=Z7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C032C43603
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2019 17:57:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F251120726
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2019 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g5cZg8hv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFoZcOzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F251120726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aGeP0Hr3b6LufH3OJR4HEpaXsXkqjvuQz6dliwt9Zgc=; b=g5cZg8hvLlFOJe
	lznnag8CCE3vTi4NAt9vQebVDCd9pb73/nw97EpRTIryYwJGnZi63O63Xc2kKOUcq+lZSqvlYWZ0O
	26uHK6VgjhRse7zeCAGJUMUpQ/4BonH4KWAANdeOdBAU3t8TirjUWxzOxpC6zSV4hj8y74Y0UWubv
	5BMlac9XusYn2SZRbqzqUge6L2SoHHSvtfdKqlL3/GgC1hZi0MW5Z/1aEedNOLkT4FoVjaVdpaRvL
	BG4aAGcJyUWaiqHKtpjR1qlCXCHvkOBA63JXv4UeUOaXPBiGJXIDSPl+3IUWJTBGWDngIGePGrtvz
	aLMkao5SOc9TuYPWVWOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ieNHh-0006JJ-L2; Mon, 09 Dec 2019 17:57:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieNGz-0005kx-Rp
 for linux-nvme@lists.infradead.org; Mon, 09 Dec 2019 17:56:43 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6D63222C4;
 Mon,  9 Dec 2019 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575914201;
 bh=4wjaVh7RvcKVNpspy14FSuhHIl0r3Pnybdm0v/Gg5IY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SFoZcOzLGYzaE6HlXLZEy1Gf7oaojJaQ+kRBm8GR1X+U2QrqHPcsIADtcJm/8pQQe
 YVVIRHjhQZsHwu9I5OZ2tM0eKvrU66/qP0ltCooYY+U27p8rAtDoyYvSmNjbmqX1EU
 oNIeD8JzR0IpDkXLfwfnOqR01XKQj+TsZgdv69gQ=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCHv3 3/4] nvme/pci: Remove use_threaded_interrupts
Date: Tue, 10 Dec 2019 02:56:21 +0900
Message-Id: <20191209175622.1964-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191209175622.1964-1-kbusch@kernel.org>
References: <20191209175622.1964-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191209_095641_915306_535A33D8 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, ming.lei@redhat.com,
 Keith Busch <kbusch@kernel.org>, tglx@linutronix.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme threaded interrupt handling provides quick completions for
latency sensitive workloads, and threaded handlers for more IOPS intensive
ones. Remove the use_threaded_interrupts nvme module parameter since
leaving it disabled should not be providing a benefit.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e415fadf7331..28e08c5ab412 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -40,9 +40,6 @@
 #define NVME_MAX_KB_SZ	4096
 #define NVME_MAX_SEGS	127
 
-static int use_threaded_interrupts;
-module_param(use_threaded_interrupts, int, 0);
-
 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
@@ -1519,13 +1516,8 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
 
-	if (use_threaded_interrupts) {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-			nvme_irq_thread, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	}
+	return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
+		nvme_irq_thread, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
