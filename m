From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Feb 2018 09:35:11 -0700
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
In-Reply-To: <yq17eqx4w64.fsf@oracle.com>
References: <20180224000547.7252-1-keith.busch@intel.com>
 <yq17eqx4w64.fsf@oracle.com>
Message-ID: <20180228163510.GC16002@localhost.localdomain>

On Tue, Feb 27, 2018@10:42:27PM -0500, Martin K. Petersen wrote:
> > On the other hand, I get the impression some people requesting this
> > may think their application will get to access the extended LBAs. The
> > reality is the kernel owns the metadata, so I may just setting myself
> > up to explain why "fdisk" still shows a 512b format instead of 520b...
> 
> The whole point of DIF (over using regular 520 or 528 byte sectors) was
> to keep the logical block size at 512 and not deal with the PI in the
> data buffers.
> 
> And the point of defining DIX was to avoid having to do what your patch
> is doing.

Right, this RFC is just about enabling formats that don't subscribe to
the DIX format. It turns out some people believe those extended LBAs
are useful for something.

I still think this LBA format is not a good fit for this driver, but
I'd like to not push people to use out-of-tree or user space drivers
if there is a reasonable way to accommodate here. The driver's existing
NVMe IO passthrough makes this format reachable already, but there is
resistance to use the ioctl over more standard read/write paths.
