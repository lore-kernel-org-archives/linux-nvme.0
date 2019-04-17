From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 17 Apr 2019 20:49:55 +0800
Subject: [PATCHv2 RFC] nvme: use nvme_set_queue_dying() during namespace
 rescanning
In-Reply-To: <134febbf-8c41-8483-7e67-c6d3f3c622af@suse.de>
References: <20190403231221.127008-1-hare@suse.de>
 <20190413082954.GD9108@ming.t460p>
 <134febbf-8c41-8483-7e67-c6d3f3c622af@suse.de>
Message-ID: <20190417124954.GA5007@ming.t460p>

On Wed, Apr 17, 2019@01:32:57PM +0200, Hannes Reinecke wrote:
> On 4/13/19 10:29 AM, Ming Lei wrote:
> [ .. ]
> > Another candidate is to hold ns's refcount and switch to remove
> > the ns from 'ctrl->namespaces' in nvme_free_ns() via the following
> > patch[1]. Together with patch "blk-mq: free hw queue's resource in
> > hctx's release handler" in the following link:
> > 
> > https://lore.kernel.org/linux-block/20190413071829.GB9108 at ming.t460p/T/#m41c04517a37cbc1b4c61357f8cb52cd3cbf31f1b
> > 
> > [1] fix race between nvme scan and reset
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index ddb943395118..12507b223584 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -402,6 +402,10 @@ static void nvme_free_ns(struct kref *kref)
> >   {
> >   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
> > +	down_write(&ns->ctrl->namespaces_rwsem);
> > +	list_del_init(&ns->list);
> > +	up_write(&ns->ctrl->namespaces_rwsem);
> > +
> >   	if (ns->ndev)
> >   		nvme_nvm_unregister(ns);
> > @@ -3166,6 +3170,29 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
> >   	return nsa->head->ns_id - nsb->head->ns_id;
> >   }
> > +void nvme_get_all_ns(struct nvme_ctrl *ctrl)
> > +{
> > +	struct nvme_ns *ns;
> > +
> > +	down_read(&ctrl->namespaces_rwsem);
> > +	list_for_each_entry(ns, &ctrl->namespaces, list)
> > +		if (kref_get_unless_zero(&ns->kref))
> > +			continue;
> > +	up_read(&ctrl->namespaces_rwsem);
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_get_all_ns);
> > +
> > +void nvme_put_all_ns(struct nvme_ctrl *ctrl)
> > +{
> > +	struct nvme_ns *ns;
> > +
> > +	down_read(&ctrl->namespaces_rwsem);
> > +	list_for_each_entry(ns, &ctrl->namespaces, list)
> > +		nvme_put_ns(ns);
> > +	up_read(&ctrl->namespaces_rwsem);
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_put_all_ns);
> > +
> >   static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> >   {
> >   	struct nvme_ns *ns, *ret = NULL;
> > @@ -3329,10 +3356,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> >   	nvme_mpath_clear_current_path(ns);
> >   	mutex_unlock(&ns->ctrl->subsys->lock);
> > -	down_write(&ns->ctrl->namespaces_rwsem);
> > -	list_del_init(&ns->list);
> > -	up_write(&ns->ctrl->namespaces_rwsem);
> > -
> >   	synchronize_srcu(&ns->head->srcu);
> >   	nvme_mpath_check_last_path(ns);
> >   	nvme_put_ns(ns);
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 527d64545023..f8f2a012c3ba 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -430,6 +430,9 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
> >   void nvme_put_ctrl(struct nvme_ctrl *ctrl);
> >   int nvme_init_identify(struct nvme_ctrl *ctrl);
> > +void nvme_get_all_ns(struct nvme_ctrl *ctrl);
> > +void nvme_put_all_ns(struct nvme_ctrl *ctrl);
> > +
> >   void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
> >   int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index c1eecde6b853..0d4fea14ccdc 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2496,6 +2496,8 @@ static void nvme_reset_work(struct work_struct *work)
> >   	int result = -ENODEV;
> >   	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
> > +	nvme_get_all_ns(&dev->ctrl);
> > +
> >   	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
> >   		goto out;
> > @@ -2603,6 +2605,7 @@ static void nvme_reset_work(struct work_struct *work)
> >    out_unlock:
> >   	mutex_unlock(&dev->shutdown_lock);
> >    out:
> > +	nvme_put_all_ns(&dev->ctrl);
> >   	nvme_remove_dead_ctrl(dev, result);
> >   }
> Hmm.
> Might; I'll have to check.

The patch actually isn't correct, especially in case that new ns is
added during resetting.

> The entire condition under which this particular error is triggered is very
> convoluted, and this issue isn't the only one contributing to it.
> Will be posting my findings once I have confirmation.

I have posted the queue freeing patch V6, which should cover this issue,
especially by the following two:

https://lore.kernel.org/linux-block/ec6aed0d-a6dc-f829-46f4-10140c7c37df at suse.de/T/#u
https://lore.kernel.org/linux-block/bc4b8607-9fe7-aece-97f7-9d7d1c2c4e0b at suse.de/T/#u


Thanks,
Ming
