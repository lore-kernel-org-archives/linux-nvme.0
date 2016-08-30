From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 30 Aug 2016 10:44:07 -0500
Subject: [PATCH WIP/RFC v2 6/6] nvme-rdma: use ib_client API to
 detect	device removal
In-Reply-To: <003d01d202c7$82a00bc0$87e02340$@opengridcomputing.com>
References: <cover.1472506505.git.swise@opengridcomputing.com>
 <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
 <20160830070614.GA32645@lst.de>
 <003d01d202c7$82a00bc0$87e02340$@opengridcomputing.com>
Message-ID: <00db01d202d5$57e8f460$07badd20$@opengridcomputing.com>

> > > +static void nvme_rdma_add_one(struct ib_device *ib_device)
> > > +{
> > > +	/* devices are added dynamically as targets use them */
> > > +}
> >
> > Is the add callback mandatory in the core?  Would be nice if we could
> > fix that up in an incremental patch.
> >
> 
> We can just not populate the add function.  From ib_register_device():
> 
> ---
>         list_for_each_entry(client, &client_list, list)
>                 if (client->add && !add_client_context(device, client))
>                         client->add(device);
> ---

I'm wrong.  If you don't provide an add function, it doesn't call
add_client_context() and thus the client isn't associated with this device and
won't get remove() calls.  

You think this should be changed in the core?  I think it is simpler just to
have a noop add function, and it keeps the current symmetry of the ib_client
API...

Steve.
