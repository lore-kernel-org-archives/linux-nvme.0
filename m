From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 18 Aug 2016 12:59:29 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <20160818152107.GA17807@infradead.org>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
 <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
 <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>
 <012701d1f958$b4953290$1dbf97b0$@opengridcomputing.com>
 <20160818152107.GA17807@infradead.org>
Message-ID: <01ee01d1f97a$4406d5c0$cc148140$@opengridcomputing.com>

> Btw, in that case the patch is not actually correct, as even workqueue
> with a higher concurrency level MAY deadlock under enough memory
> pressure.  We'll need separate workqueues to handle this case I think.
> 
> > Yes?  And the
> > reconnect worker was never completing?  Why is that?  Here are a few tidbits
> > about iWARP connections:  address resolution == neighbor discovery.  So if
the
> > neighbor is unreachable, it will take a few seconds for the OS to give up
and
> > fail the resolution.  If the neigh entry is valid and the peer becomes
> > unreachable during connection setup, it might take 60 seconds or so for a
> > connect operation to give up and fail.  So this is probably slowing the
> > reconnect thread down.   But shouldn't the reconnect thread notice that a
delete
> > is trying to happen and bail out?
> 
> I think we should aim for a state machine that can detect this, but
> we'll have to see if that will end up in synchronization overkill.

Looking at the state machine I don't see why the reconnect thread would get
stuck continually rescheduling once the controller was deleted.  Changing from
RECONNECTING to DELETING will be done by nvme_change_ctrl_state().  So once that
happens, in __nvme_rdma_del_ctrl() , the thread running reconnect logic should
stop rescheduling due to this in the failure logic of
nvme_rdma_reconnect_ctrl_work():

...
requeue:
        /* Make sure we are not resetting/deleting */
        if (ctrl->ctrl.state == NVME_CTRL_RECONNECTING) {
                dev_info(ctrl->ctrl.device,
                        "Failed reconnect attempt, requeueing...\n");
                queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
                                        ctrl->reconnect_delay * HZ);
        }
...

So something isn't happening like I think it is, I guess.

Also, even with the workqueue_alloc() change, a reboot during reconnect gets
stuck.  I never see the controllers getting deleted nor the unplug event handler
happening, so the reconnect thread seems to hang the shutdown/reboot...
