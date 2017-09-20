From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Sep 2017 15:07:52 -0400
Subject: [PATCH] nvme: set physical block size to value discovered in
 Identify Namespace
In-Reply-To: <20170920174814.GA2556@infradead.org>
References: <20170920170605.42161-1-andrzej.jakowski@intel.com>
 <20170920174842.GB1379@localhost.localdomain>
 <20170920174814.GA2556@infradead.org>
Message-ID: <20170920190752.GC1379@localhost.localdomain>

On Wed, Sep 20, 2017@10:48:14AM -0700, Christoph Hellwig wrote:
> On Wed, Sep 20, 2017@01:48:42PM -0400, Keith Busch wrote:
> > I think what you're wanting to say is:
> > 
> >   The physical block size will default to the logical block size unless
> >   otherwise specified. While NVMe doesn't provide a way to discover the
> >   physical block size, the format with best relative performance is a
> >   good indicator as to the underlying block size.
> 
> I don't like this at all.  It's a really nasty guesswork.  If you need
> this to get reasonable performance out of a specific device please
> quirk it.

I don't think it's about "reasonable" performance; it's about getting
extra relative performance. What else can the best performing LBAF
indicate other than the device's preferred access alignment/granularity?
The spec provides this hint, so it's not really a guess, but maybe
there's a better way to make use of it instead of  considering it to be
the physical block size? io_opt?

On a slightly related topic, I think we should fix the  consistency
in what's reported in the queue's attributes after reformatting the
namespace. Check out the following for what happens today:

Start with a 512b format:

# cat /sys/block/nvme0n1/queue/{minimum_io_size,logical_block_size,physical_block_size}
512
512
512

Format it to 4k:

# cat /sys/block/nvme0n1/queue/{minimum_io_size,logical_block_size,physical_block_size}
4096
4096
4096

Format it back to 512b:

# cat /sys/block/nvme0n1/queue/{minimum_io_size,logical_block_size,physical_block_size}
4096
512
4096

The first and last are the exact same NVMe format, but they're reported
differently.
