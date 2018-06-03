From: yi.zhang@redhat.com (Yi Zhang)
Date: Sun, 3 Jun 2018 12:46:29 -0400 (EDT)
Subject: [BUG REPORT] reset_controller stress operation lead to kernel
 NULL pointer
In-Reply-To: <825ff884-26d5-e05a-3375-e1a644722ad6@mellanox.com>
References: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>
 <59cee541-f34e-8586-d9c6-f52baf4710be@grimberg.me>
 <825ff884-26d5-e05a-3375-e1a644722ad6@mellanox.com>
Message-ID: <1952603032.5635954.1528044389779.JavaMail.zimbra@redhat.com>

Hi Max/Sagi

Thanks for looking this issue.
I just tried Isreal and Sagi's patch, the kernel NULL pointer cannot be reproduced any more.
But the reset operation always hang with less than 100 times, then I found IO hang on Host side and "keep-alive timer expired" observed on target[2].
I also found some other error log during my test[1].

[1]
[  245.229779] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  245.238728] nvme nvme0: Property Set error: 7, offset 0x14

[2]
Target:
[  647.523888] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:58282b02-64ae-4155-bad5-e37183e148e9.
--snip--
[  715.975355] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:58282b02-64ae-4155-bad5-e37183e148e9.
[  731.214264] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
[  731.222435] nvmet: ctrl 1 fatal error occurred!

Host:
[  245.219461] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.1.92:4420
[  245.229779] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  245.238728] nvme nvme0: Property Set error: 7, offset 0x14
[  245.302714] nvme nvme0: creating 40 I/O queues.
[  246.011104] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.1.92:4420
[  252.159464] nvme nvme0: Property Set error: 7, offset 0x14
[  252.204801] nvme nvme0: creating 40 I/O queues.
[  255.005423] nvme nvme0: Property Set error: 7, offset 0x14
--snip--
[  426.191472] nvme nvme0: creating 40 I/O queues.
[  428.994740] nvme nvme0: Property Set error: 7, offset 0x14
[  429.042588] nvme nvme0: creating 40 I/O queues.
[  615.682478] INFO: task kworker/u81:8:685 blocked for more than 120 seconds.
[  615.690891]       Not tainted 4.17.0-rc7.Sagi+ #10
[  615.696721] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  615.706003] kworker/u81:8   D    0   685      2 0x80000000
[  615.712675] Workqueue: writeback wb_workfn (flush-259:0)
[  615.719150] Call Trace:
[  615.722423]  ? __schedule+0x290/0x870
[  615.727053]  schedule+0x32/0x80
[  615.731092]  io_schedule+0x12/0x40
[  615.735425]  blk_mq_get_tag+0x12e/0x260
[  615.740240]  ? remove_wait_queue+0x60/0x60
[  615.745343]  blk_mq_get_request+0xce/0x390
[  615.750437]  ? __blk_mq_sched_bio_merge+0xec/0x190
[  615.756311]  blk_mq_make_request+0x11c/0x560
[  615.761608]  generic_make_request+0x18c/0x390
[  615.766996]  submit_bio+0x6e/0x130
[  615.771320]  ? guard_bio_eod+0x2c/0xa0
[  615.776020]  submit_bh_wbc+0x157/0x190
[  615.780727]  __block_write_full_page+0x14b/0x400
[  615.786406]  __writepage+0x19/0x50
[  615.790722]  write_cache_pages+0x222/0x470
[  615.795803]  ? bdi_set_max_ratio+0x70/0x70
[  615.800895]  generic_writepages+0x51/0x80
[  615.805883]  ? __wake_up_common_lock+0x87/0xc0
[  615.811356]  do_writepages+0x1a/0x70
[  615.815849]  __writeback_single_inode+0x3d/0x340
[  615.821508]  writeback_sb_inodes+0x24f/0x4b0
[  615.826784]  __writeback_inodes_wb+0x87/0xb0
[  615.832060]  wb_writeback+0x27c/0x310
[  615.836651]  wb_workfn+0x306/0x450
[  615.840952]  process_one_work+0x158/0x360
[  615.845932]  worker_thread+0x47/0x3e0
[  615.850517]  kthread+0xf8/0x130
[  615.854518]  ? max_active_store+0x80/0x80
[  615.859480]  ? kthread_bind+0x10/0x10
[  615.864063]  ret_from_fork+0x35/0x40


Best Regards,
  Yi Zhang


----- Original Message -----
From: "Max Gurtovoy" <maxg@mellanox.com>
To: "Sagi Grimberg" <sagi at grimberg.me>, "Yi Zhang" <yi.zhang at redhat.com>, linux-nvme at lists.infradead.org
Sent: Sunday, June 3, 2018 8:59:39 PM
Subject: Re: [BUG REPORT] reset_controller stress operation lead to kernel NULL pointer

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
