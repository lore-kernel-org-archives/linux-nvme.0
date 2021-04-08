Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F3C43461
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 17:02:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EC1610A2
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 17:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EC1610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7w2u925AlFG0Q7M4TBUBHeM/hmQJlyujQmgxMJ6L2F4=; b=S1D4gyBcKJ7bPz
	/4o/vRrmR2bgNrTbIxLnFVAbwEMJZDhgK89yvLMFqu+AihfRqExyoUzzR5Krqlu9hX4t4uQJwwwrQ
	LpDQLU563MZhCAJq9aI8qGPxnmgRQJr7UbQqEO2U5uuZkYLS3HH9S2tuBx2HRG+nQ60odE6EZYYUX
	8xeECB1oClYU21kcl+9eNudpDqI+EAYK9264MqTLctn2G97V9xOiibKb8r8YhMgioxxq0dJX/molZ
	hU7djB1av+zNlbipIYN3vK4gFE7RG86etQGPmUXLxOC1EcBB79U2Cwu9/hMwhKRfoRPSArZAXbJTH
	SGXSDey1FZoPUHTvvLoQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUY2G-008igC-6z; Thu, 08 Apr 2021 17:01:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUY2B-008icv-AN
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 17:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=iSq2Wla16I0EwxIW4Pg1yf1bMgKpM0FYpfWiFtNqs7w=; b=rR8DAPvX19UEk5/HXMkfdOt7Uq
 JZZUtTjQdQLiA6ZsARzAVhUd/qyWJ+1ueNIw8BEjht46pmkpRGlprqdehWnTom6lrM06RYrYFDERj
 04fvSttGiBCnQMyfHxxIy6UWaowAWO4qEgQa7mOAV+S9Z7Bn0iU8MZKsqr56pxtAqxEB9xt6nIeIY
 kuKrq+iiQHSxhwO4dZ4pG32QX9+aMgfsiG+b3m0FyIfrp6ms2+txCbAYtqIoSuMAiaXDIsyTgiabv
 T707gBge1je59IJJJIAgVxKW987sBi++rH3N8rq8Kw94HBel2wQpUVzHLAMt1IRBowOqnYKnTxhJd
 KEWsWn+A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY26-0002Ln-Kj; Thu, 08 Apr 2021 11:01:31 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY25-0002Iu-Ee; Thu, 08 Apr 2021 11:01:29 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  8 Apr 2021 11:01:11 -0600
Message-Id: <20210408170123.8788-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_180135_776056_B2482539 
X-CRM114-Status: GOOD (  14.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
struct device (of the client doing the DMA transfer). Thus move the
conversion to struct pci_devs for the provider and client into this
function.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2574a062a255..bcb1a6d6119d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -822,14 +822,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
-						    struct pci_dev *client)
+static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+						    struct device *dev)
 {
+	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
 	enum pci_p2pdma_map_type ret;
+	struct pci_dev *client;
 
 	if (!provider->p2pdma)
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 
+	if (!dev_is_pci(dev))
+		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+
+	client = to_pci_dev(dev);
+
 	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
 				  map_types_idx(client)));
 	if (ret != PCI_P2PDMA_MAP_UNKNOWN)
@@ -871,14 +878,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap =
 		to_p2p_pgmap(sg_page(sg)->pgmap);
-	struct pci_dev *client;
-
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return 0;
 
-	client = to_pci_dev(dev);
-
-	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
 	case PCI_P2PDMA_MAP_BUS_ADDR:
@@ -901,17 +902,9 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	struct pci_p2pdma_pagemap *p2p_pgmap =
-		to_p2p_pgmap(sg_page(sg)->pgmap);
 	enum pci_p2pdma_map_type map_type;
-	struct pci_dev *client;
-
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return;
-
-	client = to_pci_dev(dev);
 
-	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
+	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
 		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
