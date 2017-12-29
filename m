From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:30:22 +0100
Subject: [PATCH v2] nvme-pci: allocate device queues storage space at probe
In-Reply-To: <a0561911-8f7a-5600-9fa1-c9502d082f4b@grimberg.me>
References: <20171225120526.29303-1-sagi@grimberg.me>
 <20171227062048.GA27546@ming.t460p>
 <a0561911-8f7a-5600-9fa1-c9502d082f4b@grimberg.me>
Message-ID: <20171229093022.GA23313@lst.de>

On Wed, Dec 27, 2017@10:59:44AM +0200, Sagi Grimberg wrote:
>
>> Hi Sagi,
>>
>> This patch introduces a new kernel oops:
>
> Hi Ming, thanks for testing.
>
> It looks like pci resets are not serialized which is in general not
> healthy and forcing the driver to handle tough races. I think that not
> serializing it is buggy to begin with.
>
> I think [1] should solve the issue you are seeing (and I think correct
> on its own regardless).
>
> Keith, Christoph, any objections?

This looks sensible to me.
