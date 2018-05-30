From: cl@linux.com (Christopher Lameter)
Date: Wed, 30 May 2018 17:02:24 +0000
Subject: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
In-Reply-To: <b73350c8-8596-70ec-082a-e8fdf1e68d04@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <55c82aa5730c05017a58641ad9550b6c0f0e16b2.1527618402.git.swise@opengridcomputing.com>
 <01000163b1bd094e-8a191404-8725-40c0-9af5-c4b69f324a1d-000000@email.amazonses.com>
 <b73350c8-8596-70ec-082a-e8fdf1e68d04@opengridcomputing.com>
Message-ID: <01000163b200272d-9854763b-3e09-42a9-bb95-aa8a83243b4e-000000@email.amazonses.com>

On Wed, 30 May 2018, Steve Wise wrote:

> > Now we do higher order allocations here. This means that the allocation
> > can fail if system memory is highly fragmented. And the allocations can no
> > longer be satisfied from the per cpu caches. So allocation performance
> > will drop.
>
> Yes.

Maybe do some test with fragmented memory?

> >>  		if (!c->inline_page)
> >>  			goto out_unmap_cmd;
> > Maybe think about some sort of fallback to vmalloc or so if this
> > alloc fails?
>
> The memory needs to be physically contiguous and will be mapped for DMA,
> so vmalloc() won't work.?
>
> I could complicate the design and allocate a scatter gather table for
> this memory, and then register it into a single RDMA MR.?? That would
> allow allocating non-contiguous pages.? But is that complication worth
> it here?

Not sure..... Just saw the higher alloc and I have seen what other
subsystems went through when dealing with larger order allocations
