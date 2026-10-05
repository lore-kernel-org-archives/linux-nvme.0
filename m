Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E06CA5FFC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tN32JBtkwvrpOHkqPOwCz1peQMff+9nW+9FnKuTc/9Y=; b=fTLgpeGyaVO1JtZY08W2n0Ntga
	YUJptwWt4pKGgjSBfsWzhjYyQMEYj/m+NlhPfevc0w/vwnKskqw8NrijQmZGH3mshGX/pVaV0Xl4u
	98QyyOdgjYQMPv4By1DZlzM3zxGwdGNothI1qTEQqQyd5coqwb1QJgToh22zvLb9AR9fI47DJNmtC
	gtSUqBvKB72BDf1jIoECSpJ7VDfzXZo6HCm2YxImTYhot1XHqYnZtWk9dF6Ld+5cUMKI7ZHJ6Aatn
	CU5EaPtazPBgUsDE447f2pnWvI3Je3Bz8YAuH27pgIF/Nio0mrbRRlQJ3IE0UMrtuIUz5sYot/KWJ
	fAa+E68w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDkBY-0000000GiBa-3CvS;
	Mon, 05 Oct 2026 15:01:00 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDhC5-0000000GMZZ-2RSq
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 11:49:22 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so14011485e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2026 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200959; x=1791805759; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tN32JBtkwvrpOHkqPOwCz1peQMff+9nW+9FnKuTc/9Y=;
        b=S2ykqvf/oQKuNpHCxQR8XsRBeUwTvGNhV/WQ5ziwknv/HV4qIyViG2CmEgJz1lx3nA
         0+jgnPuD2nlXRf+fE0x6oV75ApvgOkyyrLrtZFq2r3pjoo20K9+LflIkYdVz+QjUNA/H
         hmonm1ey/878kk8t2z+J3VuiyYS9+fEeeu2YLjVjyXIcicASNPsMtydPHpx7F3K+zFac
         thQQvfPCHQcV8rTLQxW/B7DueV4zQyRpCqntGMYBFWpUPOMOBH76vJj0nuhvmRmYqTlT
         b15aRX8HhPXb85U9xRE9bhE6bcmi9dlGjwLbLyU0RVw1oUpk4yzSK4r1SPfFxLATrPBe
         rLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200959; x=1791805759;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tN32JBtkwvrpOHkqPOwCz1peQMff+9nW+9FnKuTc/9Y=;
        b=ckroVD96eJaaXONHoSrDHtCBsfhFjdQ+/JH614Yszt3Z80UBxjopSxbNYAzQB/YGs5
         V68pRUpE3NqgAxArWwFD+fWwc8qUoZXw1sIG/uZE6T0/rzUqsW6bfv3DcDmdXz1kcxQN
         guFbppFBVB9142+61mgjyf1vYv24NAbHEUayxXUKnF0dRCSXEssUbOe9MSiPQvEIDQPE
         M2vYaC6CMHv2boMJ/FL73eof7kWTzPA9yO+dFED7BwCBJ6+rGfLO07dBzH6YjceupoLQ
         ge+FjK1quQ4ndbiRQI5D71GX13EY6tIgQ6TKljacfZLR0LkimiaJ2fZAHWd17FlVcroN
         DTjA==
X-Forwarded-Encrypted: i=1; AKwUvBzteISI1PfTM+vl898DgPbogYZfmWSUyAn3PzbKgunowJ6no/fonQzP7p/wnIR1Gq5QPsw9xdPu3VC6@lists.infradead.org
X-Gm-Message-State: AFuF++lUhZDMGv9aaDJkECAtKibwB9IixSia6sclIEfjmF2YWFMrAOLy
	boAYtWdh0dMea9pxvi70uNJwf1ESsRkyLsZ0ZrG4nPcL8ZqaLbcUJNrx
X-Gm-Gg: AYBFou3yoBC76uGbgN3uf41iVfErK1kHQsaZvC8tOzY08N9UP22odsVjIX/49SAKXhc
	aCi3pfLV1qLCBLjjJLn527iMDFDNX+D1mLgZZcq4K+QymnbKg5ZtloVlgfwIbfsRxccjVfYAIjS
	DOfIjfJOrLtjr3UqpOd/k9I4dbjBWf9Po1p6b/3Ht16SuXcJxzTZNsqWacSkgXzknIkV8MEh0LQ
	xZUCrz0lKX39/ZLWOoTFm3d0bKYFzbcLL41QJRZxklV1gYqRr1zUNLwYeE6GB3GoliPkY8Pc1Y+
	BTWnneSarNe3fyCLL2mFDt7S/unuoAQJWiyURfIebUK96yyZwVlLQ+AG2+TWfTjbkTj5pxwK42N
	gEk5qQQI7beYoUmjaRJ5CoLewWvkfhalxJvGUea89jkU3etbo3EB3r8CFV2AeSAuHXrNM05iChr
	3XKxYTLNqIhRnTVHJqozSUUfOrXcfU2Prr3aaf12RMxzqw2b9NTloe4y2n/DP0cEwTgO5/pjRko
	S/9C00wV5AA+e3PqYS8nIN9IPP3xTkU298XEYmeyGUQcL88Ot5IAQwNlybie5RnZ2v/JTFmJdo=
