From: michael@ellerman.id.au (Michael Ellerman)
Date: Tue, 8 Oct 2013 15:33:30 +1100
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Message-ID: <20131008043330.GF31666@concordia>

On Wed, Oct 02, 2013@12:29:04PM +0200, Alexander Gordeev wrote:
> This series is against "next" branch in Bjorn's repo:
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> 
> Currently pci_enable_msi_block() and pci_enable_msix() interfaces
> return a error code in case of failure, 0 in case of success and a
> positive value which indicates the number of MSI-X/MSI interrupts
> that could have been allocated. The latter value should be passed
> to a repeated call to the interfaces until a failure or success:
> 
> 
> 	for (i = 0; i < FOO_DRIVER_MAXIMUM_NVEC; i++)
> 		adapter->msix_entries[i].entry = i;
> 
> 	while (nvec >= FOO_DRIVER_MINIMUM_NVEC) {
> 		rc = pci_enable_msix(adapter->pdev,
> 				     adapter->msix_entries, nvec);
> 		if (rc > 0)
> 			nvec = rc;
> 		else
> 			return rc;
> 	}
> 
> 	return -ENOSPC;
> 
> 
> This technique proved to be confusing and error-prone. Vast share
> of device drivers simply fail to follow the described guidelines.

To clarify "Vast share of device drivers":

 - 58 drivers call pci_enable_msix()
 - 24 try a single allocation and then fallback to MSI/LSI
 - 19 use the loop style allocation as above
 - 14 try an allocation, and if it fails retry once
 - 1  incorrectly continues when pci_enable_msix() returns > 0

So 33 drivers (> 50%) successfully make use of the "confusing and
error-prone" return value.

Another 24 happily ignore it, which is also entirely fine.

And yes, one is buggy, so obviously the interface is too complex. Thanks
drivers/ntb/ntb_hw.c

cheers
