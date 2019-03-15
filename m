From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Mar 2019 19:24:58 +0100
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <cd8a5428-602f-c9c9-3cf9-235d13a9451a@grimberg.me>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me> <20190312143231.GA1149@lst.de>
 <8a80ce70-0b98-6c82-a47c-f312a41d2d2a@grimberg.me>
 <20190315162837.GA27308@lst.de>
 <cd8a5428-602f-c9c9-3cf9-235d13a9451a@grimberg.me>
Message-ID: <20190315182458.GB3582@lst.de>

On Fri, Mar 15, 2019@10:17:18AM -0700, Sagi Grimberg wrote:
>
>>>> I like the idea behind this, but it looks rather convoluted.  I think
>>>> for the unusable namespace case we should warn and have a common label
>>>> that just sets the capacity, not touching anything else.
>>>>
>>>> Does something like this work for you?
>>>
>>> No, this is what I had done originally, but we need to always have the
>>> queue set to a decent block size, otherwise blk_queue_stack_limits()
>>> panics on div by 0..
>>
>> I actually tested it by manually hacking a 8k block size into nvmet
>> and and it works just fine for me.  Where do you see a division by
>> zero with this patch exactly?
>
> You need your block size to exceed u16 bs.

I'll need to look into actually testing something that large, but
the whole point of my patch is that we never even use the bs value
for anything. So I'm not sure why that would matter.
