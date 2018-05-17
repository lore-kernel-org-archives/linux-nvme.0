From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 08:22:01 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517142159.GC22063@localhost.localdomain>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org>
 <20180517142159.GC22063@localhost.localdomain>
Message-ID: <39c39949-1aea-4892-1d80-5ea58d1ced24@kernel.dk>

On 5/17/18 8:21 AM, Keith Busch wrote:
> On Thu, May 17, 2018@12:16:51AM -0700, Christoph Hellwig wrote:
>> On Wed, May 16, 2018@09:47:50PM -0600, Keith Busch wrote:
>>> Looks good to me. Queued up for 4.18 with just a minor changelog
>>> update.
>>
>> Folks, can we please at least wait a night to give other ins a
>> different time zone to review?  In fact for things not entirely critical
>> and non-trivial a few days would be good.
> 
> Fair enough. I did rush this one. I can back it out as we go through
> your suggestions.

Just apply it on top, doesn't really warrant a rebase imho. But yeah,
we should probably cool the jets for a day next time :-)

-- 
Jens Axboe
