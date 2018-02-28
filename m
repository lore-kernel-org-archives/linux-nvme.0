From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 27 Feb 2018 22:42:27 -0500
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
In-Reply-To: <20180224000547.7252-1-keith.busch@intel.com> (Keith Busch's
 message of "Fri, 23 Feb 2018 17:05:47 -0700")
References: <20180224000547.7252-1-keith.busch@intel.com>
Message-ID: <yq17eqx4w64.fsf@oracle.com>


Keith,

> This patch will enable such formats by allocating a bounce buffer
> interleaving the block and metadata, copying the everythign into the
> buffer for writes, or from it for reads.

Blargh. My eyes are bleeding!

> I dislike this feature intensely. It is incredibly slow and enough
> memory overhead to make this not very useful for reclaim, but it's
> possible people will leave me alone if the Linux nvme driver
> accomodated this format.

*sigh*

> On the other hand, I get the impression some people requesting this
> may think their application will get to access the extended LBAs. The
> reality is the kernel owns the metadata, so I may just setting myself
> up to explain why "fdisk" still shows a 512b format instead of 520b...

The whole point of DIF (over using regular 520 or 528 byte sectors) was
to keep the logical block size at 512 and not deal with the PI in the
data buffers.

And the point of defining DIX was to avoid having to do what your patch
is doing.

-- 
Martin K. Petersen	Oracle Linux Engineering
