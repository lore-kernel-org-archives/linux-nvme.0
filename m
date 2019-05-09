From: stefanha@gmail.com (Stefan Hajnoczi)
Date: Thu, 9 May 2019 10:12:55 +0100
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
 <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
Message-ID: <20190509091255.GB15331@stefanha-x1.localdomain>

On Mon, May 06, 2019@12:04:06PM +0300, Maxim Levitsky wrote:
> On top of that, it is expected that newer hardware will support the PASID based
> device subdivision, which will allow us to _directly_ pass through the
> submission queues of the device and _force_ us to use the NVME protocol for the
> frontend.

I don't understand the PASID argument.  The data path will be 100%
passthrough and this driver won't be necessary.

In the meantime there is already SPDK for users who want polling.  This
driver's main feature is that the host can still access the device at
the same time as VMs, but I'm not sure that's useful in
performance-critical use cases and for non-performance use cases this
driver isn't necessary.

Stefan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190509/b7f22a66/attachment.sig>
