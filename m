From: tj@kernel.org (Tejun Heo)
Date: Mon, 7 Oct 2013 14:21:17 -0400
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Message-ID: <20131007182117.GC27396@htj.dyndns.org>

Hello, Alexander.

On Wed, Oct 02, 2013@12:48:16PM +0200, Alexander Gordeev wrote:
> Alexander Gordeev (77):
>   PCI/MSI: Fix return value when populate_msi_sysfs() failed
>   PCI/MSI/PPC: Fix wrong RTAS error code reporting
>   PCI/MSI/s390: Fix single MSI only check
>   PCI/MSI/s390: Remove superfluous check of MSI type
>   PCI/MSI: Convert pci_msix_table_size() to a public interface
>   PCI/MSI: Factor out pci_get_msi_cap() interface
>   PCI/MSI: Re-design MSI/MSI-X interrupts enablement pattern
>   PCI/MSI: Get rid of pci_enable_msi_block_auto() interface
>   ahci: Update MSI/MSI-X interrupts enablement code
>   ahci: Check MRSM bit when multiple MSIs enabled
...

Whee.... that's a lot more than I expected.  I was just scanning
multiple msi users.  Maybe we can stage the work in more manageable
steps so that you don't have to go through massive conversion only to
do it all over again afterwards and likewise people don't get
bombarded on each iteration?  Maybe we can first update pci / msi code
proper, msi and then msix?

Thanks.

-- 
tejun
