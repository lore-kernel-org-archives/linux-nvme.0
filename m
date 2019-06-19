From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 19 Jun 2019 08:52:12 -0500
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <1f56c881-9005-f8ad-1557-5efd6e0ef535@suse.de>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <06c38b3e-603b-5bae-4959-9965ab40db62@suse.de>
 <CAD8Lp44rqGh3nmUOFhwq+SSxpJGuWvLFJ8sKtM0q1GeY0j4v9A@mail.gmail.com>
 <1f56c881-9005-f8ad-1557-5efd6e0ef535@suse.de>
Message-ID: <20190619135212.GB143205@google.com>

On Tue, Jun 18, 2019@05:15:52PM +0200, Hannes Reinecke wrote:
> On 6/18/19 10:06 AM, Daniel Drake wrote:

> > We can probably also use these registers for MSI support. I
> > started to experiment, doesn't quite work but I'll keep poking.
> > The doc suggests there is a single MSI-X vector for the AHCI SATA
> > device, and AHCI MSI-X Starting Vector (AMXV) has value 0x140 on
> > this platform. No idea how to interpret that value. From
> > experimentation, the AHCI SATA disk generates interrupts on vector
> > 0.
> > 
> The 0x140 is probably the offset into the PCI config space where the
> AHCI MSI-X vector table can be found ...

An MSI-X vector table is in memory space, not config space.  You'd
have to look at PCI_MSIX_TABLE_BIR to find which BAR maps it, and then
add PCI_MSIX_TABLE_OFFSET to the BAR value.

Bjorn
