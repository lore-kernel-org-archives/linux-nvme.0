From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 15:31:55 +0200
Subject: [PATCH 2/4] nvmet: ANA transition timeout handling
In-Reply-To: <20180607120745.GB11938@lst.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-3-hare@suse.de>
 <20180607120745.GB11938@lst.de>
Message-ID: <20180607153155.76452888@pentland.suse.de>

On Thu, 7 Jun 2018 14:07:46 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jun 07, 2018@09:35:54AM +0200, Hannes Reinecke wrote:
> > Whenever an ANA state change is triggered the ANA state for that
> > group ID is set to 'state change' and a delayed work is started,
> > which will be setting the port to the actual state after anatt
> > has expired.  
> 
> What is the point?  We want to move to the actual state as soon as we
> can, where as soon is defined by a backend.  So we need manual control
> over exact states, including change state.
> 
> Even for testing it makes much more sense to have entirely manual
> control, so that your userspace test framework can trivial inject too
> long transition faults.
> 
But we would _require_ userspace interaction to facilitate correct
operation. And with a purely manual configuration on the target any
ANATT value becomes meaningless as we have no way of enforcing it.

And with that patch I don't need any userspace framework; just updating
the state is enough. And I even can set ANATT to 1 to have the state
update done directly.

Hannes
