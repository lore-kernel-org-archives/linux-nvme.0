From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Oct 2018 09:24:01 -0600
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181027074452.GA15404@lst.de>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>
 <20181027074452.GA15404@lst.de>
Message-ID: <20181029152401.GA16336@localhost.localdomain>

On Sat, Oct 27, 2018@09:44:52AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 26, 2018@04:58:07PM -0600, Keith Busch wrote:
> > The quirk is for devices that pre-date the ability to discover the
> > capability. Now that we have a spec defined way to know a device's
> > deallocate behavior, and this particular device implements that method,
> > we should use that instead of a quirk.
> 
> The 'Deallocate Logical Block Features' bits 0 and 1 only tell what
> is read back from deallocated logic blocks, but it does not guarantee
> that all blocks a DSM deallocate is called on are actually deallocated.

Sure, but whether the requested blocks are deallocated or not is
irrelevant. We're only using this feature here for its deterministic
read behavior.

> That being said I really don't want to add more 'feature hacks' like this,
> it is time that we go back to a proper Write Zeroes implementation.

Yes, I agree we ought to use nvme Write Zeroes instead of DSM if
the controller supports it, but recall we had to revert the original
implementation because it broke Linus' machine. The nvme part looked
fine to me, though, so I don't know what the problem may have been.
