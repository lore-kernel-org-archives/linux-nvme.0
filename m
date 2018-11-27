From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 27 Nov 2018 02:10:48 -0800
Subject: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
In-Reply-To: <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
 <fb1200ad-35ef-1c2e-25cf-d8a71bc505b5@grimberg.me>
 <ba2d191c-cf9d-07f1-5875-6a07ef043949@kernel.dk>
Message-ID: <eee2f768-5ca2-aaa1-7d04-4fd7c9623312@grimberg.me>


>>> We currently only really support sync poll, ie poll with 1
>>> IO in flight. This prepares us for supporting async poll.
>>
>> Hey Jens,
>>
>> So are we sure that this is fine to simply replace the
>> poll functionality? you say that that we support poll
>> with only 1 I/O inflight but is it entirely true?
>> semantically speaking?
> 
> It is, unless you have multiple threads all doing polling.  Which is
> pretty inefficient, as I'm sure you know.

I am, wasn't referring to multiple threads though..


>> The interface is selective polling, which means that
>> the user can have more than a single I/O inflight but wants
>> to poll for a specific one that it really cares about.
>>
>> Would this introduce a regression for users that rely
>> on preadv2 to basically "complete *this* IO as fast as possible"?
> 
> No, it'll be exactly the same, and believe me, I've done plenty of
> performance testing to ensure that it works well.  In fact, with the
> changes queued up and this on top, polling is both faster and more
> efficient than it ever has been before, for both the classic
> preadv2/pwritev2 and the async polled IO.

I don't argue that this has not been tested, I was referring to the
following use-case: app queues say 16 I/Os with io_submit and then
issues preadv2 for an "important" 512B sector.

With this proposed change, is poll_fn more likely to return with the
first completion it sees rather than continue poll until it sees that
specific I/O it polled for?

> I think that would be useless. For SYNC type polling with one thread, it
> doesn't matter if we're looking for a particular IO, or just any IO.
> Once your into two threads, you're already wasting huge amounts of CPU,
> just to get to QD=2. The poll loop handles finding each others IOs just
> fine, so there's no worry on that side.
> 
> Polling was originally designed for the strictly SYNC interfaces, and
> since we had the cookie anyway, it was tempting to look for a specific
> IO. I think that was a mistake, as it assumed that we'd never do async
> polling.

Not arguing. Just now that we already have the selective interface in
place I'm asking is it OK to change that (IFF the above question is
indeed real) esoteric as this use-case may be...
