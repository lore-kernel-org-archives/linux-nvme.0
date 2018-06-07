From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:46:12 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607152036.275b0966@pentland.suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de> <20180607121135.GD11938@lst.de>
 <20180607143750.16ddff8f@pentland.suse.de> <20180607131026.GA13273@lst.de>
 <20180607152036.275b0966@pentland.suse.de>
Message-ID: <20180607134612.GA15587@lst.de>

On Thu, Jun 07, 2018@03:20:36PM +0200, Hannes Reinecke wrote:
> Precisely.
> Looking closer, there are not even guarantees within which time any
> target should be sending the AEN.
> So we have to start somewhere when defining a sensible timeframe during
> which we should have received an ANA AEN. And the one timer we already
> have is ANATT, so it looked logical to use that.

ANATT has no relevance here.  And more importantly not sending the
AEN until some time later is not going to cause us any grave
consequence - we already notice the non-live states by the status,
so we don't send any I/O.

> Especially due to this paragraph:
> > If no controllers are reporting ANA Optimized state or ANA
> > Non-Optimized state, then a transition may be occurring such that a
> > controller reporting the Inaccessible state may become accessible and
> > the host should retry the command on the controller reporting
> > Inaccessible state for at least ANATT seconds (refer to Figure 109).
> 
> which seems to imply to me that we can have an implicit transition on
> the target while reporting the inaccessible state error, and the use of
> ANATT here is indeed applicable.

But we'll still get the AEN.  The whole point is the above is that
if we had a queue_if_no_path=0 mode we should not give up before
ANATT.

> This code is essentially error handling.

Chances are this code is going to add more errors than it handles,
as it doesn't follow the spec.
