From: hch@lst.de (Christoph Hellwig)
Date: Wed, 4 Oct 2017 09:13:12 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-4-git-send-email-hare@suse.de>
 <20171002164218.GA11886@lst.de>
 <ece83015-0def-8e36-5645-7be00be95c40@suse.de>
 <20171003115506.GC24650@lst.de>
 <bd388bdf-25ac-8b25-f832-ba1316a64dc4@suse.de>
 <20171004061533.GA20131@lst.de>
 <19dbdf11-86c4-b6ea-a18c-a78fcae822d5@suse.de>
Message-ID: <20171004071312.GA21143@lst.de>

On Wed, Oct 04, 2017@08:33:07AM +0200, Hannes Reinecke wrote:
> > On Wed, Oct 04, 2017@07:42:00AM +0200, Hannes Reinecke wrote:
> >> Hmm. Not sure how you would be doing that. Who should be doing the
> >> claiming? Typically the claim is done whenever a device is created on
> >> top of the other...
> > 
> > We'd need a callback in the driver if it is claimed, and use that
> > to for propagating the claim, or use a shared struture to record the
> > claim.  I haven't looked into the details yet, though.
> > 
> >> What about an alternative plan: make creation of the subsystem device
> >> fully dynamic.
> >> But if a subsystem device is created it will always claim the underlying
> >> device. Then we can make the creation dependent on the NMIC attribute,
> >> and existing setups would not be affected.
> > 
> > This doesn't work because a lot of devices can just set NMIC.  E.g.
> > every namespace exported by the Linux NVMe target.
> > 
> But as it's fully dynamic we can decide how to handle each device on a
> device-by-device basis, with a common default policy.

What do you mean with fully dynamic?

> My idea is to have a default policy (create/not create subsystem devices
> if NMIC is set) set via kernel command-line, and udev rules for devices
> requiring separate handling.

Yikes.  That's exactly where I do _not_ want to go.  No more arcane
magic setup that you need to be in the in group for to know like
dm-multipath.  Things must just work, period.

The only other option I could think of would be to turn names around:
make /dev/nvmeX (chardev) and /dev/nvmeXnY the per-subsystem devices
that are multipathed if available.  We'd then need new devices for the
invdividual controllers.  With a little luck we'd get away with just
creating character devices.  This would however create a problem for
dm-multipath users, which mostly is you and your paterners/customers.

Note that in general dm-multipath should continue working but it would
generally just see one path.
