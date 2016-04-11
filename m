From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 11 Apr 2016 16:48:23 -0400
Subject: [PATCH 1/2] nvme: Fix pci_device_id table by adding the most
 generic devices in the end
In-Reply-To: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <20160411204823.GL2781@linux.intel.com>

On Mon, Apr 11, 2016@05:15:50PM -0300, Guilherme G. Piccoli wrote:
> The struct pci_device_id is used on a PCI driver probe by the PCI core
> mechanism to match the devices present on the system with the driver
> being probed. For each device, the match procedure reads each entry in
> the pci_device_id struct provided by the driver and tries to match the
> first entry it is able to do.

What you're missing is that the Apple device doesn't have the NVMe
programming model / class code.  So this patch actually has no effect.
