From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 20 Feb 2018 11:56:07 +0200
Subject: how can one drain MQ request queue ?
Message-ID: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>

hi all,
is there a way to drain a blk-mq based request queue (similar to 
blk_drain_queue for non MQ) ?

I try to fix the following situation:
Running DM-multipath over NVMEoF/RDMA block devices, toggling the switch 
ports during traffic using fio and making sure the traffic never fails.

when the switch port goes down the initiator driver start an error 
recovery process
- blk_mq_quiesce_queue for each namespace request queue
- cancel all requests of the tagset using blk_mq_tagset_busy_iter
- destroy the QPs/RDMA connections and MR pools
- blk_mq_unquiesce_queue for each namespace request queue
- reconnect to the target (after creating RDMA resources again)

During the QP destruction, I see a warning that not all the memory 
regions were back to the mr_pool. For every request we get from the 
block layer (well, almost every request) we get a MR from the MR pool.
So what I see is that, depends on the timing, some requests are 
dispatched/completed after we blk_mq_unquiesce_queue and after we 
destroy the QP and the MR pool. Probably these request were inserted 
during quiescing, and I want to flush/drain them before I destroy the QP.

Is there a way in the block layer that I can do it (we don't want to 
destroy the tagset and the request_queue on each reconnection)?

I'm open for suggestion :)

Cheers,
Max.
