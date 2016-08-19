From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Aug 2016 11:58:33 +0300
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
Message-ID: <f06590ad-e408-e234-2ec4-7f28978411b7@grimberg.me>


> Btw, in that case the patch is not actually correct, as even workqueue
> with a higher concurrency level MAY deadlock under enough memory
> pressure.  We'll need separate workqueues to handle this case I think.

Steve, does it help if you run the delete on the system_long_wq [1]?
Note, I've seen problems with forward progress when sharing
a workqueue between teardown/reconnect sequences and the rest of
the system (mostly in srp).

>> Yes?  And the
>> reconnect worker was never completing?  Why is that?  Here are a few tidbits
>> about iWARP connections:  address resolution == neighbor discovery.  So if the
>> neighbor is unreachable, it will take a few seconds for the OS to give up and
>> fail the resolution.  If the neigh entry is valid and the peer becomes
>> unreachable during connection setup, it might take 60 seconds or so for a
>> connect operation to give up and fail.  So this is probably slowing the
>> reconnect thread down.   But shouldn't the reconnect thread notice that a delete
>> is trying to happen and bail out?
>
> I think we should aim for a state machine that can detect this, but
> we'll have to see if that will end up in synchronization overkill.

The reconnect logic does take care of this state transition...

[1]:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8d2875b4c56d..93ea2831ff31 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1342,7 +1342,7 @@ static int nvme_rdma_device_unplug(struct 
nvme_rdma_queue *queue)
         }

         /* Queue controller deletion */
-       queue_work(nvme_rdma_wq, &ctrl->delete_work);
+       queue_work(system_long_wq, &ctrl->delete_work);
         flush_work(&ctrl->delete_work);
         return ret;
  }
@@ -1681,7 +1681,7 @@ static int __nvme_rdma_del_ctrl(struct 
nvme_rdma_ctrl *ctrl)
         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
                 return -EBUSY;

-       if (!queue_work(nvme_rdma_wq, &ctrl->delete_work))
+       if (!queue_work(system_long_wq, &ctrl->delete_work))
                 return -EBUSY;

         return 0;
@@ -1763,7 +1763,7 @@ static int nvme_rdma_reset_ctrl(struct nvme_ctrl 
*nctrl)
         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
                 return -EBUSY;

-       if (!queue_work(nvme_rdma_wq, &ctrl->reset_work))
+       if (!queue_work(system_long_wq, &ctrl->reset_work))
                 return -EBUSY;

         flush_work(&ctrl->reset_work);
--
