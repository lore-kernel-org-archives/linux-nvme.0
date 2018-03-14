From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Wed, 14 Mar 2018 08:31:24 -0700
Subject: [pci PATCH v6 5/5] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
In-Reply-To: <20180314085601.GD28796@lst.de>
References: <20180313212508.3553.65326.stgit@localhost.localdomain>
 <20180313213054.3553.89366.stgit@localhost.localdomain>
 <20180314085601.GD28796@lst.de>
Message-ID: <CAKgT0UcotCGAQZjT8SWp0+HeHasyt0UV8M_Ev_zi08jV1uvp8w@mail.gmail.com>

On Wed, Mar 14, 2018@1:56 AM, Christoph Hellwig <hch@lst.de> wrote:
>> +
>> +/**
>> + * pci_pf_stub_white_list - White list of devices to bind pci-pf-stub onto
>> + *
>> + * This table provides the list of IDs this driver is supposed to bind
>> + * onto. You could think of this as a list of "quirked" devices where we
>> + * are adding support for SR-IOV here since there are no other drivers
>> + * that they would be running under.
>> + *
>> + * Layout of the table below is as follows:
>> + * { Vendor ID, Device ID,
>> + *   SubVendor ID, SubDevice ID,
>> + *   Class, Class Mask,
>> + *   private data (not used) }
>> + */
>
> No need to document the PCI device table format in a random driver.

I realize this probably isn't necessary, but I wanted to document it
to make it clear in terms of layout so that it is't confused with the
quirk structure layout since this has been referred to as a "quirk"
driver a few times.

> Otherwise looks fine:
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
