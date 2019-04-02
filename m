From: kbusch@kernel.org (Keith Busch)
Date: Tue, 2 Apr 2019 02:55:40 -0600
Subject: [PATCH] nvme-multipath: avoid crash on invalid subsystem cntlid
 enumeration
In-Reply-To: <d50e5b7e-9ccb-3f9f-1ab0-2324298e0a52@suse.de>
References: <20190329095754.109653-1-hare@suse.de>
 <20190329100244.GA28689@lst.de>
 <edde200c-dc35-8e40-6406-ce72f8aafe17@suse.de>
 <20190401051732.GC16792@localhost.localdomain>
 <d50e5b7e-9ccb-3f9f-1ab0-2324298e0a52@suse.de>
Message-ID: <20190402085540.GE16792@localhost.localdomain>

On Mon, Apr 01, 2019@04:50:13AM -0700, Hannes Reinecke wrote:
> On 4/1/19 7:17 AM, Keith Busch wrote:
> > We might want to use this patch anyway. It is possible some process
> > reference count is preventing the final release when we want to remove
> > a controller, and a subsequent discover, even if the cntlid is unqiue,
> > would create a duplicate disk name.
> > 
> I don't mind which patch is taken.
> But crashing on misbehaving targets is never a good idea.

I 100% agree. :)
 
> Do I need to send the other patch?

Can we do both? I like the warning when an invalid subsystem is detected,
but your original patch fixes the unique gendisk name, so I'd vote
to keep that good code, but justify it with a slightly different
changelog. Something along the following:

  A process holding an open reference to a removed disk prevents it
  from completing deletion, so its name continues to exist. A subsequent
  gendisk creation may have the same cntlid which risks collision when
  using that for the name. Use the unique ctrl->instance instead.
