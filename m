From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 14:43:16 +0200
Subject: [PATCH 04/10] nvme: clear current path on ANA state change
In-Reply-To: <20180529122212.rd74wmr42nysxii2@linux-x5ow.site>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-5-hare@suse.de>
 <20180529122212.rd74wmr42nysxii2@linux-x5ow.site>
Message-ID: <20180529144316.24ccbf59@pentland.suse.de>

On Tue, 29 May 2018 14:22:12 +0200
"Johannes Thumshirn" <jthumshirn@suse.de> wrote:

> On Tue, May 29, 2018@12:14:25PM +0200, Hannes Reinecke wrote:
> > Whenever ANA state changes the path selection needs to be
> > retriggered, so we should be clearing the current path here.
> > 
> > Signed-off-by: Hannes Reinecke <hare at suse.com>
> > ---
> >  drivers/nvme/host/multipath.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/nvme/host/multipath.c
> > b/drivers/nvme/host/multipath.c index a5f43d164b19..a520582811f8
> > 100644 --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -44,6 +44,7 @@ void nvme_set_disk_name(char *disk_name, struct
> > nvme_ns *ns, static void nvme_update_ana_state(struct nvme_ns *ns,
> > enum nvme_ana_state state) {
> >  	WRITE_ONCE(ns->ctrl->ana_state[ns->anagrpid], state);
> > +	nvme_mpath_clear_current_path(ns);  
> 
> Don't we need the subsys lock when calling
> nvme_mpath_clear_current_path()? At least that's how I interpreted
> Paul here:
> http://lists.infradead.org/pipermail/linux-nvme/2018-May/017484.html
> 
> 

I'm aware of that, and interpreted it differently.
In the end we're only _clearing_ the pointer, not assigning a new one.
And clearing is always an atomic update, so that's okay.
We might be racing with another update, but then this is not a
hard requirement but rather a hint to the path selector. So if it's
being overwritten later on, fine.

Cheers,

Hannes
