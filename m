From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Mon, 15 Jul 2019 12:28:05 +0300
Subject: [PATCH] nvme: Add support for Apple 2018+ models
In-Reply-To: <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
 <20190715081041.GB31791@lst.de>
 <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
 <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
Message-ID: <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>

On Mon, 2019-07-15@19:03 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2019-07-15@18:43 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2019-07-15@10:10 +0200, Christoph Hellwig wrote:
> > > > +	/*
> > > > +	 * Apple 2018 and latter variant has a few issues
> > > > +	 */
> > > > +	NVME_QUIRK_APPLE_2018			= (1 << 10),
> > > 
> > > We try to have quirks for the actual issue, so this should be one quirk
> > > for the irq vectors issues, and another for the sq entry size.  Note that
> > > NVMe actually has the concept of an I/O queue entry size (IOSQES in the
> > > Cc register based on values reported in the SQES field in Identify
> > > Controller.  Do these controllers report anything interesting there?
> > 
> > Ah good to know, I'll dig.
> 
> Interesting... so SQES is 0x76, indicating that it supports the larger
> entry size but not that it mandates it.
> 
> However, we configure CC:IOSQES with 6 and the HW fails unless we have
> the 128 bytes entry size.
> 
> So the HW is bogus, but we can probably sort that by doing a better job
> at fixing up SQES in the identify on the Apple HW, and then actually
> using it for the SQ.
> 
> I checked and CC is 0x00460001 so it takes our write of "6" fine. I
> think they just ignore the value.
> 
> How do you want to proceed here ? Should I go all the way at attempting
> to honor sqes "mandatory" size field (and quirk *that*) or just I go
> the simpler way and stick to shift 6 unless Apple ?
> 
> If I go the complicated path, should I do the same with cq size
> (knowing that no known HW has a non-4 mandatory size there and we don't
> know of a HW bug... yet).
> 
> Cheers,
> Ben.
> 

To be honest, the spec explicitly states that minimum submission queue entry size is 64 
and minimum completion entry size should be is 16 bytes for NVM command set:

"Bits 3:0 define the required (i.e., minimum) Submission Queue Entry size when
using the NVM Command Set. This is the minimum entry size that may be used.
The value is in bytes and is reported as a power of two (2^n). The required value
shall be 6, corresponding to 64."

"Bits 3:0 define the required (i.e., minimum) Completion Queue entry size when using
the NVM Command Set. This is the minimum entry size that may be used. The value
is in bytes and is reported as a power of two (2^n). The required value shall be 4,
corresponding to 16."

Pages 136/137, NVME 1.3d.

In theory the spec allows for non NVM IO command set, and for which the sq/cq entry sizes can be of any size,
as indicated in SQES/CQES and set in CC.IOCQES/CC.IOSQES, but than most of the spec won't apply to it.


Also FYI, values in CC (IOCQES/IOSQES) are for I/O queues, which kind of implies that admin queue,
should always use the 64/16 bytes entries, although I haven't found any explicit mention of that.

Best regards,
	Maxim Levitsky
