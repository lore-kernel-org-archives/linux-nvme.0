From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 22 Oct 2017 21:54:39 +0300
Subject: [PATCH] nvme-rdma: fix possible hang when issuing commands during
 ctrl removal
In-Reply-To: <1508697771-3552-1-git-send-email-sagi@grimberg.me>
References: <1508697771-3552-1-git-send-email-sagi@grimberg.me>
Message-ID: <541a7b75-f382-70d3-442c-48a00f3bb9d1@grimberg.me>

Replaced Bart's old email address (now updated in .gitaliases)

On 22/10/17 21:42, Sagi Grimberg wrote:
> nvme_rdma_queue_is_ready() fails requests in case a queue is not
> LIVE. If the controller is in RECONNECTING state, we might be in
> this state for a long time (until we successfully reconnect) and
> we are better off with failing the request fast. Otherwise, we
> fail with BLK_STS_RESOURCE to have the block layer try again
> soon.
> 
> In case we are removing the controller when the admin queue
> is not LIVE, we will terminate the request with BLK_STS_RESOURCE
> but it happens before we call blk_mq_start_request() so the
> request timeout never expires, and the queue will never get
> back to LIVE (because we are removing the controller). This
> causes the removal operation to block infinitly [1].
> 
> Thus, if we are removing (state DELETING), and the queue is
> not LIVE, we need to fail the request permanently as there is
> no chance for it to ever complete successfully.
> 
> [1]
> --
> sysrq: SysRq : Show Blocked State
>    task                        PC stack   pid father
> kworker/u66:2   D    0   440      2 0x80000000
> Workqueue: nvme-wq nvme_rdma_del_ctrl_work [nvme_rdma]
> Call Trace:
>   __schedule+0x3e9/0xb00
>   schedule+0x40/0x90
>   schedule_timeout+0x221/0x580
>   io_schedule_timeout+0x1e/0x50
>   wait_for_completion_io_timeout+0x118/0x180
>   blk_execute_rq+0x86/0xc0
>   __nvme_submit_sync_cmd+0x89/0xf0
>   nvmf_reg_write32+0x4b/0x90 [nvme_fabrics]
>   nvme_shutdown_ctrl+0x41/0xe0
>   nvme_rdma_shutdown_ctrl+0xca/0xd0 [nvme_rdma]
>   nvme_rdma_remove_ctrl+0x2b/0x40 [nvme_rdma]
>   nvme_rdma_del_ctrl_work+0x25/0x30 [nvme_rdma]
>   process_one_work+0x1fd/0x630
>   worker_thread+0x1db/0x3b0
>   kthread+0x11e/0x150
>   ret_from_fork+0x27/0x40
> 01              D    0  2868   2862 0x00000000
> Call Trace:
>   __schedule+0x3e9/0xb00
>   schedule+0x40/0x90
>   schedule_timeout+0x260/0x580
>   wait_for_completion+0x108/0x170
>   flush_work+0x1e0/0x270
>   nvme_rdma_del_ctrl+0x5a/0x80 [nvme_rdma]
>   nvme_sysfs_delete+0x2a/0x40
>   dev_attr_store+0x18/0x30
>   sysfs_kf_write+0x45/0x60
>   kernfs_fop_write+0x124/0x1c0
>   __vfs_write+0x28/0x150
>   vfs_write+0xc7/0x1b0
>   SyS_write+0x49/0xa0
>   entry_SYSCALL_64_fastpath+0x18/0xad
> --
> 
> Reported-by: Bart Van Assche <bart.vanassche at wdc.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5b5458012c2c..57f1c9f49a54 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1393,6 +1393,14 @@ nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue, struct request *rq)
>   		    cmd->common.opcode != nvme_fabrics_command ||
>   		    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
>   			/*
> +			 * deleting state means that the ctrl will never accept
> +			 * commands again, fail it permanently.
> +			 */
> +			if (queue->ctrl->ctrl.state == NVME_CTRL_DELETING) {
> +				nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> +				return BLK_STS_IOERR;
> +			}
> +			/*
>   			 * reconnecting state means transport disruption, which
>   			 * can take a long time and even might fail permanently,
>   			 * so we can't let incoming I/O be requeued forever.
> 
