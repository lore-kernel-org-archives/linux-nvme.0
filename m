From: kbusch@kernel.org (Keith Busch)
Date: Thu, 8 Aug 2019 14:01:28 -0600
Subject: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
In-Reply-To: <20190808183954.GG151852@google.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain>
 <1921165.pTveHRX1Co@kreacher> <1870928.r7tBYyfqdz@kreacher>
 <20190808134356.GF151852@google.com>
 <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com>
 <20190808183954.GG151852@google.com>
Message-ID: <20190808200128.GC27077@localhost.localdomain>

On Thu, Aug 08, 2019@01:39:54PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 08, 2019@04:47:45PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 8, 2019@3:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > IIUC the NVMe device will go to the desired package idle state if
> > > the link is in L0s or L1, but not if the link is in L0.  I don't
> > > understand that connection; AFAIK that would be something outside
> > > the scope of the PCIe spec.
> > 
> > Yes, it is outside of the PCIe spec.
> > 
> > No, this is not about the NVMe device, it is about the Intel SoC
> > (System-on-a-Chip) the platform is based on.
> 
> Ah.  So this problem could occur with any device, not just NVMe?  If
> so, how do you address that?  Obviously you don't want to patch all
> drivers this way.

We discovered this when using an NVMe protocol specific power setting, so
that part is driver specific. We just have to ensure device generic
dependencies are met in order to achieve the our power target. So in
that sense, I think you would need to patch all drivers if they're also
using protocol specific settings incorrectly.

Granted, the NVMe specification doesn't detail what PCIe settings may
prevent NVMe power management from hitting the objective, but I think
ASPM enabled makes sense.
