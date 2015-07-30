From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 30 Jul 2015 14:38:28 -0400
Subject: SGL support of driver
In-Reply-To: <20150729075557.GA11755@infradead.org>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
 <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
 <20150727165756.GA8847@infradead.org>
 <20150728143500.GX13681@linux.intel.com>
 <20150729075557.GA11755@infradead.org>
Message-ID: <20150730183828.GY13681@linux.intel.com>

On Wed, Jul 29, 2015@12:55:57AM -0700, Christoph Hellwig wrote:
> 64k page size, 4k file system block size, raid 0 with a stripe size of
> 8k and two legs.
> 
> The typical SGL feds to the hardware driver for streaming I/O will be:
> 
> page A, offset 0, len 8k
> page A, offset 16k, len 8k
> page A, offset 32k, len 8k
> page A, offset 48k, len 8k
> page B, offset 0, len 8k
> 
> This is clearly something PRP list will not handle well.  Note that I'm
> not nessecarily saying this is soemthing to optimize for, the more
> interesting case for NVMe really is the vectored direct I/O case.

I'm not really interested in optimising for badly configured RAID setups :-)

But point taken, RAID (and other things) can mess with I/Os between the
page cache and the driver.
