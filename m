From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Aug 2018 09:51:06 -0600
Subject: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
Message-ID: <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>



On 31/08/18 02:08 AM, Christian K?nig wrote:
>> +One of the biggest issues is that PCI doesn't require forwarding
>> +transactions between hierarchy domains, and in PCIe, each Root Port
>> +defines a separate hierarchy domain. To make things worse, there is no
>> +simple way to determine if a given Root Complex supports this or not.
>> +(See PCIe r4.0, sec 1.3.1). Therefore, as of this writing, the kernel
>> +only supports doing P2P when the endpoints involved are all behind the
>> +same PCI bridge, as such devices are all in the same PCI hierarchy
>> +domain, and the spec guarantees that all transacations within the
>> +hierarchy will be routable, but it does not require routing
>> +between hierarchies.
> 
> Can we add a kernel command line switch and a whitelist to enable P2P 
> between separate hierarchies?

In future work, yes. But not for this patchset. This is definitely the
way I see things going, but we've chosen to start with what we've presented.

Logan
