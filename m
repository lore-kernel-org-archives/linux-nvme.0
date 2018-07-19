From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 16:10:25 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719134203.GA15212@lst.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
Message-ID: <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>

On Thu, Jul 19, 2018@03:42:03PM +0200, Christoph Hellwig wrote:
> Without even looking at the code yet:  why?  The nvme abort isn't
> very useful, and due to the lack of ordering between different
> queues almost harmful on fabrics.  What problem do you try to
> solve?

The problem I'm trying to solve here is really just single commands
timing out because of i.e. a bad switch in between which causes frame
loss somewhere.

I know RDMA and FC are defined to be lossless but reality sometimes
has a different view on this (can't talk too much for RDMA but I've
had some nice bugs in SCSI due to faulty switches dropping odd
frames).

Of cause we can still do the big hammer if one command times out due
to a misbehaving switch but we can also at least try to abort it. I
know aborts are defined as best effort, but as we're in the error path
anyways it doesn't hurt to at least try.

This would give us a chance to recover from such situations, of cause
given the target actually does something when receiving an abort.

In the FC case we can even send an ABTS and try to abort the command
on the FC side first, before doing it on NVMe. I'm not sure if we can
do it on RDMA or PCIe as well.

So the issue I'm trying to solve is easy, if one command times out for
whatever reason, there's no need to go the big transport reset route
before not even trying to recover from it. Possibly we should also try
doing a queue reset if aborting failed before doing the transport
reset.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
