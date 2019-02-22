From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 22 Feb 2019 13:28:42 -0800
Subject: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
In-Reply-To: <20190222010502.2434-1-jonathan.derrick@intel.com>
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
Message-ID: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>

On Thu, Feb 21, 2019@5:07 PM Jon Derrick <jonathan.derrick@intel.com> wrote:
>
> Some platforms don't seem to easily tolerate non-posted mmio reads on
> lost (hot removed) devices. This has been noted in previous
> modifications to other layers where an mmio read to a lost device could
> cause an undesired firmware intervention [1][2].

This is broken, and whatever platform that requires this is broken.

This has absolutely nothing to do with nvme, and should not be handled
by a driver.

The platform code should be fixed.

What broken platform is this, and why is it causing problems?

None of this wishy-washy "some platforms". Name them, and let's get them fixed.

                 Linus
