Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD77CD4F54
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 09:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=; b=UObr4sUDZZoktdpfemNVyAvwpL
	9HNrDf2waxq1hxE1w39UUxiaQ1Tnz6TNTR4OnsN3fF0yB23ThJxwXG2vbkgZfRZnSxjaArPid5a1l
	8jE/wgD86odJplIViLWqXg6bvWmA5xpZuo0+FpVN+AlyT5hXpdJX/EqO19k09Bus380c3vgi/+rZV
	g8jUJr5lCT8+AjN9GI9Mt5DxsfB1TAU6+ftE3yttWcTE2Fhfu51+UsSbgdzjBIZ/Hz4HCsMf0OleN
	bkjUeA47msilQPn4ISdW2VMmsNgJa/Pm/6fd7M1iph0oTARDyg8DTz3BGJp6oaHEG1QTsr/1pYv9X
	XK618Skw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuHv-0000000F1EF-0HcH;
	Mon, 18 May 2026 09:29:27 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuHt-0000000F1Cy-0MsY
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 09:29:26 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-488d2079582so18839915e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779096563; x=1779701363; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=;
        b=d/+4UAJA4SLPSqYRD4CSH8pxnjtlHooSw5tHG7SlpXvNxge0o2YilRaw5HI9fSS/h4
         tIRUeW01H/1XQxn4gdE/9Cg6Kxp1tOIqtFD9j1mIPS91OeHQwXHLv+MaBRt23Bclqw78
         nbxR8hmet/qIruXPGmZQx3hZSg7V+Q000gSv97av/eTilW+ZkyRU+kCHLNfp2cDaG96A
         yBIiokmR1tqVUhoEKuFrrsTqjKSEoXBl4H0tyFhzqflz/ZwfWUDYnE4EoDfUcekNIYjS
         L5+GJr/UUPVEfPz+hdyWuX2dF5LC4rwW1iK5bwIMp+fdF8chKd9uKiRSO/IHRR4uRkmj
         SYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096563; x=1779701363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=;
        b=CSx9EI1//eqqh9rofc8cl8mqA0s17nCKvvv84VHkM7RTf2EMZbHHwEMJ61J4Qa/gWM
         h+GyGQ4h++7486AuqBjNxqn0K31HOSNG3mCY/E7fDP69kSHOcXKzp/D00EuaB/54dKNI
         0Caq7OUaT+z2volQWfjUOGyQAB6s0SfTh1KN6yvoR5XG+Roqgj3R3hGiXCBrjOXD4/+X
         mXqgX7yh+I95ocM8dqoDb5gZ4cFLprRcyqqOue5Vu0pQpILRW9Zf3eeSsSLh38yO1KoL
         js+InvuoJRejS5hPLFPJYVQMxzLoS9jUi/vD+IeBH+RjGoy8+cL91RAgSMmnw33LYWQX
         9bsA==
X-Forwarded-Encrypted: i=1; AFNElJ/2TQV1ACzamoCHXyPq6iDSgLHGJEc43EmpR8rogOZ3ERF4CqWUza822SUnEZK1u7bcnqCUBzzakNyL@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6DRjZksDHC/cObYFDBFzA2bYJQO8C0cYm5F8LcghSc62+Gw8X
	yS80ELYH2E8Fat6yfMCHgkMP2Qw/znoeGSLz4X40Qkct+BNEMJZmB6qN
X-Gm-Gg: Acq92OHWzgJzrrdomq1C0ZSBB0aesPsUds9C4DV+B1ql1shiD35vb0Ttt8+RczyPWPA
	IMu6/10gCm2VrsIau2CvkBMe93ftFmg7Pkx32c3Ms2kuoidGPcEsfxW1atLEoIejxSNTJNc/gzi
	S0xAN0Gp2UUqDP79IRHTuQuCS8RfVSG/tBdJr3iezPuYb0DLnX65C1/t4SWMfGI6cySS8rAFFI/
	Y3/Axf2mlqy5nzR0DyrTCHr1b/eTQxdJHDgqXBRgkRiSf3BeNAdcyGTCv0N8WZv+MedVJHm0Z1b
	FIXUgjxcparo4Xr5BPHRuscVGM0OnA3FNJoSfTRHqJ+FVE4MhAxBfhIe/LkFf5DknKdPVuTUiDK
	/eCyJJvnxoEMCdIezUVT10xnjVXpW7/DcIr3+aIhoaDele/LK/I57Jnldbi66EGCKL5LFIvSkee
	rz2nrVJ4CkCTtEWdLUTaHapJOEpz35YtwvO84F3Km3++ockAp27QM4ngOh7m6+y3/jeGZkkJ/Wy
	0gUpNvvqvhNk3xc39jNXsBzWsE9FevP4UiNA9CRfAYg4udH3UOtWwkVzlPl0/IhJnwu4w==
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr240818345e9.0.1779096563202;
        Mon, 18 May 2026 02:29:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe582e3sm88451385e9.15.2026.05.18.02.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:29:22 -0700 (PDT)
Message-ID: <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
Date: Mon, 18 May 2026 10:29:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <20260513083817.GC6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513083817.GC6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_022925_162166_FE53E619 
X-CRM114-Status: GOOD (  29.10  )
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

