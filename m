From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Oct 2017 10:43:51 +0200
Subject: [REPOST PATCH v2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <20171025144130.8833-1-jsmart2021@gmail.com>
References: <20171025144130.8833-1-jsmart2021@gmail.com>
Message-ID: <d995811b-f88d-f1fe-eb25-13b380c20ae3@suse.de>

On 10/25/2017 04:41 PM, James Smart wrote:
> Below is  a stack trace for an issue that was reported.
> 
> What's happening is that the nvmet layer had it's controller kato
> timeout fire, which causes it to schedule its fatal error handler
> via the fatal_err_work element. The error handler is invoked, which
> calls the transport delete_ctrl() entry point, and as the transport
> tears down the controller, nvmet_sq_destroy ends up doing the final
> put on the ctlr causing it to enter its free routine. The ctlr free
> routine does a cancel_work_sync() on fatal_err_work element, which
> then does a flush_work and wait_for_completion. But, as the wait is
> in the context of the work element being flushed, its in a catch-22
> and the thread hangs.
> 
> [  326.903131] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [  326.909832] nvmet: ctrl 1 fatal error occurred!
> [  327.643100] lpfc 0000:04:00.0: 0:6313 NVMET Defer ctx release xri
> x114 flg x2
> [  494.582064] INFO: task kworker/0:2:243 blocked for more than 120
> seconds.
> [  494.589638]       Not tainted 4.14.0-rc1.James+ #1
> [  494.594986] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  494.603718] kworker/0:2     D    0   243      2 0x80000000
> [  494.609839] Workqueue: events nvmet_fatal_error_handler [nvmet]
> [  494.616447] Call Trace:
> [  494.619177]  __schedule+0x28d/0x890
> [  494.623070]  schedule+0x36/0x80
> [  494.626571]  schedule_timeout+0x1dd/0x300
> [  494.631044]  ? dequeue_task_fair+0x592/0x840
> [  494.635810]  ? pick_next_task_fair+0x23b/0x5c0
> [  494.640756]  wait_for_completion+0x121/0x180
> [  494.645521]  ? wake_up_q+0x80/0x80
> [  494.649315]  flush_work+0x11d/0x1a0
> [  494.653206]  ? wake_up_worker+0x30/0x30
> [  494.657484]  __cancel_work_timer+0x10b/0x190
> [  494.662249]  cancel_work_sync+0x10/0x20
> [  494.666525]  nvmet_ctrl_put+0xa3/0x100 [nvmet]
> [  494.671482]  nvmet_sq_:q+0x64/0xd0 [nvmet]
> [  494.676540]  nvmet_fc_delete_target_queue+0x202/0x220 [nvmet_fc]
> [  494.683245]  nvmet_fc_delete_target_assoc+0x6d/0xc0 [nvmet_fc]
> [  494.689743]  nvmet_fc_delete_ctrl+0x137/0x1a0 [nvmet_fc]
> [  494.695673]  nvmet_fatal_error_handler+0x30/0x40 [nvmet]
> [  494.701589]  process_one_work+0x149/0x360
> [  494.706064]  worker_thread+0x4d/0x3c0
> [  494.710148]  kthread+0x109/0x140
> [  494.713751]  ? rescuer_thread+0x380/0x380
> [  494.718214]  ? kthread_park+0x60/0x60
> 
> Correct by creating a final free work element, which is scheduled
> by the final ctrl put routine, so that when the flush_work (was
> cancel_work_sync) is called, it cannot be in the same work_q
> element context.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> v2:
>   convert cancel_work_sync() to flush_work() for fatal_err_work
> v3: cancelled. v2 is correct
> 
>  drivers/nvme/target/core.c  | 28 +++++++++++++++++++---------
>  drivers/nvme/target/nvmet.h |  1 +
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
