From: axboe@fb.com (Jens Axboe)
Date: Wed, 23 Jul 2014 21:07:31 +0200
Subject: [PATCH v10] NVMe: Convert to blk-mq
In-Reply-To: <53D005D6.8050302@bjorling.me>
References: <1404226382-7179-1-git-send-email-m@bjorling.me>
 <1404226382-7179-2-git-send-email-m@bjorling.me>
 <20140714124131.GA311@infradead.org> <53D005D6.8050302@bjorling.me>
Message-ID: <53D007F3.4040006@fb.com>

On 2014-07-23 20:58, Matias Bjorling wrote:
>>> +    iod = nvme_alloc_iod(psegs, blk_rq_bytes(req), GFP_ATOMIC);
>>>       if (!iod)
>>> +        return result;
>>
>> So there's still a memory allocation for each request here.  Any reason
>> this can't be preallocated at least for reasonable sized I/O?
>
> Not at all. I've kept from adding optimizations in the first pass. The
> patches following can implement the optimizations. Jens already has a
> patch for this in his tree. It also removes GFP_ATOMIC.

That is correct, and that is the way the series should be done. I've got 
patches getting rid of this allocation for smaller IO:

http://git.kernel.dk/?p=linux-block.git;a=commit;h=04497c3394f3220111d4274704a1ff6bdd3ceae3

which is a noticable win for high IOPS smaller IO.

>> Seems like blk-mq would make your life easier by exporting an iterator
>> that goes over each in-use request instead of the current
>> blk_mq_tag_busy_iter prototype.  blk_mq_timeout_check would also be able
>> to make use of that, so maybe that would be a good preparatory patch?
>
> Yes. I'll prepare a patch and send it off to Jens.

Thanks, that will clean it up nicely. It's a bit backwards these days, 
since the mechanism got changed.


-- 
Jens Axboe
