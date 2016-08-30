From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 30 Aug 2016 09:05:05 -0500
Subject: [PATCH WIP/RFC v2 6/6] nvme-rdma: use ib_client API to
 detect	device removal
In-Reply-To: <20160830070614.GA32645@lst.de>
References: <cover.1472506505.git.swise@opengridcomputing.com>
 <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
 <20160830070614.GA32645@lst.de>
Message-ID: <003d01d202c7$82a00bc0$87e02340$@opengridcomputing.com>

> 
> > +static void nvme_rdma_add_one(struct ib_device *ib_device);
> > +static void nvme_rdma_remove_one(struct ib_device *ib_device,
> > +				void *client_data);
> 
> Can we avoid the forward declarations?
> 

Yes, will do.

> > +static void nvme_rdma_add_one(struct ib_device *ib_device)
> > +{
> > +	/* devices are added dynamically as targets use them */
> > +}
> 
> Is the add callback mandatory in the core?  Would be nice if we could
> fix that up in an incremental patch.
>

We can just not populate the add function.  From ib_register_device():

---
        list_for_each_entry(client, &client_list, list)
                if (client->add && !add_client_context(device, client))
                        client->add(device);
---

> > +static void nvme_rdma_remove_one(struct ib_device *ib_device, void
> *client_data)
> > +{
> > +	struct nvme_rdma_ctrl *ctrl, *tmp;
> > +
> > +	pr_info("Removing resources for device %s\n", ib_device->name);
> > +
> > +	mutex_lock(&nvme_rdma_ctrl_mutex);
> > +	list_for_each_entry_safe(ctrl, tmp, &nvme_rdma_ctrl_list, list) {
> > +		int delete_ctrl;
> > +
> > +		if (ctrl->device->dev != ib_device)
> > +			continue;
> 
> Also not important for now, but we probably should move to a per-device
> list here if we move forward with this approach.
> 
> > +		mutex_unlock(&nvme_rdma_ctrl_mutex);
> 
> After unlocking nvme_rdma_ctrl_mutex we will need to restart the
> list walk, as others might have changed the list (e.g. for a different
> device).  Maybe we should do the per-device list from the start to
> simplify this loop.
> 

How would changing the list by adding/removing controllers for another device
cause this logic here to miss a controller associated with the device being
removed? 

> > @@ -2052,6 +2060,7 @@ static void __exit nvme_rdma_cleanup_module(void)
> >  		__nvme_rdma_del_ctrl(ctrl);
> >  	mutex_unlock(&nvme_rdma_ctrl_mutex);
> >
> > +	ib_unregister_client(&nvme_rdma_ib_client);
> 
> We shouldn't need the deletion loop above because now ib_unregister_client
> takes care of that, right?

Correct.
