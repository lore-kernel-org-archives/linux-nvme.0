From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Thu, 8 Aug 2019 20:05:48 +0000
Subject: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
In-Reply-To: <20190808183954.GG151852@google.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
 <1870928.r7tBYyfqdz@kreacher> <20190808134356.GF151852@google.com>
 <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com>
 <20190808183954.GG151852@google.com>
Message-ID: <707af7109fee4942a4ba8eebbee6cde8@AUSX13MPC105.AMER.DELL.COM>

> This is more meaningful to you than to most people because "applying
> the standard PCI PM" doesn't tell us what that means in terms of the
> device.  Presumably it has something to do with a D-state transition?
> I *assume* a suspend might involve the D0 -> D3hot transition you
> mention below?
> 
> > The reason for doing that was a (reportedly) widespread failure to
> > take the PCIe link down during D0 -> D3hot transitions of NVMe
> > devices,
> 
> I don't know any of the details, but "failure to take the link down
> during D0 -> D3hot transitions" is phrased as though it might be a
> hardware erratum.  If this *is* related to an NVMe erratum, that would
> explain why you only need to patch the nvme driver, and it would be
> useful to mention that in the commit log, since otherwise it sounds
> like something that might be needed in other drivers, too.

NVME is special in this case that there is other logic being put in place
to set the drive's power state explicitly.

I would mention that also this alternate flow is quicker for s0ix
resume since NVME doesn't go through shutdown routine.

Unanimously the feedback from vendors was to avoid NVME shutdown
and to instead use SetFeatures to go into deepest power state instead
over S0ix.

> 
> According to PCIe r5.0 sec 5.3.2, the only legal link states for D3hot
> are L1, L2/L3 Ready.  So if you put a device in D3hot and its link
> stays in L0, that sounds like a defect.  Is that what happens?
> 
> Obviously I'm still confused.  I think it would help if you could
> describe the problem in terms of the specific PCIe states involved
> (D0, D3hot, L0, L1, L2, L3, etc) because then the spec would help
> explain what's happening.

Before that commit, the flow for NVME s0ix was:

* Delete IO SQ/CQ
* Shutdown NVME controller
* Save PCI registers
* Go into D3hot
* Read PMCSR

A functioning drive had the link at L1.2 and NVME power state at PS4
at this point.
Resuming looked like this:

* Restore PCI registers
* Enable NVME controller
* Configure NVME controller (IO queues, features, etc).

After that commit the flow for NVME s0ix is:

* Use NVME SetFeatures to put drive into low power mode (PS3 or PS4)
* Save PCI config register
* ASPM is used to bring link into L1.2

The resume flow is:

* Restore PCI registers

"Non-functioning" drives consumed too much power from the old flow.

The root cause varied from manufacturer to manufacturer.
The two I know off hand:

One instance is that when PM status register is read after the device in L1.2
from D3 it causes link to go to L0 and then stay there.

Another instance I heard drive isn't able to service D3hot request when NVME
was already shut down.
