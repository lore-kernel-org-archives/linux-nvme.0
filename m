Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C5BC56208
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qChqnXEV/RUrII3F6FtB3OpL17H6S0GQj9i1G4DFOPk=; b=40aw8p37qBADCEGDJryfQzNTzI
	pwAP4Vuaf6433PF0WmxH1LkKKrhdcrVcZLUe5z1BCBx3aI6//LLhHLGvI6gOHuSTNXXg+mPVBJU0d
	nh6tlHfgCKwRSGxL7aO4KPLganwwKVx0F42fgQyF4mxdQ8jyi/SwVsB4zmUdlXNmp5Q+7pwp09bBJ
	TIn2edtezOLz2zZL16RK7GIg/4SKNQAbCCIlRKYqVTk4H6UP8fQreGMjZFT0cDRFcD1ywJdRTbQ7w
	QAjwrJ4Ww8X1dxMLRx6N1jXOaiCggS94cNG3dBkx5leD/j2/9rjk7r8IeEFG9kBOS/bDWNNzf/Gbl
	52RNrMMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wry72-00000005taz-1oKO;
	Thu, 06 Aug 2026 13:26:20 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrZL2-00000003mXU-0anm
	for linux-nvme@lists.infradead.org;
	Wed, 05 Aug 2026 10:59:09 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-471eeac43bfso702328f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2026 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785927546; x=1786532346; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qChqnXEV/RUrII3F6FtB3OpL17H6S0GQj9i1G4DFOPk=;
        b=EqlwbgqgQEfbOxDXf5+i/aeZY1Sey0usYnO2QateLLUoyBx38aUworVPL7pVkO1L+3
         yTmJPn/jxF+fpl2bo+1R8EiD4EaSoO/pvYEEwXGr1n8e9fCFgsXqOeYVXyUs+ajRQnMZ
         DZ9dp+feuQoQnJGJfXEYfwJ8Qm9BGBobEQYRyDjr2t3eFQnTbgjzT+THK6CbCC3K1qkZ
         QLL17CPQoZMXvh4omCuSeO23UZT8PhdPuYr69jRWKli1f1iIZGWGesXfPI58daUVm7Wl
         NKV7rqYCqUvNyho4TARl2YMGinPBpC7mKlu2174XuNjIChLXvVVQ4pceuUrqZkjZJhET
         hq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785927546; x=1786532346;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qChqnXEV/RUrII3F6FtB3OpL17H6S0GQj9i1G4DFOPk=;
        b=OZ6DH279LEfheyiwDmTRi1AsebkIiAJ86KXVcUorIH0RunjPLC73lLMvZaAy6iaU6p
         dXwlhZSyxOgdPTNyJdek82M4vSRIyay44p/033cHlw3vj0sV3PYZ/SjhkW3C7as3ARWz
         PcXu4sb2+w8Yp+rTTkZOZvQ+Ld3qoxT088BSus0owD86Rv1Sef4P8drgCDgF401xUX9t
         qGjgCTRaSXCfA9SNYnlTCvil6bLCdko9BJn8gK3oesnM35hct7AGMPoYbJyiqbhwvVFk
         hYKQ4rJlDorJ0yd3DN+VLesKsfGKUGt0QfMj4t5GpGTqlIslWme/7K7EXfi2TZkwnw3a
         wp3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rok+RU5ofhqH4Cz3jSQjRA0mHz75+OOEZRiPeyciw0bfCzURwFThd+FiMAvMXrqfIY8CAB2gRKf7zF2@lists.infradead.org
X-Gm-Message-State: AOJu0YyPxQcaOsdNBlMnKojPZTqtg8bAaRK1ueIBPlNmbAGHqkqM9vU9
	Z4eTdHvWzhb4auDqnOFOsJwA0CHm6w7QWZipjBwDVeqrdD9ZUN9xLavQsntphX+8mCPhBA==
X-Gm-Gg: AR+sD11Jwi6h0p20nJ8hmZEmbocBpu5aYRJ61jF5nbKdShHHGqh6Qy50fXENa0wcZGY
	nsjc9tQTkzAlaTqasV0N4IJ4dFvRzbzAaGE2Kt8+J3y3OhruwPmtlNBTcDGjU1mh5dVPj5fpcQh
	HAjIDF1EfE/Ycy2hV3mOAMde4DyUuF2a+Yg4vVsm7ISct9I02a/H3x1DrXArSbmAYODNoj7bMch
	T99gwluleJ1v9SSrenFfQEGcRgdtu5bvBk50jDAOwKSVzDkn7EkEkw3ykhvTF1Q4cPQ47914v6B
	XD3mhSq3bPFNL1NZKtpar3JQzcFCosfhYsMP8t+TZkBqXPG0iqu0ys7eD3bPrVcbCamLQzc+nXA
	6XDOSWqgE1s/d2dX5lWhZQ3h+CsVDa5Lb3LC2/atoQjGs9eOuP+MzX+Op+PTlCOL8LzWXBdwzUZ
	Klb8yO27mH5TQwwV3IuI37CUYpQeBRId41bY68u+uq5cPZ+58jkHK5mnha6PmBbaeE+FT4zicjF
	GXkvX786DN1smlz+JxGZzyOP/BQzgo4ym/U9Dhf2R7gwcI9fjfAdtJRNCp/qz9trcg49OaftuDY
	/JxDkTquKFDM5C+WPzy44phTsAoOi4ku/o9EWz94ex/Zc4Ud
