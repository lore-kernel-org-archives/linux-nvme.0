From: keith.busch@intel.com (Keith Busch)
Date: Fri, 5 Aug 2016 16:50:53 -0400
Subject: NVME regression in all kernels after 4.4.x for NVME in M2 slot
 for laptop?
In-Reply-To: <20160805190323.GA12853@merlins.org>
References: <20160805190323.GA12853@merlins.org>
Message-ID: <20160805205052.GA12688@localhost.localdomain>

On Fri, Aug 05, 2016@12:03:23PM -0700, Marc MERLIN wrote:
> Would this patch make sense as being the reason why I can't S3 sleep
> anymore and would you have a test patch against 4.5, 4.6, or 4.7 I can
> try to see if it fixes the problem?

Hi Marc,

It might be blk-mq's hot cpu notifier is invoked during suspend and
waiting for nvme's queues to freeze, which may not happen if a request
is waiting on a stopped queue. The patch you biseceted doesn't
necessarilly fix that, but the window for when a request could get queued
like that was much shorter.

Assuming that is the problem, S3 suspends PCI hardware before IO
tasks. I'll see if I can reproduce on one of my machines and look into
a fix.

Thanks,
Keith
