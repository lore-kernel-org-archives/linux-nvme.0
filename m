From: hch@lst.de (Christoph Hellwig)
Date: Sat, 27 Oct 2018 09:44:52 +0200
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181026225807.GA10621@localhost.localdomain>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>
Message-ID: <20181027074452.GA15404@lst.de>

On Fri, Oct 26, 2018@04:58:07PM -0600, Keith Busch wrote:
> The quirk is for devices that pre-date the ability to discover the
> capability. Now that we have a spec defined way to know a device's
> deallocate behavior, and this particular device implements that method,
> we should use that instead of a quirk.

The 'Deallocate Logical Block Features' bits 0 and 1 only tell what
is read back from deallocated logic blocks, but it does not guarantee
that all blocks a DSM deallocate is called on are actually deallocated.

That being said I really don't want to add more 'feature hacks' like this,
it is time that we go back to a proper Write Zeroes implementation.