X-Received: by 2002:a05:600c:4e94:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4994e6c5eafmr60022735e9.0.1785927545848;
        Wed, 05 Aug 2026 03:59:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e035900sm80665575e9.11.2026.08.05.03.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:59:05 -0700 (PDT)
Message-ID: <8285ede8-bebb-403a-8a37-b9987cd37a8f@gmail.com>
Date: Wed, 5 Aug 2026 11:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Nitesh Shetty
 <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <181b08be-04bc-4ae9-bb88-15321a82440f@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <181b08be-04bc-4ae9-bb88-15321a82440f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_035908_239569_037CDC34 
X-CRM114-Status: GOOD (  27.07  )
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:26:18 -0700
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

On 8/5/26 09:27, Christian König wrote:
...>> +struct dma_buf_io_fence {
>> +	struct dma_fence base;
>> +	spinlock_t lock;
>> +};
> 
> Upstream has change to allow embedding the spinlock into the dma_fence, so this structure here is most likely not necessary any more.

ok

>> +static const char *dma_buf_io_fence_drv_name(struct dma_fence *fence)
>> +{
>> +	/* default fence release kfree's the base pointer */
>> +	BUILD_BUG_ON(offsetof(struct dma_buf_io_fence, base));
>> +
>> +	return "dma-buf-io-ctx";
>> +}
...>> +static void dma_buf_io_map_release_work(struct work_struct *work)
>> +{
>> +	struct dma_buf_io_map *map = container_of(work, struct dma_buf_io_map,
>> +						  release_work);
>> +	struct dma_buf_io_fence *fence = map->fence;
>> +	struct dma_buf_io_ctx *ctx = map->ctx;
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +
>> +	/* the release path must wait for fences */
>> +	if (WARN_ON_ONCE(refcount_read(&ctx->refs) == 0))
>> +		return;
> 
> Stuff like that is usually illegal.

Should be fine, it's just a warning. The map holds a ctx
reference so can't be 0. IIRC, it was synchronised a bit
differently before. I can kill it, refcount_inc() has the
same warning anyway.

> And why are you using refcount directly instead of kref?

Not sure it'd make much difference here.

> 
>> +
>> +	/* Prevent from destoying the ctx while unmapping */
>> +	refcount_inc(&ctx->refs);
> 
>> +
>> +	/*
>> +	 * There are no more requests using the map, we can signal the fence.
>> +	 * It should be done before taking the resv lock as someone could be
>> +	 * waiting for the fence while holding the lock.
>> +	 */
>> +	dma_fence_signal(&fence->base);
> 
> Signaling fences has a whole bunch of very strict rules associated with it. E.g. you can't alocate memory for example.
> 
> Are you sure you actually need and want a dma_fence here?

Waiting for potentially a ton of IO synchronously on invalidate
sounds like a bad idea though. Hmm.

>> +
>> +	dma_resv_lock(dmabuf->resv, NULL);
>> +	ctx->dev_ops->unmap(ctx, map);
>> +	dma_resv_unlock(dmabuf->resv);
>> +
>> +	dma_fence_put(&fence->base);
> 
> You should probably set map->fence to NULL after that.

The map is freed two lines below, but I can add it as
a defensive measure.

>> +	percpu_ref_exit(&map->refs);
>> +	kfree(map);

...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +	struct dma_buf_io_map *map;
>> +	long ret;
>> +
>> +retry:
>> +	/*
>> +	 * ->dmabuf_map() will be calling dma_buf_map_attachment(), for which
>> +	 * we'll need to wait for fences. Do a bit nicer and try to wait
>> +	 * without the resv lock first.
>> +	 */
> 
> Clear NAK to that. Always wait while holding the resv lock if you can!
> 
> It is absolutely not beneficial to do this outside of the lock and usually just hides problems instead and prevent fixing them.

Ok

...
>> +	ret = dma_resv_reserve_fences(dmabuf->resv, 1);
>> +	if (WARN_ON_ONCE(ret)) {
>> +		struct dma_fence *fence = &map->fence->base;
>> +
>> +		dma_fence_get(fence);
>> +		percpu_ref_kill(&map->refs);
>> +		dma_fence_wait(fence, false);
>> +		dma_fence_put(fence);
>> +		return;
>> +	}
>> +
>> +	dma_resv_add_fence(dmabuf->resv, &map->fence->base,
>> +			   DMA_RESV_USAGE_KERNEL);
> 
> That sequence is clearly incorrect!
> 
> The fence must be created after dma_resv_reserve_fences(), otherwise you definately have an illegal memory operation here.

I'm not sure what you mean, can you elaborate? I only cared about
pre-allocating it to avoid allocations here. We add / signal the fence
only once, no reuse. The map is going to be killed here, and if we
create a new map, it'll have its own fence.

I can move the dma_fence_init() call here if that makes a difference?

-- 
Pavel Begunkov


