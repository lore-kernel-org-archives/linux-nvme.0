Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1F6C71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gLJ54RFAL+fAuGAKPqxLCKl4GM04kh5LmptCkmCWdQ8=; b=fqj48xQf1rGKFL
	xgcqeVHS+lGq4yGJ1uI8NVqJbKvQKQ+oHDydWfy5yH6+jPxViHgDxRE874mko5Pz2+GSnl0oVpg3j
	6Gl+3EKffHJvuPdWZVHBnK3ii6RAbJhTn70REvj1qNnMwqgLIkS24Pizg9+fzuxUuHZtxKR+1KTfn
	ZA4vHPt9wi40xL3wBuDNYHsNwDBSBACfxD9fmISwtwwcvZZgLzwtrt2bBhKbhldssh2iHibBKqKGH
	hKipo0W2ZKWZoK9g1phmNprFnrUtKmgpCBjHEf6tJlpQKXmp+WPGGIFYgE/qhH7M9r0YDganzO4eG
	51UrS0a7BELxoFwOnDOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPkV-0000000AnG3-0RsC;
	Wed, 11 Jun 2025 18:00:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPM0f-0000000A25W-3d7W
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 14:00:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 424A649B2A;
	Wed, 11 Jun 2025 14:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAE5C4CEE3;
	Wed, 11 Jun 2025 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749650457;
	bh=/2cgRtZohrG3eN6FRl+viVw3dfVpN9tpcKWa5PFKI/I=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i1GZ3famHxEyfV4BGY3mQMDLuUOmwHP65OmvhVqZa4HUTfbuBZvKH3a/B9LcscYl2
	 Pfp+ff1Gg4UkJg5/P++m4niShm3PKqXTcng9NPwoKqwHOZ+LC/7cw5FYP0PXZKIQcw
	 +wFtDgWQzhq8Uo/8nbSxxgelZ+2g7RAN1ICG223PiKFY13GkMIJiHT1VJVhnLMAINF
	 rLzDDqMs0hxO37PVv959kFYnDSAht51AoJpRKaBhvRFhCSpuGNBR+XzPJOWXbyj54W
	 HIkxDLujt+RpGKP/shF6cd7rzgY8sxbqZqxPK81AL0yYHZfe+3K6qrw6DnFEsgcexd
	 6EcVr2VQgvYUA==
Message-ID: <dbcbf77b-e1c6-4ab0-8e0a-07ad63a74faf@kernel.org>
Date: Wed, 11 Jun 2025 16:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-9-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_070057_926685_F2FFFF40 
X-CRM114-Status: GOOD (  16.65  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Having a define in kiB units is a bit weird.  Also update the
> comment now that there is not scatterlist limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


Reviewed-by: Daniel Gomez <da.gomez@samsung.com>


> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2d3573293d0c..735f448d8db2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

...

> @@ -3363,7 +3362,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	 * over a single page.
>  	 */
>  	dev->ctrl.max_hw_sectors = min_t(u32,
> -		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
> +			NVME_MAX_BYTES >> SECTOR_SHIFT,
> +			dma_opt_mapping_size(&pdev->dev) >> 9);

We use SECTOR_SHIFT for MAX_BYTES but not for the bytes returned from
dma_opt_mapping_size(). Yes, I know this is not part of the change, but still is
the same line. I think it make sense to convert it too.

