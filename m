Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E78E7DF19
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 18:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7VZogWzvjKCdeoP4iPnWvDiMMcn49uqVBMiNiwwK3Y=; b=R2OtQqKj+JAnXrz8bqvyScTvWy
	4iN8QGs/JsWGigge08SMaHNgCERdLLpFqwpdmu4bR7Xf55GeJT/DTbITEuAeyNIZwzMQNEHOYgWNp
	F0qKXeqvUFQqk8f2UlgRBj8RYNB8HVWx6szVE0M/FAvRpSOQpNKOBcIY/NIPw+6z+fGfDOpflY2gd
	i9UxScXbr3MO82hhUes14POw5bR3tFD2I2yAwaRDM7zCWTGUsnwuVMvcRhBqHpr94mkCkgr75HhNI
	rXHYBKfFjHgOICj9Yg95eCNc/kSK2u8tjISFueZVwHWIVGwe0+ZWGJ+upI+0l9eSP77+qXe/W6z2d
	Oe8DeTnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmz8j-00000005Tqo-3qHD;
	Mon, 02 Feb 2026 18:59:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmz8f-00000005TqO-1Qi4
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 18:59:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 75EFA40AD5;
	Mon,  2 Feb 2026 18:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03DEC116C6;
	Mon,  2 Feb 2026 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770058746;
	bh=n212nVWRszm8R2f4cajiy7iGPWQTB5dEeMwMYA8N+dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKZpMK5UlHObYbN2bBAWGPRxyXe0wYN2O2mOq6wukb6kSAiyc4jmTQMA2jDLz37ht
	 VTILHwRw+qC3cXp8KdASUvuh1RvgNlfiL4ntWWbLtKvPVFCrPXQODhVi38t5DdiEJc
	 GmHvYlBBY6N+j/1NZyv2m2uHYt8WUx1A+sN7xNPPZSQNpJeSgYCLrqwYs8MV1e8+o9
	 cMcnnz2tSVJCmnU5VtqWx/NR4hbYRky1V0TRy3sB2F+8cvDF9CU6C3tQ1cpcrPejWp
	 eJljtsSPB2Cbbo9Qy8wm0pjon/4dctX67bLFoCbMNXVQa2Gj8M39EXNDLg8tKovicM
	 2bTxjxgX31bmw==
Date: Mon, 2 Feb 2026 11:59:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYDz-BeIHMNUMiaF@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202173624.GA32713@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_105909_584858_42DBFA96 
X-CRM114-Status: GOOD (  21.36  )
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

On Mon, Feb 02, 2026 at 06:36:24PM +0100, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2a52cf46d960..f944b747e1bd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
>  		nvme_free_descriptors(req);
>  }
>  
> +static bool nvme_pci_alloc_dma_vecs(struct request *req,
> +		struct blk_dma_iter *iter)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +
> +	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> +			GFP_ATOMIC);
> +	if (!iod->dma_vecs)
> +		return false;
> +	iod->dma_vecs[0].addr = iter->addr;
> +	iod->dma_vecs[0].len = iter->len;
> +	iod->nr_dma_vecs = 1;
> +	return true;
> +}
> +
>  static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter)
>  {
> @@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>  		return false;
>  	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> +		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
> +			return false;

In the case where this iteration caused dma_need_unmap() to toggle to
true, this is the iteration that allocates the dma_vecs, and it
initializes the first entry to this iter. But the next lines proceed to
the save this iter in the next index, so it's doubly accounted for and
will get unmapped twice in the completion.

Also, if the allocation fails, we should set iter->status to
BLK_STS_RESOURCE so the callers know why the iteration can't continue.
Otherwise, the caller will think the request is badly formed if you
return false from here without setting iter->status.

Here's my quick take. Boot tested with swiotlb enabled, but haven't
tried to test the changing dma_need_unmap() scenario.
---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fc4a60280a07..233378faab9bd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -816,6 +816,28 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
 
+static bool nvme_pci_prp_save_mapping(struct blk_dma_iter *iter,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (!iod->dma_vecs) {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
+				GFP_ATOMIC);
+		if (!iod->dma_vecs) {
+			iter->status = BLK_STS_RESOURCE;
+			return false;
+		}
+	}
+
+	iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
+	iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
+	iod->nr_dma_vecs++;
+	return true;
+}
+
 static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter)
 {
@@ -825,11 +847,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
-		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
-		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
-		iod->nr_dma_vecs++;
-	}
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
+		return nvme_pci_prp_save_mapping(iter, req);
 	return true;
 }
 
@@ -843,15 +862,9 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
-		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
-				GFP_ATOMIC);
-		if (!iod->dma_vecs)
-			return BLK_STS_RESOURCE;
-		iod->dma_vecs[0].addr = iter->addr;
-		iod->dma_vecs[0].len = iter->len;
-		iod->nr_dma_vecs = 1;
-	}
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev))
+		if (!nvme_pci_prp_save_mapping(iter, req))
+			return iter->status;
 
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
@@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->nr_descriptors = 0;
 	iod->total_len = 0;
 	iod->meta_total_len = 0;
+	iod->nr_dma_vecs = 0;
+	iod->dma_vecs = NULL;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
--

