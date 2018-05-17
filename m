From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 08:16:17 -0600
Subject: [PATCH] nvme: remove cq check after submission
In-Reply-To: <20180517065049.GA30079@infradead.org>
References: <b88f65b5-5fa6-45a7-48ff-77a114c31160@kernel.dk>
 <20180516212010.GC20223@localhost.localdomain>
 <20180517065049.GA30079@infradead.org>
Message-ID: <a2ac17fd-b836-fd3a-3c26-5ecd1acb567d@kernel.dk>

On 5/17/18 12:50 AM, Christoph Hellwig wrote:
> On Wed, May 16, 2018@03:20:10PM -0600, Keith Busch wrote:
>> On Wed, May 16, 2018@01:58:08PM -0600, Jens Axboe wrote:
>>> We always check the completion queue after submitting, but in my testing
>>> this isn't a win even on DRAM/xpoint devices. In some cases it's
>>> actually worse. Kill it.
>>
>> Right, this was on my todo list. Agreed it's not helping anything.
>> Applied to nvme-4.18.
> 
> While I agree in general didn't we have a case where this caused a
> regression last time it came up?  Not that I'd complain if it goes
> away..

Not that I'm aware of. I've been running with this patch for quite
a while, while doing some work on polling.

> But more importantly we could split q_lock into a sq_lock and cq_lock
> now, which might bring real benefits.

Exactly, especially on queue starved setups.

-- 
Jens Axboe
