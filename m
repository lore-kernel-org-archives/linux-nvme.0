From: chuck.lever@oracle.com (Chuck Lever)
Date: Mon, 10 Jul 2017 23:57:32 -0400
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <20170710220905.GA22589@obsidianresearch.com>
References: <66b1b8be-e506-50b8-c01f-fa0e3cea98a4@grimberg.me>
 <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
 <11aa1a24-9f0b-dbb8-18eb-ad357c7727b2@grimberg.me>
 <9E30754F-464A-4B62-ADE7-F6B2F6D95763@oracle.com>
 <20170709164755.GB3058@obsidianresearch.com>
 <A7C8C159-E916-4060-9FD1-8726D816B3C0@oracle.com>
 <20170710212430.GA21721@obsidianresearch.com>
 <C142385D-3A54-44C9-BA3D-0AABBC5E9E7B@oracle.com>
 <20170710213251.GA21908@obsidianresearch.com>
 <A342254B-1ECB-4644-8D68-328A52940C52@oracle.com>
 <20170710220905.GA22589@obsidianresearch.com>
Message-ID: <718A099D-3597-4262-9A33-0BA7EFE5461F@oracle.com>


> On Jul 10, 2017,@6:09 PM, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> 
> On Mon, Jul 10, 2017@06:04:18PM -0400, Chuck Lever wrote:
> 
>>> The server sounds fine, how does the client work?
>> 
>> The client does not initiate RDMA Read or Write today.
> 
> Right, but it provides an rkey that the server uses for READ or WRITE.
> 
> The invalidate of that rkey at the client must follow the same rules
> as inline send.

Ah, I see.

The RPC reply handler calls frwr_op_unmap_sync to invalidate
any MRs associated with the RPC.

frwr_op_unmap_sync has to sort the rkeys that are remotely
invalidated, and those that have not been.

The first step is to ensure all the rkeys for an RPC are
invalid. The rkey that was remotely invalidated is skipped
here, and a chain of LocalInv WRs is posted to invalidate
any remaining rkeys. The last WR in the chain is signaled.

If one or more LocalInv WRs are posted, this function waits
for LocalInv completion.

The last step is always DMA unmapping. Note that we can't
get a completion for a remotely invalidated rkey, and we
have to wait for LocalInv to complete anyway. So the DMA
unmapping is always handled here instead of in a
completion handler.

When frwr_op_unmap_sync returns to the RPC reply handler,
the handler calls xprt_complete_rqst, and the RPC is
terminated. This guarantees that the MRs are invalid before
control is returned to the RPC consumer.


In the ^C case, frwr_op_unmap_safe is invoked during RPC
termination. The MRs are passed to the background recovery
task, which invokes frwr_op_recover_mr.

frwr_op_recover_mr destroys the fr_mr and DMA unmaps the
memory. (It's also used when registration or invalidation
flushes, which is why it uses a hammer).

So here, we're a little fast/loose: the ordering of
invalidation and unmapping is correct, but the MRs can be
invalidated after the RPC completes. Since RPC termination
can't wait, this is the best I can do for now.


--
Chuck Lever
