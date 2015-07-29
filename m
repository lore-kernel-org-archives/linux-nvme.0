From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Jul 2015 14:28:52 +0000 (UTC)
Subject: SGL support of driver
In-Reply-To: <20150729075557.GA11755@infradead.org>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
 <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
 <20150727165756.GA8847@infradead.org>
 <20150728143500.GX13681@linux.intel.com>
 <20150729075557.GA11755@infradead.org>
Message-ID: <alpine.LNX.2.00.1507291356440.15930@localhost.lm.intel.com>

On Wed, 29 Jul 2015, Christoph Hellwig wrote:
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

I think we can easily optimize for this. It would work w/ PRP if the
device's page size is set to <= 8k, which I believe all nvme controllers
support. We just need to make a small change to bvec_gap_to_prev()
to use the device's page size instead of PAGE_SIZE.

> This is clearly something PRP list will not handle well.  Note that I'm
> not nessecarily saying this is soemthing to optimize for, the more
> interesting case for NVMe really is the vectored direct I/O case.

Vectored direct never split when the block size >= page size.

512b sectors is still common in NVMe though, so yeah, those may need
separate req's.
