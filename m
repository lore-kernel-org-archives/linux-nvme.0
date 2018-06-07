From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 16:01:52 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607134612.GA15587@lst.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de>
 <20180607121135.GD11938@lst.de>
 <20180607143750.16ddff8f@pentland.suse.de>
 <20180607131026.GA13273@lst.de>
 <20180607152036.275b0966@pentland.suse.de>
 <20180607134612.GA15587@lst.de>
Message-ID: <20180607160152.15809a29@pentland.suse.de>

On Thu, 7 Jun 2018 15:46:12 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jun 07, 2018@03:20:36PM +0200, Hannes Reinecke wrote:
[ .. ]
> 
> > Especially due to this paragraph:  
> > > If no controllers are reporting ANA Optimized state or ANA
> > > Non-Optimized state, then a transition may be occurring such that
> > > a controller reporting the Inaccessible state may become
> > > accessible and the host should retry the command on the
> > > controller reporting Inaccessible state for at least ANATT
> > > seconds (refer to Figure 109).  
> > 
> > which seems to imply to me that we can have an implicit transition
> > on the target while reporting the inaccessible state error, and the
> > use of ANATT here is indeed applicable.  
> 
> But we'll still get the AEN.  The whole point is the above is that
> if we had a queue_if_no_path=0 mode we should not give up before
> ANATT.
> 
There is no guarantee that we will get the AEN.
Yes, the spec says we should, but it's just a single message which
might easily be lost if the corresponding frame is dropped.
Think of FC, which supposedly is a lossless fabric, yet a sizeable
piece of the spec deals with recovery from lost frames.
It _will_ happen.

To rephrase my problem statement:

What is the appropriate action if our copy of the ANA log page
indicates an optimized or non-optimized ANA state, but we're getting an
I/O error back indicating an inaccessible or persistent-loss ANA state?
If this is a simple active/passive scenario we will have set all paths
to inactive, leaving us with no paths to sent I/O to.

We _could_ try to implement the last-resort handling of sending I/Os to
the inaccessible paths (as per ANA base spec), but as we're not having
a round-robin selector we're ending up always hitting the first
inaccessible path. If that's the 'true' inaccessible one we will never
be able to send I/O even though the target is fully operable.

With this patch we detect this situation, and reset the controller
forcing us to re-read the ANA log page. After which we can do normal
I/O again.

If you have a better solution I'm all ears.

Cheers,

Hannes
