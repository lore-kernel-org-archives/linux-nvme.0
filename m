Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D46C83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTDoxFRYYkZW9YeRJHv0JdsLspPgUtnEMU6lXdK37tY=; b=wsjYHQZtEomhuPgSQFUcC0TVrG
	Uvr5V38ryqE9djoReroW+icGYPRJxbjXBoFubXQOyZ2qK1AuCjy1l44wvuiZcBnrMhaIlahYew1XR
	HSTgWoKD8JH1vkMZgz5XB7Wgt9uXg1iVoxdvVE1spmsnruZmWb7SMI3ifaKHTbdshw7y08/i3A0KS
	qSyKrAIG1Ls2rzUWgWrjPde+r1IZXzC1v+7JsJhAo+LrJk4Ljbb2gxXGSgyjAbPmcXAiriIRzO38O
	oTKNy+bTPFse8k6YuFaC5/zCj/nD/M8zwIEdhk+/OEnlmtX60ITptiWxbDYtJkdFVb24KvS1lfby3
	jhBft3kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaA3u-0000000EIxU-3GIt;
	Fri, 11 Jul 2025 09:28:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua9Bt-0000000E9i3-15Kw
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 08:33:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6642168AFE; Fri, 11 Jul 2025 10:32:52 +0200 (CEST)
Date: Fri, 11 Jul 2025 10:32:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, ben.copeland@linaro.org, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <20250711083251.GA6931@lst.de>
References: <20250707125223.3022531-1-hch@lst.de> <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_013309_434739_3BC4AEEB 
X-CRM114-Status: GOOD (  11.19  )
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

Hi Klara,

can you try the attached patch?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6af184f2b73b..ac3b90d31380 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -745,7 +745,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
 		return false;
-	if (dma_need_unmap(dma_dev)) {
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
 		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
 		iod->nr_dma_vecs++;
@@ -763,7 +763,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
-	if (dma_need_unmap(nvmeq->dev->dev)) {
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
 		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
 				GFP_ATOMIC);
 		if (!iod->dma_vecs)

