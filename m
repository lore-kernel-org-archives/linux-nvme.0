From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 14:02:02 +0200
Subject: [PATCH 09/10] nvmet: support configuring ANA groups
In-Reply-To: <20180607100901.5d7e92ab@pentland.suse.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-10-hch@lst.de>
 <20180607100901.5d7e92ab@pentland.suse.de>
Message-ID: <20180607120202.GB11716@lst.de>

On Thu, Jun 07, 2018@10:09:01AM +0200, Hannes Reinecke wrote:
> > +	configfs_add_default_group(&port->ana_groups_group,
> > &port->group); +
> > +	port->ana_group1.port = port;
> > +	port->ana_group1.grpid = 1;
> 
> NVMET_DEFAULT_ANA_GRPID ?

Yes.

> 
> And maybe rename 'ana_group1' to 'ana_default_group' ?

Ok.

> 
> > +	config_group_init_type_name(&port->ana_group1.group,
> > +			"1", &nvmet_ana_group_type);
> 
> snprintf(grpname, "%d", NVMET_DEFAULT_ANA_GRPID); ?

That'll require a buffer allocation.  But I guess the __stringify
should work here.

> > +void nvmet_send_ana_event(struct nvmet_subsys *subsys)
> > +{
> > +	struct nvmet_ctrl *ctrl;
> > +
> > +	mutex_lock(&subsys->lock);
> > +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +		if (nvmet_aen_disabled(ctrl,
> > NVME_AEN_CFG_ANA_CHANGE))
> > +			continue;
> > +		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
> > +				NVME_AER_NOTICE_ANA, NVME_LOG_ANA);
> > +	}
> > +	mutex_unlock(&subsys->lock);
> > +}
> > +
> 
> Isn't this sending too many AENs?
> We're changing the ANA state per _port_, which is linked to individual
> controllers.
> But controllers which are _not_ on that port won't be affected by the
> ANA change, so in theory we shouldn't send ANA AENs for not-affected
> controllers.
> 
> Can't we just add a pointer to the port in the nvmet_ctrl structure and
> filter according to the affected ports?

Yes, we should probably filter out only controllers that are on this
port.  I'll take a look at how to best do that.
