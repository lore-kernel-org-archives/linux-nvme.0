From: kbusch@kernel.org (Keith Busch)
Date: Thu, 9 May 2019 07:49:17 -0600
Subject: [PATCH v2 00/10] RFC: NVME MDEV
In-Reply-To: <20190509091255.GB15331@stefanha-x1.localdomain>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190503121838.GA21041@lst.de>
 <e8f6981863bdbba89adcba1c430083e68546ac1a.camel@redhat.com>
 <20190509091255.GB15331@stefanha-x1.localdomain>
Message-ID: <20190509134917.GC8365@localhost.localdomain>

On Thu, May 09, 2019@02:12:55AM -0700, Stefan Hajnoczi wrote:
> On Mon, May 06, 2019@12:04:06PM +0300, Maxim Levitsky wrote:
> > On top of that, it is expected that newer hardware will support the PASID based
> > device subdivision, which will allow us to _directly_ pass through the
> > submission queues of the device and _force_ us to use the NVME protocol for the
> > frontend.
> 
> I don't understand the PASID argument.  The data path will be 100%
> passthrough and this driver won't be necessary.

We still need a non-passthrough component to handle slow path,
non-doorbell controller registers and admin queue. That doesn't
necessarily need to be a kernel driver, though.
