From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Jul 2017 15:24:30 -0600
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <A7C8C159-E916-4060-9FD1-8726D816B3C0@oracle.com>
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
Message-ID: <20170710212430.GA21721@obsidianresearch.com>

On Mon, Jul 10, 2017@03:03:18PM -0400, Chuck Lever wrote:

> >> Or I could revert all the "map page cache pages" logic and
> >> just use memcpy for small NFS WRITEs, and RDMA the rest of
> >> the time. That keeps everything simple, but means large
> >> inline thresholds can't use send-in-place.
> > 
> > Don't you have the same problem with RDMA WRITE?
> 
> The server side initiates RDMA Writes. The final RDMA Write in a WR
> chain is signaled, but a subsequent Send completion is used to
> determine when the server may release resources used for the Writes.
> We're already doing it the slow way there, and there's no ^C hazard
> on the server.

Wait, I guess I meant RDMA READ path.

The same contraints apply to RKeys as inline send - you cannot DMA
unmap rkey memory until the rkey is invalidated at the HCA.

So posting an invalidate SQE and then immediately unmapping the DMA
pages is bad too..

No matter how the data is transfered the unmapping must follow the
same HCA synchronous model.. DMA unmap must only be done from the send
completion handler (inline send or invalidate rkey), from the recv
completion handler (send with invalidate), or from QP error state teardown.

Anything that does DMA memory unmap from another thread is very, very
suspect, eg async from a ctrl-c trigger event.

Jason
