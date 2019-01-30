From: david@fromorbit.com (Dave Chinner)
Date: Wed, 30 Jan 2019 11:13:49 +1100
Subject: [PATCH v2 0/4] Write-hint for FS journal
In-Reply-To: <20190129100702.GA29981@quack2.suse.cz>
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
 <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <20190125162353.GA11210@localhost.localdomain>
 <20190128124709.GB27972@quack2.suse.cz>
 <20190128232423.GD15302@localhost.localdomain>
 <20190129100702.GA29981@quack2.suse.cz>
Message-ID: <20190130001349.GT6173@dastard>

On Tue, Jan 29, 2019@11:07:02AM +0100, Jan Kara wrote:
> On Mon 28-01-19 16:24:24, Keith Busch wrote:
> > On Mon, Jan 28, 2019@04:47:09AM -0800, Jan Kara wrote:
> > > On Fri 25-01-19 09:23:53, Keith Busch wrote:
> > > > On Wed, Jan 09, 2019@09:00:57PM +0530, Kanchan Joshi wrote:
> > > > > Towards supporing write-hints/streams for filesystem journal.                   
> > > > >                                                                                 
> > > > > Here is the v1 patch for background -                                           
> > > > > https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2                        
> > > > >                                                                                 
> > > > > Changes since v1:                                                               
> > > > > - introduce four more hints for in-kernel use, as recommended by Dave chinner   
> > > > >   & Jens axboe. This isolates kernel-mode hints from user-mode ones.            
> > > > 
> > > > The nvme driver disables streams if the controller doesn't support
> > > > BLK_MAX_WRITE_HINT number of streams, so this series breaks the feature
> > > > for controllers that only support up to 4.
> > > 
> > > Right. Do you know if there are such controllers? Or are you just afraid
> > > that there could be?
> > 
> > I've asked around, and the concensus I received is all currently support
> > at least 8, but they couldn't say if that would be true for potential
> > lower budget products. Can we implement a reasonable fallback to use
> > what's available?
> 
> OK, thanks for input. So probably we should just map kernel stream IDs to 0
> if the device doesn't support them. But that probably means we need to
> propagate number of available streams up from NVME into the block layer so
> that this can be handled reasonably seamlessly. Jens, Kanchan?

Yeah, that's basically what I said we needed to do when this was
last discussed. i.e. that the block layer needed to know how many
streams the hardware had and map the 4 "kernel internal" hints
appropriately to what he device supports.

e.g. if the device only supports 4 hints, then it needs to map the
kernel hints either to zero. If it supports less than 8 streams,
then they need otbe mapped into the hints above index 5. If there
are N streams, then they need to be mapped to the hints {N-3,N}

And, to top it all off, there needs to be guards so that if we want
to grow the userspace hints to more than 4 hints, they don't crash
into ranges the kernel is already reserving because of limited
device range support.

Nothing is ever simple....

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
