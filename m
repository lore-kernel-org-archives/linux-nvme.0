From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 17 May 2017 20:28:30 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
Message-ID: <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>

Hi Alex,

> I am trying to test failure scenarios of NVMeoF + multipath. I bring
> one of ports down and expect to see failed paths using "multipath
> -ll". Instead I see that "multipath -ll" get stuck.
>
> reproduce:
> 1. Connected to NVMeoF device through 2 ports.
> 2. Bind them with multipath.
> 3. Bring one port down (ifconfig eth3 down)
> 4. Execute "multipath -ll" command and it will get stuck.
> From strace I see that multipath is stuck in io_destroy() during
> release of resources. As I understand io_destroy is stuck because of
> io_cancel() that failed. And io_cancel() failed because of port that
> was disabled in step 3.

Hmm, it looks like we do take care of failing fast pending IO, but once
we schedule periodic reconnects the request queues are already stopped
and new incoming requests may block until we successfully reconnect.

I don't have too much time for it at the moment, but here is an untested
patch for you to try out:

--
[PATCH] nvme-rdma: restart queues after we at error recovery to fast
  fail incoming io

When we encounter an transport/controller errors, error recovery
kicks in which performs:
1. stops io/admin queues
2. moves transport queues out of LIVE state
3. fast fail pending io
4. schedule periodic reconnects.

But we also need to fast fail incoming IO taht enters after we
already scheduled. Given that our queue is not LIVE anymore, simply
restart the request queues to fail in .queue_rq

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
  drivers/nvme/host/rdma.c | 20 +++++++++++---------
  1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dd1c6deef82f..a0aa2bfb91ee 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -753,28 +753,26 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
         if (ret)
                 goto requeue;

-       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
-
         ret = nvmf_connect_admin_queue(&ctrl->ctrl);
         if (ret)
-               goto stop_admin_q;
+               goto requeue;

         set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);

         ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
         if (ret)
-               goto stop_admin_q;
+               goto requeue;

         nvme_start_keep_alive(&ctrl->ctrl);

         if (ctrl->queue_count > 1) {
                 ret = nvme_rdma_init_io_queues(ctrl);
                 if (ret)
-                       goto stop_admin_q;
+                       goto requeue;

                 ret = nvme_rdma_connect_io_queues(ctrl);
                 if (ret)
-                       goto stop_admin_q;
+                       goto requeue;
         }

         changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -782,7 +780,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
         ctrl->ctrl.opts->nr_reconnects = 0;

         if (ctrl->queue_count > 1) {
-               nvme_start_queues(&ctrl->ctrl);
                 nvme_queue_scan(&ctrl->ctrl);
                 nvme_queue_async_events(&ctrl->ctrl);
         }
@@ -791,8 +788,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)

         return;

-stop_admin_q:
-       blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
  requeue:
         dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
                         ctrl->ctrl.opts->nr_reconnects);
@@ -823,6 +818,13 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);

+       /*
+        * queues are not a live anymore, so restart the queues to fail fast
+        * new IO
+        */
+       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+       nvme_start_queues(&ctrl->ctrl);
+
         nvme_rdma_reconnect_or_remove(ctrl);
  }

--
