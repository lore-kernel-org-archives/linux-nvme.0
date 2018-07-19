From: james.smart@broadcom.com (James Smart)
Date: Thu, 19 Jul 2018 08:00:01 -0700
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
Message-ID: <d8da8faf-187e-6e19-7162-d6b5caddb563@broadcom.com>


On 7/19/2018 7:10 AM, Johannes Thumshirn wrote:
> On Thu, Jul 19, 2018@03:42:03PM +0200, Christoph Hellwig wrote:
>> Without even looking at the code yet:  why?  The nvme abort isn't
>> very useful, and due to the lack of ordering between different
>> queues almost harmful on fabrics.  What problem do you try to
>> solve?
> The problem I'm trying to solve here is really just single commands
> timing out because of i.e. a bad switch in between which causes frame
> loss somewhere.
>
> I know RDMA and FC are defined to be lossless but reality sometimes
> has a different view on this (can't talk too much for RDMA but I've
> had some nice bugs in SCSI due to faulty switches dropping odd
> frames).
>
> Of cause we can still do the big hammer if one command times out due
> to a misbehaving switch but we can also at least try to abort it. I
> know aborts are defined as best effort, but as we're in the error path
> anyways it doesn't hurt to at least try.
>
> This would give us a chance to recover from such situations, of cause
> given the target actually does something when receiving an abort.
>
> In the FC case we can even send an ABTS and try to abort the command
> on the FC side first, before doing it on NVMe. I'm not sure if we can
> do it on RDMA or PCIe as well.
>
> So the issue I'm trying to solve is easy, if one command times out for
> whatever reason, there's no need to go the big transport reset route
> before not even trying to recover from it. Possibly we should also try
> doing a queue reset if aborting failed before doing the transport
> reset.
>
> Byte,
> 	Johannes

I'm with Christoph.

It doesn't work that way... command delivery is very much tied to any 
command ordering delivery requirements as well as sqhd increment on the 
target, and response delivery is tied similarly tied to sqhd delivery to 
the host as well as ordering requirements on responses. With aborts as 
you're implementing, you drop those things.? Granted, Linux's lack of 
paying attention to SQHD (a problem waiting to happen in my mind) as 
well as not using fused commands (and no other commands yet requiring 
order) make it believe it can get away without it.

You're going to confuse transports as there's no understanding in the 
transport protocol on what it means to abort/cancel a single io.?? The 
specs are rather clear, and for a good reason, that non-delivery (the 
abort or cancellation) mandates connection teardown which in turn 
mandates association teardown. You will be creating non-standard 
implementations that will fail interoperability and compliance.

If you really want single io abort - implement it in the NVMe standard 
way with Aborts to the admin queue, subject to the ACL limit.? Then push 
on the targets to support deep ACL counts and honestly responding to 
ABORT, and there will still be race conditions between the ABORT and its 
command that will make an interesting retry policy. Or, wait for Fred 
Knights, new proposal on ABORTS.

-- james
