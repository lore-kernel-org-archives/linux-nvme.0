From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Jul 2017 15:14:06 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <C04891DF-5B3B-4156-9E04-9E18B238864A@oracle.com>
References: <f1f1a68c-90db-e6bf-e35e-55c4b469c339@grimberg.me>
 <7D1C540B-FEA0-4101-8B58-87BCB7DB5492@oracle.com>
 <66b1b8be-e506-50b8-c01f-fa0e3cea98a4@grimberg.me>
 <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
 <11aa1a24-9f0b-dbb8-18eb-ad357c7727b2@grimberg.me>
 <9E30754F-464A-4B62-ADE7-F6B2F6D95763@oracle.com>
 <20170709164755.GB3058@obsidianresearch.com>
 <A7C8C159-E916-4060-9FD1-8726D816B3C0@oracle.com>
 <20170710200522.GA19293@obsidianresearch.com>
 <C04891DF-5B3B-4156-9E04-9E18B238864A@oracle.com>
Message-ID: <20170710211406.GA20889@obsidianresearch.com>

On Mon, Jul 10, 2017@04:51:20PM -0400, Chuck Lever wrote:
> 
> > On Jul 10, 2017,@4:05 PM, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> > 
> > On Mon, Jul 10, 2017@03:03:18PM -0400, Chuck Lever wrote:
> > 
> >> One option is to somehow split the Send-related data structures from
> >> rpcrdma_req, and manage them independently. I've already done that for
> >> MRs: MR state is now located in rpcrdma_mw.
> > 
> > Yes, this is is what I was implying.. Track the SQE related stuff
> > seperately in memory allocated during SQ setup - MR, dma maps, etc.
> 
> > No need for an atomic/lock then, right? The required memory is bounded
> > since the inline send depth is bounded.
> 
> Perhaps I lack some imagination, but I don't see how I can manage
> these small objects without a serialized free list or circular
> array that would be accessed in the forward path and also in a
> Send completion handler.

I don't get it, dma unmap can only ever happen in the send completion
handler, it can never happen in the forward path. (this is the whole
point of this thread)

Since you are not using send completion today you can just use the
wr_id to point to the pre-allocated memory containing the pages to
invalidate. Completely remove dma unmap from the forward path.

Usually I work things out so that the meta-data array is a ring and
every SQE post consumes a meta-data entry. Then occasionally I signal
completion and provide a wr_id of the latest ring index and the
completion handler runs through all the accumulated meta-data and acts
on it (eg unmaps/etc). This approach still allows batching
completions.

Since ring entries are bounded size we just preallocate the largest
size at QP creation. In this case it is some multiple of the number of
inline send pages * number of SQE entries.

> This seems like a lot of overhead to deal with a very uncommon
> case. I can reduce this overhead by signaling only Sends that
> need to unmap page cache pages, but still.

Yes, but it is not avoidable..

> As we previously discussed, xprtrdma does SQ accounting using RPC
> completion as the gate. Basically xprtrdma will send another RPC
> as soon as a previous one is terminated. If the Send WR is still
> running when the RPC terminates, I can potentially overrun the
> Send Queue.

Makes sense. The SQ accounting must be precise.

Jason
