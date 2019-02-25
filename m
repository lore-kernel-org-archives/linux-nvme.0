From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 24 Feb 2019 16:43:26 -0800
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
Message-ID: <CAHk-=whSN1cPoOigEAcyBOjOFeKGL9kX3xvKgZ8SYqQQd2stQQ@mail.gmail.com>

On Sun, Feb 24, 2019@3:27 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> >
> > It's not useful to panic just for random reasons. I realize that some
> > of the RAS people have the mindset that "hey, I don't know what's
> > wrong, so I'd better kill the machine than continue", but that's
> > bogus.
>
> That's the first thing I tried, but Borislav didn't like it. And he's
> right in the strictest sense of the ACPI spec: a fatal GHES error must
> result in a machine reboot [1].
>
> > What happens if we just fix that part?
>
> On rx740xd, on a NVMe hotplug bay, the upstream port stops sending
> hotplug interrupts. We could fix that with a quirk by clearing a
> proprietary bit in the switch. However, FFS won't re-arm itself to
> receive any further errors, so we'd never get notified in case there is
> a genuine error.

But this is not a genuine fatal error.

When spec and reality collide, the spec is just so much toilet paper.

In fact, the spec is worth _less_ than toilet paper, because at least
toilet paper is useful for wiping your butt clean. The spec? Not so
much.

> Keith Busch of Intel at some point suggested remapping all MMIO
> resources of a dead PCIe device to a read-only page that returns all
> F's. Neither of us were too sure how to do that, or how to handle the
> problem of in-flight DMA, which wouldn't hit the page tables.

I agree that that would be a really cute and smart way to fix things,
but no, right now I don't think we have any kind of infrastructure in
place to do something like that.

> > What is the actual ghes error? Is it the "unknown, just panic" case,
> > or something else?
>
> More like "fatal error, just panic". It looks like this (from a serial
> console):
>
> [   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic
> Hardware Error Source: 1
> [   57.680495] {1}[Hardware Error]: event severity: fatal

Ok, so the ghes information is actively wrong, and tries to kill the
machine when it shouldn't be killed.

I seriously think that the correct thing is to fix the problem at the
*source* - ie the ghes driver. That's the only driver that should care
about "this platform is broken and sends invalid fatal errors".

So instead of adding hacks to the nvme driver, I think the hacks
should be in the ghes driver. Possibly just a black-list of "this
platform is known broken, don't even enable the ghes driver for it".
Or possibly a bit more fine-grained in the sense that it knows that
"ok, this particular kind of error is due to a hotplug event, the
driver will handle it without help from us, so ignore it".

                 Linus
