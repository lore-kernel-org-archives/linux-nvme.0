From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:10:26 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607143750.16ddff8f@pentland.suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de> <20180607121135.GD11938@lst.de>
 <20180607143750.16ddff8f@pentland.suse.de>
Message-ID: <20180607131026.GA13273@lst.de>

On Thu, Jun 07, 2018@02:37:50PM +0200, Hannes Reinecke wrote:
> > We don't need to start the ANA timer for these states, it should
> > only happen for the CHANGE state.
> > 
> 
> Hmm. When we're getting these error it means that there is a divergence
> between the ANA state on the host and the target.
> 
> Which really shouldn't happen, as we _should_ have received an ANA AEN
> signalling us this state. As there is a race condition here (ANA AENs
> are being send via the admin connection, and it might be that we
> haven't gotten around to processing the ANA state yet) we should be
> starting the ANATT timer to catch any outstanding AENs.

We should receive an AEN, yes.  But there is absolutely no ordering
guarantees either in the ANA spec, or in NVMe in general for multiple
queues (admin vs I/O).  But that was intentional in the specification,
and has nothing to do with ANATT at all.

> And if we're not getting an ANA AEN within ANATT the controller should
> be considered hosed, and we need to reset it.

I can't find anything in the spec saying that.

> If you disagree, what _should_ be the appropriate handling in this
> case, ie we have the most current ANA log page, _and_ get this error
> indicating a state mismatch?

Update our in-memory state ASAP, and then just way for the AEN to
happen eventually.  As the current code does.
