From: mlin@kernel.org (Ming Lin)
Date: Fri, 9 Oct 2015 10:38:40 -0700
Subject: [PATCH] Move nvme driver source into subdirectory and move pci
 specifics from core into separate file
In-Reply-To: <20150926161121.GB30551@infradead.org>
References: <1443130050.6973.125.camel@linux.intel.com>
 <20150925000251.GA25904@infradead.org>
 <CAF1ivSYwe41J+kEuna_VYQvHSLanZzx-qqOOQ3X9EzLWYK_bFQ@mail.gmail.com>
 <20150926161121.GB30551@infradead.org>
Message-ID: <CAF1ivSa4zCLHenbwT3GNk2gkWWPQwM_G5M_FtrEY9rVq8n7iVg@mail.gmail.com>

On Sat, Sep 26, 2015@9:11 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Sep 25, 2015@10:32:36PM -0700, Ming Lin wrote:
>> >  a) move files to a new directory.  My suggestion for that would be
>> >     driver/nvme/host/ as I have a software NVMe controller
>> >     implementation under development which I'd like to also add under
>> >     a different subdirectory of drivers/nvme.
>>
>> What's the "software NVMe controller"? Is it the initiator for NVMe
>> over fabrics?
>
> It's a software implementation of the NVMe subsystem and controller
> interface.  It could be frontended by a future fabrics implementation,
> a virtio-nvme implementation, a nvme-loop implementation or with some
> additional work maybe even a Linux-based PCIe target device.

Hi Christoph,

I have been writing vhost-nvme driver for a while.
http://www.minggr.net/cgit/cgit.cgi/linux/commit/?h=vhost-nvme/v1

Seems I have to do similar submission/completion queue simulation
in vhost-nvme as in qemu/nvme.c.

Will the "software NVMe controller" do these simulation?
If yes, could you share a draft version then I can try build vhost-nvme
on top of it?

Thanks.
