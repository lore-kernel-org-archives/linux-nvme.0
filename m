From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 15:47:57 +0200
Subject: [PATCH 02/10] nvme: ANA transition timeout handling
In-Reply-To: <20180529153441.6eeff725@pentland.suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-3-hare@suse.de> <20180529124729.GC7376@lst.de>
 <20180529153441.6eeff725@pentland.suse.de>
Message-ID: <20180529134757.GA9038@lst.de>

On Tue, May 29, 2018@03:34:41PM +0200, Hannes Reinecke wrote:
> In an ideal world, yes.
> But what happens if we don't?

Then the whole ANA scheme doesn't work.

> We don't stop processing. We just record the error so that we can
> retrigger the ANA log page scan.

But showing a change state is in no way an error.

> The idea of the patch is to start off a delayed workqueue function to
> ensure we're catching ANA transition timeout errors.
> 
> The workqueue function will be cancelled if we get an AEN, but gives it
> another go at reading the ANA log if the transition timeout expires.

But a delayed work on it's own isn't going to work.  For each group
we need to record when it did transition to the change state, and then
check for ANATT expiry vs that particular value.  And we really don't
need to queue reading a log page for that.  We need to do this algorithm:

 1) when transitioning any group to change state set a timer to fire
   at now + ANATT
 2) when transitioning away from change state cancel the timer
 3) when the timer fires reset the controller as it is toast

Given that nvme_reset_ctrl is irq save it might be easiest to actually
use real Linux timers for that.  It sounds like a waste to have an
array of those for each group, but opencoding time expiration like
in the blk-mq eh code just seems like an invitation for subtle bugs.
