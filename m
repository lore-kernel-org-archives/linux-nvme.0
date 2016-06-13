From: keith.busch@intel.com (Keith Busch)
Date: Mon, 13 Jun 2016 18:35:52 -0400
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
In-Reply-To: <20160613222630.GD18747@localhost>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160613211411.GC18747@localhost>
 <20160613212810.GG12766@localhost.localdomain>
 <20160613215736.GH12766@localhost.localdomain>
 <20160613222630.GD18747@localhost>
Message-ID: <20160613223551.GJ12766@localhost.localdomain>

On Mon, Jun 13, 2016@05:26:30PM -0500, Bjorn Helgaas wrote:
> My take on that is, "it's a pretty trival check; just put it directly
> in nvme and don't bother doing anything in the PCI core."  Maybe
> someday we'll come up with a way to make things more common.  It
> doesn't really seem worth it to add something that only helps three
> drivers.

Fair enough. Will withdraw the check in pci and resend nvme.
