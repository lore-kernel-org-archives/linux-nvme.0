Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7F6C001E0
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f3+5Ws3IvZL4KRwctyVp9MLtU2uqQxu77BXFalL2nZY=; b=jVGHswNzfjuRvR8DCKyF3ucdmF
	JHi2EKe/uqepNFsyzuYolFPsTbcC9NLPVkYZ8bmZql5Jp9cJ35FDofM3oKmeM49Yb/4AkE8ltV43k
	3f1U5HO5C2RmfGXWBnMkqBFba41AIuzy5w5Ooz3I9FsOEltg0CGfKzmFd2Ys98Dw91wXb5G7Jh35E
	Ph2bR1tOk44jcIxKdOa7LV7oDRAeXxJMc3te+NnnRjPtDOjCEAGM20GB5sHPnRDDbmm30GZMNl6P+
	yPXmjT2F6VyffcBYjz5gM965dsTnNjVoi855Kw6NHm6TidyRjPmlKmiO9gaS2N6bd4hgjQjJ2ys8z
	6Uuf2NFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOFsF-007MT4-0C;
	Tue, 25 Jul 2023 11:06:39 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOFsC-007MRb-2M
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 11:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690283197; x=1721819197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f3+5Ws3IvZL4KRwctyVp9MLtU2uqQxu77BXFalL2nZY=;
  b=nFvtCR0cFg2B5IVR8zkjpTzScvhIZvg3AZWg/IE3LufK3BJAAsysZTu8
   V4llo7tk8teUvjOuOhTaoh0HnftkdmG57tSMzha9aF7Yr743eMUMfUewR
   YnkG8ATLdUVzqHhuDtMfPbNISWAZxDs9MA8TOpOx2H16O2cTuPyTIL+3r
   s=;
X-IronPort-AV: E=Sophos;i="6.01,230,1684800000"; 
   d="scan'208";a="348734793"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 11:06:30 +0000
Received: from EX19D019EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 61984A0AD0;
	Tue, 25 Jul 2023 11:06:27 +0000 (UTC)
Received: from EX19D028EUB001.ant.amazon.com (10.252.61.99) by
 EX19D019EUA002.ant.amazon.com (10.252.50.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 11:06:26 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D028EUB001.ant.amazon.com (10.252.61.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 11:06:26 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 25 Jul 2023 11:06:26 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0142E23299; Tue, 25 Jul 2023 13:06:25 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Pratyush Yadav <ptyadav@amazon.de>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme-pci: do not set the NUMA node of device if it has none
Date: Tue, 25 Jul 2023 13:06:22 +0200
Message-ID: <20230725110622.129361-1-ptyadav@amazon.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_040637_006405_61B291AC 
X-CRM114-Status: GOOD (  13.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If a device has no NUMA node information associated with it, the driver
puts the device in node first_memory_node (say node 0). As a side
effect, this gives an indication to userspace IRQ balancing programs
that the device is in node 0 so they prefer CPUs in node 0 to handle the
IRQs associated with the queues. For example, irqbalance will only let
CPUs in node 0 handle the interrupts. This reduces random access
performance on CPUs in node 1 since the interrupt for command completion
will fire on node 0.

For example, AWS EC2's i3.16xlarge instance does not expose NUMA
information for the NVMe devices. This means all NVMe devices have
NUMA_NO_NODE by default. Without this patch, random 4k read performance
measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
both nodes get similar performance (around 315k IOPS).

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index baf69af7ea78e..f5ba2d7102eae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2916,9 +2916,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
-
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
-- 
2.40.1


