From: aeasi@marvell.com (Arun Easi)
Date: Fri, 17 May 2019 17:21:38 -0700
Subject: [PATCH 3/3] nvme-fc: fail reconnect if state change fails
In-Reply-To: <alpine.LRH.2.21.9999.1905171715520.19585@mvluser05.qlc.com>
References: <20190516083740.95894-1-hare@suse.de>
 <20190516083740.95894-4-hare@suse.de>
 <alpine.LRH.2.21.9999.1905171715520.19585@mvluser05.qlc.com>
Message-ID: <alpine.LRH.2.21.9999.1905171721040.9636@mvluser05.qlc.com>

Please ignore the comment. I see that v2 already has addressed this.

Regards,
-Arun

On Fri, 17 May 2019, 5:18pm, Arun Easi wrote:

> On Thu, 16 May 2019, 1:37am, Hannes Reinecke wrote:
> 
> > If the final state change to LIVE in nvme_fc_create_association()
> > fails the controller is not operational as no I/O is possible.
> > So we should be returning an error here to reschedule reconnect.
> > 
> > Signed-off-by: Hannes Reinecke <hare at suse.com>
> > ---
> >  drivers/nvme/host/fc.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index e5c81ba2b7a1..9f9300cbdb62 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -2620,7 +2620,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> >  {
> >  	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> >  	int ret;
> > -	bool changed;
> >  
> >  	++ctrl->ctrl.nr_reconnects;
> >  
> > @@ -2725,12 +2724,19 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> >  			goto out_term_aen_ops;
> >  	}
> >  
> > -	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> > +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE)) {
> 
> Should not this be !nvme_change_ctrl_state()?
> 
> Regards,
> -Arun
> > +		if (ctrl->ctrl.state != NVME_CTRL_DELETING) {
> > +			dev_err(ctrl->ctrl.device,
> > +				"NVME-FC{%d}: error_recovery: Couldn't change "
> > +				"state from %s to LIVE\n", ctrl->cnum,
> > +				nvme_ctrl_state_name(&ctrl->ctrl));
> > +			return -EAGAIN;
> > +		}
> > +	}
> >  
> >  	ctrl->ctrl.nr_reconnects = 0;
> >  
> > -	if (changed)
> > -		nvme_start_ctrl(&ctrl->ctrl);
> > +	nvme_start_ctrl(&ctrl->ctrl);
> >  
> >  	return 0;	/* Success */
> >  
> > 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
