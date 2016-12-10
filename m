From: joe@perches.com (Joe Perches)
Date: Sat, 10 Dec 2016 14:27:53 -0800
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <alpine.DEB.2.20.1612102304390.1986@hadrien>
References: <20161210090618.GA11680@elgon.mountain>
 <1481369270.5946.51.camel@perches.com> <20161210184029.GY8176@mwanda>
 <alpine.DEB.2.20.1612102104050.1986@hadrien>
 <1481403290.1764.1.camel@perches.com>
 <alpine.DEB.2.20.1612102304390.1986@hadrien>
Message-ID: <1481408873.1764.4.camel@perches.com>

On Sat, 2016-12-10@23:07 +0100, Julia Lawall wrote:
> 
> On Sat, 10 Dec 2016, Joe Perches wrote:
> 
> > On Sat, 2016-12-10@21:06 +0100, Julia Lawall wrote:
> > > 
> > > On Sat, 10 Dec 2016, Dan Carpenter wrote:
> > > 
> > > > On Sat, Dec 10, 2016@03:27:50AM -0800, Joe Perches wrote:
> > > > > On Sat, 2016-12-10@12:06 +0300, Dan Carpenter wrote:
> > > > > > We really don't care where "ctrl" is on the stack since we're just
> > > > > > returning soon what we want is the actual ctrl pointer itself.
> > > > > > 
> > > > > > Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
> > > > > > 
> > > > > > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > > > > 
> > > > > []
> > > > > > @@ -2402,7 +2402,7 @@ enum blk_eh_timer_return
> > > > > > 
> > > > > >  	dev_info(ctrl->ctrl.device,
> > > > > >  		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
> > > > > > -		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
> > > > > > +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, ctrl);
> > > > > 
> > > > > Found by script or inspection?
> > > > > 
> > > > > If by script, it seems unlikely there's only 1 instance
> > > > > where an address of an automatic pointer type is used
> > > > > incorrectly.
> > > > 
> > > > Script.  But it's using a pretty specific heuristic where we kmalloc a
> > > > pointer and then pass the address.  It prints few warnings.  Probably
> > > > 40% false positives, but the remaining examples of course are 100% false
> > > > positives.
> > > 
> > > I tried anything that looks like a print, ie has a format string argument,
> > > and was taking the address of a local variable as another argument.  But
> > > there are lots of weird format designators in the kernel that Coccinelle
> > > doesn't know about for which passing the address of a local variable is
> > > reasonable.  So for the moment, there are, as far as I can see, just a lot
> > > of false positives.  I did add improving the support for format strings to
> > > my TODO list.
> > 
> > I think there's probably a class of defects that could
> > be found something like this in coccinelle:
> > 
> > @@
> > type T;
> > T *t;
> > @@
> > 
> > * \(netdev_emerg\|netdev_crit\|netdev_alert\|netdev_err\|netdev_notice\|netdev_warn\|netdev_warn\|netdev_info\|netdev_dbg\|dev_emerg\|dev_crit\|dev_alert\|dev_err\|dev_notice\|dev_warn\|dev_warn\|dev_info\|dev_dbg\|pr_emerg\|pr_crit\|pr_alert\|pr_err\|pr_notice\|pr_warn\|pr_warning\|pr_warn\|pr_info\|pr_debug\|printk\|vsprintf\|vscnprintf\|vsprintf\)(..., &t, ...);
> > 
> > This finds a few like:
> > 
> > diff -u -p drivers//dma/pxa_dma.c /tmp/nothing//dma/pxa_dma.c
> > --- drivers//dma/pxa_dma.c
> > +++ /tmp/nothing//dma/pxa_dma.c
> > @@ -640,9 +640,6 @@ static unsigned int clear_chan_irq(struc
> >  	dcsr = phy_readl_relaxed(phy, DCSR);
> >  	phy_writel(phy, dcsr, DCSR);
> >  	if ((dcsr & PXA_DCSR_BUSERR) && (phy->vchan))
> > -		dev_warn(&phy->vchan->vc.chan.dev->device,
> > -			 "%s(chan=%p): PXA_DCSR_BUSERR\n",
> > -			 __func__, &phy->vchan);
> > 
> >  	return dcsr & ~PXA_DCSR_RUN;
> >  }
> > 
> > btw:  It'd be nice if coccinelle could use multiple nested "\("
> 
> What exactly didn't work?  It should be possible.
> 
> My rule was:
> 
> @@
> format d;
> local idexpression l;
> identifier f != {sscanf,fscanf};
> @@
> 
> f(...,"...%@d at ...",...,
> *&l
>  ,...)
> 
> But there are many false positives, with things like %pV.
> 
> julia

I think local idexpression is not constrained
to just a pointer type..

Basically, anything that's taking an address of a
pointer should be a misuse.

I think instead of local idexpression l, using

type L;
L *l;

would be better.

My version of spatch seems to be too old to
support this syntax though.

I'll upgrade eventually and try it again later.

$ spatch --version
spatch version 1.0.5-00102-gd8ee7a6 compiled with OCaml version 4.02.3
Flags passed to the configure script: [none]
Python scripting support: yes
Syntax of regular expresssions: PCRE