X-Received: by 2002:a05:600c:1c08:b0:4a1:722a:d2a3 with SMTP id 5b1f17b1804b1-4a1722ad405mr52583605e9.23.1791200959268;
        Mon, 05 Oct 2026 04:49:19 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027727cecsm346670305e9.9.2026.10.05.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:49:18 -0700 (PDT)
Message-ID: <c15a7ff3-121e-481b-93e4-466f89520ae4@gmail.com>
Date: Mon, 5 Oct 2026 12:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
 <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
 <c07404e0-33f6-4e5f-a80a-e1901b42dc39@gmail.com>
 <ar1md2N4PkoXSE/N@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ar1md2N4PkoXSE/N@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_044921_676616_898E66DD 
X-CRM114-Status: GOOD (  31.39  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 08:00:59 -0700
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

On 9/30/26 20:43, Matthew Brost wrote:
> On Wed, Sep 30, 2026 at 01:48:49PM +0100, Pavel Begunkov wrote:
>> On 9/30/26 11:08, Pavel Begunkov wrote:
>>> On 9/30/26 04:00, Matthew Brost wrote:
>>>> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
>>> ...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>>>>> +{
>>>>> +    struct dma_buf *dmabuf = ctx->dmabuf;
>>>>> +    struct dma_buf_io_map *map;
>>>>> +    long ret;
>>>>> +
>>>>> +    guard(mutex)(&ctx->map_create_mutex);
>>>>> +
>>>>> +    scoped_guard(mutex, &ctx->map_mutex) {
>>>>> +        if (ctx->maps_killed)
>>>>> +            return ERR_PTR(-ENOENT);
>>>>> +        /* recheck under the lock in case it has already been re-created */
>>>>> +        map = __dma_buf_io_get_map(ctx);
>>>>> +        if (map)
>>>>> +            return map;
>>>>> +    }
>>>>> +
>>>>> +    dma_buf_io_wait_active_maps(ctx);
>>>>> +
>>>>> +    ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>>>>> +    if (ret)
>>>>> +        return ERR_PTR(ret);
>>>>> +
>>>>> +    ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>>>>> +                    true, MAX_SCHEDULE_TIMEOUT);
>>>>> +    if (ret <= 0) {
>>>>> +        if (!ret)
>>>>> +            ret = -EAGAIN;
>>>>> +        dma_resv_unlock(dmabuf->resv);
>>>>> +        return ERR_PTR(ret);
>>>>> +    }
>>>>> +
>>>>> +    map = ctx->dev_ops->map(ctx);
>>>>
>>>> I'm playing around this code now.
>>>>
>>>> I think you need the dma_resv_wait_timeout after the 'map'?
>>>>
>>>> If a device doesn't support p2p ->map() will typically trigger an async
>>>> migrate to system memory and data will be moving but the map is valid -
>>>> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
>>>> async behavior.
>>>
>>> There is a wait right before because I read somewhere in dma-buf
>>> comments that I need to do that, sounds a bit odd if I need to
>>> wait on fences before and after. I can add it, just curious how
>>> come that other dma_buf_map_attachment() callers don't need to do
>>> that. Or maybe they wait somewhere else?
> 
> In GPU drivers, when we receive a foreign object and map it in Xe or
> AMDGPU, this logic sits deep in the stack. However, the top-level call
> is typically ttm_bo_validate(), which in both drivers eventually
> resolves to the TTM ->move() vfunc. That path calls
> dma_buf_map_attachment(), which in turn invokes the dma-buf's ->map()
> callback.
> 
> That ->map() callback can trigger a asynchronous move on a different
> device, where the top-level call is again ttm_bo_validate().
> We then end up back in the TTM ->move() vfunc, where kernel fences are
> installed. I realize that's a lot of layers, but the call chain can end
> up looking like this.
> 
> Now we have a mapping and an object with kernel fences attached. Before
> the object can be used by either the exec IOCTL (batch buffer
> submission), the VM bind IOCTL (mapping into the GPU address space), or
> a CPU page fault (not relevant for dma-bufs since they cannot be
> CPU-mapped, but a useful example of a normal BO move), we wait on those
> kernel fences.
>   
> In the case of the exec IOCTL or VM bind IOCTL, the kernel fences are
> added as dependencies to a drm_sched job, delaying its execution until
> the fences signal. That is where the wait occurs. In the case of a CPU
> page fault, the kernel waits directly on the fences before installing
> the CPU page mappings.
> 
> So the TL;DR is if you want to immediately hand back a valid mapping,
> the kernel fences must be waited on before returning after ->map() call.

Thanks for the overview! I'll add the wait after ->map in v8

>> I can't find it, so maybe it was the comment below and I mixed
>> sth up back then. I'll move it after ->map().
>>
>>
>> * Note that for non-dynamic exporters the driver must guarantee that
>> * that the memory is available for use and cleared of any old data by
>> * the time this function returns.  Drivers which pipeline their buffer
>> * moves internally must wait for all moves and clears to complete.
>> * Dynamic exporters do not need to follow this rule: For non-dynamic
>> * importers the buffer is already pinned through @pin, which has the
>> * same requirements. Dynamic importers otoh are required to obey the
>> * dma_resv fences.
>> *
-- 
Pavel Begunkov


