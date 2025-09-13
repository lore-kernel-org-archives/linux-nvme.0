Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF26CAC58E
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Sep 2025 06:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JPeBv02rL/ngSyFPKSj+KqcccWgbbZw1j1WGbLgG7W8=; b=2r0361wd6u9EVhUbZvN7P0amg1
	cG664Ym0tnGwZxJ2+7C8I1+nSNgUcTDr6xnycPp+cY5B2JjKIM5iSKzssAUksPxFNJLhyy1ZttyFg
	0F31Hw/P0GDOaa4c8k8tI2nADU3JRGGuYdJWStPS5K8F5bQad4is3zvTGCxAEKaZNRpzG3/Z4/ear
	gmtaTuTyRQGIUEq1JJ0O29i99f8rGtNulw0E6qO4FomXtp3Xj6wyEJH1JlXysyuczSCd9bTeg9WSC
	N5Id//Wp3an10SBW+n8HFN+ok1fhcKWuVQxpwKgfSlu1cWPr0hOSA1zNAsBouBSpe7wHdwoJ25JEh
	o7T6kpmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxK8z-0000000DcGl-2ilE;
	Sat, 13 Sep 2025 06:53:57 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxK8x-0000000DcFO-1paW
	for linux-nvme@lists.infradead.org;
	Sat, 13 Sep 2025 06:53:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757746435; x=1789282435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VkTqdbJrwBVBpdCpucIUOKa63McRFJ4DT6npGdUdG/Y=;
  b=WJ+eZIK+4i277dGs7eb2QZRC9KdkdVZIQjKgYUzvi1WDFv0HvL7bxT0+
   ePlm0iQx0eolJ0KZxAsIiWh7tudWsMiap03DBX9zhBOcn3MhGy0+6PfCf
   fVCtRQ9C7Q8DExevFDDpXgRYGGIF116jJn79/VLunRQKII0ZsCmTu4j+u
   tt9y5TfCUeuNYQJvm0M/v9a2C8+pfbHa95+HGJHYepUF2WBTyqVBFr76P
   TYHo5xUcy60UO5gJt9lsQJeoZLO1dHw+Zqk23CNnHBMTtg4tZP5bwuYd7
   Eyz6nLx98gs5o4G57HrJR66Q4ICGB4gy3hpm1QyVOXcuJftrnbz7IH3Ff
   A==;
X-CSE-ConnectionGUID: dqDaIWMYRXKs9XnMkgVIYg==
X-CSE-MsgGUID: TYyOcxOzSx+gtOrjWgZ/7A==
X-IronPort-AV: E=Sophos;i="6.18,261,1751212800"; 
   d="scan'208";a="120427542"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2025 14:53:53 +0800
IronPort-SDR: 68c51501_/cp3pVld3N4Zs6LPyUbkjFgoLrgJlY6u6/KLKciwQ+zuqKI
 RGz+6mCxgz4QUgJxB6zBRVTf2e007jQv21j/Rmw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2025 23:53:54 -0700
WDCIronportException: Internal
Received: from 5cg21741xb.ad.shared (HELO shinmob.wdc.com) ([10.224.173.246])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Sep 2025 23:53:52 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] nvmet: pci-epf: fix DMA channel debug print
Date: Sat, 13 Sep 2025 15:53:50 +0900
Message-ID: <20250913065350.160301-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_235355_531319_1F9FB216 
X-CRM114-Status: GOOD (  10.85  )
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

Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
print debug information about the DMA channels for RX and TX. However,
both calls mistakenly are made for the TX channel. Fix it by referreing
to 'nvme_epf->rx_chan' and 'nvme_epf->tx_chan' and instead of the local
variable 'chan'.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Refer to nvme_epf->dma_[rt]x_chan and do not move the dev_dbg() call

 drivers/nvme/target/pci-epf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373..4bfecb0c7ee4 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -320,12 +320,14 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
 	nvme_epf->dma_enabled = true;
 
 	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
-		dma_chan_name(chan),
-		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
+		dma_chan_name(nvme_epf->dma_rx_chan),
+		dma_get_max_seg_size(dmaengine_get_dma_device(nvme_epf->
+							      dma_rx_chan)));
 
 	dev_dbg(dev, "Using DMA TX channel %s, maximum segment size %u B\n",
-		dma_chan_name(chan),
-		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
+		dma_chan_name(nvme_epf->dma_tx_chan),
+		dma_get_max_seg_size(dmaengine_get_dma_device(nvme_epf->
+							      dma_tx_chan)));
 
 	return;
 
-- 
2.51.0


