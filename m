From: kbusch@kernel.org (Keith Busch)
Date: Wed, 7 Aug 2019 15:30:40 -0600
Subject: inverting order of NVMe pci enable/disable device during
 boot/shutdown? Failing release.
In-Reply-To: <CAFCYAsfsCH+swCmpubto9od6dmJFsw0i+VDri9U+GVyZkOqcWg@mail.gmail.com>
References: <CAFCYAsfsCH+swCmpubto9od6dmJFsw0i+VDri9U+GVyZkOqcWg@mail.gmail.com>
Message-ID: <20190807213039.GA26026@localhost.localdomain>

On Wed, Aug 07, 2019@02:04:32PM -0700, Jeff Johnson wrote:
> Greetings,
> 
> Is there a way to invert the order of PCI device enable/disable during
> boot or shutdown?

There's no easy way to change that. It's not possible from the nvme
driver at least. Our shutdown notifications are initiated from the kernel,
so we don't control the device order at this level.

> I have an attached NVMe SSD chassis with 24 SSDs. I have discovered
> that on random host shutdowns that the last couple NVMe SSDs get left
> in a bad state after they are unregistered by the kernel. Out of 24
> SSDs all but the last one or two successfully remain at their
> negotiated speed and width after release. The last one, or sometimes
> two, SSDs to be released get stuck in a polling state (gen1, 0width)
> which will not clear or resolve unless the PCIe switch is reset.
> 
> Multiple backplanes and moving SSDs doesn't change the fact that it is
> always the last one or two SSDs to release on host orderly shutdown.
> 
> If I can swap the order of drive reserve/release on boot and shutdown
> then I could determine if the issue follows the physical path or the
> last drives in the release process.

Do you require all 24 slots be populated to observe the failure, or can
you repro with fewer?
