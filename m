From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 14:37:50 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607121135.GD11938@lst.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de>
 <20180607121135.GD11938@lst.de>
Message-ID: <20180607143750.16ddff8f@pentland.suse.de>

On Thu, 7 Jun 2018 14:11:35 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > +	ana_state = READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
> >  	switch (nvme_req(req)->status & 0x7ff) {
> >  	case NVME_SC_ANA_TRANSITION:
> > -		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> > -		if (!timer_pending(&ns->anatt_timer)) {
> > -			ns->anatt_timer.expires =
> > -				ns->ctrl->anatt * HZ + jiffies;
> > -			add_timer(&ns->anatt_timer);
> > +		if (ana_state != NVME_ANA_CHANGE) {
> > +			nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> > +			ana_state_changed = true;  
> 
> Needs an xchg operation to be atomic.
> 
Okay.

> >  	case NVME_SC_ANA_PERSISTENT_LOSS:
> > -		nvme_update_ana_state(ns,
> > NVME_ANA_PERSISTENT_LOSS);
> > +		if (ana_state != NVME_ANA_PERSISTENT_LOSS) {
> > +			nvme_update_ana_state(ns,
> > NVME_ANA_PERSISTENT_LOSS);
> > +			ana_state_changed = true;
> > +		}
> >  		break;
> >  	case NVME_SC_ANA_INACCESSIBLE:
> > -		nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
> > +		if (ana_state != NVME_ANA_INACCESSIBLE) {
> > +			nvme_update_ana_state(ns,
> > NVME_ANA_INACCESSIBLE);
> > +			ana_state_changed = true;
> > +		}
> >  		break;  
> 
> We don't need to start the ANA timer for these states, it should
> only happen for the CHANGE state.
> 

Hmm. When we're getting these error it means that there is a divergence
between the ANA state on the host and the target.

Which really shouldn't happen, as we _should_ have received an ANA AEN
signalling us this state. As there is a race condition here (ANA AENs
are being send via the admin connection, and it might be that we
haven't gotten around to processing the ANA state yet) we should be
starting the ANATT timer to catch any outstanding AENs.

And if we're not getting an ANA AEN within ANATT the controller should
be considered hosed, and we need to reset it.
Hence the code.

If you disagree, what _should_ be the appropriate handling in this
case, ie we have the most current ANA log page, _and_ get this error
indicating a state mismatch?

Cheers,

Hannes
