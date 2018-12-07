From: jalee@purestorage.com (Jaesoo Lee)
Date: Thu, 6 Dec 2018 16:18:28 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
Message-ID: <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>

Could you please take a look at this bug and code review?

We are seeing more instances of this bug and found that reconnect_work
could hang as well, as can be seen from below stacktrace.

 Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
 Call Trace:
 __schedule+0x2ab/0x880
 schedule+0x36/0x80
 schedule_timeout+0x161/0x300
 ? __next_timer_interrupt+0xe0/0xe0
 io_schedule_timeout+0x1e/0x50
 wait_for_completion_io_timeout+0x130/0x1a0
 ? wake_up_q+0x80/0x80
 blk_execute_rq+0x6e/0xa0
 __nvme_submit_sync_cmd+0x6e/0xe0
 nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
 ? wait_for_completion_interruptible_timeout+0x157/0x1b0
 nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
 nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
 nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
 process_one_work+0x179/0x390
 worker_thread+0x4f/0x3e0
 kthread+0x105/0x140
 ? max_active_store+0x80/0x80
 ? kthread_bind+0x20/0x20

This bug is produced by setting MTU of RoCE interface to '568' for
test while running I/O traffics.

Thanks,

Jaesoo Lee.

On Thu, Nov 29, 2018@5:54 PM Jaesoo Lee <jalee@purestorage.com> wrote:
>
> Not the queue, but the RDMA connections.
>
> Let me describe the scenario.
>
> 1. connected nvme-rdma target with 500 namespaces
> : this will make the nvme_remove_namespaces() took a long time to
> complete and open the window vulnerable to this bug
> 2. host will take below code path for nvme_delete_ctrl_work and send
> normal shutdown in nvme_shutdown_ctrl()
> - nvme_stop_ctrl
>   - nvme_stop_keep_alive --> stopped keep alive
> - nvme_remove_namespaces --> took too long time, over 10~15s
> - nvme_rdma_shutdown_ctrl
>   - nvme_rdma_teardown_io_queues
>   - nvme_shutdown_ctrl
>     - nvmf_reg_write32
>       -__nvme_submit_sync_cmd --> nvme_delete_ctrl_work blocked here
>   - nvme_rdma_teardown_admin_queue
> - nvme_uninit_ctrl
> - nvme_put_ctrl
> 3. the rdma connection is disconnected by the nvme-rdma target
> : in our case, this is triggered by the target side timeout mechanism
> : I did not try, but I think this could happen if we lost the RoCE link, too.
> 4. the shutdown notification command timed out and the work stuck
> while leaving the controller in NVME_CTRL_DELETING state
>
> Thanks,
>
> Jaesoo Lee.
>
>
> On Thu, Nov 29, 2018@5:30 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > This does not hold at least for NVMe RDMA host driver. An example scenario
> > > is when the RDMA connection is gone while the controller is being deleted.
> > > In this case, the nvmf_reg_write32() for sending shutdown admin command by
> > > the delete_work could be hung forever if the command is not completed by
> > > the timeout handler.
> >
> > If the queue is gone, this means that the queue has already flushed and
> > any commands that were inflight has completed with a flush error
> > completion...
> >
> > Can you describe the scenario that caused this hang? When has the
> > queue became "gone" and when did the shutdown command execute?
