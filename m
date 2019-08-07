From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 07 Aug 2019 11:48:33 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <20190731221956.GB15795@localhost.localdomain>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
Message-ID: <2763495.NmdaWeg79L@kreacher>

On Thursday, August 1, 2019 12:19:56 AM CEST Keith Busch wrote:
> On Wed, Jul 31, 2019@11:25:51PM +0200, Rafael J. Wysocki wrote:
> > 
> > A couple of remarks if you will.
> > 
> > First, we don't know which case is the majority at this point.  For
> > now, there is one example of each, but it may very well turn out that
> > the SK Hynix BC501 above needs to be quirked.
> > 
> > Second, the reference here really is 5.2, so if there are any systems
> > that are not better off with 5.3-rc than they were with 5.2, well, we
> > have not made progress.  However, if there are systems that are worse
> > off with 5.3, that's bad.  In the face of the latest findings the only
> > way to avoid that is to be backwards compatible with 5.2 and that's
> > where my patch is going.  That cannot be achieved by quirking all
> > cases that are reported as "bad", because there still may be
> > unreported ones.
> 
> I have to agree. I think your proposal may allow PCI D3cold, in which
> case we do need to reintroduce the HMB handling.

So I think I know what the problem is here.

If ASPM is disabled for the NVMe device (which is the case on my machine by default),
skipping the bus-level PM in nvme_suspend() causes the PCIe link of it to stay up and
that prevents the SoC from getting into deeper package C-states.

If I change the ASPM policy to "powersave" (through the module parameter in there),
ASPM gets enabled for the NVMe drive and I can get into PC10 via S2Idle with plain 5.3-rc3.

However, that's a bit less than straightforward, so I'm going to post a patch to make
nvme_suspend() fall back to the "old ways" if ASPM is not enabled for the target device.

Cheers!
