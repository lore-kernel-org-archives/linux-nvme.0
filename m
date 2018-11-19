From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 19 Nov 2018 08:18:52 -0700
Subject: [PATCH] nvme: default to 0 poll queues
In-Reply-To: <20181119075737.GA10256@lst.de>
References: <a2d999c8-135a-745f-07c2-e6c2dc52fff1@kernel.dk>
 <20181119075737.GA10256@lst.de>
Message-ID: <74ea552a-d942-b741-e85a-b3d3bc4dc2b2@kernel.dk>

On 11/19/18 12:57 AM, Christoph Hellwig wrote:
> On Sat, Nov 17, 2018@10:06:20AM -0700, Jens Axboe wrote:
>> We need a better way of configuring this, and given that
>> polling is (still) a bit niche, let's default to using
>> 0 poll queues. That way we'll have the same read/write/poll
>> behavior as 4.20, and users that want to test/use polling
>> are required to do manual configuration of the number of
>> poll queues.
>>
>> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> 
> Looks good (except that you could use more of each line for the
> commit log).
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> Given that the poll queues were introduced in the block tree, can you
> queue it up there?

Yep will do, stretched to 72 as well :-)

-- 
Jens Axboe
