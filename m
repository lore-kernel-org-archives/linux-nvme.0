From: joe@perches.com (Joe Perches)
Date: Mon, 12 Dec 2016 07:55:30 -0800
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <alpine.DEB.2.10.1612121646460.3156@hadrien>
References: <20161210090618.GA11680@elgon.mountain>
 <1481369270.5946.51.camel@perches.com> <20161210184029.GY8176@mwanda>
 <alpine.DEB.2.20.1612102104050.1986@hadrien>
 <1481403290.1764.1.camel@perches.com> <20161210210737.GR8244@mwanda>
 <1481408662.1764.3.camel@perches.com> <20161212093352.GB8176@mwanda>
 <alpine.DEB.2.10.1612121646460.3156@hadrien>
Message-ID: <1481558130.1764.21.camel@perches.com>

On Mon, 2016-12-12@16:47 +0100, Julia Lawall wrote:
> 
> On Mon, 12 Dec 2016, Dan Carpenter wrote:
> 
> > On Sat, Dec 10, 2016@02:24:22PM -0800, Joe Perches wrote:
> > > On Sun, 2016-12-11@00:07 +0300, Dan Carpenter wrote:
> > > > On Sat, Dec 10, 2016@12:54:50PM -0800, Joe Perches wrote:
> > > > > diff -u -p drivers//dma/pxa_dma.c /tmp/nothing//dma/pxa_dma.c
> > > > > --- drivers//dma/pxa_dma.c
> > > > > +++ /tmp/nothing//dma/pxa_dma.c
> > > > > @@ -640,9 +640,6 @@ static unsigned int clear_chan_irq(struc
> > > > >?????????dcsr = phy_readl_relaxed(phy, DCSR);
> > > > >?????????phy_writel(phy, dcsr, DCSR);
> > > > >?????????if ((dcsr & PXA_DCSR_BUSERR) && (phy->vchan))
> > > > > -???????????????dev_warn(&phy->vchan->vc.chan.dev->device,
> > > > > -??????????????????????? "%s(chan=%p): PXA_DCSR_BUSERR\n",
> > > > > -??????????????????????? __func__, &phy->vchan);
> > > >
> > > > That's not a defect.? We're getting the address of vchan.? I don't get
> > > > it?
> > >
> > > $ git grep -n -w vchan drivers/dma/pxa*
> > > drivers/dma/pxa_dma.c:103:????? struct pxad_chan??????? *vchan;
> >
> > I'm not sure what you're saying here still.? This code works as
> > intended.? We're not printing a stack address.
> 
> I guess that the point is that one would like to print the channel, not
> the address of the channel?

Generally, printing the address of a pointer
_can_ be useful, but it's likely a defect with
a low false positive rate.
