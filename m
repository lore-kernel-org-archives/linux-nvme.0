From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jun 2015 06:24:46 -0700
Subject: abort question
In-Reply-To: <20150611131254.GM2729@linux.intel.com>
References: <20150611104603.GA1754@infradead.org>
 <20150611131254.GM2729@linux.intel.com>
Message-ID: <20150611132446.GA21761@infradead.org>

On Thu, Jun 11, 2015@09:12:54AM -0400, Matthew Wilcox wrote:
> On Thu, Jun 11, 2015@03:46:03AM -0700, Christoph Hellwig wrote:
> > Don't we need to reserve a request and SQ entry to that we can
> > always send an abort?  Otherwise a lockded up controller will never
> > send a abort and always just reset the timer, and never escalate
> > to a controller reset.
> 
> Aborts are sent on the admin queue, not the IO queue.  There should
> always be plenty of space on the admin queue.

The default admin queue has 256 entries, of which we reserve one for the
AEN command.  I've been hacking up a NVMe command fuzzer that sends
semi-random [1] commands to a device, and I manage to reproduce a case
where it seems like aborts don't make progress.  I haven't fully sorted
it out yet, but it seems like aborts don't happen.

[1] I had to black list commands like I/O CQ/SQ deletion as that crashes
the driver pretty reliably.
