From: bhutchings@solarflare.com (Ben Hutchings)
Date: Thu, 3 Oct 2013 23:49:45 +0100
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Message-ID: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>

On Wed, 2013-10-02@12:48 +0200, Alexander Gordeev wrote:
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
> 
> This update converts pci_enable_msix() and pci_enable_msi_block()
> interfaces to canonical kernel functions and makes them return a
> error code in case of failure or 0 in case of success.
[...]

I think this is fundamentally flawed: pci_msix_table_size() and
pci_get_msi_cap() can only report the limits of the *device* (which the
driver usually already knows), whereas MSI allocation can also be
constrained due to *global* limits on the number of distinct IRQs.

Currently pci_enable_msix() will report a positive value if it fails due
to the global limit.  Your patch 7 removes that.  pci_enable_msi_block()
unfortunately doesn't appear to do this.

It seems to me that a more useful interface would take a minimum and
maximum number of vectors from the driver.  This wouldn't allow the
driver to specify that it could only accept, say, any even number within
a certain range, but you could still leave the current functions
available for any driver that needs that.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
