Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D5C5DF66
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TQMo+LaXiMExWfUD2JBd89EULUd9CGxSsD/9ZCxdPqs=; b=cz483qVMv5siXbrJMdz8V5d97u
	AY8JJkqvea6w61E/L0L/Pcf69MzvRBZwvSN8uRCquP49XJu8Nl+ekHs0JwCJzi5wTBRSixHIgx9Ni
	3qPhPwJ+Xl6Qrv3xfXKZnt8mg3wKoJfs+k3UpJU+MRiCuBaCyX2tdWni2Z1FncbYSwx87PSXQDXnt
	RYWHBYn2cOLtmv7c5dpzytl9JXtYLbjpto+p9Gi50Uld29H+KXfzYyoRGvbTG+OF2YA6d13h1S32W
	o4G+97nMJRQ8pV7nHjykJ3L838oagvj27AOSeM7yL2Fo1FIJHkoTsnNkDBbVlwTDmJZalDqFyMD/c
	OrUkyRlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvxJR-00000006D4m-1f6u;
	Mon, 17 Aug 2026 13:23:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvxJN-00000006D48-3NM2
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 13:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786973012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQMo+LaXiMExWfUD2JBd89EULUd9CGxSsD/9ZCxdPqs=;
	b=CJawj3SQ732MBKFvOgMvwtjrvMGEYWP0cdYOiRZicKSM+HCp11KWEdQdliHrSUtNoyVg7k
	ORP7mDvqcVEKUtxVCBSod4AOYSXTUF45n6J+UmPfUz7TxuDMKLIOboX4738G++XgRrPy3R
	wbT7k6admLqxCAGJZhrfUc+icphrm4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-0MKTmQxqNx2MKdcs14B8Ug-1; Mon, 17 Aug 2026 09:23:17 -0400
X-MC-Unique: 0MKTmQxqNx2MKdcs14B8Ug-1
X-Mimecast-MFC-AGG-ID: 0MKTmQxqNx2MKdcs14B8Ug_1786972997
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954a93c565so17872295e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 06:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972996; x=1787577796;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCS0C4w6z2feiQqFwp6dHkY/PSJTm+5CQIMULXMvb5Q=;
        b=Rju9N1K9o5UpojO2ynvjId0tZINNf/hKPhycn/ryombIJR9puBiPiTpPmyQmGPjc8e
         xpvvODGT+lfGbs3R/W6eCVFZOp24TK1laN4kp1onRMIMWcr2zh2PR0e3XelsZAJyTraS
         QqPysD1CWbPQp1UOvmjxDQ24U9+hRXOFHIgBMY2LYwNdZSHTB2iaF3olwm9zgVP98OzI
         WVTAfU9uuUZTim/u17Tt8b9ykdcQa7vCStjcPG6hnoJH/BBmUUmw/hhfeqN79Xuer9Y0
         CTCZFNTxhp3DtfyCPhZzY4wNhLoq0CBK+nRYztCfKSrovjxv/3Q5hGyGhv/WbgdUjyZv
         LguQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3cTy2K2//uUf1D+IxzuZx197a/i5Qhb/LBhccI8DluGKeyQWM0/2UHsYtLvFm3bj9mM5aqi9fRdXA@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+M6CRMxHR/xXar8/xFZe74nZ+vpSCzY4KB1N8oXKoqDgU0N1b
	jfB0DPuffJtVPe0xUxtxJD3s9/EU40oFVHR9VTaAfsi2mj9m7Px3NNZM+gE+sT5Mhj/p3vh4pk4
	KmLq/Wp7YdWWZZZ69BfJu2GTY4ie3I0FwgZ1aWDJz5tiooyErEZ6qCzwnjv/AZuqrleoO
X-Gm-Gg: AR+sD12q7IpxVCT2VZqTFws0/fUlSlh2wd7gWPyj5m0AbyxvwYmDYbXjZFZZmiLQ40n
	sGW8eFkprKD/1lkyrUSk5XO53chd1lDfTdSA1kOQILaInBXbKF/3HCZqO8NBVT/xHKrGW2rVIHm
	mQhCJIjEru4pbXiCMwaX+lYS6PHbahMpay/e3gjs1LlLfDiQgfBsW16d+XkGFqXHXOhtOYa3Vx5
	2eqSEbkQ+Wo9wXhbKnI1nXdUNq0fWQYI2Uh0MAWxJfAabvtW+GwUZ3pqnVIwiK7M6izTPJA0wsg
	tPppkDSCWYX9zJm2B0udJ1jgeXDH3Z9v1i2JD2x8nBtxpD4VG3lO0cXc5VWUjR3XR0MVqb+skdR
	iH2xW8XHu/8eI2fOiE7lwk9IjtQlhtEn3XSL9oMB1IiA=
