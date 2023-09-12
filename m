Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA97CA0EF2
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cCIAGD0EhSyg1g9Is9nI4Dr2kf8GMGSZY5kO3oFROQA=; b=Vnmt/VrGV7nqwjycTdF/RGqMkF
	9jM5P9a8Dv0YBWKZDc8DDvdeQ5HLFZXChM2NHB8PSG07CkM8w6ai2AmmNRF0K4L/35x6831a8+t3k
	TkPjyk5pdrZNnZhZgMcXGNDGM6giAxYY/pR1opE+RxuoViFkVPV3l/uBk4LbTDA/aARfgf2YY/Gtt
	ofRQHYEOj19DO/ZI69DQ2As/0zbqUKqATtj3u81BXK9p8G1SRcoh2FNOtk4DHFLSSAQN6RXAPuX0z
	r8xoMu0l1ho/e8aYx2r9WYz7PlVzdjpNLt49ZP1S48Gh+nRqUHC4sm5a8sS1OPbJ33QRtLwRj+yhz
	JQV55MiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5hO-003kwO-0d;
	Tue, 12 Sep 2023 15:53:10 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg5hL-003kvC-0l
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 15:53:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694533988; x=1726069988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cCIAGD0EhSyg1g9Is9nI4Dr2kf8GMGSZY5kO3oFROQA=;
  b=sw1s4/gGMNkSM8ogKXVgc799dawo1juOpCBCv/AOnAX8bjlyZr9ctWmf
   RHa7pkbxWTHEUuKS4ZXNrbLbkHfOkMb+PFaKWgfYLAf6gVQbbze+BOHP9
   RHBkGIuAzBtC1Db19wsQpS5jY4+TGNh8P8acMr2OYBBMaFVsXNunHfQVu
   w=;
X-IronPort-AV: E=Sophos;i="6.02,139,1688428800"; 
   d="scan'208";a="355873318"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:53:02 +0000
Received: from EX19D020EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 42D4A47852;
	Tue, 12 Sep 2023 15:53:00 +0000 (UTC)
Received: from EX19D028EUC001.ant.amazon.com (10.252.61.241) by
 EX19D020EUA002.ant.amazon.com (10.252.50.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 15:52:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D028EUC001.ant.amazon.com (10.252.61.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 15:52:59 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 15:52:58 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 342B720D5A; Tue, 12 Sep 2023 17:52:58 +0200 (CEST)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Pratyush Yadav <ptyadav@amazon.de>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme-pci: do not set the NUMA node of device if it has none
Date: Tue, 12 Sep 2023 17:52:49 +0200
Message-ID: <20230912155249.113009-1-ptyadav@amazon.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_085307_422898_4DCB2B59 
X-CRM114-Status: GOOD (  13.24  )
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
puts the device in node first_memory_node (say node 0). Not having a
NUMA node and being associated with node 0 are completely different
things and it makes little sense to mix the two.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---

Changes in v2:
- Re-worded the commit message.

 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..347cb5daebc3 100644
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


