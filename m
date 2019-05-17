From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 17 May 2019 12:34:19 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190517093516.GA17006@lst.de>
References: <20190516142657.GD23333@localhost.localdomain>
 <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
 <64e8e0252a4042b99dd3d0def15b1780@AUSX13MPC105.AMER.DELL.COM>
 <20190516193822.GA23853@localhost.localdomain>
 <CAJZ5v0gBQVjy70CbA6CzkkjsGQYGeO6fDjJimvadM5_oq=3qeA@mail.gmail.com>
 <20190516203950.GB23853@localhost.localdomain>
 <CAJZ5v0hZSiQuuq2+P+uLd3uE=ruuTW+5DmAdjqcr39=7poUe-g@mail.gmail.com>
 <CAJZ5v0j0V10BYrME=KU1AJXGDMRUFFHiZEHQnsXhNJGPZKBSUw@mail.gmail.com>
 <20190517090521.GA15509@lst.de>
 <CAJZ5v0iL+ERE4Yy5yO8U2no194sRkvqNZHh5HsZXKvvHbxtk+g@mail.gmail.com>
 <20190517093516.GA17006@lst.de>
Message-ID: <CAJZ5v0gLqL7GUjwz5F8=9Fc-W2n3FRzbbB2L8udaXgN4Vsd8-Q@mail.gmail.com>

On Fri, May 17, 2019@11:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 17, 2019@11:17:52AM +0200, Rafael J. Wysocki wrote:
> > AFAICS, using DMA while creating a hibernation snapshot image of
> > memory would not be a good idea, so the host memory buffer should be
> > disabled during the "freeze" stage or hibernation (and it can be
> > re-enabled when that stage is complete).
>
> Once we'd disable the HMB the harm is done, so no point in re-enabling it.

But after the "freeze" stage the image may need to be written to the
device, so I guess it would be useful to enable the HMB for that?

> What would this mean in terms of ops?  Only disable in freeze_noirq?

It can be disabled in any of the "freeze" callbacks (freeze,
freeze_late, freeze_irq) where it makes most sense.  I also would
re-enable it in the complementary "thaw" one, in case the device will
be used to store the image.

> Or stick to the simple ops and find another helper that indicates we are doing a hibernation?

There are no helpers for that, it needs to be done manually, sort of.
