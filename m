From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 24 Aug 2016 09:09:48 -0500
Subject: nvme_rdma - leaves provider resources allocated
In-Reply-To: <98396d58-4a16-0e1f-e42b-912edb8a7cf6@grimberg.me>
References: <014301d1fd5f$a2da7000$e88f5000$@opengridcomputing.com>
 <98396d58-4a16-0e1f-e42b-912edb8a7cf6@grimberg.me>
Message-ID: <006501d1fe11$2c3e6200$84bb2600$@opengridcomputing.com>

> 
> > Assume an nvme_rdma host has one attached controller in RECONNECTING state,
> and
> > that controller has failed to reconnect at least once and thus is in the
> > delay_schedule time before retrying the connection.  At that moment, there
are
> > no cm_ids allocated for that controller because the admin queue and the io
> > queues have been freed.  So nvme_rdma cannot get a DEVICE_REMOVAL from
> the
> > rdma_cm.  This means if the underlying provider module is removed, it will
be
> > removed with resources still allocated by nvme_rdma.  For iw_cxgb4, this
causes
> > a BUG_ON() in gen_pool_destroy() because MRs are still allocated for the
> > controller.
> >
> > Thoughts on how to fix this?
> 
> Hey Steve,
> 
> I think it's time to go back to your client register proposal.
> 
> I can't think of any way to get it right at the moment...
> 
> Maybe if we can make it only do something meaningful in remove_one()
> to handle device removal we can get away with it...

Hey Sagi, 

I'm finalizing a WIP series that provides a different approach.  (we can
certainly reconsider my ib_client patch too).  But my WIP adds the concept of an
"unplug" cm_id for each nvme_rdma_ctrl controller.  When the controller is first
created and the admin qp is connected to the target, the unplug_cm_id is created
and address resolution is done on it to bind it to the same device that the
admin QP is bound to.   This unplug_cm_id remains across any/all kato recovery
and thus will always be available for DEVICE_REMOVAL events.  This simplifies
the unplug handler because the cm_id isn't associated with any of the IO queues
nor the admin queue.  

I also found another bug:  if the reconnect worker times out waiting for rdma
connection setup on an IO or admin QP, a QP is leaked.   I'm looking into this
as well.

Do you have any thoughts on the controller reference around deletion issue I
posted?  

http://lists.infradead.org/pipermail/linux-nvme/2016-August/005919.html

Thanks!

Steve.
