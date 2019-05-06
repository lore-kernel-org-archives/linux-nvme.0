From: kbusch@kernel.org (Keith Busch)
Date: Mon, 6 May 2019 10:43:25 -0600
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <20190506125752.GA5288@lst.de>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
 <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
 <20190506125752.GA5288@lst.de>
Message-ID: <20190506164325.GB2219@localhost.localdomain>

On Mon, May 06, 2019@05:57:52AM -0700, Christoph Hellwig wrote:
> > However, similar to the (1), when the driver will support the devices with
> > hardware based passthrough, it will have to dedicate a bunch of queues to the
> > guest, configure them with the appropriate PASID, and then let the guest useA
> > these queues directly.
> 
> We will not let you abuse the nvme queues for anything else.  We had
> that discussion with the mellanox offload and it not only unsafe but
> also adds way to much crap to the core nvme code for corner cases.
> 
> Or to put it into another way:  unless your paravirt interface requires
> zero specific changes to the core nvme code it is not acceptable at all.

I agree we shouldn't specialize generic queues for this, but I think
it is worth revisiting driver support for assignable hardware resources
iff the specification defines it.

Until then, you can always steer processes to different queues by
assigning them to different CPUs.
