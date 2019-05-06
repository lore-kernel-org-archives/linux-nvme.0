From: hch@lst.de (Christoph Hellwig)
Date: Mon, 6 May 2019 14:57:52 +0200
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
 <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
Message-ID: <20190506125752.GA5288@lst.de>

On Mon, May 06, 2019@12:04:06PM +0300, Maxim Levitsky wrote:
> 1. Frontend interface (the interface that faces the guest/userspace/etc):
> 
> VFIO/mdev is just way to expose a (partially) software defined PCIe device to a
> guest.
> 
> Vhost on the other hand is an interface that is hardcoded and optimized for
> virtio. It can be extended to be pci generic, but why to do so if we already
> have VFIO.

I wouldn't say vhost is virtio specific.  At least Hanne's vhost-nvme
doesn't get impacted by that a whole lot.

> 2. Backend interface (the connection to the real nvme device):
> 
> Currently the backend interface _doesn't have_ to allocate a dedicated queue and
> bypass the block layer. It can use the block submit_bio/blk_poll as I
> demonstrate in the last patch in the series. Its 2x slower though.
> 
> However, similar to the (1), when the driver will support the devices with
> hardware based passthrough, it will have to dedicate a bunch of queues to the
> guest, configure them with the appropriate PASID, and then let the guest useA
> these queues directly.

We will not let you abuse the nvme queues for anything else.  We had
that discussion with the mellanox offload and it not only unsafe but
also adds way to much crap to the core nvme code for corner cases.

Or to put it into another way:  unless your paravirt interface requires
zero specific changes to the core nvme code it is not acceptable at all.
