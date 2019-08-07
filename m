From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 6 Aug 2019 18:31:07 -0600
Subject: [PATCH v2 00/14] PCI/P2PDMA: Support transactions that hit the
 host bridge
In-Reply-To: <20190806234439.GW151852@google.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190806234439.GW151852@google.com>
Message-ID: <e31f13f8-5afd-6f38-a206-163e9f77c91a@deltatee.com>



On 2019-08-06 5:44 p.m., Bjorn Helgaas wrote:
> On Tue, Jul 30, 2019@10:35:31AM -0600, Logan Gunthorpe wrote:
>> Here's v2 of the patchset. It doesn't sound like there's anything
>> terribly controversial here so this version is mostly just some
>> cleanup changes for clarity.
>>
>> Changes in v2:
>>  * Rebase on v5.3-rc2 (No changes)
>>  * Re-introduce the private pagemap structure and move the p2p-specific
>>    elements out of the commond dev_pagemap (per Christoph)
>>  * Use flags instead of bool in the whitelist (per Jason)
>>  * Only store the mapping type in the xarray (instead of the distance
>>    with flags) such that a function can return the mapping method
>>    with a switch statement to decide how to map. (per Christoph)
>>  * Drop find_parent_pci_dev() on the fast path and rely on the fact
>>    that the struct device passed to the mapping functions *must* be
>>    a PCI device and convert it directly. (per suggestions from
>>    Christoph and Jason)
>>  * Collected Christian's Reviewed-by's
>> --
>>
>> As discussed on the list previously, in order to fully support the
>> whitelist Christian added with the IOMMU, we must ensure that we
>> map any buffer going through the IOMMU with an aprropriate dma_map
>> call. This patchset accomplishes this by cleaning up the output of
>> upstream_bridge_distance() to better indicate the mapping requirements,
>> caching these requirements in an xarray, then looking them up at map
>> time and applying the appropriate mapping method.
>>
>> After this patchset, it's possible to use the NVMe-of P2P support to
>> transfer between devices without a switch on the whitelisted root
>> complexes. A couple Intel device I have tested this on have also
>> been added to the white list.
>>
>> Most of the changes are contained within the p2pdma.c, but there are
>> a few minor touches to other subsystems, mostly to add support
>> to call an unmap function.
>>
>> The final patch in this series demonstrates a possible
>> pci_p2pdma_map_resource() function that I expect Christian will need
>> but does not have any users at this time so I don't intend for it to be
>> considered for merging.
> 
> I don't see pci_p2pdma_map_resource() in any of these patches.

Oh, sorry, I removed that in v2 seeing there was some confusion over it.
I guess I forgot to remove the reference in the cover letter.

> I tentatively applied these to pci/p2pdma with minor typographical
> updates (below), but I'll update the branch if necessary.

Great, thanks! The typographical changes look good.

I already have one very minor change queued up for these. Should I just
send you a small patch against your branch for you to squash?

Logan
