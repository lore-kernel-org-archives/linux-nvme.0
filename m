From: jalee@purestorage.com (Jaesoo Lee)
Date: Thu, 29 Nov 2018 17:54:45 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
Message-ID: <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>

Not the queue, but the RDMA connections.

Let me describe the scenario.

1. connected nvme-rdma target with 500 namespaces
: this will make the nvme_remove_namespaces() took a long time to
complete and open the window vulnerable to this bug
2. host will take below code path for nvme_delete_ctrl_work and send
normal shutdown in nvme_shutdown_ctrl()
- nvme_stop_ctrl
  - nvme_stop_keep_alive --> stopped keep alive
- nvme_remove_namespaces --> took too long time, over 10~15s
- nvme_rdma_shutdown_ctrl
  - nvme_rdma_teardown_io_queues
  - nvme_shutdown_ctrl
    - nvmf_reg_write32
      -__nvme_submit_sync_cmd --> nvme_delete_ctrl_work blocked here
  - nvme_rdma_teardown_admin_queue
- nvme_uninit_ctrl
- nvme_put_ctrl
3. the rdma connection is disconnected by the nvme-rdma target
: in our case, this is triggered by the target side timeout mechanism
: I did not try, but I think this could happen if we lost the RoCE link, too.
4. the shutdown notification command timed out and the work stuck
while leaving the controller in NVME_CTRL_DELETING state

Thanks,

Jaesoo Lee.


On Thu, Nov 29, 2018@5:30 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > This does not hold at least for NVMe RDMA host driver. An example scenario
> > is when the RDMA connection is gone while the controller is being deleted.
> > In this case, the nvmf_reg_write32() for sending shutdown admin command by
> > the delete_work could be hung forever if the command is not completed by
> > the timeout handler.
>
> If the queue is gone, this means that the queue has already flushed and
> any commands that were inflight has completed with a flush error
> completion...
>
> Can you describe the scenario that caused this hang? When has the
> queue became "gone" and when did the shutdown command execute?
