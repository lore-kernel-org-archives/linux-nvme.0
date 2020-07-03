Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1FBC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD592070C
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JdjUSsGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD592070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mG55xojYdhXOsnip82PnM0REthAhideyk3L3sp9F2eo=; b=JdjUSsGh1oh+Gj0qOrHW8F9Kgl
	Jk6iE/idNRCjx+PoMIzsy5Z2Iew+JaQT5SfVN9/ZYAJ2XSE2m74a0DTaWTrlHRdlDEE7aiYUsSHMd
	Dp/R57EmfTePuuLVyljK2gAkUvyMj2v4lhU9d+ZcQ/OqSVpseqSCn/xpqwHS9RRFJk/J6keZD9Yz7
	1TmH8wFzZgoNH2xNsuPzlaXPzQsdoX0IcD2bUSbm6xSGWys0ZMPUiFpjXF/BISntqirB09cwcjwew
	RBmr1B3WCUbmMODKByM3TZl65rPzK6xz2paQJp8hzd/E0H4CwvsE2Af5xgP8hYrVPnGAT6Y4kBct5
	UWNu359g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrBlv-00071N-5A; Fri, 03 Jul 2020 02:49:51 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrBlr-0006zo-Pj
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 02:49:48 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U1XOWK8_1593744584; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U1XOWK8_1593744584) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Jul 2020 10:49:44 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 2/5] nvme-pci: Add a blank line after declarations
Date: Fri,  3 Jul 2020 10:49:21 +0800
Message-Id: <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_224948_114515_32FD2FF7 
X-CRM114-Status: UNSURE (   9.33  )
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a blank line after declarations to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a3d0c86..d0e9bbf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1019,6 +1019,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+
 	if (nvme_cqe_pending(nvmeq))
 		return IRQ_WAKE_THREAD;
 	return IRQ_NONE;
@@ -1401,6 +1402,7 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 
 	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
 		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
+
 		mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
 		q_depth = div_u64(mem_per_q, entry_size);
 
@@ -2875,6 +2877,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
 	nvme_disable_prepare_reset(dev, true);
 }
 
@@ -3005,6 +3008,7 @@ static int nvme_suspend(struct device *dev)
 static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
+
 	return nvme_disable_prepare_reset(ndev, true);
 }
 
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
