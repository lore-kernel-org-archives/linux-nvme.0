From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:48:14 +0100
Subject: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
In-Reply-To: <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
 <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
 <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
Message-ID: <20171229094814.GC24043@lst.de>

On Wed, Dec 27, 2017@11:01:48PM +0200, Sagi Grimberg wrote:
>
>> Awesome!
>>
>> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>
> Wait, aren't we unquiesce queues also in nvme_dev_disable?
>
> Doesn't that rely that the queues are suspended and queue_rq
> will fail there?

We don't seem to have any other check as far as I can tell.