X-Received: by 2002:a05:600c:46d4:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-4998aff59d6mr293102295e9.14.1786972996490;
        Mon, 17 Aug 2026 06:23:16 -0700 (PDT)
X-Received: by 2002:a05:600c:46d4:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-4998aff59d6mr293101445e9.14.1786972995959;
        Mon, 17 Aug 2026 06:23:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0876b8sm57303745e9.8.2026.08.17.06.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:23:15 -0700 (PDT)
Message-ID: <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
Date: Mon, 17 Aug 2026 15:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eauger@redhat.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@kernel.dk
Cc: Keith Busch <kbusch@kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
In-Reply-To: <20251014150456.2219261-2-kbusch@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wY-las2oMwneDp0fDFZuXqqIsz-c5PhcF3xxRz_Zo6E_1786972997
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------8CAmikxCf33xtcNkEMDTdIzg"
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_062334_003589_4B2E422D 
X-CRM114-Status: GOOD (  35.81  )
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

This is a multi-part message in MIME format.
--------------8CAmikxCf33xtcNkEMDTdIzg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Keith, Christoph,

On 10/14/25 5:04 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The blk-mq dma iterator has an optimization for requests that align to
> the device's iommu merge boundary. This boundary may be larger than the
> device's virtual boundary, but the code had been depending on that queue
> limit to know ahead of time if the request is guaranteed to align to
> that optimization.
> 
> Rather than rely on that queue limit, which many devices may not report,
> save the lowest set bit of any boundary gap between each segment in the
> bio while checking the segments. The request stores the value for
> merging and quickly checking per io if the request can use iova
> optimizations.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio.c               |  1 +
>  block/blk-map.c           |  3 +++
>  block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
>  block/blk-mq-dma.c        |  3 +--
>  block/blk-mq.c            |  6 ++++++
>  include/linux/bio.h       |  2 ++
>  include/linux/blk-mq.h    | 16 ++++++++++++++++
>  include/linux/blk_types.h | 12 ++++++++++++
>  8 files changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c278d..7b13bdf72de09 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -253,6 +253,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  	bio->bi_write_hint = 0;
>  	bio->bi_write_stream = 0;
>  	bio->bi_status = 0;
> +	bio->bi_bvec_gap_bit = 0;
>  	bio->bi_iter.bi_sector = 0;
>  	bio->bi_iter.bi_size = 0;
>  	bio->bi_iter.bi_idx = 0;
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 60faf036fb6e4..17a1dc2886786 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -459,6 +459,8 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
>  	if (rq->bio) {
>  		if (!ll_back_merge_fn(rq, bio, nr_segs))
>  			return -EINVAL;
> +		rq->phys_gap_bit = bio_seg_gap(rq->q, rq->biotail, bio,
> +					       rq->phys_gap_bit);
>  		rq->biotail->bi_next = bio;
>  		rq->biotail = bio;
>  		rq->__data_len += bio->bi_iter.bi_size;
> @@ -469,6 +471,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
>  	rq->nr_phys_segments = nr_segs;
>  	rq->bio = rq->biotail = bio;
>  	rq->__data_len = bio->bi_iter.bi_size;
> +	rq->phys_gap_bit = bio->bi_bvec_gap_bit;
>  	return 0;
>  }
>  EXPORT_SYMBOL(blk_rq_append_bio);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 002c594798242..2a1da435462de 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -302,6 +302,12 @@ static unsigned int bio_split_alignment(struct bio *bio,
>  	return lim->logical_block_size;
>  }
>  
> +static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
> +					struct bio_vec *bv)
> +{
> +	return bv->bv_offset | (bvprv->bv_offset + bvprv->bv_len);
> +}
> +
>  /**
>   * bio_split_io_at - check if and where to split a bio
>   * @bio:  [in] bio to be split
> @@ -319,8 +325,8 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
> +	unsigned nsegs = 0, bytes = 0, gaps = 0;
>  	struct bvec_iter iter;
> -	unsigned nsegs = 0, bytes = 0;
>  
>  	bio_for_each_bvec(bv, bio, iter) {
>  		if (bv.bv_offset & lim->dma_alignment ||
> @@ -331,8 +337,11 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
>  		 */
> -		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> -			goto split;
> +		if (bvprvp) {
> +			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> +				goto split;
> +			gaps |= bvec_seg_gap(bvprvp, &bv);
> +		}
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> @@ -350,6 +359,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	}
>  
>  	*segs = nsegs;
> +	bio->bi_bvec_gap_bit = ffs(gaps);
>  	return 0;
>  split:
>  	if (bio->bi_opf & REQ_ATOMIC)
> @@ -385,6 +395,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	 * big IO can be trival, disable iopoll when split needed.
>  	 */
>  	bio_clear_polled(bio);
> +	bio->bi_bvec_gap_bit = ffs(gaps);
>  	return bytes >> SECTOR_SHIFT;
>  }
>  EXPORT_SYMBOL_GPL(bio_split_io_at);
> @@ -721,6 +732,21 @@ static bool blk_atomic_write_mergeable_rqs(struct request *rq,
>  	return (rq->cmd_flags & REQ_ATOMIC) == (next->cmd_flags & REQ_ATOMIC);
>  }
>  
> +u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
> +	       u8 gaps_bit)
> +{
> +	struct bio_vec pb, nb;
> +
> +	gaps_bit = min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
> +	gaps_bit = min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
> +
> +	bio_get_last_bvec(prev, &pb);
> +	bio_get_first_bvec(next, &nb);
> +	if (!biovec_phys_mergeable(q, &pb, &nb))
> +		gaps_bit = min_not_zero(gaps_bit, ffs(bvec_seg_gap(&pb, &nb)));
> +	return gaps_bit;
> +}
> +
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
>   * For mq with scheduling, the appropriate queue wide lock should be held.
> @@ -785,6 +811,9 @@ static struct request *attempt_merge(struct request_queue *q,
>  	if (next->start_time_ns < req->start_time_ns)
>  		req->start_time_ns = next->start_time_ns;
>  
> +	req->phys_gap_bit = bio_seg_gap(req->q, req->biotail, next->bio,
> +					min_not_zero(next->phys_gap_bit,
> +						     req->phys_gap_bit));
>  	req->biotail->bi_next = next->bio;
>  	req->biotail = next->biotail;
>  
> @@ -908,6 +937,8 @@ enum bio_merge_status bio_attempt_back_merge(struct request *req,
>  	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
>  		blk_zone_write_plug_bio_merged(bio);
>  
> +	req->phys_gap_bit = bio_seg_gap(req->q, req->biotail, bio,
> +					req->phys_gap_bit);
>  	req->biotail->bi_next = bio;
>  	req->biotail = bio;
>  	req->__data_len += bio->bi_iter.bi_size;
> @@ -942,6 +973,8 @@ static enum bio_merge_status bio_attempt_front_merge(struct request *req,
>  
>  	blk_update_mixed_merge(req, bio, true);
>  
> +	req->phys_gap_bit = bio_seg_gap(req->q, bio, req->bio,
> +					req->phys_gap_bit);
>  	bio->bi_next = req->bio;
>  	req->bio = bio;
>  
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 449950029872a..94d3461b5bc8e 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
>  static inline bool blk_can_dma_map_iova(struct request *req,
>  		struct device *dma_dev)
>  {
> -	return !((queue_virt_boundary(req->q) + 1) &
> -		dma_get_merge_boundary(dma_dev));
> +	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));

I observe a regression on RHEL due to that change in
blk_can_dma_map_iova() with a 64kB host. This also occurs with upstream
(7.2-rc7).

For an NVME device blk_can_dma_map_iova() now returns trues while it did
not before. And it seems it shouldn't because it then causes some errors
on the dma_iova_link() path due to unaligned iova:

[ 4486.655564] iommu: unaligned: iova 0x14c34000 pa 0x000010764d790000
size 0x1d0000 min_pagesz 0x10000

It occurs when launching a 4kB guest with virtio-blk.

I traced:
nvme 0015:01:00.0: req_phys_gap_mask=0xffffffffffff0000,
queue_virt_boundary+1=0x1, get_merge_boundary=0xffff

See additional traces attached.

Does that ring a bell for you?

Thank you in advance

Best Regards

Eric


>  }
>  
>  static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 09f5794141615..c12e5ee315fce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	INIT_LIST_HEAD(&rq->queuelist);
>  	rq->q = q;
>  	rq->__sector = (sector_t) -1;
> +	rq->phys_gap_bit = 0;
>  	INIT_HLIST_NODE(&rq->hash);
>  	RB_CLEAR_NODE(&rq->rb_node);
>  	rq->tag = BLK_MQ_NO_TAG;
> @@ -668,6 +669,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>  			goto out_queue_exit;
>  	}
>  	rq->__data_len = 0;
> +	rq->phys_gap_bit = 0;
>  	rq->__sector = (sector_t) -1;
>  	rq->bio = rq->biotail = NULL;
>  	return rq;
> @@ -748,6 +750,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  	rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
>  	blk_mq_rq_time_init(rq, alloc_time_ns);
>  	rq->__data_len = 0;
> +	rq->phys_gap_bit = 0;
>  	rq->__sector = (sector_t) -1;
>  	rq->bio = rq->biotail = NULL;
>  	return rq;
> @@ -2674,6 +2677,8 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
>  	rq->bio = rq->biotail = bio;
>  	rq->__sector = bio->bi_iter.bi_sector;
>  	rq->__data_len = bio->bi_iter.bi_size;
> +	rq->phys_gap_bit = bio->bi_bvec_gap_bit;
> +
>  	rq->nr_phys_segments = nr_segs;
>  	if (bio_integrity(bio))
>  		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q,
> @@ -3380,6 +3385,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  	}
>  	rq->nr_phys_segments = rq_src->nr_phys_segments;
>  	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
> +	rq->phys_gap_bit = rq_src->phys_gap_bit;
>  
>  	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
>  		goto free_and_out;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 16c1c85613b76..ad2d57908c1c0 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -324,6 +324,8 @@ extern struct bio *bio_split(struct bio *bio, int sectors,
>  			     gfp_t gfp, struct bio_set *bs);
>  int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *segs, unsigned max_bytes, unsigned len_align);
> +u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
> +		u8 gaps_bit);
>  
>  /**
>   * bio_next_split - get next @sectors from a bio, splitting if necessary
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index b25d12545f46d..ddda00f07fae4 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -152,6 +152,14 @@ struct request {
>  	unsigned short nr_phys_segments;
>  	unsigned short nr_integrity_segments;
>  
> +	/*
> +	 * The lowest set bit for address gaps between physical segments. This
> +	 * provides information necessary for dma optimization opprotunities,
> +	 * like for testing if the segments can be coalesced against the
> +	 * device's iommu granule.
> +	 */
> +	unsigned char phys_gap_bit;
> +
>  #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>  	struct bio_crypt_ctx *crypt_ctx;
>  	struct blk_crypto_keyslot *crypt_keyslot;
> @@ -208,6 +216,14 @@ struct request {
>  	void *end_io_data;
>  };
>  
> +/*
> + * Returns a mask with all bits starting at req->phys_gap_bit set to 1.
> + */
> +static inline unsigned long req_phys_gap_mask(const struct request *req)
> +{
> +	return ~(((1 << req->phys_gap_bit) >> 1) - 1);
> +}
> +
>  static inline enum req_op req_op(const struct request *req)
>  {
>  	return req->cmd_flags & REQ_OP_MASK;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 8e8d1cc8b06c4..53501ebb0623e 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -218,6 +218,18 @@ struct bio {
>  	enum rw_hint		bi_write_hint;
>  	u8			bi_write_stream;
>  	blk_status_t		bi_status;
> +
> +	/*
> +	 * The bvec gap bit indicates the lowest set bit in any address offset
> +	 * between all bi_io_vecs. This field is initialized only after the bio
> +	 * is split to the hardware limits (see bio_split_io_at()). The value
> +	 * may be used to consider DMA optimization when performing that
> +	 * mapping. The value is compared to a power of two mask where the
> +	 * result depends on any bit set within the mask, so saving the lowest
> +	 * bit is sufficient to know if any segment gap collides with the mask.
> +	 */
> +	u8			bi_bvec_gap_bit;
> +
>  	atomic_t		__bi_remaining;
>  
>  	struct bvec_iter	bi_iter;

--------------8CAmikxCf33xtcNkEMDTdIzg
Content-Type: text/plain; charset=UTF-8; name="IOerrors.txt"
Content-Disposition: attachment; filename="IOerrors.txt"
Content-Transfer-Encoding: base64

WyA0NDgzLjU4ODg0M10gVGFpbnRlZDogW1ddPVdBUk4KWyA0NDgzLjU5MTg3Ml0gSGFyZHdhcmUg
bmFtZTogRGVsbCBJbmMuIERlbGwgU2VydmVyIDk3MTJhL0RlbGwgOTcxMmEsIEJJT1MgMi4xNiAw
Ni8xOS8yMDI1ClsgNDQ4My42MDAwNTddIHBzdGF0ZTogMjM0MDAwMDkgKG56Q3YgZGFpZiArUEFO
IC1VQU8gK1RDTyArRElUIC1TU0JTIEJUWVBFPS0tKQpbIDQ0ODMuNjA3MTc1XSBwYyA6IGRtYV9p
b3ZhX2xpbmsrMHgxYTAvMHgyMjAKWyA0NDgzLjYxMTM1OV0gbHIgOiBkbWFfaW92YV9saW5rKzB4
NDgvMHgyMjAKWyA0NDgzLjYxNTQ1NF0gc3AgOiBmZmZmODAwMTkwMWVmNDYwClsgNDQ4My42MTg4
MzddIHgyOTogZmZmZjgwMDE5MDFlZjQ2MCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3OiBmZmZm
MTAwMDQ4YTIyYjAwClsgNDQ4My42MjYxMzNdIHgyNjogZmZmZjEwMDRkNjYyODE3OCB4MjU6IDAw
MDAwMDAwMDAwMDAwMDAgeDI0OiAwMDAwMDAwMDAwMDAwMDAyClsgNDQ4My42MzM0MjldIHgyMzog
ZmZmZjEwMDAwZDUxZTBkMCB4MjI6IDAwMDAwMDAwMDAwMDQwMDAgeDIxOiAwMDAwMTA3ODI2Mzg0
MDAwClsgNDQ4My42NDA3MjVdIHgyMDogMDAwMDAwMDAwMDAwNDAwMCB4MTk6IDAwMDAwMDAwMDAw
MDQwMDAgeDE4OiAwMDAwMDAwMDAwMDAwMDAwClsgNDQ4My42NDgwMjFdIHgxNzogMDAwMDAwMDAw
MDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDYgeDE1OiAwMDAwMTA3ODI2Mzg4MDAwClsgNDQ4
My42NTUzMTZdIHgxNDogMDAwMDAwMDAwMDAwNDAwMCB4MTM6IDAwMDAwMDAwMDAwMDQwMDAgeDEy
OiAwMDAwMDAwMGQ5YzdjMDAwClsgNDQ4My42NjI2MTJdIHgxMTogMDAwMDAwMDAwMDAwMDAwMiB4
MTA6IDAwMDAwMDAwMDAxZjgwMDAgeDkgOiBmZmZmZDQ2OTc0Zjc5MWUwClsgNDQ4My42Njk5MDhd
IHg4IDogMDAwMDEwNzgyNjM4NDAwMCB4NyA6IDAwMDAwMDAwMDAwMGZmZmYgeDYgOiAwMDAwMDAw
MDAwMDAwMDAwClsgNDQ4My42NzcyMDRdIHg1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IDAwMDAw
MDAwMDAwMDQwMDAgeDMgOiAwMDAwMDAwMDAwMDA0MDAwClsgNDQ4My42ODQ1MDBdIHgyIDogMDAw
MDEwNzgyNjM4NDAwMCB4MSA6IGZmZmYxMDA0ZDY2MjgxNzggeDAgOiBmZmZmMTAwMDQ4YTJlZDIw
ClsgNDQ4My42OTE3OThdIENhbGwgdHJhY2U6ClsgNDQ4My42OTg0ODBdICBibGtfZG1hX21hcF9p
dGVyX3N0YXJ0KzB4MWUwLzB4MmM4ClsgNDQ4My43MDMxMTZdICBibGtfcnFfZG1hX21hcF9pdGVy
X3N0YXJ0KzB4NDgvMHhjMApbIDQ0ODMuNzA3ODM0XSAgbnZtZV9tYXBfZGF0YSsweDk0LzB4MjE4
IFtudm1lXQpbIDQ0ODMuNzEyMjA2XSAgbnZtZV9wcmVwX3JxLnBhcnQuMCsweDM0LzB4MWQwIFtu
dm1lXQpbIDQ0ODMuNzE3MTAxXSAgbnZtZV9xdWV1ZV9ycXMrMHgxODQvMHgyYzggW252bWVdClsg
NDQ4My43MjE2NDFdICBibGtfbXFfZGlzcGF0Y2hfcXVldWVfcmVxdWVzdHMrMHgxNzAvMHgxYTAK
WyA0NDgzLjcyNjk4OF0gIGJsa19tcV9mbHVzaF9wbHVnX2xpc3QrMHhhNC8weDFhMApbIDQ0ODMu
NzMxNTMwXSAgYmxrX2FkZF9ycV90b19wbHVnKzB4ZWMvMHgxZTAKWyA0NDgzLjczNTcxNV0gIGJs
a19tcV9zdWJtaXRfYmlvKzB4NThjLzB4ODAwClsgNDQ4My43Mzk5MDBdICBfX3N1Ym1pdF9iaW8r
MHg4Yy8weDIzOApbIDQ0ODMuNzQzNTU2XSAgX19zdWJtaXRfYmlvX25vYWNjdCsweDY4LzB4MWQ4
ClsgNDQ4My43NDc4MjldICBzdWJtaXRfYmlvX25vYWNjdF9ub2NoZWNrKzB4MWE0LzB4MWUwClsg
NDQ4My43NTI3MjZdICBzdWJtaXRfYmlvX25vYWNjdCsweDEwYy8weDQyOApbIDQ0ODMuNzU2OTEx
XSAgc3VibWl0X2JpbysweGFjLzB4MjM4ClsgNDQ4My43NjAzODNdICBpb21hcF9kaW9fc3VibWl0
X2JpbysweDk4LzB4ZDAKWyA0NDgzLjc2NDY2Nl0gIGlvbWFwX2Rpb19iaW9faXRlcisweDM0OC8w
eDUxOApbIDQ0ODMuNzY4OTQwXSAgaW9tYXBfZGlvX2l0ZXIrMHhkMC8weDExOApbIDQ0ODMuNzcy
NzY5XSAgX19pb21hcF9kaW9fcncrMHgxN2MvMHg1YzgKWyA0NDgzLjc3NjY4OF0gIGlvbWFwX2Rp
b19ydysweDE4LzB4NTgKWyA0NDgzLjc4MDI1MV0gIHhmc19maWxlX2Rpb19yZWFkKzB4MTA0LzB4
MTY4IFt4ZnNdClsgNDQ4My43ODUwNDVdICB4ZnNfZmlsZV9yZWFkX2l0ZXIrMHhlYy8weDEwOCBb
eGZzXQpbIDQ0ODMuNzg5ODA3XSAgZG9faXRlcl9yZWFkdl93cml0ZXYrMHgxYjAvMHgyMDAKWyA0
NDgzLjc5NDI2Ml0gIHZmc19yZWFkdisweDE5MC8weDI5MApbIDQ0ODMuNzk3NzM1XSAgX19hcm02
NF9zeXNfcHJlYWR2KzB4ZTAvMHgxMjgKWyA0NDgzLjgwMTkyMl0gIGludm9rZV9zeXNjYWxsLmNv
bnN0cHJvcC4wKzB4NzQvMHhkMApbIDQ0ODMuODA2NzMzXSAgZG9fZWwwX3N2YysweGI4LzB4ZDAK
WyA0NDgzLjgxMDExN10gIGVsMF9zdmMrMHg0NC8weDFiOApbIDQ0ODMuODEzMzI5XSAgZWwwdF82
NF9zeW5jX2hhbmRsZXIrMHhhMC8weGYwClsgNDQ4My44MTc2MDNdICBlbDB0XzY0X3N5bmMrMHgx
YWMvMHgxYjAKWyA0NDgzLjgyMTM0Nl0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBd
LS0tClsgNDQ4My44MjYxMTBdIEkvTyBlcnJvciwgZGV2IG52bWUxbjEsIHNlY3RvciA3NjQ0Nzgw
MCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4YzgwMCBwaHlzX3NlZyAyOCBwcmlvIGNsYXNzIDIKWyA0
NDg0LjI0NzczMF0gSS9PIGVycm9yLCBkZXYgbnZtZTFuMSwgc2VjdG9yIDc5MDg1MTkyIG9wIDB4
MDooUkVBRCkgZmxhZ3MgMHhjODAwIHBoeXNfc2VnIDMxIHByaW8gY2xhc3MgMgpbIDQ0ODQuMjY5
NzM1XSBJL08gZXJyb3IsIGRldiBudm1lMW4xLCBzZWN0b3IgNzc0MDQwNDggb3AgMHgwOihSRUFE
KSBmbGFncyAweGM4MDAgcGh5c19zZWcgMTggcHJpbyBjbGFzcyAyClsgNDQ4NC45Njk3MDddIEkv
TyBlcnJvciwgZGV2IG52bWUxbjEsIHNlY3RvciA3NjQ2NTg2NCBvcCAweDA6KFJFQUQpIGZsYWdz
IDB4YzgwMCBwaHlzX3NlZyAzMSBwcmlvIGNsYXNzIDIKWyA0NDg1LjA0MDMyN10gSS9PIGVycm9y
LCBkZXYgbnZtZTFuMSwgc2VjdG9yIDgyMzM5MDQ4IG9wIDB4MDooUkVBRCkgZmxhZ3MgMHhjODAw
IHBoeXNfc2VnIDIyIHByaW8gY2xhc3MgMgpbIDQ0ODUuNjA2Mzg1XSBJL08gZXJyb3IsIGRldiBu
dm1lMW4xLCBzZWN0b3IgODY1MjkyOTYgb3AgMHgwOihSRUFEKSBmbGFncyAweGM4MDAgcGh5c19z
ZWcgNCBwcmlvIGNsYXNzIDIKWyA0NDg2LjU2NDQ3Ml0gSS9PIGVycm9yLCBkZXYgbnZtZTFuMSwg
c2VjdG9yIDgwMzg4MzkyIG9wIDB4MDooUkVBRCkgZmxhZ3MgMHhjODAwIHBoeXNfc2VnIDQgcHJp
byBjbGFzcyAyClsgNDQ4Ni42NTU1NjRdIGlvbW11OiB1bmFsaWduZWQ6IGlvdmEgMHgxNGMzNDAw
MCBwYSAweDAwMDAxMDc2NGQ3OTAwMDAgc2l6ZSAweDFkMDAwMCBtaW5fcGFnZXN6IDB4MTAwMDAK
WyA0NDg2LjY2NDkxNV0gaW9tbXU6IHVuYWxpZ25lZDogaW92YSAweDE0ODM0MDAwIHBhIDB4MDAw
MDEwNzY0ZDc5MDAwMCBzaXplIDB4MWQwMDAwIG1pbl9wYWdlc3ogMHgxMDAwMApbIDQ0ODYuNjc0
MjYzXSBpbnZhbGlkIGVycm9yLCBkZXYgbnZtZTFuMSwgc2VjdG9yIDM3MTYwNDMzODQgb3AgMHgw
OihSRUFEKSBmbGFncyAweGM4MDAgcGh5c19zZWcgMiBwcmlvIGNsYXNzIDIKWyA0NDg3LjMwNDI3
Ml0gSS9PIGVycm9yLCBkZXYgbnZtZTFuMSwgc2VjdG9yIDg2MTAxNjE2IG9wIDB4MDooUkVBRCkg
ZmxhZ3MgMHhjODAwIHBoeXNfc2VnIDMgcHJpbyBjbGFzcyAyClsgNDQ4Ny4zMDU4OTRdIEkvTyBl
cnJvciwgZGV2IG52bWUxbjEsIHNlY3RvciA4NjEwOTgwOCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4
YzgwMCBwaHlzX3NlZyAzIHByaW8gY2xhc3MgMgoK
--------------8CAmikxCf33xtcNkEMDTdIzg--


