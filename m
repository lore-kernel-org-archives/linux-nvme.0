From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 15:34:41 +0200
Subject: [PATCH 02/10] nvme: ANA transition timeout handling
In-Reply-To: <20180529124729.GC7376@lst.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-3-hare@suse.de>
 <20180529124729.GC7376@lst.de>
Message-ID: <20180529153441.6eeff725@pentland.suse.de>

On Tue, 29 May 2018 14:47:29 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > +	if (ns->anagrpid != le32_to_cpu(id->anagrpid)) {
> > +		dev_warn(ctrl->device, "nsid %d ANA group id
> > changed\n",
> > +			 ns->head->ns_id);
> > +		queue_delayed_work(nvme_wq, &ctrl->ana_work, 0);
> > +	}  
> 
> No need to queue any work if an anagrpid changed.  We'll automatically
> index into the right group once it has changed.
> 
> > diff --git a/drivers/nvme/host/multipath.c
> > b/drivers/nvme/host/multipath.c index 1a8791340862..2fcaf50d84e2
> > 100644 --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -69,6 +69,8 @@ void nvme_failover_req(struct request *req)
> >  		 * entirely trivial..
> >  		 */
> >  		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> > +		queue_delayed_work(nvme_wq, &ns->ctrl->ana_work,
> > +				   ns->ctrl->anatt * HZ);  
> 
> This doesn't make much sense.  Once we get the ana transitioning
> status we should either retry the command up to ANATT or try another
> path.  There is no point in scheduling a read of the log page after
> ANATT, as we'll already get an AEN when that log page is ready.
> 
In an ideal world, yes.
But what happens if we don't?

> > @@ -323,7 +325,7 @@ static int nvme_process_ana_log(struct
> > nvme_ctrl *ctrl, bool groups_only) ctrl->ana_log_buf,
> > ctrl->ana_log_size, 0); if (error) {
> >  		dev_warn(ctrl->device, "Failed to get ANA log:
> > %d\n", error);
> > -		return error;
> > +		return -EIO;
> >  	}
> >  
> >  	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps);
> > i++) { @@ -345,6 +347,8 @@ static int nvme_process_ana_log(struct
> > nvme_ctrl *ctrl, bool groups_only) dev_info(ctrl->device, "ANA
> > group %d: %s.\n", grpid, nvme_ana_state_names[desc->state]);
> >  		WRITE_ONCE(ctrl->ana_state[grpid], desc->state);
> > +		if (desc->state == NVME_ANA_CHANGE)
> > +			error = -EAGAIN;  
> 
> Huh?  Why would be stop processing our log when we see a change state?
> This looks extremely dubious to me, and does not match the changelog
> either.
> 
We don't stop processing. We just record the error so that we can
retrigger the ANA log page scan.

> > +	if (!ctrl->ana_log_buf)
> > +		return;  
> 
> How would the log buf disappear?  Even if it does please does this
> in a separate, documented patch.
> 
> > +	if (ctrl->state != NVME_CTRL_LIVE)
> > +		return;  
> 
> This looks sensible, but it should probably also check for ADMIN_LIVE
> for completeness, and be a seprate, properly documented patch.
> 
Ok, will be doing so.

> > +		/*
> > +		 * In case of an I/O error just add a small delay
> > to not hit
> > +		 * the target too hard
> > +		 */
> > +		if (ret == -EIO)
> > +			log_delay =
> > msecs_to_jiffies(NVME_ANA_LOG_DELAY);
> > +		queue_delayed_work(nvme_wq, &ctrl->ana_work,
> > log_delay);  
> 
> What is the rationale for this I/O error handling?  In NVMe over
> Fabrics transport errors tear down the association, so I really
> don't see why we should handle errors here.
> 
The idea of the patch is to start off a delayed workqueue function to
ensure we're catching ANA transition timeout errors.

The workqueue function will be cancelled if we get an AEN, but gives it
another go at reading the ANA log if the transition timeout expires.

I do agree on the EIO error, though. That can be removed.

Cheers,

Hannes
