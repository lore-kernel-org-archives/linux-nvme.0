From: hch@lst.de (Christoph Hellwig)
Date: Sat, 27 Apr 2019 07:54:53 +0200
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's
 whole lifetime
In-Reply-To: <20190426224542.GD31470@ming.t460p>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-10-ming.lei@redhat.com> <20190424162746.GE23854@lst.de>
 <20190425010030.GD22636@ming.t460p> <20190426151114.GB20438@lst.de>
 <20190426224542.GD31470@ming.t460p>
Message-ID: <20190427055453.GA21483@lst.de>

On Sat, Apr 27, 2019@06:45:43AM +0800, Ming Lei wrote:
> Still no difference between your suggestion and the way in this patch, given
> driver specific change is a must. Even it is more clean to hold the
> queue refocunt by drivers explicitly because we usually do the get/put pair
> in one place, instead that getting refcnt in one subsystem, and doing put in
> another place.
> 
> I am going to drop this patch in V8 since my original plan is to fix block
> layer's race in this patchset.

Doing the untegistration and final reference drop is just a bad pattern,
leading to possible bugs.  I'm fine with you just dropping it for now,
I guess I'll just send a scripted conversion moving the put to the drivers
to Jens after -rc1 to sort it out.  Probably including a rename
of blk_cleanup_queue so that everyone notices the difference.
