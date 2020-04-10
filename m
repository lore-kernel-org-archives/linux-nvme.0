Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62752C2BA2B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 09:57:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD1D2064A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 09:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b1e3IGFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD1D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KV2fz9pUQuan5ut3Akc1ZO9mlkD8jbF+7HPiZa5DWww=; b=b1e3IGFqam0uO3
	9SPR4I9cAfBGinDzSPqjNtmirOPY1dCpYZZyhK52MnbUIxcSkob2PiJj//H8Dtvo0maeRHmoTiEkh
	FleVJcKlZOrlNTGtRndjpHXIhf8oXUwZWz98VEzqID7XxNKXNwfoCGIUqeHayEtNWkq3P2abSL77e
	42FQ6ClxTWP710tjVAgYN2Gm55OWVJf1IJAMQO5yTuxoNu0Yc5oflkKq9b7ekP8V8jphcSuQdLcy7
	AGPizbbjPJEdlN3O9UUU6ovQtTB2uKZ70326yCqx+jUYGqaKyabyrAnX6+Rz8VXUBwGNKnIQB723V
	8xiNc4hrbVwuyGyCMXhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMqPn-0005YT-J7; Fri, 10 Apr 2020 09:57:35 +0000
Received: from mx2.didiglobal.com ([111.202.154.82] helo=bsf02.didichuxing.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMqPl-0005MW-65
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 09:57:34 +0000
X-ASG-Debug-ID: 1586512649-0e410863a0508900001-VMfPqL
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by
 bsf02.didichuxing.com with ESMTP id z8ODZacewmSbly4k;
 Fri, 10 Apr 2020 17:57:29 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Apr
 2020 17:57:29 +0800
Date: Fri, 10 Apr 2020 17:57:24 +0800
From: Weiping Zhang <zhangweiping@didiglobal.com>
To: <hch@infradead.org>, <axboe@kernel.dk>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
Subject: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
Message-ID: <20200410095719.GA4393@192.168.3.9>
X-ASG-Orig-Subj: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS06.didichuxing.com (172.20.36.207) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1586512649
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2042
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0014 1.0000 -2.0121
X-Barracuda-Spam-Score: -2.01
X-Barracuda-Spam-Status: No,
 SCORE=-2.01 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81088
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200410_025733_414331_9BAA2FBB 
X-CRM114-Status: UNSURE (   8.26  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since the commit 147b27e4bd0 "nvme-pci: allocate device queues storage space at probe"
nvme_alloc_queue will not alloc struct nvme_queue any more.
If user change write/poll_queues to larger than the number of
allocated queue in nvme_probe, nvme_alloc_queue will touch
the memory out of boundary.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e79e412b276..cc10258e578e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -89,6 +89,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
  */
 struct nvme_dev {
 	struct nvme_queue *queues;
+	int nr_allocated_queue;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
@@ -2074,6 +2075,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	unsigned long size;
 
 	nr_io_queues = max_io_queues();
+	if (nr_io_queues > dev->nr_allocated_queue - 1)
+		nr_io_queues = dev->nr_allocated_queue - 1;
 
 	/*
 	 * If tags are shared with admin queue (Apple bug), then
@@ -2742,7 +2745,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int node, result = -ENOMEM;
+	int node, nr_queue, result = -ENOMEM;
 	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
 	size_t alloc_size;
@@ -2755,11 +2758,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
+	nr_queue = max_queue_count();
+	dev->queues = kcalloc_node(nr_queue, sizeof(struct nvme_queue),
 					GFP_KERNEL, node);
 	if (!dev->queues)
 		goto free;
 
+	dev->nr_allocated_queue = nr_queue;
+
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
-- 
2.18.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
