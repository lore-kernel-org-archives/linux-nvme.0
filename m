From: drake@endlessm.com (Daniel Drake)
Date: Tue, 11 Jun 2019 11:25:55 +0800
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <20190610211628.GA68572@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <20190610211628.GA68572@google.com>
Message-ID: <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>

Hi Bjorn,

Thanks for the quick feedback. You raise some good questions that I'll
be sure to clarify in the next revision. To focus on some of the
pending details here:

On Tue, Jun 11, 2019@5:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Ugh.  Is there a spec that details what's actually going on here?

Unfortunately there isn't a great spec to go on.
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/100-series-chipset-datasheet-vol-2.pdf
has some details on the VS_CAP register (section 14.2.10).
Beyond that, Intel contributed patches to enable support for these
devices previously:
https://marc.info/?l=linux-ide&m=147709610621480&w=2
and stated that "The patch contents are [the spec]".
https://marc.info/?l=linux-ide&m=147733119300691&w=2
Later in the thread it was also stated unequivocally that the
interrupt is shared & the original NVMe dev config space is
unavailable.
I'll add references to these details in the next revision.

> This driver makes a lot of assumptions about how this works, e.g.,
> apparently there's an AHCI BAR that covers "hidden devices" plus some
> other stuff of some magic size, whatever is special about device 0,
> etc, but I don't see the source of those assumptions.

The AHCI BAR covering hidden devices is sort-of covered in the VS_CAP
spec so I can at least reference that.

> I'm not really keen on the precedent this sets about pretending things
> are PCI when they're not.  This seems like a bit of a kludge that
> might happen to work now but could easily break in the future because
> it's not based on any spec we can rely on.  Plus it makes future PCI
> maintenance harder because we have to worry about how these differ
> from real PCI devices.
>
> I think this creates a fake PCI host bridge, but not an actual PCIe
> Root Port, right?  I.e., "lspci" doesn't show a new Root Port device,
> does it?
>
> But I suppose "lspci" *does* show new NVMe devices that seem to be
> PCIe endpoints?  But they probably don't *work* like PCIe endpoints,
> e.g., we can't control ASPM, can't use AER, etc?

I appreciate your input here as I don't frequently go down to this
level of detail with PCI. I'm trying to follow the previous
suggestions from Christoph Hellwig, and further clarification on the
most appropriate way to do this would be appreciated:

https://marc.info/?l=linux-ide&m=147923593001525&w=2
"implementing a bridge driver like VMD"
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
"The right way to do this would be to expose a fake PCIe root port
that both the AHCI and NVMe driver bind to."

I'm not completely clear regarding the difference between a PCI host
bridge and a PCIe root port, but indeed, after my patch, when running
lspci, you see:

1. The original RAID controller, now claimed by this new intel-nvme-remap driver

0000:00:17.0 RAID bus controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 30)
    Subsystem: ASUSTeK Computer Inc. 82801 Mobile SATA Controller [RAID mode]
    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16
    Memory at b4390000 (32-bit, non-prefetchable) [size=32K]
    Memory at b43aa000 (32-bit, non-prefetchable) [size=256]
    I/O ports at 4090 [size=8]
    I/O ports at 4080 [size=4]
    I/O ports at 4060 [size=32]
    Memory at b4300000 (32-bit, non-prefetchable) [size=512K]
    Capabilities: [d0] MSI-X: Enable- Count=20 Masked-
    Capabilities: [70] Power Management version 3
    Capabilities: [a8] SATA HBA v1.0
    Kernel driver in use: intel-nvme-remap

2. The RAID controller presented by intel-nvme-remap on a new bus,
with the cfg space tweaked in a way that it gets probed & accepted by
the ahci driver:

10000:00:00.0 SATA controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 30) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. 82801 Mobile SATA Controller [RAID mode]
    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16, NUMA node 0
    Memory at b4390000 (32-bit, non-prefetchable) [size=32K]
    Memory at b43aa000 (32-bit, non-prefetchable) [size=256]
    I/O ports at 4090 [size=8]
    I/O ports at 4080 [size=4]
    I/O ports at 4060 [size=32]
    Memory at b4300000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [d0] MSI-X: Enable- Count=20 Masked-
    Capabilities: [70] Power Management version 3
    Capabilities: [a8] SATA HBA v1.0
    Kernel driver in use: ahci

3. The (previously inaccessible) NVMe device as presented on the new
bus by intel-nvme-remap, probed by the nvme driver

10000:00:01.0 Non-Volatile memory controller: Intel Corporation Device
0000 (prog-if 02 [NVM Express])
    Flags: bus master, fast Back2Back, fast devsel, latency 0, IRQ 16,
NUMA node 0
    Memory at b430c000 (64-bit, non-prefetchable) [size=16K]
    Kernel driver in use: nvme

I think Christoph's suggestion does ultimately require us to do some
PCI pretending in some form, but let me know if there are more
accepable ways to do this. If you'd like to see this appear more like
a PCIe root port then I guess I can use pci-bridge-emul.c to do this,
although having a fake root bridge appear in lspci output feels like
I'd be doing even more pretending.

Also happy to experiment with alternative approaches if you have any
suggestions? With the decreasing cost of NVMe SSDs, we're seeing an
influx of upcoming consumer PC products that will ship with the NVMe
disk being the only storage device, combined with the BIOS default of
"RST Optane" mode which will prevent Linux from seeing it at all, so
I'm really keen to swiftly find a way forward here.

Thanks!
Daniel
