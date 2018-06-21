From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Jun 2018 08:39:47 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180621070954.GA21304@infradead.org>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180621070954.GA21304@infradead.org>
Message-ID: <ce58c5ca-e2cd-de6a-a021-7f65b56d8a21@kernel.dk>

On 6/21/18 1:09 AM, Christoph Hellwig wrote:
> On Wed, Jun 20, 2018@02:09:03PM -0600, Jens Axboe wrote:
>> Talking more to myself - higher order allocations needed to make
>> progress isn't a viable approach. There may _never_ be any available,
>> which means we are stuck since this isn't backed by a mempool.
> 
> Yes, I've complained about that a few times in the past, but so far
> no one has hit it in practice.

Well, I have :-). The problem is that it'll only really happen in
production, since no micro testing will end up with memory fragmented
enough to pose an issue.

>> How about something like the below. Default to a size that will
>> never require > PAGE_SIZE allocation, and back that with a single
>> entry mempool. Even if we don't wait on it, if we keep retrying
>> we'll always be able to allocate memory and make forward progress.
>> And allocating a single page is a hell of a lot more likely than
>> a 2nd order allocation.
> 
> I suspect some people might be unhappy about the limit on I/O
> sizes.  That is why we want through all that effort with
> chained S/G lists in SCSI, which are now also used by NVMe over
> Fabrics.  But except for that we absolutely have to move to
> mempools.

That may be the case, but it's a lot less of an issue than SCSI is,
since the command overhead is suitably small. So I don't see a big issue
with limiting it. Besides, having to do higher order allocations for an
IO is bound to pose much bigger issues than having two smaller IOs
instead. That's especially true in production, where memory allocation
stalls are pretty frequent.

-- 
Jens Axboe
