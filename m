Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E5C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e5iFuezd9EwC5nzUcR7QkonorsFzawfkU1PKWLkLgfQ=; b=HguzSS2ktwn7DePL7EVTmo3puR
	Gq1tLAHFKIK0saXRo0MCcQxgHYhglgMuphZK/gv/1xtOhvrZLPdtt0OyTT/SdTSJZ24SaKjpdLGlp
	V0UTu1H3DreV/Nu1rxKhnJWFHim36qO9kh0gm1H6Ks0vmcclUzFMvP6Qwu8UyjKl/k+JkSAyDYbtx
	P4vydKxh7aLPcl2oXXZTf938bdnZfoFoebG7RtDqu27I7ThBa95Er9m3Z4ncuhcUJvorBnKTePu33
	J6ohUVADRd6SU3AiA20QGepz8WesZFLJNBcNWaAr/iLjfP19BcWy/pG4Z2OaLMEHZFHY1A/xoonKh
	WxK6RuRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEJa-00Bxbl-9x; Tue, 27 Sep 2022 17:24:14 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odEJX-00BxZO-0J
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 17:24:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1664299451; x=1695835451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e5iFuezd9EwC5nzUcR7QkonorsFzawfkU1PKWLkLgfQ=;
  b=X4C0/bxPJQ5jSJicfzSucgNzfCSqP2rB0IXIOO64/rfJmbhaTXYm+Z4G
   LQY7aUfg2pM26hGCbw2oVHyjF9SB41fhZJUcWqPk6z0OqymSS1EQ/60UU
   LaZz1mWhr4O16QwQ7wuepWtBU+tZJR71RHGUQ2q2kl/NpGRWjClai3jFQ
   U=;
X-IronPort-AV: E=Sophos;i="5.93,350,1654560000"; 
   d="scan'208";a="228990471"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-4213ea4c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 17:24:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-4213ea4c.us-west-2.amazon.com (Postfix) with ESMTPS id 757A08143E;
	Tue, 27 Sep 2022 17:24:05 +0000 (UTC)
Received: from EX19D021UWA004.ant.amazon.com (10.13.139.67) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 27 Sep 2022 17:24:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D021UWA004.ant.amazon.com (10.13.139.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Tue, 27 Sep 2022 17:24:05 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Tue, 27 Sep 2022 17:24:05
 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
	id EBD5C26F8; Tue, 27 Sep 2022 17:24:04 +0000 (UTC)
From: Rishabh Bhatnagar <risbhat@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>, <kbusch@kernel.org>,
	<mbacco@amazon.com>, <benh@amazon.com>, Rishabh Bhatnagar
	<risbhat@amazon.com>
Subject: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Date: Tue, 27 Sep 2022 17:23:54 +0000
Message-ID: <20220927172354.18283-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_102411_102875_ABDE85C9 
X-CRM114-Status: GOOD (  10.84  )
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

If swiotlb is force enabled dma_max_mapping_size ends up calling
swiotlb_max_mapping_size which takes into account the min align
mask for the device.
Set the min align mask for nvme driver before calling
dma_max_mapping_size while calculating max hw sectors.

Fixes: 7637de311bd2 ("nvme-pci: limit max_hw_sectors based on the DMA max
mapping size")
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
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


