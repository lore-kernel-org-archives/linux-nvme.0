From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Apr 2019 20:09:58 +0200
Subject: [PATCH] nvme-multipath: avoid crash on invalid subsystem
 cntlid enumeration
In-Reply-To: <20190402085540.GE16792@localhost.localdomain>
References: <20190329095754.109653-1-hare@suse.de>
 <20190329100244.GA28689@lst.de>
 <edde200c-dc35-8e40-6406-ce72f8aafe17@suse.de>
 <20190401051732.GC16792@localhost.localdomain>
 <d50e5b7e-9ccb-3f9f-1ab0-2324298e0a52@suse.de>
 <20190402085540.GE16792@localhost.localdomain>
Message-ID: <20190403180958.GE28682@lst.de>

On Tue, Apr 02, 2019@02:55:40AM -0600, Keith Busch wrote:
> On Mon, Apr 01, 2019@04:50:13AM -0700, Hannes Reinecke wrote:
> > On 4/1/19 7:17 AM, Keith Busch wrote:
> > > We might want to use this patch anyway. It is possible some process
> > > reference count is preventing the final release when we want to remove
> > > a controller, and a subsequent discover, even if the cntlid is unqiue,
> > > would create a duplicate disk name.
> > > 
> > I don't mind which patch is taken.
> > But crashing on misbehaving targets is never a good idea.
> 
> I 100% agree. :)
>  
> > Do I need to send the other patch?
> 
> Can we do both? I like the warning when an invalid subsystem is detected,
> but your original patch fixes the unique gendisk name, so I'd vote
> to keep that good code, but justify it with a slightly different
> changelog. Something along the following:

Yes, let's do both.  Hannes, please resend a series with this patch
with the updated changelog and the duplicate cntlid check one.
