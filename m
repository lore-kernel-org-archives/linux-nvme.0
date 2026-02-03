Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A8E8306E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 09:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1GlfkZeHmhG5tF+PzbZrfjseQAg4AkR6eobCQziX6k=; b=4ePn5Sz7/hATziZaX1UyUGTGHx
	0dRwrOo1P3X3YC/bxDPylR2z8E04m9PVPmb3G/N81cuyDnUo/SY7HWo3T/7JpgZMMmt4bMyvtNTsG
	WlFBHNWAxEH4itN3KIP8r3uzbJg5OqPxwvlJnGL/MLu2tueZ1jYlWmoVUS/Yn6pS+y1yt2DynIgRX
	tvo6hMBa/yqSNZiEd2wg9cwtoBCDCwV1xpqbPojAhPfqQ0SnRUWuVd3hv+XdF+RmmS1eVnROEcXYn
	6oR81eHm1oer1w4Ay0SrsFkbmt3okuqiHzDo/FJcOzDBDi24+ueCxRjgMnYIJp/6+Y1AcPXL+Eoq9
	Xdf49uUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnCvv-00000006OvY-3OKL;
	Tue, 03 Feb 2026 09:42:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnCvu-00000006OvH-1Bjd
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 09:42:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DFE97601E6;
	Tue,  3 Feb 2026 09:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F99C116D0;
	Tue,  3 Feb 2026 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111772;
	bh=EP6hebxXuzMwDV5Ffd1p+JjJKhmCyYU4+x3pH8Oyi0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VeOS6bWySgsnmyAL2gE60kiItsBbikEW4HaTji2zdw1/yQfgGMgkN3s4CcU/ZP2O5
	 xwuf2pyCDppHMytgjapDGjrVacAEdYxkVh4fXfIdReHQ74m91JKVSJZz7AM3bB3o6t
	 /S+VNZBCDpS9Gg5w5/4dQ13xuhCVhLn+fzHF3QNtcsF/dzjlMj1QXzo3gykAqQm1sZ
	 Hx3fRQB101/mv0ubGlf18GNiqgYxchUTkNLshjQRsrKWoGC7CPjH/AYh4YpZBkUI3M
	 kcRJ05ui4Loy/Bd/AibTffqJCMo8euQlkx5dckb8u/3vvuDFsbicGP1su4Pdaw79IN
	 yskkh0rPjIlRw==
Date: Tue, 3 Feb 2026 11:42:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260203094247.GP34749@unreal>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDz-BeIHMNUMiaF@kbusch-mbp>
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

On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
> On Mon, Feb 02, 2026 at 06:36:24PM +0100, Christoph Hellwig wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 2a52cf46d960..f944b747e1bd 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
> >  		nvme_free_descriptors(req);
> >  }
> >  
> > +static bool nvme_pci_alloc_dma_vecs(struct request *req,
> > +		struct blk_dma_iter *iter)
> > +{
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> > +
> > +	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> > +			GFP_ATOMIC);
> > +	if (!iod->dma_vecs)
> > +		return false;
> > +	iod->dma_vecs[0].addr = iter->addr;
> > +	iod->dma_vecs[0].len = iter->len;
> > +	iod->nr_dma_vecs = 1;
> > +	return true;
> > +}
> > +
> >  static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
> >  		struct blk_dma_iter *iter)
> >  {
> > @@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
> >  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
> >  		return false;
> >  	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> > +		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
> > +			return false;
> 
> In the case where this iteration caused dma_need_unmap() to toggle to
> true, this is the iteration that allocates the dma_vecs, and it
> initializes the first entry to this iter. But the next lines proceed to
> the save this iter in the next index, so it's doubly accounted for and
> will get unmapped twice in the completion.
> 
> Also, if the allocation fails, we should set iter->status to
> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
> Otherwise, the caller will think the request is badly formed if you
> return false from here without setting iter->status.
> 
> Here's my quick take. Boot tested with swiotlb enabled, but haven't
> tried to test the changing dma_need_unmap() scenario.
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9fc4a60280a07..233378faab9bd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -816,6 +816,28 @@ static void nvme_unmap_data(struct request *req)
>  		nvme_free_descriptors(req);
>  }
>  
> +static bool nvme_pci_prp_save_mapping(struct blk_dma_iter *iter,
> +				      struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	if (!iod->dma_vecs) {
> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +
> +		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> +				GFP_ATOMIC);
> +		if (!iod->dma_vecs) {
> +			iter->status = BLK_STS_RESOURCE;
> +			return false;
> +		}
> +	}
> +
> +	iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> +	iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
> +	iod->nr_dma_vecs++;
> +	return true;
> +}
> +
>  static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter)
>  {
> @@ -825,11 +847,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		return true;
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>  		return false;
> -	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> -		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> -		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
> -		iod->nr_dma_vecs++;
> -	}
> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))

Can dev->dma_skip_sync be modified in parallel with this check?  
If so, dma_need_unmap() may return different results depending on the  
time at which it is invoked.

> +		return nvme_pci_prp_save_mapping(iter, req);

Thanks

