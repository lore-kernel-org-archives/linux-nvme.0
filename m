From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:33:34 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517153007.GB19042@infradead.org>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org>
 <20180517142159.GC22063@localhost.localdomain>
 <39c39949-1aea-4892-1d80-5ea58d1ced24@kernel.dk>
 <20180517153007.GB19042@infradead.org>
Message-ID: <6df24c77-bdc8-4265-30ea-8140eedc1fbd@kernel.dk>

On 5/17/18 9:30 AM, Christoph Hellwig wrote:
> On Thu, May 17, 2018@08:22:01AM -0600, Jens Axboe wrote:
>> Just apply it on top, doesn't really warrant a rebase imho. But yeah,
>> we should probably cool the jets for a day next time :-)
> 
> Honestly, between the poll issue and things like the volatile
> annotations that should have been a separate prep patch I'd rather
> back out and restart the thing slowly.  We should still have plenty
> of time to get it done for this merge window.

The poll issue is almost moot imho, unless you have a ton of other
IO on the same hardware queue while you poll. It'll work fine, the
testing I ran didn't find anything. Agree the volatile should have
been a prep, but again not really a major thing.

-- 
Jens Axboe
