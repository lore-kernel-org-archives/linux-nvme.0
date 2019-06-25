From: drake@endlessm.com (Daniel Drake)
Date: Tue, 25 Jun 2019 11:51:28 +0800
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
In-Reply-To: <20190624061617.GA2848@lst.de>
References: <20190620051333.2235-1-drake@endlessm.com>
 <20190620051333.2235-3-drake@endlessm.com>
 <20190620061038.GA20564@lst.de>
 <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
 <20190624061617.GA2848@lst.de>
Message-ID: <CAD8Lp464B0dOd+ayF_AK4DRzHEpiaSbUOXjVJ5bq5zMXq=BBKQ@mail.gmail.com>

On Mon, Jun 24, 2019@2:16 PM Christoph Hellwig <hch@lst.de> wrote:
> IFF we want to support it it has to be done at the PCIe layer.  But
> even that will require actual documentation and support from Intel.
>
> If Intel still believes this scheme is their magic secret to control
> the NVMe market and give themselves and unfair advantage over their
> competitors there is not much we can do.

Since the 2016 discussion, more documentation has been published:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf
Chapter 15 is entirely new, and section 15.2 provides a nice clarity
improvement of the magic regs in the AHCI BAR, which I have used in
these patches to clean up the code and add documentation in the header
(see patch 1 in this series, ahci-remap.h).

I believe there's room for further improvement in the docs here, but
it would be nice to know what you see as the blocking questions or
documentation gaps that would prevent us from continuing to develop
the fake PCI bridge approach
(https://marc.info/?l=linux-pci&m=156015271021614&w=2). We are going
to try and push Intel on this via other channels to see if we can get
a contact to help us, so it would be useful if I can include a
concrete list of what we need.

Bearing in mind that we've already been told that the NVMe device
config space is inaccessible, and the new docs show exactly how the
BIOS enforces such inaccessibility during early boot, the remaining
points you mentioned recently were:

 b) reset handling, including the PCI device removal as the last
    escalation step
 c) SR-IOV VFs and their management
 d) power management

Are there other blocking questions you would require answers to?

Thanks,
Daniel
