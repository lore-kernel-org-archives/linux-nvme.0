From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 08:21:15 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517074732.GA24736@infradead.org>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org> <20180517074732.GA24736@infradead.org>
Message-ID: <b6b84242-9bf3-ed78-6257-31c4ee8ee5cb@kernel.dk>

On 5/17/18 1:47 AM, Christoph Hellwig wrote:
> On Thu, May 17, 2018@12:16:51AM -0700, Christoph Hellwig wrote:
>> On Wed, May 16, 2018@09:47:50PM -0600, Keith Busch wrote:
>>> Looks good to me. Queued up for 4.18 with just a minor changelog
>>> update.
>>
>> Folks, can we please at least wait a night to give other ins a
>> different time zone to review?  In fact for things not entirely critical
>> and non-trivial a few days would be good.
> 
> And here is the patch with my suggestions from the last round:

Looks good to me, also tests out fine.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
