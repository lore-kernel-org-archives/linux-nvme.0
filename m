Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA38AE677EC
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Nov 2024 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zkq8x4dmz9yfUFHPf0EELUUQUn7E8nglf4dRQUS+EMY=; b=p6S6U3/LBDS90Qj//VrNnxf9qh
	tGICYC87MV7mgzZVSm6dSNgP+9ql+fZTpV3SVrTIqtE/Db23t1M4DNjj6sw4yca1XFYloKVZLl13/
	PMUkuZAWx2pQhbAvxxtOhawZ1rWl692UZs9ZanXqGwnJnRaelMuKocD5WNdGgq1GBt3JVYcy3f59Y
	fTdwc5Ur4M4wkshyMi+z6eTpwvqfSqWTtVzXYCgYf8IBej/5i55m4SSfrF/c2SrS9YrAjDpfYlbuY
	4i+kqx8pd+ppYfEsZDGF/5HVtayUMzwpr5WjswMoSUrxGA1aQAJwC8DKuvo37Jl7+uhqOFE9htJws
	gZTsQmKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t78jf-00000009ErV-3NCQ;
	Sat, 02 Nov 2024 07:39:51 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t78jb-00000009EqN-3WK3
	for linux-nvme@lists.infradead.org;
	Sat, 02 Nov 2024 07:39:49 +0000
Message-ID: <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730533181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zkq8x4dmz9yfUFHPf0EELUUQUn7E8nglf4dRQUS+EMY=;
	b=Vo9PwtDerSGdplleUNX0Y/p+JDHIf70BdVvazCyN6y7vBeSmJN/2zQyKwdwVLMDJ75gcUi
	p2dyDGNKJmn61rctVMXgRmkGSEuGDVdgsPLZmNxceQZmMQrgLWD8jMvyZRZxdxYdGOxMmE
	AmgT0wss4pgZ2ZNAb8fYVAZQLqSC69g=
Date: Sat, 2 Nov 2024 08:39:35 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730037261.git.leon@kernel.org>
 <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_003948_039429_315157AE 
X-CRM114-Status: GOOD (  33.70  )
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

在 2024/10/27 15:21, Leon Romanovsky 写道:
> From: Christoph Hellwig <hch@lst.de>
> 
> To get out of the dma mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the dma mapping path, and only for already
> marked bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   block/bio.c               | 36 +++++++++++++++++++++++++++++-------
>   block/blk-map.c           | 32 ++++++++++++++++++++++++--------
>   include/linux/blk_types.h |  2 ++
>   3 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 2d3bc8bfb071..943a6d78cb3e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -928,8 +928,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
>   		return false;
>   	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
>   		return false;
> -	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> -		return false;
>   
>   	*same_page = ((vec_end_addr & PAGE_MASK) == ((page_addr + off) &
>   		     PAGE_MASK));
> @@ -993,6 +991,14 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   	if (bio->bi_vcnt > 0) {
>   		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>   
> +		/*
> +		 * When doing ZONE_DEVICE-based P2P transfers, all pages in a
> +		 * bio must be P2P pages from the same device.
> +		 */
> +		if ((bio->bi_opf & REQ_P2PDMA) &&
> +		    !zone_device_pages_have_same_pgmap(bv->bv_page, page))
> +			return 0;
> +
>   		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
>   				same_page)) {
>   			bio->bi_iter.bi_size += len;
> @@ -1009,6 +1015,9 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   		 */
>   		if (bvec_gap_to_prev(&q->limits, bv, offset))
>   			return 0;
> +	} else {
> +		if (is_pci_p2pdma_page(page))
> +			bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
>   	}
>   
>   	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
> @@ -1133,11 +1142,24 @@ static int bio_add_page_int(struct bio *bio, struct page *page,
>   	if (bio->bi_iter.bi_size > UINT_MAX - len)
>   		return 0;
>   
> -	if (bio->bi_vcnt > 0 &&
> -	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
> -				page, len, offset, same_page)) {
> -		bio->bi_iter.bi_size += len;
> -		return len;
> +	if (bio->bi_vcnt > 0) {
> +		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +
> +		/*
> +		 * When doing ZONE_DEVICE-based P2P transfers, all pages in a
> +		 * bio must be P2P pages from the same device.
> +		 */
> +		if ((bio->bi_opf & REQ_P2PDMA) &&
> +		    !zone_device_pages_have_same_pgmap(bv->bv_page, page))
> +			return 0;
> +
> +		if (bvec_try_merge_page(bv, page, len, offset, same_page)) {
> +			bio->bi_iter.bi_size += len;
> +			return len;
> +		}
> +	} else {
> +		if (is_pci_p2pdma_page(page))
> +			bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
>   	}
>   
>   	if (bio->bi_vcnt >= bio->bi_max_vecs)
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 0e1167b23934..03192b1ca6ea 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -568,6 +568,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
>   	const struct queue_limits *lim = &q->limits;
>   	unsigned int nsegs = 0, bytes = 0;
>   	struct bio *bio;
> +	int error;
>   	size_t i;
>   
>   	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
> @@ -588,15 +589,30 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
>   	for (i = 0; i < nr_segs; i++) {
>   		struct bio_vec *bv = &bvecs[i];
>   
> -		/*
> -		 * If the queue doesn't support SG gaps and adding this
> -		 * offset would create a gap, fallback to copy.
> -		 */
> -		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
> -			blk_mq_map_bio_put(bio);
> -			return -EREMOTEIO;
> +		error = -EREMOTEIO;
> +		if (bvprvp) {
> +			/*
> +			 * If the queue doesn't support SG gaps and adding this
> +			 * offset would create a gap, fallback to copy.
> +			 */
> +			if (bvec_gap_to_prev(lim, bvprvp, bv->bv_offset))
> +				goto put_bio;
> +
> +			/*
> +			 * When doing ZONE_DEVICE-based P2P transfers, all pages
> +			 * in a bio must be P2P pages, and from the same device.
> +			 */
> +			if ((bio->bi_opf & REQ_P2PDMA) &&
> +			    zone_device_pages_have_same_pgmap(bvprvp->bv_page,
> +					bv->bv_page))
> +				goto put_bio;
> +		} else {
> +			if (is_pci_p2pdma_page(bv->bv_page))
> +				bio->bi_opf |= REQ_P2PDMA | REQ_NOMERGE;
>   		}
> +
>   		/* check full condition */
> +		error = -EINVAL;
>   		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
>   			goto put_bio;
>   		if (bytes + bv->bv_len > nr_iter)
> @@ -611,7 +627,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
>   	return 0;
>   put_bio:
>   	blk_mq_map_bio_put(bio);
> -	return -EINVAL;
> +	return error;
>   }
>   
>   /**
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index dce7615c35e7..94cf146e8ce6 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -378,6 +378,7 @@ enum req_flag_bits {
>   	__REQ_DRV,		/* for driver use */
>   	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
>   	__REQ_ATOMIC,		/* for atomic write operations */
> +	__REQ_P2PDMA,		/* contains P2P DMA pages */
>   	/*
>   	 * Command specific flags, keep last:
>   	 */
> @@ -410,6 +411,7 @@ enum req_flag_bits {
>   #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
>   #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
>   #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
> +#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)

#define REQ_P2PDMA	(__force blk_opf_t)BIT_ULL(__REQ_P2PDMA)

Use BIT_ULL instead of direct left shit.

Zhu Yanjun

>   
>   #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
>   


