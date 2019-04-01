From: keith.busch@intel.com (Keith Busch)
Date: Sun, 31 Mar 2019 21:10:37 -0600
Subject: [PATCH 1/2] nvmet: make MDTS value configurable
In-Reply-To: <9abfa47a-3374-a1a0-8370-1096d02743d0@suse.com>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-2-hare@suse.de>
 <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>
 <9abfa47a-3374-a1a0-8370-1096d02743d0@suse.com>
Message-ID: <20190401031036.GB11565@localhost.localdomain>

On Sun, Mar 31, 2019@07:02:40PM -0700, Hannes Reinecke wrote:
> > I think it's more of a ctrl/nvmet_port configuration than a subsystem.
> > 
> > For example if you have 2 HCAs, one is super strong and can transfer 
> > upto 8MB and the second is old model and can transfer upto 64KiB.
> > 
> > do
> > 
> > id->mdts = ctrl->ops->port_mdts(req->port);
> > 
> > and inside the implementation you can do
> > 
> > min_not_zero(max_port_hca_cap_in_mdts_units, mdts_configfs_val);
> > 
> > and it will fix the comment that is written above (we're not really 
> > unlimited).
> > 
> > this way we're using the low level device characteristics and also cover 
> > the bio split test.
> > 
> > thoughts ?
> > 
> > 
> Yeah, true, it should be a port configuration.
> 
> I'll be updating the patch.

Wouldn't this indicate MDTS should be driven from hardware constraints
rather than user tunable knobs? I don't think we should have user
parameters if their only purpose is to test how host drivers react
to them. It's okay if they've a functional purpose, but there are so
many adjustable nvme parameters, this is a bit of a slippery slope if we
want to turn the nvme target driver into a host driver test vehicle.
