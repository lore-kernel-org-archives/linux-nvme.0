Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF35FE77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 22:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gzwuWqYv4WT+H+v0TerIu3OK3suNQQflQ7F88x5UxU=; b=1gIhOu6/FxnwNElLlclsM600kj
	heHlsPc/jkn/PCskojSRgJBxCNHGk5YXGIE/r29pbB87ZKWCSLuEYCYQ3EtZtVXPuIV5X5OeAY5T+
	bXrPY1hdL9eH5nEhEwkqCI0iLTcZmt1S++cAVOoGJzsz3ZeTafqShZTWlk9tqaogAXa7UDUPPJiMf
	DPb8WSrO5LiBfNcoKJyndJqvJGZ8+G69RK7AcFjyAhle2BKu8ckCPuT3w6ZYuHjZprjx6ZSEEqCwZ
	0M5balF/Ylm+7G1m/Q2bqIEwjHAMoSRqh0ZrgXZejxxV9qlx4vFXyKdDorwv/qaudpDbHHSqTCgtq
	UNBqbADA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUCNA-0000000FhVM-29GE;
	Sat, 04 Jan 2025 22:11:56 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUCN8-0000000FhUq-00X1
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 22:11:55 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso11243529f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 04 Jan 2025 14:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736028712; x=1736633512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gzwuWqYv4WT+H+v0TerIu3OK3suNQQflQ7F88x5UxU=;
        b=n3+A7Jxu4/QN3s0MtWpvAbEDtbZ6MBEB0Uw19Hn2/5G8+xSj7a6e9NEnWe+33SlrjR
         E56HjnxJSlFxAsSoR8xP/khqBCoimcCdVQQ7eFgQUB052rINF1OFtcKYoWXEVUZf8wU0
         NDV5vfN63a6c1sMqAcqEO6C0uiibg+uCq4P0JYEhB66MFkWAg2XTaFsIQOW8NWQB6049
         wwu9i08vHhudbk0TD7klE3wRmRJapY+nK166uSCjuQZmxnWvCDFqBjxaLOb4aCct5Ge9
         +tIOtmN7eaL+nnPhEnKTYzWbYx/eD80H7mLnJ8zpYv+zI9sPcc8O2YpZoIo9Gy8I4r5X
         0ueQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpXZrRVRN86MBi/ZqM3F7AOceOAAdV+CkclcJ1r0iSafzhXEMsQL1aj7yOFm2iddH2j2lssjYu+Li+@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1ua3310Cb9Z+QPSGs7I3SkvDbyfUZbP/qSwWDMTDsA3bPPd6f
	9u9clz1rU+t+LDCcSFUxavD8emuVsJ8sMLVa1OQ3950FRnQCSNWO
X-Gm-Gg: ASbGncv83BuAQcV0mPpacSaIGsEJ9Fb39snOdMFgGlD7HSLF7q6EShYHLAjhxCrTf2f
	+gFg2BYbNkZ9yLUpUF23P8Wjo5X/L9bGBGMyW7x4uSd3TWgJikh/KUGvrjzcFqxwI8TN6sIG6XD
	qg6D87jSO4ogfWx3IW1Qw5PeOYzATbwSac5LyF68Dmp7gV/dENec66yGGSHzcN4/wyLVreEtupw
	uVIeG70KrKwtdlrq34TQr44L4jIy59J9Wf2aF0veGDvLt/TAALbCY2MwvUl3hAcLHzDbWcxIxmb
	GU8UoE0q2pHiRfI+E5oG23c=
X-Google-Smtp-Source: AGHT+IEiRIDWXXsDhHRNseRHXez167n6bJKIibbf12N1+gxvi9iEsPrcDoH7/JL4Dulr48TlIQniHA==
X-Received: by 2002:a05:6000:4023:b0:385:e5dc:e285 with SMTP id ffacd0b85a97d-38a22406d4emr47237244f8f.58.1736028711931;
        Sat, 04 Jan 2025 14:11:51 -0800 (PST)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b417afsm562520085e9.36.2025.01.04.14.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 14:11:51 -0800 (PST)
