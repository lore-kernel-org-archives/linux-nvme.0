From: Martin.George@netapp.com (George, Martin)
Date: Mon, 28 Jan 2019 14:01:57 +0000
Subject: [PATCH] nvme-multipath: relax ANA state check
In-Reply-To: <20190128074332.GC3287@lst.de>
References: <20190125111236.5389-1-marting@netapp.com>
 <20190128074332.GC3287@lst.de>
Message-ID: <a244559921598a647490a6d40368a11a989e7bbe.camel@netapp.com>

On Mon, 2019-01-28@08:43 +0100, Christoph Hellwig wrote:
> 
> This description does not seem to match the patch:
> 
> >  static void nvme_update_ns_ana_state(struct nvme_ana_group_desc
> > *desc,
> >               struct nvme_ns *ns)
> >  {
> > -     enum nvme_ana_state old;
> > -
> >       mutex_lock(&ns->head->lock);
> > -     old = ns->ana_state;
> >       ns->ana_grpid = le32_to_cpu(desc->grpid);
> >       ns->ana_state = desc->state;
> >       clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
> > 
> > -     if (nvme_state_is_live(ns->ana_state) &&
> > !nvme_state_is_live(old))
> > +     if (nvme_state_is_live(ns->ana_state))
> >               nvme_mpath_set_live(ns);
> 
> What the patch does is to always call nvme_mpath_set_live when
> transitioning to a live state, where live is defined as optimized or
> non-optimized, instead of limiting that call to transitions from
> states that were not considered live.

Ok. Will modify the description accordingly and resend the patch. Thank
you.

-Martin George
