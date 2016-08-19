From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 19 Aug 2016 09:22:00 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <f06590ad-e408-e234-2ec4-7f28978411b7@grimberg.me>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
 <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
 <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>
 <012701d1f958$b4953290$1dbf97b0$@opengridcomputing.com>
 <20160818152107.GA17807@infradead.org>
 <f06590ad-e408-e234-2ec4-7f28978411b7@grimberg.me>
Message-ID: <007f01d1fa25$0c8ce7f0$25a6b7d0$@opengridcomputing.com>

> 
> > Btw, in that case the patch is not actually correct, as even workqueue
> > with a higher concurrency level MAY deadlock under enough memory
> > pressure.  We'll need separate workqueues to handle this case I think.
> 
> Steve, does it help if you run the delete on the system_long_wq [1]?
> Note, I've seen problems with forward progress when sharing
> a workqueue between teardown/reconnect sequences and the rest of
> the system (mostly in srp).
> 

I can try this, but see my comments below.  I'm not sure there is any deadlock
at this point..

> >> Yes?  And the
> >> reconnect worker was never completing?  Why is that?  Here are a few
tidbits
> >> about iWARP connections:  address resolution == neighbor discovery.  So if
the
> >> neighbor is unreachable, it will take a few seconds for the OS to give up
and
> >> fail the resolution.  If the neigh entry is valid and the peer becomes
> >> unreachable during connection setup, it might take 60 seconds or so for a
> >> connect operation to give up and fail.  So this is probably slowing the
> >> reconnect thread down.   But shouldn't the reconnect thread notice that a
delete
> >> is trying to happen and bail out?
> >
> > I think we should aim for a state machine that can detect this, but
> > we'll have to see if that will end up in synchronization overkill.
> 
> The reconnect logic does take care of this state transition...

Yes, I agree.  The disconnect/delete command changes the controller state from
RECONNECTING to DELETEING and the reconnecting thread will not reschedule itself
for that controller.

In further debugging (see my subsequent emails), it appears that there really
isn't a deadlock.   First, let me describe the main problem: the IWCM will block
destroying a cm_id until the driver has completed a connection setup attempt.
See IWCM_F_CONNECT_WAIT in drivers/infiniband/core/iwcm.c.  Further, iw_cxgb4's
TCP engine can take up to 60 seconds to fail a TCP connection setup if the neigh
entry is valid yet the peer is unresponsive.   So what we see happening is that
when kato kicks in after the target reboots and _before_ the neigh entry for the
target is flushed due to no connectivity, the connection setup attempts all get
initiated by the reconnect logic in the nvmf/rdma host driver.  Even though the
nvme/rdma host driver times out such an attempt in ~1sec
(NVME_RDMA_CONNECT_TIMEOUT_MS), it gets stuck for up to 60 seconds destroying
the cm_id.   So for my setup, each controller has 32 io queues.  That causes the
reconnect thread to get stuck for VERY LONG periods of time.  Even if the
controllers are deleted thus changing the state of the controller to DELETING,
the thread will still get stuck for at least 60 seconds trying to destroy its
current connecting cm_id.  Then you multiply that by 10 controllers in my test
and you see that the reconnect logic is taking way too long to give up.

So I think I need to see about removing the IWCM_F_CONNECT_WAIT logic in the
iwcm.

One other thing:  in both nvme_rdma_device_unplug() and nvme_rdma_del_ctrl(),
the code kicks the delete_work thread to delete the controller and then calls
flush_work().  This is a possible touch-after-free, no?  The proper way, I
think, should be to take a ref on ctrl, kick the delete_work thread, call
flush_work(), and then nvme_put_ctrl(ctrl).  Do you agree?  While doing this
debug, I wondered if this issue was causing a delete thread to get stuck in
flush_work().  I never proved that, and I think the real issue is the
IWCM_F_CONNECT_WAIT logic.

Steve.
