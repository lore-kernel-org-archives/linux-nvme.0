From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 24 Feb 2019 14:42:35 -0800
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
Message-ID: <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>

On Sun, Feb 24, 2019@12:37 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> Dell r740xd to name one. r640 is even worse -- they probably didn't give
> me one because I'd have too much stuff to complain about.
>
> On the above machines, firmware-first (FFS) tries to guess when there's
> a SURPRISE!!! removal of a PCIe card and supress any errors reported to
> the OS. When the OS keeps firing IO over the dead link, FFS doesn't know
> if it can safely supress the error. It reports is via NMI, and
> drivers/acpi/apei/ghes.c panics whenever that happens.

Can we just fix that ghes driver?

It's not useful to panic just for random reasons. I realize that some
of the RAS people have the mindset that "hey, I don't know what's
wrong, so I'd better kill the machine than continue", but that's
bogus.

What happens if we just fix that part?

> As I see it, there's a more fundamental problem. As long as we accept
> platforms where firmware does some things first (FFS), we have much less
> control over what happens. The best we can do is wishy-washy fixes like
> this one.

Oh, I agree that platforms with random firmware things are horrid. But
we've been able to handle them just fine before, without making every
single possible hotplug pci driver have nasty problems and
workarounds.

I suspect we'd be much better off having the ghes driver just not panic.

What is the actual ghes error? Is it the "unknown, just panic" case,
or something else?

               Linus
