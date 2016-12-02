From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Dec 2016 17:48:06 -0500
Subject: [PATCH v3] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <c28126550f46f20aec1f069a4a8d10d802332dda.1480697884.git.luto@kernel.org>
References: <c28126550f46f20aec1f069a4a8d10d802332dda.1480697884.git.luto@kernel.org>
Message-ID: <20161202224805.GA8698@localhost.localdomain>

On Fri, Dec 02, 2016@08:58:57AM -0800, Andy Lutomirski wrote:
> When debugging nvme controller crashes, it's nice to know whether
> the controller died cleanly so that the failure is just reflected in
> CSTS, it died and put an error in PCI_STATUS, or whether it died so
> badly that it stopped responding to PCI configuration space reads.
> 
> I've seen a failure that gives 0xffff in PCI_STATUS on a Samsung
> "SM951 NVMe SAMSUNG 256GB" with firmware "BXW75D0Q".
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Andy Lutomirski <luto at kernel.org>

Totally fine with this, but just want to mention that even the MMIO read
has caused problems when racing a pciehp hot plug event. A config read in
this case is another opprotunity for a completion timeout, unless I can
get Bjorn to apply the patch series disabling config access on surprise
removed devices. Or maybe our nvme health check polling implementation
is misguided.

Reviewed-by: Keith Busch <keith.busch at intel.com>
