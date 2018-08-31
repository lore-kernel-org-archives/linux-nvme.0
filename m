From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Aug 2018 09:48:40 -0600
Subject: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
Message-ID: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>



On 31/08/18 02:04 AM, Christian K?nig wrote:
> Am 30.08.2018 um 20:53 schrieb Logan Gunthorpe:
>> Some PCI devices may have memory mapped in a BAR space that's
>> intended for use in peer-to-peer transactions. In order to enable
>> such transactions the memory must be registered with ZONE_DEVICE pages
>> so it can be used by DMA interfaces in existing drivers.
> 
> We want to use that feature without ZONE_DEVICE pages for DMA-buf as well.
> 
> How hard would it be to separate enabling P2P detection (e.g. distance 
> between two devices) from this?

Pretty easy. P2P detection is pretty much just pci_p2pdma_distance() ,
which has nothing to do with the ZONE_DEVICE support.

(And the distance function makes use of a number of static functions
which could be combined into a simpler interface, should we need it.)

Logan
