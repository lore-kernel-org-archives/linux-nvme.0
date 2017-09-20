From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 13:10:13 -0700
Subject: [PATCH] nvme: set physical block size to value discovered in
 Identify Namespace
In-Reply-To: <20170920190752.GC1379@localhost.localdomain>
References: <20170920170605.42161-1-andrzej.jakowski@intel.com>
 <20170920174842.GB1379@localhost.localdomain>
 <20170920174814.GA2556@infradead.org>
 <20170920190752.GC1379@localhost.localdomain>
Message-ID: <20170920201013.GA2037@infradead.org>

On Wed, Sep 20, 2017@03:07:52PM -0400, Keith Busch wrote:
> I don't think it's about "reasonable" performance; it's about getting
> extra relative performance. What else can the best performing LBAF
> indicate other than the device's preferred access alignment/granularity?
> The spec provides this hint, so it's not really a guess, but maybe
> there's a better way to make use of it instead of  considering it to be
> the physical block size? io_opt?

>From Documentation/ABI/testing/sysfs-block:

What:           /sys/block/<disk>/queue/physical_block_size
Date:           May 2009
Contact:        Martin K. Petersen <martin.petersen at oracle.com>
Description:
                This is the smallest unit a physical storage device can
                write atomically.  It is usually the same as the logical
                block size but may be bigger.  One example is SATA
                drives with 4KB sectors that expose a 512-byte logical
                block size to the operating system.  For stacked block
                devices the physical_block_size variable contains the
                maximum physical_block_size of the component devices.

The best performing format certainly isn't related to that at all.
If we'd really want to set a physical_block_size we'd have to based
it on top of AWUN/AWUPF (although I still struggle how you define
a global value based on LBAs if the device supports different LBA
formats) or NAWUN/NABSN/NABSPF if supported.

The closest to what you seem to want above would be io_min:

What:           /sys/block/<disk>/queue/minimum_io_size
Date:           April 2009
Contact:        Martin K. Petersen <martin.petersen at oracle.com>
Description:
                Storage devices may report a granularity or preferred
                minimum I/O size which is the smallest request the
                device can perform without incurring a performance
                penalty.  For disk drives this is often the physical
                block size.  For RAID arrays it is often the stripe
                chunk size.  A properly aligned multiple of
                minimum_io_size is the preferred request size for
                workloads where a high number of I/O operations is
                desired.

> On a slightly related topic, I think we should fix the  consistency
> in what's reported in the queue's attributes after reformatting the
> namespace. Check out the following for what happens today:

I think we just need to opt into always getting the Namespace Attribute
Notices AER and this should be taken care of automatically?  I was
going to send a patch for that for other reasons eventually.
