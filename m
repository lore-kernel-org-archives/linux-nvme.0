From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:23:55 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
Message-ID: <20180719142355.GA18800@lst.de>

On Thu, Jul 19, 2018@04:10:25PM +0200, Johannes Thumshirn wrote:
> The problem I'm trying to solve here is really just single commands
> timing out because of i.e. a bad switch in between which causes frame
> loss somewhere.

And that is exactly the case where NVMe abort does not actually work
in any sensible way.

Remember that while NVMe guarantes ordered delivery inside a given
queue it does not guarantee anything between multiple queues.

So now you have your buggy FC setup where an I/O command times out
because your switch delayed it for two hours due to a firmware bug.

After 30 seconds we send an abort over the admin queue, which happens
to pass through just fine.  The controller will tell you: no command
found as it has never seen it.

No with the the code following what we have in PCIe that just means
we'll eventually controller reset after the I/O command times out
the second time as we still won't have seen a completion for it.

If you incorrectly just continue and resend the command we'll actually
get the command sent twice and thus a potential bug once the original
command just gets sent along.
