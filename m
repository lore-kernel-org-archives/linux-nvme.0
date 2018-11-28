From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 05:54:04 -0700
Subject: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
In-Reply-To: <20181128071601.GA11774@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-4-axboe@kernel.dk>
 <20181128071601.GA11774@infradead.org>
Message-ID: <dd6bf846-c5f4-8aea-64fa-bf613d5079d2@kernel.dk>

On 11/28/18 12:16 AM, Christoph Hellwig wrote:
> On Mon, Nov 26, 2018@09:35:51AM -0700, Jens Axboe wrote:
>> blk-mq passes information to the hardware about any given request being
>> the last that we will issue in this sequence. The point is that hardware
>> can defer costly doorbell type writes to the last request. But if we run
>> into errors issuing a sequence of requests, we may never send the request
>> with bd->last == true set. For that case, we need a hook that tells the
>> hardware that nothing else is coming right now.
>>
>> For failures returned by the drivers ->queue_rq() hook, the driver is
>> responsible for flushing pending requests, if it uses bd->last to
>> optimize that part. This works like before, no changes there.
>>
>> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> 
> This looks fine, but normally I would only add the method together with
> the actual user..

I included the two hunks from patch 7 in this one, so there's a real
use (and fix) with it.

-- 
Jens Axboe
