From: chuck.lever@oracle.com (Chuck Lever)
Date: Mon, 10 Jul 2017 16:51:20 -0400
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <20170710200522.GA19293@obsidianresearch.com>
References: <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
 <9990B5CB-E0FF-481E-9F34-21EACF0E796E@oracle.com>
 <f1f1a68c-90db-e6bf-e35e-55c4b469c339@grimberg.me>
 <7D1C540B-FEA0-4101-8B58-87BCB7DB5492@oracle.com>
 <66b1b8be-e506-50b8-c01f-fa0e3cea98a4@grimberg.me>
 <9D8C7BC8-7E18-405A-9017-9DB23A6B5C15@oracle.com>
 <11aa1a24-9f0b-dbb8-18eb-ad357c7727b2@grimberg.me>
 <9E30754F-464A-4B62-ADE7-F6B2F6D95763@oracle.com>
 <20170709164755.GB3058@obsidianresearch.com>
 <A7C8C159-E916-4060-9FD1-8726D816B3C0@oracle.com>
 <20170710200522.GA19293@obsidianresearch.com>
Message-ID: <C04891DF-5B3B-4156-9E04-9E18B238864A@oracle.com>


> On Jul 10, 2017,@4:05 PM, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> 
> On Mon, Jul 10, 2017@03:03:18PM -0400, Chuck Lever wrote:
> 
>> One option is to somehow split the Send-related data structures from
>> rpcrdma_req, and manage them independently. I've already done that for
>> MRs: MR state is now located in rpcrdma_mw.
> 
> Yes, this is is what I was implying.. Track the SQE related stuff
> seperately in memory allocated during SQ setup - MR, dma maps, etc.

> No need for an atomic/lock then, right? The required memory is bounded
> since the inline send depth is bounded.

Perhaps I lack some imagination, but I don't see how I can manage
these small objects without a serialized free list or circular
array that would be accessed in the forward path and also in a
Send completion handler.

And I would still have to signal all Sends, which is extra
interrupts and context switches.

This seems like a lot of overhead to deal with a very uncommon
case. I can reduce this overhead by signaling only Sends that
need to unmap page cache pages, but still.


But I also realized that Send Queue accounting can be broken by a
delayed Send completion.

As we previously discussed, xprtrdma does SQ accounting using RPC
completion as the gate. Basically xprtrdma will send another RPC
as soon as a previous one is terminated. If the Send WR is still
running when the RPC terminates, I can potentially overrun the
Send Queue.


--
Chuck Lever
