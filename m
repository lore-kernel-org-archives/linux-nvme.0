Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C97BC982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofpT4h/xZOk97T1LnY16xox+YwsLCtjUsNXPXQGc7Q0=; b=X3T9hp4sDPAkm/qJCHL4flNUZe
	pCL5ukK15Fqaj6lI5cDGNhJjNYrmc+0H/Y9jqgO7ZucPQiC73MTmaHQY4g/Ff/w/6xpThsTM5QY2/
	tUni+JVruvJsf2wBReWDXtGv4Tu29j48ziXcjxTl1UunXc3T/Dke6YTyiJi4zu7eucjLc4XyN4X8F
	baDUvReIugXpk8oQaY4c8nFxUr4ecPLMhZvakW/kV/duh5NmQG7WpmR5Hf5hOtC+soeocil+0DbHD
	c5SOBdGkHvNKH/dUun2BNUE4JymoUb2WdAKOaE/xKFpegNlcfiXp/aICUJsl7qgDW5EX7UFJFCs1V
	otVxlizA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWI-00000002VmF-0RSt;
	Mon, 21 Sep 2026 15:01:26 +0000
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eWE-00000002JJD-3jWh
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:57:20 +0000
Received: by mail-ed2-x0f.google.com with SMTP id 4fb4d7f45d1cf-6aa13e194easo4685494a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999037; x=1790603837; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ofpT4h/xZOk97T1LnY16xox+YwsLCtjUsNXPXQGc7Q0=;
        b=kXZakYsBaJU40kdRJ2zq8kXmSHuyqNmRZI5odglBj8PinaIKrrU4eog1otYQ9vvgq7
         uY2UYTXHbfNng+ucDAXMMD3MwkyW0151+ZNxG0QZ9QNZt7DSNKiwsSwKsV3GeV1rz+DF
         jwnwbL/UhdvXFV8CYbAdEx32MN/AtDFV43cymKysWi8dFTfrSVHaOkxPz2RUoGd0Z8DO
         CcC2Fbgj1cKfXKswiX3c2hZLcyJYlOHhFXK/SZ2/C9C9HB6IH26DaHcPtf0DT5kuu+oF
         mYodx7qJfrD03PAtXnyXQqfWaLH1M+cCT4DUv6lBdXErZZ5SxpWVcVLw7av6N7aVyi8x
         hEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999037; x=1790603837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ofpT4h/xZOk97T1LnY16xox+YwsLCtjUsNXPXQGc7Q0=;
        b=Z8fu09MqDQgEEocgJlKQjM66FZyEz10hBL/pvsbwCGfl+6eIy0cDfd3/bmye+MuTcO
         mhj3eadBQ59zKeRg03LaJm1u5O2tq8uJEGgJ+Nlnr9CbjL3bEkshdyDmxpRv6eb53H+E
         Hu1+DQQI1ZugoUwFI3HEZ1UQDfY7jl8RiJesRJ40Ix8HJj9xCTAM5zFlrOHfpd23kjWE
         1d6icjZxTj1FoDW9dF8JMn9Q77dm029QbpY6vdAPeIz8byHvaDGWVnJ+njCkiGqymyZ/
         AhHfpiLWEQA/Ee8+lTaX5yfHgJd80GyK65w3DJ2q/qU8fFuJu+aC5L+rXLeIWSwhcNJr
         1nQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBw7q3CeavU2Uad7u5kuKMbcQOWO+ohhB007B5+EIznRLz0ZUNVOeRU5A+1UmQYklAy/N9OsWa37Lm@lists.infradead.org
X-Gm-Message-State: AFuF++mrRuIaSfTF1ug6m0j9nbaNIvqQWHQmm5cQSvKZ+aYc4mK4F5rk
	4vTeOI8SfwGBNpQJWvG5sl77j6l3qoPAvKZNecbquFInv3lwNz37v5sq
