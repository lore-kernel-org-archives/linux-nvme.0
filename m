From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 16:35:34 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719142355.GA18800@lst.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
Message-ID: <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>

On Thu, Jul 19, 2018@04:23:55PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 19, 2018@04:10:25PM +0200, Johannes Thumshirn wrote:
> > The problem I'm trying to solve here is really just single commands
> > timing out because of i.e. a bad switch in between which causes frame
> > loss somewhere.
> 
> And that is exactly the case where NVMe abort does not actually work
> in any sensible way.
> 
> Remember that while NVMe guarantes ordered delivery inside a given
> queue it does not guarantee anything between multiple queues.
> 
> So now you have your buggy FC setup where an I/O command times out
> because your switch delayed it for two hours due to a firmware bug.
> 
> After 30 seconds we send an abort over the admin queue, which happens
> to pass through just fine.  The controller will tell you: no command
> found as it has never seen it.
> 
> No with the the code following what we have in PCIe that just means
> we'll eventually controller reset after the I/O command times out
> the second time as we still won't have seen a completion for it.

Exactly that was my intention.

> If you incorrectly just continue and resend the command we'll actually
> get the command sent twice and thus a potential bug once the original
> command just gets sent along.

OK, let me see where I'm stuck here. We're issuing a command, it gets
lost due to $REASON and I'm aborting it. The upper layers then
eventually retry the command and it arrives at the target side. But so
does the old command as well and we have a duplicate. Correct?

So if we keep our old behavior and tear down the queues and
re-establish them, then the upper layers retry the command and it
arrives on the target. But shortly afterwards the switch happens to
find the old command in it's ingress buffers and decides to forward it
to the target as well, how does that differ? The CMDID and SQID are
probably different but all the payload will be the same, wouldn't it?

So we still have our duplicate on the other side, don't we?

I feel I'm missing out something here.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
