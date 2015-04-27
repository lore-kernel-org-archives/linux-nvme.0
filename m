From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 27 Apr 2015 12:27:07 -0700
Subject: [PATCHv3] NVMe: Spliting large i/o in the ioctl path
In-Reply-To: <alpine.LNX.2.00.1504271915450.19844@localhost.lm.intel.com>
References: <3D.9F.25582.055AF255@epcpsbge3.samsung.com>
 <000001d080dc$fdcd8750$f96895f0$@samsung.com>
 <alpine.LNX.2.00.1504271915450.19844@localhost.lm.intel.com>
Message-ID: <20150427192707.GA32438@infradead.org>

On Mon, Apr 27, 2015@07:22:29PM +0000, Keith Busch wrote:
> On Mon, 27 Apr 2015, sathyavathi wrote:
> >Keith,
> >
> >Any update on this patch.
> 
> No new comments your implementation. This ioctl is not a critical or
> fast path though, so I'm not sure why we'd force the kernel driver to
> correct a malformed passthru.
> 
> Basically, I'm on the side that if your app misuses the ioctl, you get
> to keep both pieces. Your patch is available if a maintainer disagrees.

Btw, I'll send a patch soon will make the ioctl and SCSI code use the block
layer S/G mapping, which will give us this feature for free.  It might make
sense to hold out for it.  I'll prioritize finishing this one so I can
get it out ASAP.
