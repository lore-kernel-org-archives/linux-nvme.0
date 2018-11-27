From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Nov 2018 08:20:05 -0700
Subject: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
In-Reply-To: <eee2f768-5ca2-aaa1-7d04-4fd7c9623312@grimberg.me>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
 <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
 <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
 <eee2f768-5ca2-aaa1-7d04-4fd7c9623312@grimberg.me>
Message-ID: <470ea9e2-9546-8001-bed9-ed4753f061cb@kernel.dk>

On 11/27/18 3:10 AM, Sagi Grimberg wrote:
>> No, it'll be exactly the same, and believe me, I've done plenty of
>> performance testing to ensure that it works well.  In fact, with the
>> changes queued up and this on top, polling is both faster and more
>> efficient than it ever has been before, for both the classic
>> preadv2/pwritev2 and the async polled IO.
> 
> I don't argue that this has not been tested, I was referring to the
> following use-case: app queues say 16 I/Os with io_submit and then
> issues preadv2 for an "important" 512B sector.
> 
> With this proposed change, is poll_fn more likely to return with the
> first completion it sees rather than continue poll until it sees that
> specific I/O it polled for?

Any IO completion will make it return, that was the case before and that
is still the case. If it isn't your specific IO, then you get to go
around the loop again.

>> I think that would be useless. For SYNC type polling with one thread, it
>> doesn't matter if we're looking for a particular IO, or just any IO.
>> Once your into two threads, you're already wasting huge amounts of CPU,
>> just to get to QD=2. The poll loop handles finding each others IOs just
>> fine, so there's no worry on that side.
>>
>> Polling was originally designed for the strictly SYNC interfaces, and
>> since we had the cookie anyway, it was tempting to look for a specific
>> IO. I think that was a mistake, as it assumed that we'd never do async
>> polling.
> 
> Not arguing. Just now that we already have the selective interface in
> place I'm asking is it OK to change that (IFF the above question is
> indeed real) esoteric as this use-case may be...

It won't cause any real change for the sync use case. There's no
difference between multiple sync users of polling and a mixed async/sync
polled use case in that regard.

-- 
Jens Axboe
