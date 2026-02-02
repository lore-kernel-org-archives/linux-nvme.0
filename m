Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064E4E7DF13
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G1Cg7tIY4H/8uzIZI1Pf135Mc/QILQVCDdPZmqk5+0Q=; b=LQExadMKkn86P7Qlc98oU4m0Fh
	/y7AkI20dxNP44aqcTJDoMShqdUZ3LcSEu4A0g/HJoqpwWkCT6fflXggHc4e4MIo/oj4yJOgFjp5d
	FuRJgcr1Fzsm/0ADgzwJRjW9RmOFkr4CMX9t7AG1/N4YjTdAaqySLX1OKrhEnvnhXmpu+ayy89+p3
	2abEtpbwZxBOMVwYGidq2Om7zitOUkh6k41AzHRpqf1UerG4MyXTuePvoKfAVzhKVkauDkqQKnjU7
	gKKhGj5B5W86W1cDwodiaqv2yNowm3geBACcL3TkivKPO7MQL7zj9c0IeHWkrq94Cn1zGXTb2oxUu
	ezI+LXZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxqj-00000005Mji-3BwE;
	Mon, 02 Feb 2026 17:36:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxqg-00000005Mio-2hIJ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:36:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8711568B05; Mon,  2 Feb 2026 18:36:24 +0100 (CET)
Date: Mon, 2 Feb 2026 18:36:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202173624.GA32713@lst.de>
References: <20260202143548.GA19313@lst.de> <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDbNC1z81D3lZ2r@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_093630_962184_F219FFE2 
X-CRM114-Status: GOOD (  20.51  )
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

On Mon, Feb 02, 2026 at 10:13:24AM -0700, Keith Busch wrote:
> > "This function must be called after all mappings that might
> >  need to be unmapped have been performed."
> > 
> > Trying to infer anything from it beforehand is definitely a bug in the
> > caller.
> 
> Well that doesn't really make sense. No matter how many mappings the
> driver has done, there will always be more. ?

Yeah.  It's more like if this returns true, all future calls, plus
the previous one (which might have caused this).  For that something
like the patch below should work in nvme.  Totally untested as I'm
about to head away from the desk and prepare dinner.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a52cf46d960..f944b747e1bd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
 
+static bool nvme_pci_alloc_dma_vecs(struct request *req,
+		struct blk_dma_iter *iter)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
+			GFP_ATOMIC);
+	if (!iod->dma_vecs)
+		return false;
+	iod->dma_vecs[0].addr = iter->addr;
+	iod->dma_vecs[0].len = iter->len;
+	iod->nr_dma_vecs = 1;
+	return true;
+}
+
 static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter)
 {
@@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
 	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
+		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
+			return false;
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
 		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
 		iod->nr_dma_vecs++;
@@ -844,13 +862,8 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	__le64 *prp_list;
 
 	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
-		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
-				GFP_ATOMIC);
-		if (!iod->dma_vecs)
+		if (!nvme_pci_alloc_dma_vecs(req, iter))
 			return BLK_STS_RESOURCE;
-		iod->dma_vecs[0].addr = iter->addr;
-		iod->dma_vecs[0].len = iter->len;
-		iod->nr_dma_vecs = 1;
 	}
 
 	/*



