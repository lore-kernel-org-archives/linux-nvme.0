From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Jan 2016 00:08:39 +0000
Subject: [PATCH 0/3] NVMe: Introduce CMB allocation scheme
In-Reply-To: <20160106201308.GB21311@localhost.localdomain>
References: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
 <20160106201308.GB21311@localhost.localdomain>
Message-ID: <20160113000838.GA5803@localhost.localdomain>

On Wed, Jan 06, 2016@08:13:08PM +0000, Keith Busch wrote:
> On Wed, Dec 30, 2015@10:47:56AM -0700, Jon Derrick wrote:
> > This patchset changes the CMB allocation scheme. Instead of reserving
> > the entire range for SQes and automatically placing the SQes in the CMB,
> > this set creates sysfs knobs to manage it. This allows partial usage of
> > the CMB for SQes, so that the remainder can be mmapped or used for other
> > NVMe-defined CMB usages.
> 
> Thanks, Jon.
> 
> In general, I like the control and visibility this provides. With this,
> I think we're on the verge of warranting a new drivers/nvme/host/sysfs.c
> file to keep all the nvme sysfs management in one place.
> 
> I don't think anyone is in a rush to see this in the 4.5 merge window,
> so I'll load this on a CMB capable machine and provide a more thorough
> review in the next week or so.

One potential problem, this allows the queue depth to change on a live
request_queue. The block layer won't allow that right now. That can
also theoretically happen on a controller reset, but doesn't happen in
real life (that I know of). For this CMB proposal to really be useful,
we need a new blk-mq API to let us change the depth at runtime.

I thought the dynamic h/w contexts patch[1] was 'ok' and may have
provided a route to change the depth as well. That patch, though, saw a
0-day boot failure. The failure was incorrectly sent to my spam folder,
and I only noticed it this week. If that can be acceptably resolved,
then it looks possible to alter the queue depth with a bit more work.

---
[1] http://lists.infradead.org/pipermail/linux-nvme/2015-December/003452.html
