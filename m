From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 30 Aug 2016 12:48:06 -0500
Subject: [PATCH WIP/RFC v3 3/6] nvme_rdma: keep a ref on the ctrl during
 delete/flush
In-Reply-To: <c749145e-618e-ef0c-4249-8f441c55e4b1@grimberg.me>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <f3b74c6ef7caba2fdff194be0c90ec7423103893.1472574410.git.swise@opengridcomputing.com>
 <c749145e-618e-ef0c-4249-8f441c55e4b1@grimberg.me>
Message-ID: <012001d202e6$aa27bbb0$fe773310$@opengridcomputing.com>

> 
> 
> > -	/* Queue controller deletion */
> > +	/*
> > +	 * Queue controller deletion. Keep a reference until all
> > +	 * work is flushed since delete_work will free the ctrl mem
> > +	 */
> > +	kref_get(&ctrl->ctrl.kref);
> 
> kref_get_unless_zero?
> 

At the top of nvme_rdma_device_unplug(), we change the ctrl state to DELETING.
If that succeeded, and thus we own the delete process, and are about to kref the
controller, how could the controller ref be 0?  If it is, it is probably freed
which means we're in a bad way...
