From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 22 Oct 2017 20:16:37 +0300
Subject: v4.14-rc5 NVMeOF regression?
In-Reply-To: <1508343856.2540.8.camel@wdc.com>
References: <1508192588.2493.60.camel@wdc.com>
 <82de6177-27f5-463e-3446-0305fd9f6790@grimberg.me>
 <5fb38923-36f7-c069-5f1d-96f4a9c98248@wdc.com>
 <07f75a37-cd25-81c1-3264-2be80bb9a763@grimberg.me>
 <1508343856.2540.8.camel@wdc.com>
Message-ID: <9b7da98b-c3f0-c076-574e-0a70f5566913@grimberg.me>


>> If you ran into a real deadlock, did you have any other output from
>> hung_task watchdog? I do not yet understand the root cause from
>> lockdep info provided.
>>
>> Also, do you know at which test-case this happened?
> 
> Hello Sagi,
> 
> Running test case 1 should be sufficient to trigger the deadlock. SysRq-w
> produced the following output:
> 
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

Hi Bart,

So I've looked into this, and I want to share my findings.
I'm able to reproduce this hang when trying to disconnect from
a controller which is already in reconnecting state.

The problem as I see it, is that we are returning BLK_STS_RESOURCE
from nvme_rdma_queue_rq() before we start the request timer (fail
before blk_mq_start_request) so the request timeout never
expires (and given that we are in deleting sequence, the command is
never expected to complete).

But for some reason, I don't see the request get re-issued again,
should the driver take care of this by calling
blk_mq_delay_run_hw_queue()?

Thinking more on this, if we are disconnecting from a controller,
and we are unable to issue admin/io commands (queue state is not
LIVE) we probably should not fail with BLK_STS_RESOURCE but rather
BLK_STS_IOERR.

This change makes the issue go away:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5b5458012c2c..be77cd098182 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1393,6 +1393,12 @@ nvme_rdma_queue_is_ready(struct nvme_rdma_queue 
*queue, struct request *rq)
                     cmd->common.opcode != nvme_fabrics_command ||
                     cmd->fabrics.fctype != nvme_fabrics_type_connect) {
                         /*
+                        * deleting state means that the ctrl will never 
accept
+                        * commands again, fail it permanently.
+                        */
+                       if (queue->ctrl->ctrl.state == NVME_CTRL_DELETING)
+                               return BLK_STS_IOERR;
+                       /*
                          * reconnecting state means transport 
disruption, which
                          * can take a long time and even might fail 
permanently,
                          * so we can't let incoming I/O be requeued 
forever.
--

Does anyone have a better idea?
