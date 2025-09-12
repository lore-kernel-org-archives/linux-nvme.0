Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F18CAC582
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 11:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZjyoBs014BErlYfvZ+SyQ6UxgfJpx/zl4ilsxMuZ+Lc=; b=qgxZL4zhk8LkpyRhj0Y8rmg7IN
	4JtiLbtupJh2zdINk3ZzXZrXVO7SU4TCQ4mjU0ksg2v41voURvfIa74jjnZck6c8d1OdfRpS9LtaN
	4xtELfLNqs1btlSQiFTebYa5NjGvdLJL+WEZrHVPS8HO3WijmyRfBhZiLtCkvrZm53ehlIJXQt00e
	T+WoojOz94opcsjOdmeFDYpka449iqd9d9tkWbFlY8aVIWqgLRDZWrmXaj+9S+MbjqwZVwJ9Use/E
	Tivv7MgQPZLzJodvHQznsmS0b0jPDM1jzPJO+a2I0z9hP66wT0WWJmXgXBjQnHpR40Z5ttzr1cvRD
	Vu/QxsYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux1m9-00000008pLu-2p8Q;
	Fri, 12 Sep 2025 11:17:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux1m7-00000008pKS-1YnD
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 11:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757675827; x=1789211827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jeKa9razUexC5Byw6sRFwXEIDD1eY2mNaYhCtDT2YwQ=;
  b=el8JPhoRGeFBKUDGGOSWXr+UjBcDeClRrZNIasbWdlcJNmjYnm6b6d37
   JNF29Wp0McPjuAsBBnaQgAacOd+jASbg65zlW3DRVM0WAJ6lrJZQAH7aQ
   DzREcQFAjbFe+GHK36VoVZrXL+XtE5Izdp/pnunHsHD5CobIMsyQFRP8u
   4r9TfWFgasQtKAhEaMjoCrQCEWDHVOafQTHSypEat3JXuU8Gss2kHINs1
   VaPx1Owjg4dIWTOkDQee4G+85EbF+0cQaY6hAGrmxvH26jXl6/NS9Cv2l
   IMD9Vf14IPJuCU7FjWeM4uitJvHM8aDYXm1llzBfyeQb8AeK2wx4MI3/M
   A==;
X-CSE-ConnectionGUID: 5bvR1gdoSNuQYAVZLkekFQ==
X-CSE-MsgGUID: 3Wc0qLLQQymoRrYb1/ho+Q==
X-IronPort-AV: E=Sophos;i="6.18,259,1751212800"; 
   d="scan'208";a="116813162"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2025 19:17:05 +0800
IronPort-SDR: 68c40131_Tf0LVmy+DrCt9fmi/XlpiurjORX3vHDlmyX0bFLqRFYTxtv
 SJPUr7gpCb9mnEw03kfi9v0f9aSEVaer/uE7SHQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2025 04:17:05 -0700
WDCIronportException: Internal
Received: from wdap-u7myouusf5.ad.shared (HELO shinmob.wdc.com) ([10.224.173.217])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2025 04:17:04 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvmet: pci-epf: fix DMA channel debug print
Date: Fri, 12 Sep 2025 20:17:03 +0900
Message-ID: <20250912111703.676993-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_041707_433566_9353D357 
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

Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
print debug information about the DMA channels for RX and TX. However,
both calls mistakenly are made for the TX channel. Fix it so that one
call prints the RX channel as intended.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/pci-epf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373..cee3ae6f5be7 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -310,6 +310,10 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
 
 	nvme_epf->dma_rx_chan = chan;
 
+	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
+		dma_chan_name(chan),
+		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
+
 	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
 	chan = dma_request_channel(mask, nvmet_pci_epf_dma_filter, &filter);
 	if (!chan)
@@ -319,10 +323,6 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
 
 	nvme_epf->dma_enabled = true;
 
-	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
-		dma_chan_name(chan),
-		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
-
 	dev_dbg(dev, "Using DMA TX channel %s, maximum segment size %u B\n",
 		dma_chan_name(chan),
 		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
-- 
2.51.0


