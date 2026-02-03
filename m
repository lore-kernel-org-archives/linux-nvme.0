Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957FFE83052
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFJiMK2yninrUK3zeL6bEIsAtLo3Xl48E97RFmzuFMs=; b=rOjiuaHqmf6mLv6MmaeBXS0tkI
	7MqOFr9oD4+Ks4Qq7puaudkH3n2YI1tF96Phzd6wSc35g62u8H1nsTD9AzzQ4J91Z3/NI3zCgISnR
	iy46mz4E/xbOdKy7SiHhSxQhuPi4SwPvAhuUrTaaj8B3ekMe7YabeQ1YGmmlhwtkpd8sw7YvOqWQ4
	Z8Rp+qK1gcc0GzdVSvABfggBp5OaMvvEe01hqXAVO+U+XgeP9y8PhUdVPnI7Ilu7najvlOKNiEHVm
	KvVgIWA28Ieo8BhCmXvmIZD7oyYqVyI/tVeRJwoMrCA3gKZtWhtdTP9fgKhorPzbU4jbZ+IHW+APX
	9ft8PJqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8xJ-000000066M3-44zG;
	Tue, 03 Feb 2026 05:28:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8xG-000000066LP-2RuU
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:28:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 274B568AFE; Tue,  3 Feb 2026 06:27:57 +0100 (CET)
Date: Tue, 3 Feb 2026 06:27:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260203052756.GA15839@lst.de>
References: <20260202143548.GA19313@lst.de> <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp> <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDz-BeIHMNUMiaF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_212802_799040_942EEEA7 
X-CRM114-Status: GOOD (  20.41  )
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
> In the case where this iteration caused dma_need_unmap() to toggle to
> true, this is the iteration that allocates the dma_vecs, and it
> initializes the first entry to this iter. But the next lines proceed to
> the save this iter in the next index, so it's doubly accounted for and
> will get unmapped twice in the completion.

Yeah.

> Also, if the allocation fails, we should set iter->status to
> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
> Otherwise, the caller will think the request is badly formed if you
> return false from here without setting iter->status.
> 
> Here's my quick take. Boot tested with swiotlb enabled, but haven't
> tried to test the changing dma_need_unmap() scenario.

Looks much better.  Cosmetic nits below.

Pradeep, can you test this with your setup?

> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
> +		return nvme_pci_prp_save_mapping(iter, req);

> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev))
> +		if (!nvme_pci_prp_save_mapping(iter, req))
> +			return iter->status;

I'd move the dma_use_iova / dma_need_unmap checks into
nvme_pci_prp_save_mapping to simplify this a bit more.

>  
>  	/*
>  	 * PRP1 always points to the start of the DMA transfers.
> @@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
>  	iod->nr_descriptors = 0;
>  	iod->total_len = 0;
>  	iod->meta_total_len = 0;
> +	iod->nr_dma_vecs = 0;
> +	iod->dma_vecs = NULL;

I don't think we need the dma_vecs initialization here, as everything
is keyed off nr_dma_vecs.

