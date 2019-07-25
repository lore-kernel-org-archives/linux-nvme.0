From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 10:00:54 -0600
Subject: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
In-Reply-To: <20190725115038.GC31065@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-15-logang@deltatee.com> <20190724063235.GC1804@lst.de>
 <57e8fc1a-de70-fb65-5ef1-ffa2b95c73a6@deltatee.com>
 <20190725115038.GC31065@lst.de>
Message-ID: <3d5400df-f109-9ffa-3e79-8f6bb8d7de34@deltatee.com>



On 2019-07-25 5:50 a.m., Christoph Hellwig wrote:
> On Wed, Jul 24, 2019@10:06:22AM -0600, Logan Gunthorpe wrote:
>> Yes. This is the downside of dealing only with a phys_addr_t: we have to
>> look up against it. Unfortunately, I believe it's possible for different
>> BARs on a device to be in different windows, so something like this is
>> necessary unless we already know the BAR the phys_addr_t belongs to. It
>> might probably be sped up a bit by storing the offsets of each bar
>> instead of looping through all the bridge windows, but I don't think it
>> will get you *that* much.
>>
>> As this is an example with no users, the answer here will really depend
>> on what the use-case is doing. If they can lookup, ahead of time, the
>> mapping type and offset then they don't have to do this work on the hot
>> path and it means that pci_p2pdma_map_resource() is simply not a
>> suitable API.
> 
> Ok.  So lets just keep this out as an RFC and don't merge it until an
> actual concrete user shows up.


Yup, that was my intention and I mentioned that in the commit message.

Logan
