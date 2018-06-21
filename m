From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 00:09:54 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
Message-ID: <20180621070954.GA21304@infradead.org>

On Wed, Jun 20, 2018@02:09:03PM -0600, Jens Axboe wrote:
> Talking more to myself - higher order allocations needed to make
> progress isn't a viable approach. There may _never_ be any available,
> which means we are stuck since this isn't backed by a mempool.

Yes, I've complained about that a few times in the past, but so far
no one has hit it in practice.

> How about something like the below. Default to a size that will
> never require > PAGE_SIZE allocation, and back that with a single
> entry mempool. Even if we don't wait on it, if we keep retrying
> we'll always be able to allocate memory and make forward progress.
> And allocating a single page is a hell of a lot more likely than
> a 2nd order allocation.

I suspect some people might be unhappy about the limit on I/O
sizes.  That is why we want through all that effort with
chained S/G lists in SCSI, which are now also used by NVMe over
Fabrics.  But except for that we absolutely have to move to
mempools.