X-Gm-Gg: AYBFou0jUxJolBHpYAGL1h34hAXPDNc1r8aJYS4qoBCQCfeQfOQNexHPnuyAIB90ZFj
	ClbWnkB3X5x2M8ZuLI+wwhf0GiemXlm72LoZAA5TR5ovjX3sI0VJuVEUVZoeWDFIBbDGB/jGTh8
	/XHRIDTNoHFifOLUuaOPzxKeXvFkVq/AjRp4Ui3mDh68Nc+pBSkNiNRpbsoZEXshGRD120ldsjq
	Ct0jRHMjNLwhz5oSjwj23ylXsj3oKm4Y0g6y9UXMSX9xWFIK7TtGaJJfxIAqSofW/Lo9ls/Vc6f
	B1PNuA7LIFyhB/2rZVG9KveshcPz3TcCCKfVKAR1ZaGizAjusDa6MgiYqFBPCVC9vPZfCYBNpg8
	c0WLhL5bVJv+uN+zl5/kuXDH1y+R8n9j9bZ2KclZC2U9SbFNbG1nmv+g7bwGQhGw4Q/GFXXXwax
	8g6fOimfRpyR60Kwgn2nRLm6NCm8C8p4fcCxUfNAVRCZR1bAVoP/heeEeUk+2S8iQ7eaqh6Z0YP
	DorD+x05exVsVX3sKwNg0Pul1fENMinEyAEzE3p/ebJkg3hT+9T+Pu4Hevo/2s+RuEQhnyOir8f
	qyv+IAO+6sIh0YSQ1UlLu2JON+Dg4hcB+Z1l
X-Received: by 2002:a05:6402:210f:b0:6a9:aead:4e98 with SMTP id 4fb4d7f45d1cf-6aa577f5cfdmr8215865a12.1.1789999036894;
        Mon, 21 Sep 2026 06:57:16 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e0d3c5sm4446691a12.22.2026.09.21.06.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:57:14 -0700 (PDT)
Message-ID: <a8b01e56-bc86-412b-862c-d6a3efef2e6d@gmail.com>
Date: Mon, 21 Sep 2026 14:57:05 +0100
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
 <8285ede8-bebb-403a-8a37-b9987cd37a8f@gmail.com>
 <0113c49a-a364-4df6-9ab4-681c789d9d3b@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <0113c49a-a364-4df6-9ab4-681c789d9d3b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_065718_955044_F2DB0D7E 
X-CRM114-Status: GOOD (  18.43  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:23 -0700
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

On 8/6/26 08:29, Christian König wrote:
> On 8/5/26 12:59, Pavel Begunkov wrote:
>> On 8/5/26 09:27, Christian König wrote:
> 
>>>> +
>>>> +    dma_resv_lock(dmabuf->resv, NULL);
>>>> +    ctx->dev_ops->unmap(ctx, map);
>>>> +    dma_resv_unlock(dmabuf->resv);
>>>> +
>>>> +    dma_fence_put(&fence->base);
>>>
>>> You should probably set map->fence to NULL after that.
>>
>> The map is freed two lines below, but I can add it as
>> a defensive measure.
> 
> In that case it's ok, I've just haven't seen the kfree(map) below.
> 
>> ...
>>>> +    ret = dma_resv_reserve_fences(dmabuf->resv, 1);
>>>> +    if (WARN_ON_ONCE(ret)) {
>>>> +        struct dma_fence *fence = &map->fence->base;
>>>> +
>>>> +        dma_fence_get(fence);
>>>> +        percpu_ref_kill(&map->refs);
>>>> +        dma_fence_wait(fence, false);
>>>> +        dma_fence_put(fence);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    dma_resv_add_fence(dmabuf->resv, &map->fence->base,
>>>> +               DMA_RESV_USAGE_KERNEL);
>>>
>>> That sequence is clearly incorrect!
>>>
>>> The fence must be created after dma_resv_reserve_fences(), otherwise you definately have an illegal memory operation here.
>>
>> I'm not sure what you mean, can you elaborate? I only cared about
>> pre-allocating it to avoid allocations here. We add / signal the fence
>> only once, no reuse. The map is going to be killed here, and if we
>> create a new map, it'll have its own fence.
>>
>> I can move the dma_fence_init() call here if that makes a difference?
> 
> Yeah that is a good start, but you might need a bit more.
> 
> Here is a summary of the usual procedure you need to follow when implementing a dma_fence backend:
> 
> 1. Allocate your operation object, in this case here it's your mapping I think.
> 2. Prepare your operation, including all memory allocations.
> 3. Call dma_resv_reserve_fences() to reserve a fence slot.
> 4. Allocate and init your dma_fence object.

Looks I forgot it reply here, sorry for that. I killed dma fences in
v6 in favour of synchronous waiting, it turned to be less trouble even
outside of these fencing rules as I can rely on dma-resv lock less in
the code.

-- 
Pavel Begunkov


