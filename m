From: drake@endlessm.com (Daniel Drake)
Date: Tue, 11 Jun 2019 10:46:32 +0800
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
Message-ID: <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>

On Tue, Jun 11, 2019@12:00 AM Keith Busch <keith.busch@gmail.com> wrote:
>
> On Mon, Jun 10, 2019@1:45 AM Daniel Drake <drake@endlessm.com> wrote:
> > +       /* We don't support sharing MSI interrupts between these devices */
> > +       nrdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>
> And this is a problem, isn't it? Since we don't have an option to open
> the MSI implementation in RAID mode your experience will be much
> better to disable this mode when using Linux as per the current
> recommendation rather than limping along with legacy IRQ.

What's the specific problem that you see here? Is it that the
interrupt delivery mechanism is legacy wire instead of MSI, or is the
problem that the interrupt is shared over the whole set of storage
devices?

I installed Windows 10 on this product in RAID mode and it is using
the legacy interrupt too. Also, on Linux, MSI interrupts have already
been disabled on the AHCI part of such setups for a good while now:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f723fa4e69920f6a5dd5fa0d10ce90e2f14d189c

The earlier patches from Dan Williams also had the design of sharing
the legacy interrupt:
https://marc.info/?l=linux-ide&m=147709610621480&w=2

I think some kind of MSI support may be possible, perhaps something
similar to what is done by drivers/pci/controller/vmd.c, but it needs
a bit more thought, and I was hoping that we could get the base device
support in place before investigating MSI as a separate step. However,
if the concern you are raising is regarding the sharing of interrupts,
I think that cannot change because the NVMe devices PCI config space
is totally inaccessible when in this mode. That means there is no way
we can configure a per-device MSI message, so the interrupt will
continue to be shared regardless of delivery mechanism.

Thanks,
Daniel
