From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Feb 2019 14:59:38 -0700
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
Message-ID: <20190222215938.GG10237@localhost.localdomain>

On Fri, Feb 22, 2019@01:28:42PM -0800, Linus Torvalds wrote:
> On Thu, Feb 21, 2019@5:07 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
> >
> > Some platforms don't seem to easily tolerate non-posted mmio reads on
> > lost (hot removed) devices. This has been noted in previous
> > modifications to other layers where an mmio read to a lost device could
> > cause an undesired firmware intervention [1][2].
> 
> This is broken, and whatever platform that requires this is broken.
> 
> This has absolutely nothing to do with nvme, and should not be handled
> by a driver.
> 
> The platform code should be fixed.

This is, of course, the correct answer. We just find platform firmware
uncooperative, so we see these attempts to avoid them.

I really don't like this driver piecemeal approach if we're going to
quirk around these platforms, though. I'd rather see the invalidated
address ranges remapped to a fault handler fixup exception once and be
done with it.

Or we can say you don't get to use this feature if you bought that
hardware.
