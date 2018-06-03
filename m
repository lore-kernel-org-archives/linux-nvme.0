From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 3 Jun 2018 15:59:39 +0300
Subject: [BUG REPORT] reset_controller stress operation lead to kernel
 NULL pointer
In-Reply-To: <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>
References: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
 <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>
Message-ID: <825ff884-26d5-e05a-3375-e1a644722ad6@mellanox.com>

hi Sagi,
Israel already sent a similar commit that is on hold (based on your 
proposal in the past):


The race is between completing the request at error recovery work
and rdma completions.
If we cancel the request before getting the good rdma completion
we get a NULL deref of the request MR at nvme_rdma_process_nvme_rsp().

When Canceling the request we return its mr to the mr pool (set mr to NULL)
and also unmap its data.
Canceling the requests while the rdma queues are active is not safe.
Because rdma queues are active and we get good rdma completions
that can use the mr pointer which may be NULL.
Completing the request too soon may lead also to performing DMA to/from
user buffers which might have been already unmapped.

The commit fixes the race by draining the QP before
starting the abort commands mechanism.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
  drivers/nvme/host/rdma.c | 8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c1abfc8..56fccac 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -734,7 +734,6 @@ static struct blk_mq_tag_set 
*nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
  static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
  		bool remove)
  {
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
  	if (remove) {
  		blk_cleanup_queue(ctrl->ctrl.admin_q);
  		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
@@ -817,7 +816,6 @@ static int nvme_rdma_configure_admin_queue(struct 
nvme_rdma_ctrl *ctrl,
  static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
  		bool remove)
  {
-	nvme_rdma_stop_io_queues(ctrl);
  	if (remove) {
  		blk_cleanup_queue(ctrl->ctrl.connect_q);
  		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
@@ -947,6 +945,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct 
work_struct *work)
  	return;

  destroy_admin:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
  	nvme_rdma_destroy_admin_queue(ctrl, false);
  requeue:
  	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
@@ -963,12 +962,14 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)

  	if (ctrl->ctrl.queue_count > 1) {
  		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
  		blk_mq_tagset_busy_iter(&ctrl->tag_set,
  					nvme_cancel_request, &ctrl->ctrl);
  		nvme_rdma_destroy_io_queues(ctrl, false);
  	}

  	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
  	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
  				nvme_cancel_request, &ctrl->ctrl);
  	nvme_rdma_destroy_admin_queue(ctrl, false);
@@ -1725,6 +1726,7 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)
  {
  	if (ctrl->ctrl.queue_count > 1) {
  		nvme_stop_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
  		blk_mq_tagset_busy_iter(&ctrl->tag_set,
  					nvme_cancel_request, &ctrl->ctrl);
  		nvme_rdma_destroy_io_queues(ctrl, shutdown);
@@ -1736,6 +1738,7 @@ static void nvme_rdma_shutdown_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool shutdown)
  		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);

  	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
  	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
  				nvme_cancel_request, &ctrl->ctrl);
  	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
@@ -2001,6 +2004,7 @@ static struct nvme_ctrl 
*nvme_rdma_create_ctrl(struct device *dev,
  	return &ctrl->ctrl;

  out_remove_admin_queue:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
  	nvme_rdma_destroy_admin_queue(ctrl, true);
  out_kfree_queues:
  	kfree(ctrl->queues);


This includes also error flows. Christoph said it will be good idea to 
add it to the core...







On 6/3/2018 3:20 PM, Sagi Grimberg wrote:
> 
>> Hi
>>
>> I would like to report a kernel NULL pointer bug with reset_controller 
>> stress operation during fio background, here is the reproducer and 
>> kernel log, let me know if you need more info
>>
>> Reproducer:
>> 1. connect to target
>> 2. do fio stress testing background
>> 3. do reset_controller stress test
>> num=0
>> while [ $num -lt 100 ];
>> do
>> ???? echo 1 >/sys/block/nvme0n1/device/reset_controller
>> ???? ret=$?
>> ???? if [ $ret -eq 1 ]; then
>> ???????? echo "reset_controller operation failed: $num"
>> ???????? break
>> ???? fi
>> ???? ((num++))
>> ???? sleep 0.5
>> done
>>
>> HW:
>> 04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family 
>> [ConnectX-4]
>> 04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family 
>> [ConnectX-4]
> 
> Hi Yi, thanks for reporting!
> 
> Can you check if the below patch makes this go away?
> -- 
> commit 5b9b261df4a9f3c5ce04abcae8c74717a2355962
> Author: Sagi Grimberg <sagi at grimberg.me>
> Date:?? Sun Feb 25 20:06:52 2018 +0200
> 
>  ??? nvme-rdma: stop rdma queue pairs before cancelling all reaquests
> 
>  ??? We cannot risk having queue-pairs accessing user buffers after
>  ??? their I/O requests were completed.
> 
>  ??? Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 7b3f08410430..2890e560d043 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -965,12 +965,14 @@ static void nvme_rdma_error_recovery_work(struct 
> work_struct *work)
> 
>  ??????? if (ctrl->ctrl.queue_count > 1) {
>  ??????????????? nvme_stop_queues(&ctrl->ctrl);
> +?????????????? nvme_rdma_stop_io_queues(ctrl);
>  ??????????????? blk_mq_tagset_busy_iter(&ctrl->tag_set,
>  ??????????????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
>  ??????????????? nvme_rdma_destroy_io_queues(ctrl, false);
>  ??????? }
> 
>  ??????? blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +?????? nvme_rdma_stop_queue(&ctrl->queues[0]);
>  ??????? blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  ??????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
>  ??????? nvme_rdma_destroy_admin_queue(ctrl, false);
> @@ -1720,8 +1722,11 @@ static void nvme_rdma_shutdown_ctrl(struct 
> nvme_rdma_ctrl *ctrl, bool shutdown)
>  ?{
>  ??????? if (ctrl->ctrl.queue_count > 1) {
>  ??????????????? nvme_stop_queues(&ctrl->ctrl);
> +?????????????? nvme_rdma_stop_io_queues(ctrl);
>  ??????????????? blk_mq_tagset_busy_iter(&ctrl->tag_set,
>  ??????????????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
> +?????????????? if (shutdown)
> +?????????????????????? nvme_start_queues(&ctrl->ctrl);
>  ??????????????? nvme_rdma_destroy_io_queues(ctrl, shutdown);
>  ??????? }
> 
> @@ -1731,6 +1736,7 @@ static void nvme_rdma_shutdown_ctrl(struct 
> nvme_rdma_ctrl *ctrl, bool shutdown)
>  ??????????????? nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
> 
>  ??????? blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> +?????? nvme_rdma_stop_queue(&ctrl->queues[0]);
>  ??????? blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>  ??????????????????????????????? nvme_cancel_request, &ctrl->ctrl);
>  ??????? blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> -- 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C132a350b85164000961108d5c94c70dc%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636636252518868081&sdata=EYlGxGSmzlncFDOxtASojkWxDGwmhVBe%2Bmm%2F0mA9p%2Fw%3D&reserved=0 
> 
