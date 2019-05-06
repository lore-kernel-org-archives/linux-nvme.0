From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Mon, 06 May 2019 12:04:06 +0300
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <20190503121838.GA21041@lst.de>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
Message-ID: <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>

On Fri, 2019-05-03@14:18 +0200, Christoph Hellwig wrote:
> I simply don't get the point of this series.
> 
> MDEV is an interface for exposing parts of a device to a userspace
> program / VM.  But that this series appears to do is to expose a
> purely software defined nvme controller to userspace.  Which in
> principle is a good idea, but we have a much better framework for that,
> which is called vhost.

Let me explain the reasons for choosing the IO interfaces as I did:

1. Frontend interface (the interface that faces the guest/userspace/etc):

VFIO/mdev is just way to expose a (partially) software defined PCIe device to a
guest.

Vhost on the other hand is an interface that is hardcoded and optimized for
virtio. It can be extended to be pci generic, but why to do so if we already
have VFIO.

So the biggest advantage of using VFIO _currently_ is that I don't add any new
API/ABI to the kernel, and neither the userspace (qemu) needs to learn to use a
new API. 

It also worth noting that VFIO supports nesting out of box, so I don't need to
worry about it (vhost has to deal with that on the protocol level using its
IOTLB facility).

On top of that, it is expected that newer hardware will support the PASID based
device subdivision, which will allow us to _directly_ pass through the
submission queues of the device and _force_ us to use the NVME protocol for the
frontend.

2. Backend interface (the connection to the real nvme device):

Currently the backend interface _doesn't have_ to allocate a dedicated queue and
bypass the block layer. It can use the block submit_bio/blk_poll as I
demonstrate in the last patch in the series. Its 2x slower though.

However, similar to the (1), when the driver will support the devices with
hardware based passthrough, it will have to dedicate a bunch of queues to the
guest, configure them with the appropriate PASID, and then let the guest use
these queues directly.


Best regards,
	Maxim Levitsky
