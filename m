From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 13 Nov 2018 20:28:10 -0500
Subject: nvme: utilize two queue maps, one for reads and one for writes
In-Reply-To: <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
References: <20181114004148.GA29545@roeck-us.net>
 <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
Message-ID: <20181114012810.GA14592@redhat.com>

On Tue, Nov 13 2018 at  7:51pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 11/13/18 5:41 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > On Wed, Oct 31, 2018@08:36:31AM -0600, Jens Axboe wrote:
> >> NVMe does round-robin between queues by default, which means that
> >> sharing a queue map for both reads and writes can be problematic
> >> in terms of read servicing. It's much easier to flood the queue
> >> with writes and reduce the read servicing.
> >>
> >> Implement two queue maps, one for reads and one for writes. The
> >> write queue count is configurable through the 'write_queues'
> >> parameter.
> >>
> >> By default, we retain the previous behavior of having a single
> >> queue set, shared between reads and writes. Setting 'write_queues'
> >> to a non-zero value will create two queue sets, one for reads and
> >> one for writes, the latter using the configurable number of
> >> queues (hardware queue counts permitting).
> >>
> >> Reviewed-by: Hannes Reinecke <hare at suse.com>
> >> Reviewed-by: Keith Busch <keith.busch at intel.com>
> >> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> > 
> > This patch causes hangs when running recent versions of
> > -next with several architectures; see the -next column at
> > kerneltests.org/builders for details.  Bisect log below; this
> > was run with qemu on alpha. Reverting this patch as well as
> > "nvme: add separate poll queue map" fixes the problem.
> 
> I don't see anything related to what hung, the trace, and so on.
> Can you clue me in? Where are the test results with dmesg?
> 
> How to reproduce?

Think Guenter should've provided a full kerneltests.org url, but I had a
look and found this for powerpc with -next:
https://kerneltests.org/builders/next-powerpc-next/builds/998/steps/buildcommand/logs/stdio

Has useful logs of the build failure due to block.

(not seeing any -next failure for alpha but Guenter said he was using
qemu so the build failure could've been any arch qemu supports)

Mike
