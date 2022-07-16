Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0900C43334
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jul 2022 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YLMrBMak9diEtG2Iokg1H+xhhQF8JxdDrp1+rpOZqow=; b=DHBMhon4KfF2/NQ1r0ks7zQbhA
	EY+0XblJuNhfBVtYZXA8eav1R5faw2UpMKodkujuQMPJhT2MwJUpd5Dxvwvc5QaLia65/hn/pluko
	Kd28mkWiLEncOGXuGM0vTuTiiL7kxxzpPEG2pJJoAg234Nds2XotLDuVRxNfV9hTbbbAGj/PNzDD/
	OD8vOXIoTEXUmJeJChVVi216yBfDnM10XBvNhJaEz5qzMUiurYE6c3ngLJkrTp/4Q1KFwvS65eZvz
	ES3fX/2yVjgpsGt8vf64mq+FfipQ1kuWsVQ9UiCDorGarFasL3JInh+k85A+sGKmEOvR8e4lgoMzz
	3pYyzdXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCgJN-00FqMF-Ig; Sat, 16 Jul 2022 11:50:17 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCgJK-00FqJL-3U
	for linux-nvme@lists.infradead.org; Sat, 16 Jul 2022 11:50:16 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJUDiDf_1657972181;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VJUDiDf_1657972181)
          by smtp.aliyun-inc.com;
          Sat, 16 Jul 2022 19:50:06 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: remove useless assignment in nvme_pci_setup_prps
Date: Sat, 16 Jul 2022 19:49:41 +0800
Message-Id: <1657972181-72398-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220716_045014_353036_C3A65125 
X-CRM114-Status: UNSURE (   7.01  )
X-CRM114-Notice: Please train this message.
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

From: Liu Song <liusong@linux.alibaba.com>

If prp_list is NULL, nvme_unmap_sg will be performed, and the assignment
to first_dma is meaningless, so remove it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 193b447..3872e33 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -670,7 +670,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 
 	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
-		iod->first_dma = dma_addr;
 		iod->npages = -1;
 		return BLK_STS_RESOURCE;
 	}
-- 
1.8.3.1


