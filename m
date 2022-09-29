Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE12EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SA5Zv3CFmymWcqoF3kgJhVL3n30g1TRkOiD3YxTlFFM=; b=hSL6dhJc4h9DW/SoS9+MME5I5g
	tAd+lrNTL+xUztSG0cXOHGpr11XR1NRp2RQeO+EFX0OM8dn21h6eLz+R5rY29O0dadxqTXJ/y5yA6
	yKx2yaycrCsA36lWK/H6bmQN9JgxcKXWt7/lX+3nEvTTpaNmRyDk/qc1Xt63HHRC/1lzmeWbPUi/G
	D8NAgBEkvZm+npLnVQclJmDq1jV2k09OBm+R56hCjRW/j4/4AQWeShPA9wpmBkvIrzCHUh9o8OvnS
	1tqpz4+/uSQ/ev2abgONvxYw8k+rS2gElGOU14R2vpfB27Et6L2NIPLvfP5ueNZSXaviWMMnH2imZ
	Uzzyj7fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyC0-004twU-Cl; Thu, 29 Sep 2022 18:23:28 +0000
Received: from smtp-fw-9103.amazon.com ([207.171.188.200])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyBs-004ttd-A6
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 18:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1664475800; x=1696011800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SA5Zv3CFmymWcqoF3kgJhVL3n30g1TRkOiD3YxTlFFM=;
  b=BsCPzFtw2x0IychwdVkwkBRuTNYjWux1jp+Pt1ETdCMfLz6o0myP1roV
   bwzyJO4l6hlbjZvF0UER0koI+OarHSW+eWQAlrtPVV3L0fBTI37oLjAjv
   HHkQfWBwTIwWhgdcEm+gB/4gMrIrtrN7NeBx2qcCFmG/fqi1y9PMpwvbR
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,356,1654560000"; 
   d="scan'208";a="1059364674"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 18:23:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 2457281255;
	Thu, 29 Sep 2022 18:23:12 +0000 (UTC)
Received: from EX19D012UWB001.ant.amazon.com (10.13.138.50) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 29 Sep 2022 18:23:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D012UWB001.ant.amazon.com (10.13.138.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Thu, 29 Sep 2022 18:23:11 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 29 Sep 2022 18:23:10
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
	id 98CF927B3; Thu, 29 Sep 2022 18:23:09 +0000 (UTC)
From: Rishabh Bhatnagar <risbhat@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<stable@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>, <kbusch@kernel.org>,
	<mbacco@amazon.com>, <benh@amazon.com>, <sjpark@amazon.com>, "Rishabh
 Bhatnagar" <risbhat@amazon.com>
Subject: [PATCH v2] nvme-pci: Set min align mask before calculating max_hw_sectors
Date: Thu, 29 Sep 2022 18:22:59 +0000
Message-ID: <20220929182259.22523-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_112320_435929_08D4BBE7 
X-CRM114-Status: GOOD (  12.86  )
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

In cases where swiotlb is enabled dma_max_mapping_size takes into
account the min align mask for the device. Right now the mask is
set after the max hw sectors are calculated which might result in
a request size that overflows the swiotlb buffer.
Set the min align mask for nvme driver before calling
dma_max_mapping_size while calculating max hw sectors.

Fixes: 7637de311bd2 ("nvme-pci: limit max_hw_sectors based on the DMA max mapping size")
Cc: stable@vger.kernel.org
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 Changes in V2:
 - Add Cc: <stable@vger.kernel.org> tag
 - Improve the commit text
 - Add patch version

 Changes in V1:
 - Add fixes tag

 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..30e71e41a0a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2834,6 +2834,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_start_admin_queue(&dev->ctrl);
 	}
 
+	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+
 	/*
 	 * Limit the max command size to prevent iod->sg allocations going
 	 * over a single page.
@@ -2846,7 +2848,6 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Don't limit the IOMMU merged segment size.
 	 */
 	dma_set_max_seg_size(dev->dev, 0xffffffff);
-	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
 
 	mutex_unlock(&dev->shutdown_lock);
 
-- 
2.37.1


