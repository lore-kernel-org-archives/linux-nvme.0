From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 12 Jun 2019 08:49:25 -0500
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAD8Lp479mY=dAhFvGT2ZiJP12KXszhWev=QpCcgfgoew0TxgWg@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <20190610211628.GA68572@google.com>
 <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>
 <20190611195254.GB768@google.com>
 <CAD8Lp479mY=dAhFvGT2ZiJP12KXszhWev=QpCcgfgoew0TxgWg@mail.gmail.com>
Message-ID: <20190612134925.GC13533@google.com>

On Wed, Jun 12, 2019@11:16:03AM +0800, Daniel Drake wrote:
> On Wed, Jun 12, 2019@3:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > Why do you need these to be PCI devices?
> 
> I don't have a particular preference, but was trying to explore the
> suggestions from the last round of review:
> 
> https://marc.info/?l=linux-ide&m=147923593001525&w=2
> "implementing a bridge driver like VMD"
> http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
> "The right way to do this would be to expose a fake PCIe root port
> that both the AHCI and NVMe driver bind to."
> 
> > It looks like the main thing
> > you get is a hook to bind the driver to.  Could you accomplish
> > something similar by doing some coordination between the ahci and nvme
> > drivers directly, without involving PCI?
> 
> That's basically what Dan Williams originally proposed, and Christoph
> Hellwig was not particularly excited by it...
> 
> Can you take a quick at the original patches and see what you think?
> https://marc.info/?l=linux-ide&m=147709611121482&w=2
> https://marc.info/?l=linux-ide&m=147709611621483&w=2
> https://marc.info/?l=linux-ide&m=147709612221484&w=2
> https://marc.info/?l=linux-ide&m=147709612721485&w=2
> https://marc.info/?l=linux-ide&m=147709613221487&w=2

I see Christoph's objections starting at
https://marc.info/?l=linux-ide&m=147711904724908&w=2
and I agree that this AHCI/NVMe melding is ugly.

But given the existence of this ugly hardware, my opinion is that
Dan's original patch series (above) is actually a nice way to deal
with it.  That's exactly the sort of thing I was proposing.

Part of Christoph's objection was the issue of how reset works, and
that objection absolutely makes sense to me.  But IMO adding a fake
PCI host bridge and fake PCI devices that really don't work because
they have read-only config space just smears the issue over
PCI/VFIO/etc in addition to AHCI and NVMe.

Bjorn