On 5/13/26 09:38, Christoph Hellwig wrote:
> FYI, I really want SGL support before this get merged, but ignoring that
> for now:

I was hoping to let Samsung guys to send a follow up they already have,
but I'll ask them to have about taking it into this patch set.

>> +struct nvme_dmabuf_map {
>> +	struct io_dmabuf_map base;
>> +	dma_addr_t *dma_list;
>> +	struct sg_table *sgt;
>> +	unsigned nr_entries;
> 
> I'd make dma_list a variable-sized array at the end of the struture to avoid
> an extra allocation and pointer derefernece.

Ok

>> +static void nvme_dmabuf_map_sync(struct nvme_dev *nvme_dev, struct request *req,
>> +				 bool for_cpu)
>> +{
>> +	int length = blk_rq_payload_bytes(req);
>> +	struct device *dev = nvme_dev->dev;
>> +	enum dma_data_direction dma_dir;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map;
>> +	dma_addr_t *dma_list;
>> +	int offset, map_idx;
>> +
>> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
>> +	dma_list = map->dma_list;
>> +
>> +	offset = bio->bi_iter.bi_bvec_done;
>> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
> 
> Please initialize the variable at declaration time and use or add proper
> helpers to simplify this:

> static inline struct nvme_dmabuf_map *
> to_nvme_dmabuf_map(struct io_dmabuf_map *map)
> {
> 	return container_of(map, struct nvme_dmabuf_map, base);
> }
> 
> ....
> 
> 	enum dma_data_direction dma_dir = rq_dma_dir(req);
> 	struct device *dev = nvme_dev->dev;
> 	struct bio *bio = req->bio;
> 	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
> 	dma_addr_t *dma_list = map->dma_list;
> 	int offset = bio->bi_iter.bi_bvec_done;
> 	int mmap_idx = offset / NVME_CTRL_PAGE_SIZE;
> 	int length = blk_rq_payload_bytes(req) +
> 		offset & (NVME_CTRL_PAGE_SIZE - 1);
> 
> Also a lot of these ints sound like they should be unsigned.

Ok

>> +
>> +	while (length > 0) {
>> +		u64 dma_addr = dma_list[map_idx++];
>> +
>> +		if (for_cpu)
>> +			__dma_sync_single_for_cpu(dev, dma_addr,
>> +						  NVME_CTRL_PAGE_SIZE, dma_dir);
>> +		else
>> +			__dma_sync_single_for_device(dev, dma_addr,
>> +						     NVME_CTRL_PAGE_SIZE,
>> +						     dma_dir);
>> +		length -= NVME_CTRL_PAGE_SIZE;
>> +	}
>> +}
> 
> Nothing should be using these __dma_sync helpers that are internal
> details. Using them means you call into sync code that should be skipped
> on most common server class systems.

Yeah, the kernel test robot already flagged it as well

> Also the for_cpu argument is a bit ugly.  I'd rather have separate
> routines as in the core dma-mapping code, even if that means a little bit
> of code duplication.
> 
>> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
>> +					     struct nvme_queue *nvmeq)
>> +{
>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +	int length = blk_rq_payload_bytes(req);
>> +	u64 dma_addr, prp1_dma, prp2_dma;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map;
>> +	dma_addr_t *dma_list;
>> +	dma_addr_t prp_dma;
>> +	__le64 *prp_list;
>> +	int i, map_idx;
>> +	int offset;
>> +
>> +	nvme_dmabuf_map_sync(nvmeq->dev, req, false);
>> +
>> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
>> +	dma_list = map->dma_list;
>> +
>> +	offset = bio->bi_iter.bi_bvec_done;
>> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +	offset &= (NVME_CTRL_PAGE_SIZE - 1);
>> +	prp1_dma = dma_list[map_idx++] + offset;
> 
> Same comments as for the sync helper above.
> 
>> +	length -= (NVME_CTRL_PAGE_SIZE - offset);
>> +	if (length <= 0) {
>> +		prp2_dma = 0;
>> +		goto done;
>> +	}
>> +
>> +	if (length <= NVME_CTRL_PAGE_SIZE) {
>> +		prp2_dma = dma_list[map_idx];
>> +		goto done;
>> +	}
>> +
>> +	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
>> +	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
>> +		iod->flags |= IOD_SMALL_DESCRIPTOR;
>> +
>> +	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
>> +			&prp_dma);
>> +	if (!prp_list)
>> +		return BLK_STS_RESOURCE;
>> +
>> +	iod->descriptors[iod->nr_descriptors++] = prp_list;
>> +	prp2_dma = prp_dma;
> 
> And I really hate how this duplicates all the nasty PRP building logic,
> although right now I don't have a good answer to that.
> 
>> +static inline bool nvme_rq_is_dmabuf_attached(struct request *req)
>> +{
>> +	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
>> +		return false;
>> +	return req->bio && bio_flagged(req->bio, BIO_DMABUF_MAP);
>> +}
> 
> This is something that should go into the block layer.

I'll move it

-- 
Pavel Begunkov


