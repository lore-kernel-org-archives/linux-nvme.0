From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 11 Feb 2016 10:34:53 -0500
Subject: RCU-ified dm-mpath for testing/review
In-Reply-To: <20160211015030.GA4481@redhat.com>
References: <56B7659C.8040601@dev.mellanox.co.il>
 <56B772D6.2090403@sandisk.com>
 <56B77444.3030106@dev.mellanox.co.il>
 <56B776DE.30101@dev.mellanox.co.il>
 <20160207172055.GA6477@redhat.com> <56B99A49.5050400@suse.de>
 <20160209145547.GA21623@redhat.com> <56BA0689.9030007@suse.de>
 <20160210004518.GA23646@redhat.com>
 <20160211015030.GA4481@redhat.com>
Message-ID: <20160211153452.GA7827@redhat.com>

On Wed, Feb 10 2016 at  8:50pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Tue, Feb 09 2016 at  7:45pm -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > 
> > OK, I took a crack at embracing RCU.  Only slightly better performance
> > on my single NUMA node testbed.  (But I'll have to track down a system
> > with multiple NUMA nodes to do any justice to the next wave of this
> > optimization effort)
> > 
> > This RCU work is very heavy-handed and way too fiddley (there could
> > easily be bugs).  Anyway, please see:
> > http://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git/commit/?h=devel2&id=d80a7e4f8b5be9c81e4d452137623b003fa64745
> > 
> > But this might give you something to build on to arrive at something
> > more scalable?
> 
> I've a bit more polished version of this work (broken up into multiple
> commits, with some fixes, etc) here:
> http://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git/log/?h=devel3
> 
> Hannes and/or Sagi, if you get a chance to try this on your NUMA system
> please let me know how it goes.

Initial review has uncovered some locking problems with the current code
(nothing that caused crashes or hangs in my testing but...) so please
hold off on testing until you hear from me (hopefully tomorrow).

Thanks,
Mike
