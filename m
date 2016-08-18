From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 18 Aug 2016 09:47:52 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <012701d1f958$b4953290$1dbf97b0$@opengridcomputing.com>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
 <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
 <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>
 <012701d1f958$b4953290$1dbf97b0$@opengridcomputing.com>
Message-ID: <017601d1f95f$7f270cd0$7d752670$@opengridcomputing.com>

> >
> > >> Can this be related due to the fact that we use a signle-threaded
> > >> workqueue for delete/reset/reconnect? (delete cancel_sync the active
> > >> reconnect work...)
> > >>
> > >> Does this untested patch help?
> > >
> > > That seems to do it!
> >
> > Is this a formal tested-by?
> 
> Sure, 

While the patch worked for deleting the controllers, it still hangs if I reboot
the host after the target reboots and the host begins kato recovery.  Looks like
the reconnect thread just gets stuck doing this:

[  947.095936] nvme nvme4: Failed reconnect attempt, requeueing...
[  947.616015] nvme nvme5: rdma_resolve_addr wait failed (-110).
[  947.623943] nvme nvme5: Failed reconnect attempt, requeueing...
[  948.128012] nvme nvme6: rdma_resolve_addr wait failed (-110).
[  948.135956] nvme nvme6: Failed reconnect attempt, requeueing...
[  948.624052] nvme nvme7: rdma_resolve_addr wait failed (-104).

I'll try and get a crash dump of this state to look at all the threads.  But I
think we need the reconnect worker to give up if the controller it is
reconnecting is getting deleted or the device removed.

>
> but let me ask a question:  So the bug was that the delete controller
> worker was blocked waiting for the reconnect worker to complete.  Yes?  And
the
> reconnect worker was never completing?  Why is that?  Here are a few tidbits
> about iWARP connections:  address resolution == neighbor discovery.  So if the
> neighbor is unreachable, it will take a few seconds for the OS to give up and
> fail the resolution.  If the neigh entry is valid and the peer becomes
> unreachable during connection setup, it might take 60 seconds or so for a
> connect operation to give up and fail.  So this is probably slowing the
> reconnect thread down.   But shouldn't the reconnect thread notice that a
delete
> is trying to happen and bail out?
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
