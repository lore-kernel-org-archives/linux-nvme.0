From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 3 Jun 2018 15:20:27 +0300
Subject: [BUG REPORT] reset_controller stress operation lead to kernel
 NULL pointer
In-Reply-To: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
References: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
Message-ID: <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>


> Hi
> 
> I would like to report a kernel NULL pointer bug with reset_controller stress operation during fio background, here is the reproducer and kernel log, let me know if you need more info
> 
> Reproducer:
> 1. connect to target
> 2. do fio stress testing background
> 3. do reset_controller stress test
> num=0
> while [ $num -lt 100 ];
> do
>      echo 1 >/sys/block/nvme0n1/device/reset_controller
>      ret=$?
>      if [ $ret -eq 1 ]; then
>          echo "reset_controller operation failed: $num"
>          break
>      fi
>      ((num++))
>      sleep 0.5
> done
> 
> HW:
> 04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
> 04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]

Hi Yi, thanks for reporting!

Can you check if the below patch makes this go away?
--
commit 5b9b261df4a9f3c5ce04abcae8c74717a2355962
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Sun Feb 25 20:06:52 2018 +0200

     nvme-rdma: stop rdma queue pairs before cancelling all reaquests

     We cannot risk having queue-pairs accessing user buffers after
     their I/O requests were completed.

     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7b3f08410430..2890e560d043 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -965,12 +965,14 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
+               nvme_rdma_stop_io_queues(ctrl);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
                 nvme_rdma_destroy_io_queues(ctrl, false);
         }

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+       nvme_rdma_stop_queue(&ctrl->queues[0]);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
         nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -1720,8 +1722,11 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)
  {
         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
+               nvme_rdma_stop_io_queues(ctrl);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
+               if (shutdown)
+                       nvme_start_queues(&ctrl->ctrl);
                 nvme_rdma_destroy_io_queues(ctrl, shutdown);
         }

@@ -1731,6 +1736,7 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)
                 nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+       nvme_rdma_stop_queue(&ctrl->queues[0]);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
         blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
--
