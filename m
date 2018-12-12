From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Dec 2018 09:50:17 -0700
Subject: [PATCH v2] nvme: provide fallback for discard alloc failure
In-Reply-To: <f53d0bc1-6fe0-12e5-c210-e583d71bc739@kernel.dk>
References: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
 <20181212162855.GA10895@localhost.localdomain>
 <f53d0bc1-6fe0-12e5-c210-e583d71bc739@kernel.dk>
Message-ID: <20181212165017.GB10895@localhost.localdomain>

On Wed, Dec 12, 2018@09:36:36AM -0700, Jens Axboe wrote:
> On 12/12/18 9:28 AM, Keith Busch wrote:
> > On Wed, Dec 12, 2018@09:18:11AM -0700, Jens Axboe wrote:
> >> When boxes are run near (or to) OOM, we have a problem with the discard
> >> page allocation in nvme. If we fail allocating the special page, we
> >> return busy, and it'll get retried. But since ordering is honored for
> >> dispatch requests, we can keep retrying this same IO and failing. Behind
> >> that IO could be requests that want to free memory, but they never get
> >> the chance.
> >>
> >> Allocate a fixed discard page per controller for a safe fallback, and use
> >> that if the initial allocation fails.
> > 
> > Do we need to allocate this per controller? One page for the whole driver
> > may be sufficient to make forward progress, right?
> 
> It should be, but that might create a shit storm if we're OOM and have
> tons of drives. I think one per controller is saner, and it's dwarfed
> by memory we consume anyway in static allocations.

Okay fair enough.

Reviewed-by: Keith Busch <keith.busch at intel.com>
