From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 29 Nov 2018 09:52:51 -0700
Subject: [PATCH 2/7] blk-mq: add mq_ops->commit_rqs()
In-Reply-To: <20181129154546.GB7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-3-axboe@kernel.dk>
 <20181129154546.GB7234@infradead.org>
Message-ID: <d4ee9225-f26b-e460-a579-af518123ad72@kernel.dk>

On 11/29/18 8:45 AM, Christoph Hellwig wrote:
> On Wed, Nov 28, 2018@06:35:33AM -0700, Jens Axboe wrote:
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
>> Reviewed-by: Omar Sandoval <osandov at fb.com>
>> Reviewed-by: Ming Lei <ming.lei at redhat.com>
>> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> I don't think I actually reviewed it before in this form.
> 
> But now that I took a look it does indeed look fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Only change is moving those two hunks from the later patch into this
one, so it isn't an empty declaration.

-- 
Jens Axboe
