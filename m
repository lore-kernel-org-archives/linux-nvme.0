From: joe@perches.com (Joe Perches)
Date: Sat, 10 Dec 2016 16:36:48 -0800
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <alpine.DEB.2.20.1612102104050.1986@hadrien>
References: <20161210090618.GA11680@elgon.mountain>
 <1481369270.5946.51.camel@perches.com> <20161210184029.GY8176@mwanda>
 <alpine.DEB.2.20.1612102104050.1986@hadrien>
Message-ID: <1481416608.1764.7.camel@perches.com>

On Sat, 2016-12-10@21:06 +0100, Julia Lawall wrote:
> 
> On Sat, 10 Dec 2016, Dan Carpenter wrote:
> 
> > On Sat, Dec 10, 2016@03:27:50AM -0800, Joe Perches wrote:
> > > On Sat, 2016-12-10@12:06 +0300, Dan Carpenter wrote:
> > > > We really don't care where "ctrl" is on the stack since we're just
> > > > returning soon what we want is the actual ctrl pointer itself.
> > > > 
> > > > Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
> > > > 
> > > > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > > 
> > > []
> > > > @@ -2402,7 +2402,7 @@ enum blk_eh_timer_return
> > > > 
> > > >  	dev_info(ctrl->ctrl.device,
> > > >  		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
> > > > -		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
> > > > +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, ctrl);
> > > 
> > > Found by script or inspection?
> > > 
> > > If by script, it seems unlikely there's only 1 instance
> > > where an address of an automatic pointer type is used
> > > incorrectly.
> > 
> > Script.  But it's using a pretty specific heuristic where we kmalloc a
> > pointer and then pass the address.  It prints few warnings.  Probably
> > 40% false positives, but the remaining examples of course are 100% false
> > positives.
> 
> I tried anything that looks like a print, ie has a format string argument,
> and was taking the address of a local variable as another argument.  But
> there are lots of weird format designators in the kernel that Coccinelle
> doesn't know about for which passing the address of a local variable is
> reasonable.  So for the moment, there are, as far as I can see, just a lot
> of false positives.  I did add improving the support for format strings to
> my TODO list.

fyi: A message from Rasmus awhile ago on the smatch list
     sent to me and Dan that's relevant.
     (AFAIK: this list isn't archived anywhere)

On Wed, 2015-02-11@11:34 +0100, Rasmus Villemoes wrote:
> Hi,
> 
> As mentioned, I've been working on getting smatch to do type checking of
> the various %p format extensions. The code is now on github
> (https://github.com/Villemoes/smatch).
> 
> Note that this work revealed a bug in sparse's handling of string
> literals coming from macro expansions
> (http://thread.gmane.org/gmane.comp.parsers.sparse/4080). I've applied
> one of the suggested fixes, but it's still not clear to me what the
> final fix will be in sparse upstream. Anyway, this was good enough to
> get the ball rolling.
> 
> While developing this, I found it useful to only enable that specific
> check (both to get smatch run faster and to get less noise in the
> output), so there's also a few unrelated patches in the printf branch
> implementing that feature.
> 
> sparse currently ignores attribute((format)), so the list of printf functions
> has been extracted with a perl script and hard-coded. Even if sparse
> understood attribute((format)), I wouldn't know how to set up a hook for
> 'call of function with this or that attribute'.
> 
> I don't think it's ready to be merged upstream (and whether that will
> even happen is of course entirely up to Dan), but now it's out there for
> people to play with. I have already sent patches for the four %p bugs
> found, but there may be a few more lurking in arch/<not x86>/ - I don't
> know how to pursuade the build system to go there.
> 
> Rasmus
