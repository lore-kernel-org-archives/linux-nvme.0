From: osandov@osandov.com (Omar Sandoval)
Date: Wed, 25 Apr 2018 08:58:39 -0700
Subject: [PATCH blktests 3/3] nvme: add a regression test for UUID ns
 descriptops
In-Reply-To: <20180425155211.o4bwaryvo3lo6l4i@linux-x5ow.site>
References: <20180424161251.6502-1-jthumshirn@suse.de>
 <20180424161251.6502-3-jthumshirn@suse.de>
 <20180425153036.GA30070@vader>
 <20180425155211.o4bwaryvo3lo6l4i@linux-x5ow.site>
Message-ID: <20180425155839.GC30070@vader>

On Wed, Apr 25, 2018@09:52:12AM -0600, Johannes Thumshirn wrote:
> On Wed, Apr 25, 2018@08:30:36AM -0700, Omar Sandoval wrote:
> [...]
> > The TODO comment was leftover here, I removed it.
> 
> Oops sorry.

I should probably rename it `make check` and have it check for leftover
TODO comments as well.

> > > +DESCRIPTION="Test nvme and nvmet UUID NS descriptors"
> > > +
> > > +QUICK=1
> > > +
> > > +requires() {
> > > +	_have_program nvme && _have_module nvme-loop && _have_module loop \
> > > +	    && _have_configfs
> > > +}
> > > +
> > > +_find_nvme_loop_dev() {
> > > +	for dev in /sys/block/nvme*; do
> > > +		dev="$(basename $dev)"
> > 
> > There's some missing quoting around "$dev" here. There's also some more
> > missing quoting, `make shellcheck` will catch this sort of thing.
> 
> Thanks, I'll try to not forget running shellcheck. Maybe we should set
> up travis on github to catch this?

Good idea. I need to clean up some other errors that have snuck in.
