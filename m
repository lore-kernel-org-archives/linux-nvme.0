From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Mar 2018 09:56:01 +0100
Subject: [pci PATCH v6 5/5] pci-pf-stub: Add PF driver stub for PFs
 that function only to enable VFs
In-Reply-To: <20180313213054.3553.89366.stgit@localhost.localdomain>
References: <20180313212508.3553.65326.stgit@localhost.localdomain>
 <20180313213054.3553.89366.stgit@localhost.localdomain>
Message-ID: <20180314085601.GD28796@lst.de>

> +
> +/**
> + * pci_pf_stub_white_list - White list of devices to bind pci-pf-stub onto
> + *
> + * This table provides the list of IDs this driver is supposed to bind
> + * onto. You could think of this as a list of "quirked" devices where we
> + * are adding support for SR-IOV here since there are no other drivers
> + * that they would be running under.
> + *
> + * Layout of the table below is as follows:
> + * { Vendor ID, Device ID,
> + *   SubVendor ID, SubDevice ID,
> + *   Class, Class Mask,
> + *   private data (not used) }
> + */

No need to document the PCI device table format in a random driver.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
