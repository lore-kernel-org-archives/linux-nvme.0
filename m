Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AFFC369CF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xnYUnjlPLMuKhibM+7cC9sCIRKgMq6xtZ4OhCazpOY=; b=XFmypOzg1Yt39nJeqDRzuk+3ib
	FCdg3hMc/mSXBVX03HG2g7wZek13CJnPYMSJp+uaPWGzl6nva7rtd3w5KQFDGcdj41v0Xdvv16gSK
	ZwIskW2ggBcGwCphi8/Tc/rssr/P1nMKyRyxKCXtF2CBUR7Lczf5BGKEF4RusTAjgfNMd2ipNUHWY
	j9tSLAfVcHx6OTIvAljR9W591Y8GR8e0CFzqfBVtyMU9tJc/YgUQCPw2iuXh8phqVRxAc0/YI1Hup
	MT78p0AclGHldyLZfgUPCa9P20mnPfTTR0FPqdXyV5lUgpnzXTxRBF+y/5QHsN6F797rXG/P7f2G2
	Z3Y/5OzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ooS-0000000H1F5-3IFd;
	Fri, 18 Apr 2025 16:43:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ggQ-0000000FYxR-0J9U
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 08:02:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7563DA4B31F;
	Fri, 18 Apr 2025 07:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3F4C4CEE2;
	Fri, 18 Apr 2025 08:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744963364;
	bh=dp/a0KQW6s1HUowZp3pVpovc87ZhWIisQB2UIJrvz9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AfNjpKOb21ywlYC/OrmRmyZovar5QMJh+pzsXdQLXpgfvDc8s2FeKsSSmY9uXRTYw
	 7wueHQYcigWmtPF+uctGlYB6aqVtEHv+CpGDOHl1li5M44Rc5SMCIoY6/r9MejZdQH
	 YfSW7LPrPI/uKn3wu+W+GH0hzdb2JPLJEoABq2IVJ2AT4uHQc0IkJaUk/JTNFeZucb
	 KZbcgbbNjw/HEo4kl9nYCTZuLh5jAH55WgCZcGrxraZ5NX/CyK0uoSq8QRicV6VWFF
	 2omjCGL8y8CFmi6A3Nbm1MMks5Iz1Jz1pZsFO4W6VoN007BeBsG1aNaiETWWvXDioq
	 cwUe4iTyuUaEg==
Message-ID: <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
Date: Fri, 18 Apr 2025 17:02:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Leon Romanovsky <leonro@nvidia.com>
References: <cover.1744825142.git.leon@kernel.org>
 <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_010246_261527_46A6C3C9 
