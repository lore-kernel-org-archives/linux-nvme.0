Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F9C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRo7GGlkJBdyP1GPGTDC4VOBQi5lYgQ5JIjo8+mX9RE=; b=NNjvP8ug7Wf62ahTdVKwiq09b8
	/hvkIXRzWUOFidcDe/uz3Bw+8k/Gp6cLoOM0s51WKf7UDeemH235SIMls8KBaRq6gbDZzjwmvIHXW
	jDFfDpePjfufNFIIEihwd1SBes1uI9pSVl29BR9+Nq5VwfBrqz46yDiM2qlYmcf4miIkoOMWW6dWS
	JvDjQfPY6GuauFLfWbCJwIXcWlRNCaxzhCBgZKxgr6DoUUl3Fadt9bqEt8BbcUNpNi4HXR7i74kLl
	mnzh/BKpEQ5y1qD+Jx/hXkRDPYoLoBqqTT9idzlmCHdn8ZC/O6c5GdjmP26guIZz005PwgqMv4kHI
	iR9l4RyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRRsh-00DHXX-PK; Mon, 13 Feb 2023 06:00:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRRsa-00DHW9-AM
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 05:59:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF98068BFE; Mon, 13 Feb 2023 06:59:45 +0100 (CET)
Date: Mon, 13 Feb 2023 06:59:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: max_hw_sectors error caused by recent NVMe driver commit
Message-ID: <20230213055945.GA13648@lst.de>
References: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_215956_544845_5CC35B14 
X-CRM114-Status: GOOD (  15.04  )
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

Hi Michael,

does this fix the problem for you?

commit 0467e96bafd2e84b67ba5c122bbbbac5e3f267e9
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Feb 13 06:58:33 2023 +0100

    nvme dma_mask

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407ccf..cb068f92bd597e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,18 +2509,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int dma_address_bits = 64;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
 
 	pci_set_master(pdev);
 
-	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
-		dma_address_bits = 48;
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(dma_address_bits)))
-		goto disable;
-
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
 		result = -ENODEV;
 		goto disable;
@@ -2998,7 +2992,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 			     quirks);
 	if (ret)
 		goto out_put_device;
-	
+
+	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
+		dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(48));
+	else
+		dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64));
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 

