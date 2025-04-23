Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5D1C369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=; b=TkpuShN/+084Ig1lxaUXQEZlRt
	MJZ8nYT3F5sytcn8AJNY0fsy76B1vUm+/BJ6/NLt3r8f8Sqda6RqZRSgQJwd00hrUN0ee6NvSzY8X
	w4V1dtUq66iQuml8LRfR9TCMPx3tGTLQQ2BO+vYQmxFIrA7aLXekzgu0QuStHn7j4N9bq9+prcm0s
	UMwWGoOdl01rhoDlNJ39aKHTRCfe7vc+vcz4QJnnQyt90mtSzmURWosX0euShEUKFPHALwwsbeohr
	+QbYGqfl1p4Hmb1fBjUnX4oHorUEwmwwwP0Zxc2Aj48zg4v0qpiW0V2bMq3X0KHs7iiNsPrCEeGY7
	ViKVzjDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mmz-0000000Cf6N-2JSy;
	Thu, 24 Apr 2025 02:58:13 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eXX-0000000BUR1-1tIj
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 18:09:45 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4772f48f516so14213571cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745431782; x=1746036582; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=V1uv3HQLyyZR+1dxmUCuNCHMbpUBxGORixU+hUgz799ckBU3kw9jXbdqsUyLJ/frSv
         L805t59R3NU2Y+nauaGpO4uHNZto5P1xkhOc7HxFzzyWU5Vk8Aw6MP84nGggEJsXOb2l
         rUWZnKuag3p8JMrMTg5LBmbGe1LOP6M1gpSU9oNwlrERsnEUHP4meOONHU9YXQEXx5Dc
         0y47WWdVa5+SiUteA4QRfY38OXmtgC/tLVLQW7U0CCnkhfOaaRSPS3vsw+fHebu27G7q
         5VQWj1Oz56N13q+0g3qzEejVACI8uezTz1JKjreLMdLHag1cC9pOw2X3gk3M+IxVhYcM
         BqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431782; x=1746036582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=TFBbxvSLJy+fDEQ+ppvg7SMuxq/N50PixMXbAFFGUM54V2ZLTHQX1wLCwPXPRuPpl2
         YN2QYoeu487JsnC2KPtWMz2gqT4gbME9sV6CjdkUSyPhtpIm0h+u77btAgT7YE50pnsc
         3fuhRB6mjt6ogtIiIxTucITuM1T1Kodd+V5XeGyjKjFssORkro1qN5dUGBMDfy+P6Uhf
         c+hn52d3N+O7M3JrjorG+PS0IYQOoll3jP52oQSH6psnNACYvcxTEUIVbhwDh/QRNko6
         DnRCQ7pFaK4iW9bqIClyvgK4DjjSbhrFQDMAPhfZi1I2Mn0TXYDlvU6gdYsQvXqBqfGN
         GKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJox2Z/v+G1WBxiaPWvT70xFqrGxi+Uomsx/BBqNd/4ooGGKB9tm9Ud8m7r+4p6tMSoqBlZKro4TKf@lists.infradead.org
X-Gm-Message-State: AOJu0YzMunsLAQGTPFrJCBwV2TJdsJvxcIcIjdAn0YIOHW2DIrAuIAFs
	CHix3EpJu/NgwgzpD3x9gCISut+Le7HZOC9Q824D1swCrqM/CxN/kYpUXy2G/Dg=
X-Gm-Gg: ASbGncuVA938dNCkIG93IE1FqSnusKCM9OivJOs3C3MKfDftxqWWj1T1EOu9JI2YvQ7
	L3Jb67xb6PiG/Iec01qW/DX8l1kKWvtDU8PnBNLdIlDIGIGWKNNPOD2nQqnV6Qq+S+EFWHBNk4t
	XxusuwBitGCjWoX/buN4V6GdXRpmto1mq3Nq1w6FRSea+iVop7CBayg3B7y6xhGRgVFAVEOKOVi
	/+79TaR4L3U9yWoYClsZEE4+o2pi5g8g6sPAOsRXWcEu6g4wMxpqeIHo475bOACrla3tRR+Iskb
	Pqjap7L+9P4v4ksLk9lcOrene7MZHkGdWSH2jI/ECbezlc3Kw6w+4isfEdmF+GfKpNMK0gummYN
	amAmkRtqo0HOI4G8J25M=
X-Google-Smtp-Source: AGHT+IH4xfxeCQIatfvhUgdAx8fM2pKJgYvLzginEQw7PV9Sr3aShEQ97+Q+stgMKvhEecV5S0qx4w==
X-Received: by 2002:a05:622a:248d:b0:477:84f5:a0b with SMTP id d75a77b69052e-47e780b3d65mr2842901cf.2.1745431782337;
        Wed, 23 Apr 2025 11:09:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b485sm71764181cf.27.2025.04.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:09:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eXV-00000007LuW-1WeA;
	Wed, 23 Apr 2025 15:09:41 -0300
Date: Wed, 23 Apr 2025 15:09:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 17/24] vfio/mlx5: Enable the DMA link API
Message-ID: <20250423180941.GS1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_110943_496277_BEB4BE05 
X-CRM114-Status: GOOD (  21.01  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 19:58:12 -0700
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

On Wed, Apr 23, 2025 at 11:13:08AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Remove intermediate scatter-gather table completely and
> enable new DMA link API.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 298 ++++++++++++++++-------------------
>  drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
>  drivers/vfio/pci/mlx5/main.c |  31 ----
>  3 files changed, 147 insertions(+), 203 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
> +			      struct page **page_list, u32 *mkey_in,
> +			      struct dma_iova_state *state,
> +			      enum dma_data_direction dir)
> +{
> +	dma_addr_t addr;
> +	size_t mapped = 0;
> +	__be64 *mtt;
> +	int i, err;
>  
> -	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
> +	WARN_ON_ONCE(dir == DMA_NONE);
> +
> +	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
> +
> +	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
> +		addr = state->addr;
> +		for (i = 0; i < npages; i++) {
> +			err = dma_iova_link(mdev->device, state,
> +					    page_to_phys(page_list[i]), mapped,
> +					    PAGE_SIZE, dir, 0);
> +			if (err)
> +				goto error;
> +			*mtt++ = cpu_to_be64(addr);
> +			addr += PAGE_SIZE;
> +			mapped += PAGE_SIZE;
> +		}

This is an area I'd like to see improvement on as a follow up.

Given we know we are allocating contiguous IOVA we should be able to
request a certain alignment so we can know that it can be put into the
mkey as single mtt. That would eliminate the double translation cost in
the HW.

The RDMA mkey builder is able to do this from the scatterlist but the
logic to do that was too complex to copy into vfio. This is close to
being simple enough, just the alignment is the only problem.

Jason

