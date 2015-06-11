From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jun 2015 15:44:53 +0000 (UTC)
Subject: abort question
In-Reply-To: <20150611132446.GA21761@infradead.org>
References: <20150611104603.GA1754@infradead.org>
 <20150611131254.GM2729@linux.intel.com>
 <20150611132446.GA21761@infradead.org>
Message-ID: <alpine.LNX.2.00.1506111437260.15930@localhost.lm.intel.com>

On Thu, 11 Jun 2015, Christoph Hellwig wrote:
> On Thu, Jun 11, 2015@09:12:54AM -0400, Matthew Wilcox wrote:
>> On Thu, Jun 11, 2015@03:46:03AM -0700, Christoph Hellwig wrote:
>>> Don't we need to reserve a request and SQ entry to that we can
>>> always send an abort?  Otherwise a lockded up controller will never
>>> send a abort and always just reset the timer, and never escalate
>>> to a controller reset.
>>
>> Aborts are sent on the admin queue, not the IO queue.  There should
>> always be plenty of space on the admin queue.
>
> The default admin queue has 256 entries, of which we reserve one for the
> AEN command.  I've been hacking up a NVMe command fuzzer that sends
> semi-random [1] commands to a device, and I manage to reproduce a case
> where it seems like aborts don't make progress.  I haven't fully sorted
> it out yet, but it seems like aborts don't happen.

The AEN is special. We want to submit one, but we can't leave the request
"active" without deadlockling blk-mq's hot-cpu notification, so it's the
only reserved command in the admin tagset for this special treatment. We
can't reserve another without risking tag collisions.

If an admin command times out, we go straight to the heavy hammer and
reset the controller, so we don't need an available tag to issue abort.

If you've managed to exhaust all 254 general purpose admin tags and an IO
request times out, we've got a problem, but should fix itself eventually
when one of the admin commands completes or times out.

> [1] I had to black list commands like I/O CQ/SQ deletion as that crashes
> the driver pretty reliably.

There are ways to crash the system with the passthru. The IOCTL is a
prividged command: with great power comes great responsibility. :)
