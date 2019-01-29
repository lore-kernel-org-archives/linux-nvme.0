From: jack@suse.cz (Jan Kara)
Date: Tue, 29 Jan 2019 11:07:02 +0100
Subject: [PATCH v2 0/4] Write-hint for FS journal
In-Reply-To: <20190128232423.GD15302@localhost.localdomain>
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
 <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <20190125162353.GA11210@localhost.localdomain>
 <20190128124709.GB27972@quack2.suse.cz>
 <20190128232423.GD15302@localhost.localdomain>
Message-ID: <20190129100702.GA29981@quack2.suse.cz>

On Mon 28-01-19 16:24:24, Keith Busch wrote:
> On Mon, Jan 28, 2019@04:47:09AM -0800, Jan Kara wrote:
> > On Fri 25-01-19 09:23:53, Keith Busch wrote:
> > > On Wed, Jan 09, 2019@09:00:57PM +0530, Kanchan Joshi wrote:
> > > > Towards supporing write-hints/streams for filesystem journal.                   
> > > >                                                                                 
> > > > Here is the v1 patch for background -                                           
> > > > https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2                        
> > > >                                                                                 
> > > > Changes since v1:                                                               
> > > > - introduce four more hints for in-kernel use, as recommended by Dave chinner   
> > > >   & Jens axboe. This isolates kernel-mode hints from user-mode ones.            
> > > 
> > > The nvme driver disables streams if the controller doesn't support
> > > BLK_MAX_WRITE_HINT number of streams, so this series breaks the feature
> > > for controllers that only support up to 4.
> > 
> > Right. Do you know if there are such controllers? Or are you just afraid
> > that there could be?
> 
> I've asked around, and the concensus I received is all currently support
> at least 8, but they couldn't say if that would be true for potential
> lower budget products. Can we implement a reasonable fallback to use
> what's available?

OK, thanks for input. So probably we should just map kernel stream IDs to 0
if the device doesn't support them. But that probably means we need to
propagate number of available streams up from NVME into the block layer so
that this can be handled reasonably seamlessly. Jens, Kanchan?

								Honza

-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
