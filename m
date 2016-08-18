From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 18 Aug 2016 08:59:15 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
 <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
 <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>
Message-ID: <012701d1f958$b4953290$1dbf97b0$@opengridcomputing.com>

> 
> >> Can this be related due to the fact that we use a signle-threaded
> >> workqueue for delete/reset/reconnect? (delete cancel_sync the active
> >> reconnect work...)
> >>
> >> Does this untested patch help?
> >
> > That seems to do it!
> 
> Is this a formal tested-by?

Sure, but let me ask a question:  So the bug was that the delete controller
worker was blocked waiting for the reconnect worker to complete.  Yes?  And the
reconnect worker was never completing?  Why is that?  Here are a few tidbits
about iWARP connections:  address resolution == neighbor discovery.  So if the
neighbor is unreachable, it will take a few seconds for the OS to give up and
fail the resolution.  If the neigh entry is valid and the peer becomes
unreachable during connection setup, it might take 60 seconds or so for a
connect operation to give up and fail.  So this is probably slowing the
reconnect thread down.   But shouldn't the reconnect thread notice that a delete
is trying to happen and bail out?  
