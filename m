From: drake@endlessm.com (Daniel Drake)
Date: Wed, 12 Jun 2019 11:16:03 +0800
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <20190611195254.GB768@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <20190610211628.GA68572@google.com>
 <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>
 <20190611195254.GB768@google.com>
Message-ID: <CAD8Lp479mY=dAhFvGT2ZiJP12KXszhWev=QpCcgfgoew0TxgWg@mail.gmail.com>

On Wed, Jun 12, 2019@3:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> It also said (three years ago) that there was some hope of opening the
> specs.  But I guess that hasn't happened.

I think the brief spec I already linked to may have been published as
a result of the discussion there:
https://marc.info/?l=linux-ide&m=147734288604783&w=2

Either way I'm not aware of any more detailed information having been
published since then.

> > 2. The RAID controller presented by intel-nvme-remap on a new bus,
> > with the cfg space tweaked in a way that it gets probed & accepted by
> > the ahci driver:
> >
> > 10000:00:00.0 SATA controller: Intel Corporation 82801 Mobile SATA
> > Controller [RAID mode] (rev 30) (prog-if 01 [AHCI 1.0])
> >     Memory at b4390000 (32-bit, non-prefetchable) [size=32K]
>
> Exposing the same device in two different places (0000:00:17.0 and
> 10000:00:00.0) is definitely an architectural issue.  Logically we're
> saying that accesses to b4390000 are claimed by two different devices.

I guess intel-nvme-remap could tweak the 0000:00:17.0 device to remove
those BARs so that they ultimately only appear under 10000:00:00.0.
But that doesn't sound particularly nice either.

If we continue down this road, another possibility is to leave the
0000:00:17.0 device untouched, claimed and driven by the ahci driver
as it is now, and rather than have intel-nvme-remap be a separate
driver that claims the PCI device, just have it as a kind of library
that gets called into from ahci. intel-nvme-remap would then create
the "fake" PCI bus but only expose the NVMe devs there (not the AHCI
one). This would deviate a little from the original suggestion of
"expose a fake PCIe root port that both the AHCI and NVMe driver bind
to.".

> > 3. The (previously inaccessible) NVMe device as presented on the new
> > bus by intel-nvme-remap, probed by the nvme driver
> >
> > 10000:00:01.0 Non-Volatile memory controller: Intel Corporation Device
> > 0000 (prog-if 02 [NVM Express])
> >     Memory at b430c000 (64-bit, non-prefetchable) [size=16K]
>
> From a hardware point of view, I think it *was* previously accessible.
> Maybe not in a convenient, driver-bindable way, but I don't think your
> patch flips any PCI_COMMAND or similar register enable bits.
> Everything should have been accessible before if you knew where to
> look.

Pretty much, but in addition to fishing out the NVMe memory address
from the AHCI BAR,  you also have to know to share the interrupt with
AHCI, and also the PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER bits must
be set on the AHCI device in order for the NVMe devices to work.

> Why do you need these to be PCI devices?

I don't have a particular preference, but was trying to explore the
suggestions from the last round of review:

https://marc.info/?l=linux-ide&m=147923593001525&w=2
"implementing a bridge driver like VMD"
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
"The right way to do this would be to expose a fake PCIe root port
that both the AHCI and NVMe driver bind to."

> It looks like the main thing
> you get is a hook to bind the driver to.  Could you accomplish
> something similar by doing some coordination between the ahci and nvme
> drivers directly, without involving PCI?

That's basically what Dan Williams originally proposed, and Christoph
Hellwig was not particularly excited by it...

Can you take a quick at the original patches and see what you think?
https://marc.info/?l=linux-ide&m=147709611121482&w=2
https://marc.info/?l=linux-ide&m=147709611621483&w=2
https://marc.info/?l=linux-ide&m=147709612221484&w=2
https://marc.info/?l=linux-ide&m=147709612721485&w=2
https://marc.info/?l=linux-ide&m=147709613221487&w=2

> I assume that whatever magic Intel is doing with this "RST Optane"
> mode, the resulting platform topology is at least compliant with the
> PCI spec, so all the standard things in the spec like AER, DPC, power
> management, etc, still work.

That would also be my expectation - those standard things you
configure on the AHCI device would also affect the mode of operation
of the hidden NVMe devices, in the same way that the
PCI_COMMAND_MASTER AHCI bit affects NVMe device access.

> This all sounds urgent, but without details of what this "RST Optane"
> mode means actually means, I don't know what to do with it.  I want to
> avoid the voodoo programming of "we don't know *why* we're doing this,
> but it seems to work."

>From the user perspective, we're doing it so that they get access to
their storage device.

But I guess you meant more from the technical architecture
perspective. My understanding comes from
https://mjg59.dreamwidth.org/44694.html : this is a game of Windows
driver politics.
Intel doesn't want the standard Windows NVMe driver to bind to the
NVMe devices, because that driver is power hungry and makes Intel
platforms look bad. So they came up with this scheme to hide the NVMe
devices from view, and then only the power-eficient Intel Windows
driver knows how to find them.

The implementation follows patches, emails and the VS_CAP spec, all
authored by Intel. I'm not confident that we'll get any more than
that. The 2016 patches only appeared 5 months after numerous Lenovo
customers had reported their inability to access their disk on Linux
(they didn't even have a BIOS configuration option at that point).
While some information was then shared in patches and emails, as you
have seen Intel wasn't very forthcoming in providing a decent spec.
Intel's last comment in the 2016 thread wasn't exactly positive:
https://marc.info/?l=linux-ide&m=147953592417285&w=2
and there was no reponse from Intel to my 2017 thread:
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013323.html

So at this point I'd advocate for just piecing together the pieces of
the puzzle that we do have (I'll work to reference the details better
in the next patch revision), accepting that we're working with an
architecture that doesn't seem well thought out, and then figure out
the least painful way to support it.

Thanks,
Daniel
