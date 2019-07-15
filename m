From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 15 Jul 2019 20:01:05 +1000
Subject: [PATCH] nvme: Add support for Apple 2018+ models
In-Reply-To: <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
 <20190715081041.GB31791@lst.de>
 <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
 <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
 <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
Message-ID: <c82b6aa094f1681272ec1e2a55e47758c435f784.camel@kernel.crashing.org>

On Mon, 2019-07-15@12:28 +0300, Maxim Levitsky wrote:
> 
> To be honest, the spec explicitly states that minimum submission queue entry size is 64 
> and minimum completion entry size should be is 16 bytes for NVM command set:
> 
> "Bits 3:0 define the required (i.e., minimum) Submission Queue Entry size when
> using the NVM Command Set. This is the minimum entry size that may be used.
> The value is in bytes and is reported as a power of two (2^n). The required value
> shall be 6, corresponding to 64."

Yes, I saw that :-) Apple seems to ignore this and CC:IOSQES and
effectively hard wire a size of 7 (128 bytes) for the IO queue.

> "Bits 3:0 define the required (i.e., minimum) Completion Queue entry size when using
> the NVM Command Set. This is the minimum entry size that may be used. The value
> is in bytes and is reported as a power of two (2^n). The required value shall be 4,
> corresponding to 16."
> 
> Pages 136/137, NVME 1.3d.
> 
> In theory the spec allows for non NVM IO command set, and for which the sq/cq entry sizes can be of any size,
> as indicated in SQES/CQES and set in CC.IOCQES/CC.IOSQES, but than most of the spec won't apply to it.
> 
> 
> Also FYI, values in CC (IOCQES/IOSQES) are for I/O queues, which kind of implies that admin queue,
> should always use the 64/16 bytes entries, although I haven't found any explicit mention of that.

Right, and it does on the Apple HW as well.

Cheers,
Ben.
