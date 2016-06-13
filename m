From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 13 Jun 2016 17:26:30 -0500
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
In-Reply-To: <20160613215736.GH12766@localhost.localdomain>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160613211411.GC18747@localhost>
 <20160613212810.GG12766@localhost.localdomain>
 <20160613215736.GH12766@localhost.localdomain>
Message-ID: <20160613222630.GD18747@localhost>

On Mon, Jun 13, 2016@05:57:37PM -0400, Keith Busch wrote:
> On Mon, Jun 13, 2016@05:28:10PM -0400, Keith Busch wrote:
> > On Mon, Jun 13, 2016@04:14:11PM -0500, Bjorn Helgaas wrote:
> > > Can we do that at the same time?  If we add good new stuff and only
> > > use it one place, there's not as much overall goodness as there would
> > > be if we updated everybody to do it similarly.
> > 
> > Sounds good, I'll send a series taking advantage of this for all the
> > other PF drivers duplicating this check in their sriov_configure.
> 
> Heh, I thought "no big deal", thinking all use was similar to
> NVMe's. However, most network drivers have multiple paths to sriov
> configuration, or have other requirements to changing the live
> count! There's only two drivers I find that can immediately use the
> simplification safely. I'll send those updates to just those ones.

My take on that is, "it's a pretty trival check; just put it directly
in nvme and don't bother doing anything in the PCI core."  Maybe
someday we'll come up with a way to make things more common.  It
doesn't really seem worth it to add something that only helps three
drivers.

Bjorn