Message-ID: <65b1b566-a9e1-4015-a750-2fe7a8fe4f9b@grimberg.me>
Date: Sun, 5 Jan 2025 00:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: remove bio_add_pc_page
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20250103073417.459715-1-hch@lst.de>
 <20250103073417.459715-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250103073417.459715-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_141154_113208_E6B3C30C 
X-CRM114-Status: GOOD (  42.05  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>



On 03/01/2025 9:33, Christoph Hellwig wrote:
> Lift bio_split_rw_at into blk_rq_append_bio so that it validates the
> hardware limits.  With this all passthrough callers can simply add
> bio_add_page to build the bio and delay checking for exceeding of limits
> to this point instead of doing it for each page.
>
> While this looks like adding a new expensive loop over all bio_vecs,
> blk_rq_append_bio is already doing that just to counter the number of
> segments.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c                        | 107 ++------------------------
>   block/blk-map.c                    | 118 +++++++----------------------
>   block/blk.h                        |   8 --
>   drivers/nvme/target/passthru.c     |  18 +++--
>   drivers/nvme/target/zns.c          |   3 +-
>   drivers/target/target_core_pscsi.c |   6 +-
>   include/linux/bio.h                |   2 -
>   7 files changed, 48 insertions(+), 214 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index d5bdc31d88d3..4e1a27d312c9 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -946,8 +946,11 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
>   
>   /*
>    * Try to merge a page into a segment, while obeying the hardware segment
> - * size limit.  This is not for normal read/write bios, but for passthrough
> - * or Zone Append operations that we can't split.
> + * size limit.
> + *
> + * This is kept around for the integrity metadata, which is still tries
> + * to build the initial bio to the hardware limit and doesn't have proper
> + * helpers to split.  Hopefully this will go away soon.
>    */
>   bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>   		struct page *page, unsigned len, unsigned offset,
> @@ -964,106 +967,6 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>   	return bvec_try_merge_page(bv, page, len, offset, same_page);
>   }
>   
> -/**
> - * bio_add_hw_page - attempt to add a page to a bio with hw constraints
> - * @q: the target queue
> - * @bio: destination bio
> - * @page: page to add
> - * @len: vec entry length
> - * @offset: vec entry offset
> - * @max_sectors: maximum number of sectors that can be added
> - * @same_page: return if the segment has been merged inside the same page
> - *
> - * Add a page to a bio while respecting the hardware max_sectors, max_segment
> - * and gap limitations.
> - */
> -int bio_add_hw_page(struct request_queue *q, struct bio *bio,
> -		struct page *page, unsigned int len, unsigned int offset,
> -		unsigned int max_sectors, bool *same_page)
> -{
> -	unsigned int max_size = max_sectors << SECTOR_SHIFT;
> -
> -	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
> -		return 0;
> -
> -	len = min3(len, max_size, queue_max_segment_size(q));
> -	if (len > max_size - bio->bi_iter.bi_size)
> -		return 0;
> -
> -	if (bio->bi_vcnt > 0) {
> -		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> -
> -		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
> -				same_page)) {
> -			bio->bi_iter.bi_size += len;
> -			return len;
> -		}
> -
> -		if (bio->bi_vcnt >=
> -		    min(bio->bi_max_vecs, queue_max_segments(q)))
> -			return 0;
> -
> -		/*
> -		 * If the queue doesn't support SG gaps and adding this segment
> -		 * would create a gap, disallow it.
> -		 */
> -		if (bvec_gap_to_prev(&q->limits, bv, offset))
> -			return 0;
> -	}
> -
> -	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
> -	bio->bi_vcnt++;
> -	bio->bi_iter.bi_size += len;
> -	return len;
> -}
> -
> -/**
> - * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
> - * @q: the target queue
> - * @bio: destination bio
> - * @folio: folio to add
> - * @len: vec entry length
> - * @offset: vec entry offset in the folio
> - * @max_sectors: maximum number of sectors that can be added
> - * @same_page: return if the segment has been merged inside the same folio
> - *
> - * Add a folio to a bio while respecting the hardware max_sectors, max_segment
> - * and gap limitations.
> - */
> -int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
> -		struct folio *folio, size_t len, size_t offset,
> -		unsigned int max_sectors, bool *same_page)
> -{
> -	if (len > UINT_MAX || offset > UINT_MAX)
> -		return 0;
> -	return bio_add_hw_page(q, bio, folio_page(folio, 0), len, offset,
> -			       max_sectors, same_page);
> -}
> -
> -/**
> - * bio_add_pc_page	- attempt to add page to passthrough bio
> - * @q: the target queue
> - * @bio: destination bio
> - * @page: page to add
> - * @len: vec entry length
> - * @offset: vec entry offset
> - *
> - * Attempt to add a page to the bio_vec maplist. This can fail for a
> - * number of reasons, such as the bio being full or target block device
> - * limitations. The target block device must allow bio's up to PAGE_SIZE,
> - * so it is always possible to add a single page to an empty bio.
> - *
> - * This should only be used by passthrough bios.
> - */
> -int bio_add_pc_page(struct request_queue *q, struct bio *bio,
> -		struct page *page, unsigned int len, unsigned int offset)
> -{
> -	bool same_page = false;
> -	return bio_add_hw_page(q, bio, page, len, offset,
> -			queue_max_hw_sectors(q), &same_page);
> -}
> -EXPORT_SYMBOL(bio_add_pc_page);
> -
>   /**
>    * __bio_add_page - add page(s) to a bio in a new segment
>    * @bio: destination bio
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 894009b2d881..67a2da3b7ed9 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -189,7 +189,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
>   			}
>   		}
>   
> -		if (bio_add_pc_page(rq->q, bio, page, bytes, offset) < bytes) {
> +		if (bio_add_page(bio, page, bytes, offset) < bytes) {
>   			if (!map_data)
>   				__free_page(page);
>   			break;
> @@ -272,86 +272,27 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
>   static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>   		gfp_t gfp_mask)
>   {
> -	iov_iter_extraction_t extraction_flags = 0;
> -	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>   	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
>   	struct bio *bio;
>   	int ret;
> -	int j;
>   
>   	if (!iov_iter_count(iter))
>   		return -EINVAL;
>   
>   	bio = blk_rq_map_bio_alloc(rq, nr_vecs, gfp_mask);
> -	if (bio == NULL)
> +	if (!bio)
>   		return -ENOMEM;
> -
> -	if (blk_queue_pci_p2pdma(rq->q))
> -		extraction_flags |= ITER_ALLOW_P2PDMA;
> -	if (iov_iter_extract_will_pin(iter))
> -		bio_set_flag(bio, BIO_PAGE_PINNED);
> -
> -	while (iov_iter_count(iter)) {
> -		struct page *stack_pages[UIO_FASTIOV];
> -		struct page **pages = stack_pages;
> -		ssize_t bytes;
> -		size_t offs;
> -		int npages;
> -
> -		if (nr_vecs > ARRAY_SIZE(stack_pages))
> -			pages = NULL;
> -
> -		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
> -					       nr_vecs, extraction_flags, &offs);
> -		if (unlikely(bytes <= 0)) {
> -			ret = bytes ? bytes : -EFAULT;
> -			goto out_unmap;
> -		}
> -
> -		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
> -
> -		if (unlikely(offs & queue_dma_alignment(rq->q)))
> -			j = 0;
> -		else {
> -			for (j = 0; j < npages; j++) {
> -				struct page *page = pages[j];
> -				unsigned int n = PAGE_SIZE - offs;
> -				bool same_page = false;
> -
> -				if (n > bytes)
> -					n = bytes;
> -
> -				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
> -						     max_sectors, &same_page))
> -					break;
> -
> -				if (same_page)
> -					bio_release_page(bio, page);
> -				bytes -= n;
> -				offs = 0;
> -			}
> -		}
> -		/*
> -		 * release the pages we didn't map into the bio, if any
> -		 */
> -		while (j < npages)
> -			bio_release_page(bio, pages[j++]);
> -		if (pages != stack_pages)
> -			kvfree(pages);
> -		/* couldn't stuff something into bio? */
> -		if (bytes) {
> -			iov_iter_revert(iter, bytes);
> -			break;
> -		}
> -	}
> -
> +	ret = bio_iov_iter_get_pages(bio, iter);
> +	if (ret)
> +		goto out_put;

This looks like a more involved change than converting bio_add_hw_page. 
Perhaps should go into a separate patch? Other than that, looks good 
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

