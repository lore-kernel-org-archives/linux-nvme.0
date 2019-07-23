From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 23 Jul 2019 10:58:41 -0600
Subject: [PATCH 00/14] PCI/P2PDMA: Support transactions that hit the host
 bridge
In-Reply-To: <d7c7011e-e9b7-89f8-99ba-b674d45821c6@amd.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <d7c7011e-e9b7-89f8-99ba-b674d45821c6@amd.com>
Message-ID: <deaa0992-24c8-be93-f623-a5b2b442e4d0@deltatee.com>



On 2019-07-23 10:30 a.m., Koenig, Christian wrote:
> Am 23.07.19 um 01:08 schrieb Logan Gunthorpe:
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
>>
>> This patchset is based on 5.3-rc1 and a git branch is available here:
>>
>> https://github.com/sbates130272/linux-p2pmem/ p2pdma_rc_map_v1
> 
> I reviewed patches #1-#3 and #14.
> 
> Feel free to stick an Acked-by: Christian K?nig 
> <christian.koenig at amd.com> to the rest, but I'm not really deep into the 
> NVMe P2P handling here.

Thanks!

Logan
