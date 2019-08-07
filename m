From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Aug 2019 12:45:00 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state
 for suspend" has problems
In-Reply-To: <2763495.NmdaWeg79L@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <2763495.NmdaWeg79L@kreacher>
Message-ID: <20190807104500.GB11356@lst.de>

On Wed, Aug 07, 2019@11:48:33AM +0200, Rafael J. Wysocki wrote:
> So I think I know what the problem is here.
> 
> If ASPM is disabled for the NVMe device (which is the case on my machine by default),
> skipping the bus-level PM in nvme_suspend() causes the PCIe link of it to stay up and
> that prevents the SoC from getting into deeper package C-states.
> 
> If I change the ASPM policy to "powersave" (through the module parameter in there),
> ASPM gets enabled for the NVMe drive and I can get into PC10 via S2Idle with plain 5.3-rc3.
> 
> However, that's a bit less than straightforward, so I'm going to post a patch to make
> nvme_suspend() fall back to the "old ways" if ASPM is not enabled for the target device.

Sounds sensibel.

FYI your mail is not properly formatted and has way too long lines.