X-CRM114-Status: GOOD (  26.94  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

On 4/18/25 15:47, Leon Romanovsky wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> blk_rq_dma_map API is costly for single-segment requests.
> Avoid using it and map the bio_vec directly.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/nvme/host/pci.c | 65 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8d99a8f871ea..cf020de82962 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -216,6 +216,11 @@ struct nvme_queue {
>  	struct completion delete_done;
>  };
>  
> +enum {
> +	IOD_LARGE_DESCRIPTORS = 1, /* uses the full page sized descriptor pool */
> +	IOD_SINGLE_SEGMENT = 2, /* single segment dma mapping */
> +};
> +
>  /*
>   * The nvme_iod describes the data in an I/O.
>   */
> @@ -224,7 +229,7 @@ struct nvme_iod {
>  	struct nvme_command cmd;
>  	bool aborted;
>  	u8 nr_descriptors;	/* # of PRP/SGL descriptors */
> -	bool large_descriptors;	/* uses the full page sized descriptor pool */
> +	unsigned int flags;
>  	unsigned int total_len; /* length of the entire transfer */
>  	unsigned int total_meta_len; /* length of the entire metadata transfer */
>  	dma_addr_t meta_dma;
> @@ -529,7 +534,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
>  static inline struct dma_pool *nvme_dma_pool(struct nvme_dev *dev,
>  		struct nvme_iod *iod)
>  {
> -	if (iod->large_descriptors)
> +	if (iod->flags & IOD_LARGE_DESCRIPTORS)
>  		return dev->prp_page_pool;
>  	return dev->prp_small_pool;
>  }
> @@ -630,6 +635,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>  static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	unsigned int nr_segments = blk_rq_nr_phys_segments(req);
> +	dma_addr_t dma_addr;
> +
> +	if (nr_segments == 1 && (iod->flags & IOD_SINGLE_SEGMENT)) {

nvme_pci_setup_prps() calls nvme_try_setup_prp_simple() which sets
IOD_SINGLE_SEGMENT if and only if the req has a single phys segment. So why do
you need to count the segments again here ? Looking at the flag only should be
enough, no ?

> +		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
> +		dma_unmap_page(dev->dev, dma_addr, iod->total_len,
> +				rq_dma_dir(req));
> +		return;
> +	}
>  
>  	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_state, iod->total_len)) {
>  		if (iod->cmd.common.flags & NVME_CMD_SGL_METABUF)
> @@ -642,6 +656,41 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>  		nvme_free_descriptors(dev, req);
>  }
>  
> +static bool nvme_try_setup_prp_simple(struct nvme_dev *dev, struct request *req,
> +				      struct nvme_rw_command *cmnd,
> +				      struct blk_dma_iter *iter)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct bio_vec bv = req_bvec(req);
> +	unsigned int first_prp_len;
> +
> +	if (is_pci_p2pdma_page(bv.bv_page))
> +		return false;
> +	if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) + bv.bv_len >
> +	    NVME_CTRL_PAGE_SIZE * 2)
> +		return false;
> +
> +	iter->addr = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
> +	if (dma_mapping_error(dev->dev, iter->addr)) {
> +		iter->status = BLK_STS_RESOURCE;
> +		goto out;
> +	}
> +	iod->total_len = bv.bv_len;
> +	cmnd->dptr.prp1 = cpu_to_le64(iter->addr);
> +
> +	first_prp_len = NVME_CTRL_PAGE_SIZE -
> +			(bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1));
> +	if (bv.bv_len > first_prp_len)
> +		cmnd->dptr.prp2 = cpu_to_le64(iter->addr + first_prp_len);
> +	else
> +		cmnd->dptr.prp2 = 0;
> +
> +	iter->status = BLK_STS_OK;
> +	iod->flags |= IOD_SINGLE_SEGMENT;
> +out:
> +	return true;
> +}
> +
>  static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>  					struct request *req)
>  {
> @@ -652,6 +701,12 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>  	dma_addr_t prp1_dma, prp2_dma = 0;
>  	unsigned int prp_len, i;
>  	__le64 *prp_list;
> +	unsigned int nr_segments = blk_rq_nr_phys_segments(req);
> +
> +	if (nr_segments == 1) {
> +		if (nvme_try_setup_prp_simple(dev, req, cmnd, &iter))
> +			return iter.status;
> +	}
>  
>  	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
>  		return iter.status;
> @@ -693,7 +748,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>  
>  	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) >
>  	    NVME_SMALL_DESCRIPTOR_SIZE / sizeof(__le64))
> -		iod->large_descriptors = true;
> +		iod->flags |= IOD_LARGE_DESCRIPTORS;
>  
>  	prp_list = dma_pool_alloc(nvme_dma_pool(dev, iod), GFP_ATOMIC,
>  			&prp2_dma);
> @@ -808,7 +863,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
>  	}
>  
>  	if (entries > NVME_SMALL_DESCRIPTOR_SIZE / sizeof(*sg_list))
> -		iod->large_descriptors = true;
> +		iod->flags |= IOD_LARGE_DESCRIPTORS;
>  
>  	sg_list = dma_pool_alloc(nvme_dma_pool(dev, iod), GFP_ATOMIC, &sgl_dma);
>  	if (!sg_list)
> @@ -932,7 +987,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  
>  	iod->aborted = false;
>  	iod->nr_descriptors = 0;
> -	iod->large_descriptors = false;
> +	iod->flags = 0;
>  	iod->total_len = 0;
>  	iod->total_meta_len = 0;
>  


-- 
Damien Le Moal
Western Digital Research

